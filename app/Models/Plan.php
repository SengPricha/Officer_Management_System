<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Plan extends Model
{
    protected $table = 'plans';
    protected $primaryKey = 'PlanID';
    protected $fillable = ['PlanName', 'UnitID'];

    public function unit()
    {
        return $this->belongsTo(Unit::class, 'UnitID', 'UnitID');
    }

    public function office()
    {
        return $this->hasMany(Office::class, 'PlanID', 'PlanID');
    }
}
