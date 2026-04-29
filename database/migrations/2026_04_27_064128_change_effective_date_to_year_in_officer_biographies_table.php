<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('officer_biographies', function (Blueprint $table) {
            // ប្តូរពី date មកជា year វិញ
            $table->year('effective_date')->change();
        });
    }

    public function down(): void
    {
        Schema::table('officer_biographies', function (Blueprint $table) {
            // បើចង់ revert វិញ គឺប្តូរមកជា date ធម្មតា
            $table->date('effective_date')->change();
        });
    }
};
