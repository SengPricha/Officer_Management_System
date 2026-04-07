<?php

namespace App\Http\Controllers;

use Inertia\Inertia;
use App\Models\Unit;
use Illuminate\Http\Request;

class UnitController extends Controller
{
    public function show($unit_id)
    {
        $unit = \App\Models\Unit::with(['plan', 'section', 'post'])->findOrFail($unit_id);
        return Inertia::render('Unit/Show', ['unit' => $unit]);
    }
}
