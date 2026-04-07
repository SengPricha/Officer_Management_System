<?php

namespace App\Http\Controllers;

use App\Models\Post;
use Inertia\Inertia;
use Illuminate\Http\Request;

class PostController extends Controller
{
    public function show($unit_id, $post_id)
    {
        $post = Post::with('unit')
            ->where('UnitID', $unit_id)
            ->findOrFail($post_id);

        return Inertia::render('Post/Show', [
            'post' => $post
        ]);
    }
}
