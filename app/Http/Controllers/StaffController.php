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
        $request->validate([
            'OfficerName'    => 'required|string|max:255',
            'OfficerID_Code' => 'nullable|string|unique:officers,OfficerID_Code',
            'Gender'         => 'required',
            'RankID'         => 'required|exists:ranks,RankID',
            'UnitID'         => 'required|integer',
            'StatusID'       => 'required|integer',
            'RoleID'         => 'nullable|exists:roles,RoleID',
            'DOB'            => 'nullable|date',
            'StartDate'      => 'nullable|date',
        ], [
            'RankID.required' => 'សូមជ្រើសរើសឋានន្តរស័ក្ដិ',
            'OfficerName.required' => 'សូមបញ្ចូលឈ្មោះមន្រ្តី',
            'OfficerID_Code.unique' => 'អត្តលេខមន្រ្តីនេះបានប្រើរួចហើយ',
            'OfficerID_Code.required' => 'សូមបញ្ចូលអត្តលេខមន្ត្រី',
            'Gender.required' => 'សូមជ្រើសរើសភេទ',
            'UnitID.required' => 'សូមជ្រើសរើសអង្គភាព',
            'StatusID.required' => 'សូមជ្រើសរើសស្ថានភាព',
            'RoleID.required' => 'សូមជ្រើសរើសតួនាទី',
            'DOB.date' => 'សូមបញ្ចូលថ្ងៃខែឆ្នាំកំណើត',
            'StartDate.date' => 'សូមបញ្ចូលថ្ងៃខែឆ្នាំចូលនគរបាលជាតិ',
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

                if ($request->hasFile('profile_image')) {
                    $file = $request->file('profile_image');
                    $path = $file->store('profiles', 'public');
                    $officer->ProfileImage = basename($path);
                }

                $officer->save();

                if ($request->hasFile('documents')) {
                    foreach ($request->file('documents') as $file) {
                        $originalName = $file->getClientOriginalName();
                        $extension    = $file->getClientOriginalExtension();
                        $filenameOnly = pathinfo($originalName, PATHINFO_FILENAME);

                        $finalName = $originalName;
                        $counter = 1;
                        while (Storage::disk('public')->exists('documents/' . $finalName)) {
                            $finalName = $filenameOnly . " ($counter)." . $extension;
                            $counter++;
                        }
                        $path = $file->storeAs('documents', $finalName, 'public');
                        Document::create([
                            'OfficerID' => $officer->ID,
                            'FileName'  => $finalName,
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
        $officers = Officer::with(['rank', 'role', 'unit', 'status', 'plan']) // បន្ថែម plan ក្នុង with
            ->where('StatusID', 1)
            // Filter តាមឈ្មោះ ឬអត្តលេខ
            ->when($request->search, function ($query, $search) {
                $query->where(function ($q) use ($search) {
                    $q->where('OfficerName', 'like', "%{$search}%")
                        ->orWhere('OfficerID_Code', 'like', "%{$search}%");
                });
            })
            // Filter តាមឋានន្តរស័ក្តិ (RankID)
            ->when($request->rank, function ($query, $rank) {
                $query->where('RankID', $rank);
            })
            // Filter តាមផែន (PlanID)
            ->when($request->plan, function ($query, $plan) {
                $query->where('PlanID', $plan);
            })
            ->orderBy('RankID', 'asc')
            ->paginate(10)
            ->withQueryString();

        return Inertia::render('Dashboard', [
            'officers' => $officers,
            'ranks'    => \App\Models\Rank::all(), // បោះទៅឱ្យ Vue ជ្រើសរើស
            'plans'    => \App\Models\Plan::all(), // បោះទៅឱ្យ Vue ជ្រើសរើស
            'filters'  => $request->only(['search', 'rank', 'plan']) // រក្សាតម្លៃ Filter
        ]);
    }

    public function show(Request $request, $id)
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
            'documents'
        ])->findOrFail($id);

        return Inertia::render('Staff/Show', [
            'officer' => $officer,
            'origin' => $request->query('origin', 'dashboard')
        ]);
    }

    public function destroy($id)
    {
        $officer = Officer::with('documents')->findOrFail($id);
        foreach ($officer->documents as $doc) {
            Storage::delete('public/documents/' . $doc->FileName);
            $doc->delete();
        }
        $officer->delete();

        return redirect()->route('dashboard')->with('success', 'ទិន្នន័យមន្ត្រីត្រូវបានលុបដោយជោគជ័យ');
    }

    public function edit(Request $request, $id)
    {
        $officer = Officer::findOrFail($id);
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

    public function update(Request $request, $id)
    {
        $officer = Officer::findOrFail($id);

        $data = $request->validate([
            'OfficerName'    => 'required|string|max:255',
            'OfficerID_Code' => 'required|unique:officers,OfficerID_Code,' . $id . ',ID',
            'RankID'         => 'required|exists:ranks,RankID',
            'RoleID'         => 'required|exists:roles,RoleID',
            'Gender'         => 'required',
            'DOB'            => 'required|date',
            'StartDate'      => 'required|date',
            'StatusID'       => 'required',
            'ProfileImage'   => 'nullable|image|mimes:jpg,jpeg,png|max:2048',
            'UnitID'         => 'required|exists:units,UnitID',
            'PlanID'         => 'nullable|exists:plans,PlanID',
            'OfficeID'       => 'nullable|exists:offices,OfficeID',
            'SectionID'      => 'nullable|exists:sections,SectionID',
            'PostID'         => 'nullable|exists:posts,PostID',

            'documents.*'    => 'nullable|file|mimes:pdf,doc,docx,jpg,png|max:5120',
        ], []);

        if ($request->hasFile('ProfileImage')) {
            if (!empty($officer->ProfileImage)) {
                $oldPath = 'profiles/' . $officer->ProfileImage;
                if (Storage::disk('public')->exists($oldPath)) {
                    Storage::disk('public')->delete($oldPath);
                }
            }
            $file = $request->file('ProfileImage');
            $filename = time() . '_' . $file->getClientOriginalName();
            $file->storeAs('profiles', $filename, 'public');
            $data['ProfileImage'] = $filename;
        } else {
            $data['ProfileImage'] = $officer->ProfileImage;
        }
        $officer->update($data);
        if ($request->hasFile('documents')) {
            foreach ($request->file('documents') as $file) {
                $path = $file->store('officer_documents', 'public');
                $officer->documents()->create([
                    'FilePath' => $path,
                    'FileName' => $file->getClientOriginalName(),
                ]);
            }
        }

        return redirect()->route('dashboard')->with('message', 'កែសម្រួលទិន្នន័យបានជោគជ័យ!');
    }
}
