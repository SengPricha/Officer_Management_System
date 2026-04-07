<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Unit extends Model
{
    protected $table = 'units';
    protected $primaryKey = 'UnitID';
    protected $fillable = ['UnitName'];

    public $timestamps = true;

    public function plan()
    {
        return $this->hasMany(Plan::class, 'UnitID', 'UnitID');
    }
    public function office()
    {
        return $this->hasMany(Office::class, 'UnitID', 'UnitID');
    }
    public function officers()
    {
        return $this->hasMany(Officer::class, 'UnitID', 'UnitID');
    }

    public function post()
    {
        return $this->hasMany(Post::class, 'UnitID', 'UnitID');
    }
    public function section()
    {
        return $this->hasMany(Section::class, 'UnitID', 'UnitID');
    }
}
