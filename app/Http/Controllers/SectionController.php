<?php

namespace App\Http\Controllers;

use App\Models\Section;
use Inertia\Inertia;
use Illuminate\Http\Request;

class SectionController extends Controller
{
    /**
     * លក្ខខណ្ឌទី១: UnitID 1 > Plan > Office > Section
     */
    public function showFromOffice($unit_id, $plan_id, $office_id, $section_id)
    {
        $section = Section::with(['officer', 'office.plan.unit']) // ទាញឡើងទៅលើឱ្យដល់ Unit
            ->where('OfficeID', $office_id)
            ->findOrFail($section_id);

        return Inertia::render('Section/Show', [
            'section' => $section,
            'context' => 'office'
        ]);
    }

    /**
     * លក្ខខណ្ឌទី២: UnitID != 1 > Section (ចុះពី Unit មក Section ផ្ទាល់)
     */
    public function showDirect($unit_id, $section_id)
    {
        $section = Section::with(['officer', 'unit']) // ទាញមកត្រឹម Unit បានហើយ
            ->where('UnitID', $unit_id)
            ->findOrFail($section_id);

        return Inertia::render('Section/Show', [
            'section' => $section,
            'context' => 'unit'
        ]);
    }
}
