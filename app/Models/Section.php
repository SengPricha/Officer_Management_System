<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Section extends Model
{
    protected $table = 'sections';
    protected $primaryKey = 'SectionID';
    protected $fillable = ['SectionName', 'OfficeID', 'UnitID'];

    public function officer()
    {
        return $this->hasMany(Officer::class, 'SectionID', 'SectionID');
    }
    public function office()
    {
        return $this->belongsTo(Office::class, 'OfficeID', 'OfficeID');
    }
    public function unit()
    {
        return $this->belongsTo(Unit::class, 'UnitID', 'UnitID');
    }
}
