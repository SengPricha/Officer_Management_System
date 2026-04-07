<?php

namespace App\Http\Controllers;

use Inertia\Inertia;
use App\Models\Officer;
use Illuminate\Http\Request;

class SuspendController extends Controller
{
    public function index(Request $request)
    {
        $officers = Officer::with(['rank', 'role', 'unit', 'status'])
            ->where('StatusID', 11)
            ->when($request->search, function ($query, $search) {
                $query->where(function ($q) use ($search) {
                    $q->where('OfficerName', 'like', "%{$search}%")
                        ->orWhere('OfficerID_Code', 'like', "%{$search}%");
                });
            })
            ->orderBy('RankID', 'asc')
            ->paginate(12)
            ->withQueryString();

        return Inertia::render('Suspend/index', [
            'officers' => $officers,
            'filters'  => $request->only(['search'])
        ]);
    }
}
