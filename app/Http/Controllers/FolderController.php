<?php

namespace App\Http\Controllers;
use App\Models\Document;
use Inertia\Inertia;


class FolderController extends Controller
{
    public function index()
    {
        $documents = Document::with('officer')->latest()->get();

        return Inertia::render('Folder/index', [
            'documents' => $documents
        ]);
    }
}
