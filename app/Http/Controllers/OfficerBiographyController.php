<?php

namespace App\Http\Controllers;

use App\Models\Officer;
use App\Models\Rank;
use App\Models\Role;
use App\Models\OfficerBiography;
use App\Models\Document; // បន្ថែម Document Model
use Illuminate\Http\Request;
use Inertia\Inertia;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\DB;

class OfficerBiographyController extends Controller
{
    public function index(int $id)
    {
        $officer = Officer::with(['rank', 'biographies' => function ($query) {
            $query->orderBy('effective_date', 'desc') // រៀបតាមកាលបរិច្ឆេទវិញទើបសមស្រប
                ->with(['rank', 'role']);
        }])->findOrFail($id);

        return Inertia::render('Biography/Index', [
            'officer' => $officer,
            'ranks'   => Rank::all(),
            'roles'   => Role::all(),
        ]);
    }

    public function store(Request $request)
    {
        $request->validate([
            'officer_id'     => 'required',
            'biography_name' => 'required|string|max:255',
            'rank_id'        => 'required',
            'role_id'        => 'required',
            'effective_date' => 'required|integer|min:1900|max:' . (date('Y') + 10),
            'documents'      => 'nullable|array',
            'documents.*'    => 'mimes:pdf,jpg,jpeg,png|max:2048',
        ], [
            'rank_id.required' => 'សូមជ្រើសរើសឋានន្តរស័ក្ដិ!',
            'role_id.required' => 'សូមជ្រើសរើសតួនាទី!',
            'biography_name.required' => 'សូមបញ្ចូលឈ្មោះឯកសារ!',
            'effective_date' => 'សូមជ្រើសរើសឆ្នាំ!',
        ]);

        DB::transaction(function () use ($request) {
            $biography = OfficerBiography::create([
                'officer_id'     => $request->officer_id,
                'rank_id'        => $request->rank_id,
                'role_id'        => $request->role_id,
                'biography_name' => $request->biography_name,
                'effective_date' => $request->effective_date,
            ]);

            if ($request->hasFile('documents')) {
                foreach ($request->file('documents') as $file) {
                    $this->uploadDocument($file, $request->officer_id, $biography->id);
                }
            }
        });

        return back()->with('success', 'រក្សាទុកជោគជ័យ');
    }

    // បន្ថែម Method សម្រាប់ Update
    public function update(Request $request, int $id)
    {
        $request->validate([
            'biography_name' => 'required|string|max:255',
            'rank_id'        => 'required',
            'role_id'        => 'required',
            'effective_date' => 'required|integer|min:1900|max:' . (date('Y') + 10),
            'documents'      => 'nullable|array',
            'documents.*'    => 'mimes:pdf,jpg,jpeg,png|max:2048',
        ]);

        DB::transaction(function () use ($request, $id) {
            $biography = OfficerBiography::findOrFail($id);
            $biography->update([
                'rank_id'        => $request->rank_id,
                'role_id'        => $request->role_id,
                'biography_name' => $request->biography_name,
                'effective_date' => $request->effective_date,
            ]);

            if ($request->hasFile('documents')) {
                foreach ($request->file('documents') as $file) {
                    $this->uploadDocument($file, $biography->officer_id, $biography->id);
                }
            }
        });

        return back()->with('success', 'កែប្រែទិន្នន័យជោគជ័យ');
    }

    private function uploadDocument($file, $officerId, $biographyId)
    {
        $originalName = $file->getClientOriginalName();
        $filename = pathinfo($originalName, PATHINFO_FILENAME);
        $extension = $file->getClientOriginalExtension();

        $finalName = $originalName;
        $counter = 1;

        while (Storage::disk('public')->exists('documents/' . $finalName)) {
            $finalName = $filename . " ($counter)." . $extension;
            $counter++;
        }

        $filePath = $file->storeAs('documents', $finalName, 'public');

        Document::create([
            'OfficerID'    => $officerId,
            'FileName'     => $finalName,
            'FilePath'     => $filePath,
            'biography_id' => $biographyId,
        ]);
    }
}
