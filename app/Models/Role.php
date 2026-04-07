<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Role extends Model
{
    use HasFactory;

    protected $table = 'roles';
    protected $primaryKey = 'RoleID';
    protected $fillable = ['RoleName', 'Priority'];

    public function officers()
    {
        return $this->hasMany(Officer::class, 'RoleID', 'RoleID');
    }
}
