<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Post extends Model
{
    protected $table = 'posts';
    protected $primaryKey = 'PostID';
    protected $fillable = ['PostName', 'UnitID'];

    public function unit() { return $this->belongsTo(Unit::class, 'UnitID', 'UnitID'); }
}
