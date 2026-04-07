<?php

namespace App\Http\Controllers;

use App\Models\Unit;
use Inertia\Inertia;

class StructureController extends Controller
{
    public function index()
    {
        $units = Unit::with([
            'plan.office.section',
            'section',
            'post',
        ])->get();

        return Inertia::render('Structure/index', [
            'units' => $units
        ]);
    }
}
