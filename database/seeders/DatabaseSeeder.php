<?php

namespace Database\Seeders;

use App\Models\User;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Hash; // ហៅមកដើម្បីបង្កើត Password សម្ងាត់

class DatabaseSeeder extends Seeder
{
    use WithoutModelEvents;

    /**
     * Seed the application's database.
     */
    public function run(): void
    {
        // កែប្រែត្រង់នេះឲ្យត្រូវនឹង Field ក្នុង Database របស់អ្នក
        User::factory()->create([
            'name'     => 'Administrator',
            'username' => 'admin911',                // ប្រើ username សម្រាប់ Login
            'password' => Hash::make('admin911@123$'), // បង្កើត Password លំនាំដើម
        ]);
    }
}
