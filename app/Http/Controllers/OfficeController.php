<?php

namespace App\Http\Controllers;

use App\Models\Office;
use Illuminate\Http\Request;
use Inertia\Inertia;

class OfficeController extends Controller
{
    public function show($unit_id, $plan_id, $office_id)
    {
        $office = \App\Models\Office::with(['plan.unit', 'section'])
            ->where('PlanID', $plan_id)
            ->findOrFail($office_id);

        return Inertia::render('Office/Show', [
            'office' => $office,
        ]);
    }
}
