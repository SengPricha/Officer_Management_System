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
use Illuminate\Support\Facades\File;
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

    private function generateUniqueFileName($file, $destinationFolder)
    {
        $originalName = $file->getClientOriginalName();
        $filename = pathinfo($originalName, PATHINFO_FILENAME);
        $extension = pathinfo($originalName, PATHINFO_EXTENSION);

        $finalName = $originalName;
        $counter = 1;

        while (File::exists(public_path($destinationFolder . '/' . $finalName))) {
            $finalName = $filename . '(' . $counter . ').' . $extension;
            $counter++;
        }

        return $finalName;
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
            'StatusNote'     => 'required_if:StatusID,4,5,6,12|nullable|string|max:255',
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

                // [កែសម្រួលទី១]៖ ត្រូវហៅទាញរូបភាព Profile មកដាក់ក្នុង Object មុននឹង Save មន្ត្រីចូល DB
                if ($request->hasFile('ProfileImage')) {
                    $file = $request->file('ProfileImage');
                    $fileName = $this->generateUniqueFileName($file, 'profiles');
                    $file->move(public_path('profiles'), $fileName);
                    $officer->ProfileImage = $fileName;
                }

                $officer->save();

                if ($request->hasFile('documents')) {
                    foreach ($request->file('documents') as $file) {
                        $fileName = $this->generateUniqueFileName($file, 'documents');
                        $file->move(public_path('documents'), $fileName);

                        Document::create([
                            'OfficerID'  => $officer->ID,
                            'FileName'   => $file->getClientOriginalName(),
                            'FilePath'   => 'documents/' . $fileName,
                        ]);
                    }
                }
            });

            return redirect()->route('staff.index')->with('success', 'ទិន្នន័យមន្ត្រីត្រូវបានរក្សាទុកដោយជោគជ័យ!');
        } catch (\Exception $e) {
            return back()->withErrors(['error' => 'បរាជ័យក្នុងការរក្សាទុក៖ ' . $e->getMessage()]);
        }
    }

    public function index(Request $request)
    {
        $officers = Officer::with(['rank', 'role', 'unit', 'status', 'plan', 'office'])
            ->whereIn('StatusID', [1, 2, 3, 4, 5, 11, 12])
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
            ->orderBy('RoleID', 'asc')
            ->orderBy('RankID', 'asc')
            ->orderByRaw("CAST(OfficerID_Code AS UNSIGNED) asc")
            ->paginate(10)
            ->withQueryString();

        return Inertia::render('Staff/Index', [
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

        $validatedData = $request->validate([
            'OfficerName'    => 'required|string|max:255',
            'OfficerID_Code' => 'required|string|unique:officers,OfficerID_Code,' . $id . ',ID',
            'RankID'         => 'required|exists:ranks,RankID',
            'RoleID'         => 'required|exists:roles,RoleID',
            'Gender'         => 'required',
            'DOB'            => 'required|date',
            'StartDate'      => 'required|date',
            'StatusID'       => 'required',
            'StatusNote'     => 'required_if:StatusID,4,5,6,12|max:255',
            'UnitID'         => 'required|exists:units,UnitID',
            'PlanID'         => 'nullable|exists:plans,PlanID',
            'OfficeID'       => 'nullable|exists:offices,OfficeID',
            'SectionID'      => 'nullable|exists:sections,SectionID',
            'PostID'         => 'nullable|exists:posts,PostID',
            'documents.*'    => 'nullable|file|mimes:pdf,doc,docx,jpg,png|max:5120',
        ]);

        if (!in_array($request->StatusID, [4, 5, 6, 12])) {
            $validatedData['StatusNote'] = null;
        } else {
            $validatedData['StatusNote'] = $request->StatusNote;
        }

        if ($request->hasFile('ProfileImage')) {
            $file = $request->file('ProfileImage');
            $fileName = $this->generateUniqueFileName($file, 'profiles');

            if ($officer->ProfileImage && File::exists(public_path('profiles/' . $officer->ProfileImage))) {
                File::delete(public_path('profiles/' . $officer->ProfileImage));
            }

            $file->move(public_path('profiles'), $fileName);
            $officer->ProfileImage = $fileName;
        }
        unset($validatedData['ProfileImage']);
        $officer->update($validatedData);
        if ($request->hasFile('documents')) {
            $currentOfficerId = isset($id) ? $id : (isset($staff) ? $staff->id : null);
            if (!$currentOfficerId && isset($officer)) {
                $currentOfficerId = $officer->id;
            }

            if ($currentOfficerId) {
                foreach ($request->file('documents') as $file) {
                    $fileName = $this->generateUniqueFileName($file, 'documents');
                    $file->move(public_path('documents'), $fileName);
                    Document::create([
                        'OfficerID'  => $currentOfficerId,
                        'FileName'   => $file->getClientOriginalName(),
                        'FilePath'   => 'documents/' . $fileName,
                    ]);
                }
            } else {
                return back()->withErrors(['error' => 'មិនអាចរក្សាទុកឯកសារបានទេ ព្រោះរកមិនឃើញ ID របស់បុគ្គលិកឡើយ!']);
            }
        }

        return redirect()->route('staff.index')->with('success', 'កែសម្រួលទិន្នន័យបានជោគជ័យ!');
    }

    public function destroy(int $id)
    {
        $officer = Officer::with('documents')->findOrFail($id);
        foreach ($officer->documents as $doc) {
            $filePath = urldecode($doc->FilePath);
            $publicDocPath = public_path($filePath);
            $storageDocPath = storage_path('app/public/' . $filePath);
            if (File::exists($publicDocPath)) {
                File::delete($publicDocPath);
            }
            if (File::exists($storageDocPath)) {
                File::delete($storageDocPath);
            }
            Document::destroy($doc->DocID ?? $doc->DocumentID ?? $doc->id);
        }
        if (!empty($officer->ProfileImage)) {
            $profilePath = urldecode($officer->ProfileImage);

            $publicProfilePath = public_path('profiles/' . $profilePath);
            $storageProfilePath = storage_path('app/public/profiles/' . $profilePath);

            if (File::exists($publicProfilePath)) {
                File::delete($publicProfilePath);
            }
            if (File::exists($storageProfilePath)) {
                File::delete($storageProfilePath);
            }
        }
        $officer->delete($id);

        return redirect()->route('staff.index')->with('success', 'ទិន្នន័យមន្ត្រីត្រូវបានលុបដោយជោគជ័យ');
    }

    public function destroyDocument(int $id)
    {
        $document = Document::findOrFail($id);
        $filePath = urldecode($document->FilePath);

        $publicPath = public_path($filePath);
        $storagePath = storage_path('app/public/' . $filePath);

        if (File::exists($publicPath)) {
            File::delete($publicPath);
        }
        if (File::exists($storagePath)) {
            File::delete($storagePath);
        }

        $document->delete();

        return redirect()->back()->with('success', 'ឯកសារត្រូវបានលុបដោយជោគជ័យ');
    }
}
