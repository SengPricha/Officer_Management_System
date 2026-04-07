<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Officer extends Model
{
    use HasFactory;

    protected $table = 'officers';
    protected $primaryKey = 'ID';

    protected $fillable = [
        'OfficerName',
        'Gender',
        'DOB',
        'OfficerID_Code',
        'StartDate',
        'ProfileImage',
        'RankID',
        'RoleID',
        'UnitID',
        'PlanID',
        'OfficeID',
        'SectionID',
        'PostID',
        'StatusID'
    ];


    public function documents()
    {
        return $this->hasMany(Document::class, 'OfficerID', 'ID');
    }

    // --- Relationship ផ្សេងៗ ---

    public function rank()
    {
        return $this->belongsTo(Rank::class, 'RankID', 'RankID');
    }

    public function role()
    {
        return $this->belongsTo(Role::class, 'RoleID', 'RoleID');
    }

    public function unit()
    {
        return $this->belongsTo(Unit::class, 'UnitID', 'UnitID');
    }

    public function plan()
    {
        return $this->belongsTo(Plan::class, 'PlanID', 'PlanID');
    }

    public function office()
    {
        return $this->belongsTo(Office::class, 'OfficeID', 'OfficeID');
    }

    public function section()
    {
        return $this->belongsTo(Section::class, 'SectionID', 'SectionID');
    }

    public function post()
    {
        return $this->belongsTo(Post::class, 'PostID', 'PostID');
    }

    public function status()
    {
        return $this->belongsTo(Status::class, 'StatusID', 'StatusID');
    }
}
