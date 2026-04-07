<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Office extends Model
{
    protected $table = 'offices';
    protected $primaryKey = 'OfficeID';
    protected $fillable = ['OfficeName', 'PlanID'];

    public function plan()
    {
        return $this->belongsTo(Plan::class, 'PlanID', 'PlanID');
    }

    public function section()
    {
        return $this->hasMany(Section::class, 'OfficeID', 'OfficeID');
    }
}
