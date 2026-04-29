<?php

namespace App\Http\Controllers;

use Inertia\Inertia;
use App\Models\Unit;
use Illuminate\Http\Request;

class UnitController extends Controller
{
    public function show($unit_id)
    {
        $unit = Unit::with([
            'plan',
            'section',
            'post',
            'officers' => function ($query) {
                $query->with(['rank', 'role'])
                    ->where('StatusID', 1)
                    ->whereIn('RoleID', [1, 2])
                    ->orderBy('RoleID', 'asc');
            }
        ])->findOrFail($unit_id);

        return Inertia::render('Unit/Show', [
            'unit' => $unit
        ]);
    }
}
