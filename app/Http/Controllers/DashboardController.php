<?php

namespace App\Http\Controllers;

use App\Models\Officer;
use Inertia\Inertia;
use Illuminate\Http\Request;

class DashboardController extends Controller
{
    public function index()
    {
        $totalOfficers = Officer::whereIn('StatusID', [1, 2, 3, 4, 5, 11, 12])->count();
        $activeOfficers = Officer::query()->where('StatusID', 1)->count();

        $maleOfficers = Officer::query()
            ->whereIn('StatusID', [1, 2, 3, 4, 5, 11, 12])
            ->where('Gender', 'ប្រុស')
            ->count();

        $femaleOfficers = Officer::query()
            ->whereIn('StatusID', [1, 2, 3, 4, 5, 11, 12])
            ->where('Gender', 'ស្រី')
            ->count();

        return Inertia::render('Dashboard', [
            'totalOfficers' => $totalOfficers,
            'activeOfficers' => $activeOfficers,
            'maleOfficers' => $maleOfficers,
            'femaleOfficers' => $femaleOfficers,
        ]);
    }
}
