<?php

namespace App\Http\Controllers;

use App\Models\Plan;
use Illuminate\Http\Request;
use Inertia\Inertia;

class PlanController extends Controller
{
    public function show($unit_id, $plan_id)
    {
        $plan = \App\Models\Plan::with(['office'])->where('UnitID', $unit_id)->findOrFail($plan_id);
        return Inertia::render('Plan/Show', ['plan' => $plan, 'unit_id' => $unit_id]);
    }
}
