<?php

use App\Http\Controllers\FolderController;
use App\Http\Controllers\ProfileController;
use App\Http\Controllers\TrainingController;
use App\Http\Controllers\DisciplineController;
use App\Http\Controllers\RetiredController;
use App\Http\Controllers\DeathController;
use App\Http\Controllers\TransferOutController;
use App\Http\Controllers\TransferInController;
use App\Http\Controllers\DismissController;
use App\Http\Controllers\DisabledController;
use App\Http\Controllers\OfficeController;
use App\Http\Controllers\SectionController;
use App\Http\Controllers\PostController;
use App\Http\Controllers\StructureController;
use App\Http\Controllers\SuspendController;
use App\Http\Controllers\PlanController;
use App\Http\Controllers\UnitController;
use App\Http\Controllers\StaffController;
use Illuminate\Support\Facades\Route;

use Inertia\Inertia;

Route::get('/', function () {
    return redirect()->route('login');
});

Route::middleware(['auth', 'verified'])->group(function () {
    // Route::get('/dashboard', function () {
    //     return Inertia::render('Dashboard');
    // })->name('dashboard');

    Route::get('/dashboard', [StaffController::class, 'index'])->name('dashboard');
    Route::get('/structure/unit/{unit}', [UnitController::class, 'show'])->name('unit.show');
    Route::get('/structure/unit/{unit}/plan/{plan}', [PlanController::class, 'show'])->name('plan.show');
    Route::get('/structure/unit/{unit}/plan/{plan}/office/{office}', [OfficeController::class, 'show'])->name('office.show');
    Route::get('/structure/unit/{unit}/plan/{plan}/office/{office}/section/{section}', [SectionController::class, 'showFromOffice'])->name('office.section.show');
    Route::get('/structure/unit/{unit}/section/{section}', [SectionController::class, 'showDirect'])->name('unit.section.show');
    Route::get('/structure/unit/{unit}/post/{post}', [PostController::class, 'show'])->name('unit.post.show');
    Route::get('/structure', [StructureController::class, 'index'])->name('structure.index');
    

    Route::get('/training', [TrainingController::class, 'index'])->name('training.index');
    Route::get('/folder', [FolderController::class, 'index'])->name('folder.index');
    Route::get('/discipline', [DisciplineController::class, 'index'])->name('discipline.index');
    Route::get('/retired', [RetiredController::class, 'index'])->name('retired.index');
    Route::get('/transferout', [TransferOutController::class, 'index'])->name('transferout.index');
    Route::get('/transferin', [TransferInController::class, 'index'])->name('transferin.index');
    Route::get('/death', [DeathController::class, 'index'])->name('death.index');
    Route::get('/dismiss', [DismissController::class, 'index'])->name('dismiss.index');
    Route::get('/disabled', [DisabledController::class, 'index'])->name('disabled.index');
    Route::get('/suspend', [SuspendController::class, 'index'])->name('suspend.index');
    Route::get('/profile', [ProfileController::class, 'edit'])->name('profile.edit');
    Route::patch('/profile', [ProfileController::class, 'update'])->name('profile.update');
    Route::delete('/profile', [ProfileController::class, 'destroy'])->name('profile.destroy');

    Route::get('/staff/create', [StaffController::class, 'create'])->name('staff.create');
    Route::post('/staff', [StaffController::class, 'store'])->name('staff.store');
    Route::get('/staff/{id}', [StaffController::class, 'show'])->name('staff.show');
    Route::get('/staff/{id}/edit', [StaffController::class, 'edit'])->name('staff.edit');
    Route::put('/staff/{id}', [StaffController::class, 'update'])->name('staff.update');
    Route::delete('/staff/{id}', [StaffController::class, 'destroy'])->name('staff.destroy');
});

require __DIR__ . '/auth.php';
