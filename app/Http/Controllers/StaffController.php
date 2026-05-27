<?php

namespace App\Http\Controllers;

use App\Models\Officer;
use App\Models\Document;
use App\Models\Rank;
use App\Models\Unit;
use App\Models\Role;
use App\Models\Plan;
use App\Models\Office;
use App\Models\Section;
use App\Models\Post;
use App\Models\Status;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Storage;
use Inertia\Inertia;

class StaffController extends Controller
{
    public function create()
    {
        return Inertia::render('Staff/Create', [
            'ranks' => Rank::orderBy('Priority', 'asc')->get()->map(fn($r) => ['id' => $r->RankID, 'name' => $r->RankName]),
            'units' => Unit::orderBy('UnitID', 'asc')->get()->map(fn($u) => ['id' => $u->UnitID, 'name' => $u->UnitName]),
            'roles' => Role::orderBy('Priority', 'asc')->get()->map(fn($ro) => ['id' => $ro->RoleID, 'name' => $ro->RoleName]),
            'plans' => Plan::orderBy('PlanID', 'asc')->get()->map(fn($p) => [
                'id' => $p->PlanID,
                'name' => $p->PlanName,
                'unit_id' => $p->UnitID
            ]),
            'offices' => Office::orderBy('OfficeID', 'asc')->get()->map(fn($o) => [
                'id' => $o->OfficeID,
                'name' => $o->OfficeName,
                'plan_id' => $o->PlanID
            ]),
            'sections' => Section::orderBy('SectionID', 'asc')->get()->map(fn($s) => [
                'id' => $s->SectionID,
                'name' => $s->SectionName,
                'office_id' => $s->OfficeID,
                'unit_id' => $s->UnitID
            ]),
            'posts' => Post::orderBy('PostID', 'asc')->get()->map(fn($po) => [
                'id' => $po->PostID,
                'name' => $po->PostName,
                'unit_id' => $po->UnitID
            ]),
            'statuses' => Status::orderBy('StatusID', 'asc')->get()->map(fn($st) => ['id' => $st->StatusID, 'name' => $st->StatusName]),
        ]);
    }

    public function store(Request $request)
    {
        // កែសម្រួល validation ឱ្យត្រូវជា profile_image (អក្សរតូច) សម្រាប់ទំព័រ Create ករណីបងប្រើអក្សរតូចនៅទីនោះ
        $request->validate([
            'OfficerName'    => 'required|string|max:255',
            'OfficerID_Code' => 'nullable|string|unique:officers,OfficerID_Code',
            'Gender'         => 'required',
            'RankID'         => 'required|exists:ranks,RankID',
            'UnitID'         => 'required|integer',
            'StatusID'       => 'required|integer',
            'StatusNote'     => 'required_if:StatusID,4,5,6,12|max:255',
            'RoleID'         => 'required|exists:roles,RoleID',
            'DOB'            => 'required|date',
            'StartDate'      => 'required|date',
        ], [
            'RankID.required' => 'សូមជ្រើសរើសឋានន្តរស័ក្ដិ',
            'OfficerName.required' => 'សូមបញ្ចូលឈ្មោះមន្រ្តី',
            'OfficerID_Code.unique' => 'អត្តលេខមន្រ្តីនេះបានប្រើរួចហើយ',
            'OfficerID_Code.required' => 'សូមបញ្ចូលអត្តលេខមន្ត្រី',
            'Gender.required' => 'សូមជ្រើសរើសភេទ',
            'UnitID.required' => 'សូមជ្រើសរើសអង្គភាព',
            'StatusID.required' => 'សូមជ្រើសរើសស្ថានភាព',
            'RoleID.required' => 'សូមជ្រើសរើសតួនាទី',
            'DOB.required' => 'សូមបញ្ចូលថ្ងៃខែឆ្នាំកំណើត',
            'StartDate.required' => 'សូមបញ្ចូលថ្ងៃខែឆ្នាំចូលនគរបាលជាតិ',
        ]);

        try {
            DB::transaction(function () use ($request) {
                $officer = new Officer();
                $officer->OfficerName    = $request->OfficerName;
                $officer->Gender         = $request->Gender;
                $officer->DOB            = $request->DOB;
                $officer->OfficerID_Code = $request->OfficerID_Code;
                $officer->StartDate      = $request->StartDate;
                $officer->RankID         = $request->RankID;
                $officer->RoleID         = $request->RoleID;
                $officer->UnitID         = $request->UnitID;
                $officer->PlanID         = $request->PlanID;
                $officer->OfficeID       = $request->OfficeID;
                $officer->SectionID      = $request->SectionID;
                $officer->PostID         = $request->PostID;
                $officer->StatusID       = $request->StatusID;

                if (in_array($request->StatusID, [4, 5, 6, 12])) {
                    $officer->StatusNote = $request->StatusNote;
                } else {
                    $officer->StatusNote = null;
                }

                // ឆែកមើល File រូបភាពសម្រាប់ទំព័រ Create
                if ($request->hasFile('profile_image')) {
                    $file = $request->file('profile_image');
                    $filename = time() . '_' . uniqid() . '.' . $file->extension();
                    $file->storeAs('profiles', $filename, 'public');
                    $officer->ProfileImage = $filename;
                }

                $officer->save();

                if ($request->hasFile('documents')) {
                    foreach ($request->file('documents') as $file) {
                        $originalName = $file->getClientOriginalName();
                        $extension    = $file->extension();
                        $safeName = 'doc_' . time() . '_' . uniqid() . '.' . $extension;
                        $path = $file->storeAs('documents', $safeName, 'public');

                        Document::create([
                            'OfficerID' => $officer->ID,
                            'FileName'  => $originalName,
                            'FilePath'  => $path
                        ]);
                    }
                }
            });

            return redirect()->route('dashboard')->with('success', 'ទិន្នន័យមន្ត្រីត្រូវបានរក្សាទុកដោយជោគជ័យ!');
        } catch (\Exception $e) {
            return back()->withErrors(['error' => 'បរាជ័យក្នុងការរក្សាទុក៖ ' . $e->getMessage()]);
        }
    }

