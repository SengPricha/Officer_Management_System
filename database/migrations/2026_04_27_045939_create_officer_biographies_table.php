<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::dropIfExists('officer_biographies');
        Schema::create('officer_biographies', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('officer_id');
            $table->unsignedBigInteger('rank_id');
            $table->unsignedBigInteger('role_id');
            $table->string('biography_name');
            $table->string('file_path')->nullable();
            $table->date('effective_date');
            $table->timestamps();
            $table->foreign('officer_id')->references('ID')->on('officers')->onDelete('cascade');
            $table->foreign('rank_id')->references('RankID')->on('ranks')->onUpdate('cascade');
            $table->foreign('role_id')->references('RoleID')->on('roles')->onUpdate('cascade');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('officer_biographies');
    }
};
