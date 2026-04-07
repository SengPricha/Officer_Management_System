<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Document extends Model
{

    protected $primaryKey = 'DocID';
    protected $table = 'documents';
    protected $fillable = [
        'OfficerID',
        'FileName',
        'FilePath'
    ];

    public function officer()
    {
        return $this->belongsTo(Officer::class, 'OfficerID', 'ID');
    }
}