    public function index(Request $request)
    {
        $officers = Officer::with(['rank', 'role', 'unit', 'status', 'plan', 'office'])
            ->where('StatusID', 1)
            ->when($request->search, function ($query, $search) {
                $search = trim($search);
                $query->where(function ($q) use ($search) {
                    $q->where('OfficerName', 'like', "%{$search}%")
                        ->orWhere('OfficerID_Code', 'like', "%{$search}%");
                });
            })
            ->when($request->rank, function ($query, $rank) {
                $query->where('RankID', $rank);
            })
            ->when($request->plan, function ($query, $plan) {
                $query->where('PlanID', $plan);
            })
            ->when($request->office, function ($query, $office) {
                $query->where('OfficeID', $office);
            })
            ->orderBy('RankID', 'asc')
            ->paginate(10)
            ->withQueryString();

        return Inertia::render('Dashboard', [
            'officers' => $officers,
            'ranks'    => \App\Models\Rank::all(),
            'plans'    => \App\Models\Plan::all(),
            'offices'  => \App\Models\Office::all(),
            'filters'  => $request->only(['search', 'rank', 'plan', 'office'])
        ]);
    }

    public function show(Request $request, int $id)
    {
        $officer = Officer::with([
            'rank',
            'unit',
            'plan',
            'office',
            'section',
            'post',
            'status',
            'role',
            'documents',
            'biographies' => function ($query) {
                $query->orderBy('id', 'asc');
            },
            'biographies.rank',
            'biographies.role',
        ])->findOrFail($id);

        return Inertia::render('Staff/Show', [
            'officer' => $officer,
            'origin' => $request->query('origin', 'dashboard')
        ]);
    }

    public function destroy(int $id)

    {
        $officer = Officer::with('documents')->findOrFail($id);
        foreach ($officer->documents as $doc) {

            // លុបឯកសារពិតប្រាកដចេញពី Storage

            if (Storage::disk('public')->exists($doc->FilePath)) {

                Storage::disk('public')->delete($doc->FilePath);
            }
            Document::destroy($doc->DocumentID ?? $doc->id);
        }

        Officer::destroy($id);

        return redirect()->route('dashboard')->with('success', 'ទិន្នន័យមន្ត្រីត្រូវបានលុបដោយជោគជ័យ');
    }

