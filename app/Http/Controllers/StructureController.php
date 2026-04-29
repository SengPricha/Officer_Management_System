<?php

namespace App\Http\Controllers;

use App\Models\Unit;
use Inertia\Inertia;

class StructureController extends Controller
{
    public function index()
    {
        $units = Unit::with(['section', 'post', 'plan.office.section'])
            ->orderBy('UnitID', 'asc')
            ->get();

        return Inertia::render('Structure/index', [
            'units' => $units,
        ]);
    }
}
