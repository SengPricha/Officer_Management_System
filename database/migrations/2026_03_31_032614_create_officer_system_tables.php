<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up()
    {
        Schema::create('ranks', function (Blueprint $table) {
            $table->bigIncrements('RankID');
            $table->string('RankName');
            $table->integer('Priority')->default(0);
            $table->timestamps();
        });

        Schema::create('roles', function (Blueprint $table) {
            $table->bigIncrements('RoleID');
            $table->string('RoleName');
            $table->timestamps();
        });

        Schema::create('status', function (Blueprint $table) {
            $table->bigIncrements('StatusID');
            $table->string('StatusName');
            $table->timestamps();
        });

        Schema::create('units', function (Blueprint $table) {
            $table->bigIncrements('UnitID');
            $table->string('UnitName');
            $table->timestamps();
        });

        Schema::create('plans', function (Blueprint $table) {
            $table->bigIncrements('PlanID');
            $table->string('PlanName');
            $table->unsignedBigInteger('UnitID');
            $table->foreign('UnitID')->references('UnitID')->on('units')->onDelete('cascade');
            $table->timestamps();
        });

        Schema::create('offices', function (Blueprint $table) {
            $table->bigIncrements('OfficeID');
            $table->string('OfficeName');
            $table->unsignedBigInteger('PlanID');
            $table->foreign('PlanID')->references('PlanID')->on('plans')->onDelete('cascade');
            $table->timestamps();
        });

        Schema::create('sections', function (Blueprint $table) {
            $table->bigIncrements('SectionID');
            $table->string('SectionName');
            $table->unsignedBigInteger('OfficeID')->nullable();
            $table->unsignedBigInteger('UnitID')->nullable();
            $table->foreign('OfficeID')->references('OfficeID')->on('offices');
            $table->foreign('UnitID')->references('UnitID')->on('units');
            $table->timestamps();
        });

        Schema::create('posts', function (Blueprint $table) {
            $table->bigIncrements('PostID');
            $table->string('PostName');
            $table->unsignedBigInteger('UnitID');
            $table->foreign('UnitID')->references('UnitID')->on('units');
            $table->timestamps();
        });

        Schema::create('officers', function (Blueprint $table) {
            $table->bigIncrements('ID');
            $table->string('OfficerName');
            $table->string('Gender')->nullable();
            $table->date('DOB')->nullable();
            $table->string('OfficerID_Code')->nullable();
            $table->date('StartDate')->nullable();
            $table->string('ProfileImage')->nullable();
            $table->unsignedBigInteger('RankID');
            $table->unsignedBigInteger('RoleID');
            $table->unsignedBigInteger('StatusID');
            $table->unsignedBigInteger('UnitID');
            $table->unsignedBigInteger('PlanID')->nullable();
            $table->unsignedBigInteger('OfficeID')->nullable();
            $table->unsignedBigInteger('SectionID')->nullable();
            $table->unsignedBigInteger('PostID')->nullable();


            $table->foreign('RankID')->references('RankID')->on('ranks');
            $table->foreign('RoleID')->references('RoleID')->on('roles');
            $table->foreign('StatusID')->references('StatusID')->on('status');
            $table->foreign('UnitID')->references('UnitID')->on('units');
            $table->foreign('PlanID')->references('PlanID')->on('plans');
            $table->foreign('OfficeID')->references('OfficeID')->on('offices');
            $table->foreign('SectionID')->references('SectionID')->on('sections');
            $table->foreign('PostID')->references('PostID')->on('posts');

            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('officers');
        Schema::dropIfExists('posts');
        Schema::dropIfExists('sections');
        Schema::dropIfExists('offices');
        Schema::dropIfExists('plans');
        Schema::dropIfExists('units');
        Schema::dropIfExists('status');
        Schema::dropIfExists('roles');
        Schema::dropIfExists('ranks');
    }
};
