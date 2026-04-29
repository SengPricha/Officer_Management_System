<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class OfficerBiography extends Model
{
    use HasFactory;

    // កំណត់ឈ្មោះ Table (ក្នុងករណី Laravel ចាប់ឈ្មោះមិនត្រូវ)
    protected $table = 'officer_biographies';

    // អនុញ្ញាតឱ្យបញ្ចូលទិន្នន័យក្នុង Column ទាំងនេះ
    protected $fillable = [
        'officer_id',
        'rank_id',
        'role_id',
        'biography_name',
        'file_path',
        'effective_date'
    ];

    /**
     * សម្ព័ន្ធភាពទៅកាន់ Table Officers
     */
    public function officer()
    {
        // ភ្ជាប់ officer_id ទៅកាន់ ID របស់ Table officers
        return $this->belongsTo(Officer::class, 'officer_id', 'ID');
    }

    /**
     * សម្ព័ន្ធភាពទៅកាន់ Table Ranks
     */
    public function rank()
    {
        // ភ្ជាប់ rank_id ទៅកាន់ RankID របស់ Table ranks
        return $this->belongsTo(Rank::class, 'rank_id', 'RankID');
    }

    /**
     * សម្ព័ន្ធភាពទៅកាន់ Table Roles
     */
    public function role()
    {
        // ភ្ជាប់ role_id ទៅកាន់ RoleID របស់ Table roles
        return $this->belongsTo(Role::class, 'role_id', 'RoleID');
    }
    public function document()
    {
        return $this->belongsTo(Document::class, 'doc_id', 'DocID');
    }
}