    public function edit(Request $request, int $id)
    {
        $officer = Officer::with('documents')->findOrFail($id);
        return Inertia::render('Staff/Edit', [
            'officer' => $officer,
            'origin' => $request->query('origin', 'dashboard'),
            'ranks' => Rank::orderBy('Priority', 'asc')->get()->map(fn($r) => ['id' => $r->RankID, 'name' => $r->RankName]),
            'units' => Unit::orderBy('UnitID', 'asc')->get()->map(fn($u) => ['id' => $u->UnitID, 'name' => $u->UnitName]),
            'roles' => Role::orderBy('Priority', 'asc')->get()->map(fn($ro) => ['id' => $ro->RoleID, 'name' => $ro->RoleName]),
            'plans' => Plan::orderBy('PlanID', 'asc')->get()->map(fn($p) => [
                'id' => $p->PlanID,
                'name' => $p->PlanName,
                'unit_id' => $p->UnitID
            ]),
            'offices' => Office::orderBy('OfficeID', 'asc')->get()->map(fn($o) => [
                'id' => $o->OfficeID,
                'name' => $o->OfficeName,
                'plan_id' => $o->PlanID
            ]),
            'sections' => Section::orderBy('SectionID', 'asc')->get()->map(fn($s) => [
                'id' => $s->SectionID,
                'name' => $s->SectionName,
                'office_id' => $s->OfficeID,
                'unit_id' => $s->UnitID
            ]),
            'posts' => Post::orderBy('PostID', 'asc')->get()->map(fn($po) => [
                'id' => $po->PostID,
                'name' => $po->PostName,
                'unit_id' => $po->UnitID
            ]),
            'statuses' => Status::orderBy('StatusID', 'asc')->get()->map(fn($st) => ['id' => $st->StatusID, 'name' => $st->StatusName]),
        ]);
    }

    public function update(Request $request, int $id)
    {
        $officer = Officer::findOrFail($id);

        $data = $request->validate([
            'OfficerName'    => 'required|string|max:255',
            'OfficerID_Code' => 'required|string|unique:officers,OfficerID_Code,' . $id . ',ID',
            'RankID'         => 'required|exists:ranks,RankID',
            'RoleID'         => 'required|exists:roles,RoleID',
            'Gender'         => 'required',
            'DOB'            => 'required|date',
            'StartDate'      => 'required|date',
            'StatusID'       => 'required',
            'StatusNote'     => 'required_if:StatusID,4,5,6,12|max:255',
            'ProfileImage'   => 'nullable', // រក្សាទុកជាអក្សរធំ ដើម្បីកុំឱ្យទើសពេលបញ្ជូន String ឈ្មោះចាស់
            'UnitID'         => 'required|exists:units,UnitID',
            'PlanID'         => 'nullable|exists:plans,PlanID',
            'OfficeID'       => 'nullable|exists:offices,OfficeID',
            'SectionID'      => 'nullable|exists:sections,SectionID',
            'PostID'         => 'nullable|exists:posts,PostID',
            'documents.*'    => 'nullable|file|mimes:pdf,doc,docx,jpg,png|max:5120',
        ], []);

        if (!in_array($request->StatusID, [4, 5, 6, 12])) {
            $data['StatusNote'] = null;
        } else {
            $data['StatusNote'] = $request->StatusNote;
        }

        // ត្រួតពិនិត្យការ Upload រូបភាព Profile ថ្មី (ឆែកមើលថាជា File ឬអត់)
        if ($request->hasFile('ProfileImage')) {
            // លុបរូបភាពចាស់ចោលពី Storage ការពារការណែន Volume
            if (!empty($officer->ProfileImage)) {
                $oldPath = 'profiles/' . $officer->ProfileImage;
                if (Storage::disk('public')->exists($oldPath)) {
                    Storage::disk('public')->delete($oldPath);
                }
            }

            $file = $request->file('ProfileImage');
            // បង្កើតឈ្មោះថ្មីដែលមានលក្ខណៈ Unique ការពារការជាន់ឈ្មោះគ្នា
            $filename = time() . '_' . uniqid() . '.' . $file->extension();
            $file->storeAs('profiles', $filename, 'public');
            $data['ProfileImage'] = $filename;
        } else {
            // បើគ្មានការប្តូររូបភាពថ្មីទេ យកឈ្មោះរូបភាពចាស់ក្នុង Database ដដែល
            $data['ProfileImage'] = $officer->ProfileImage;
        }

        $officer->update($data);

        // ត្រួតពិនិត្យការ Upload ឯកសារបន្ថែម
        if ($request->hasFile('documents')) {
            foreach ($request->file('documents') as $file) {
                $originalName = $file->getClientOriginalName();
                $extension    = $file->extension();

                $safeName = 'doc_' . time() . '_' . uniqid() . '.' . $extension;
                $path = $file->storeAs('documents', $safeName, 'public');

                $officer->documents()->create([
                    'FileName' => $originalName,
                    'FilePath' => $path,
                ]);
            }
        }

        return redirect()->route('dashboard')->with('message', 'កែសម្រួលទិន្នន័យបានជោគជ័យ!');
    }
}
