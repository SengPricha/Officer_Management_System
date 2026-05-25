<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB; // ហៅមកប្រើសម្រាប់ Run SQL
use Illuminate\Support\Facades\File; // ហៅមកប្រើសម្រាប់អានឯកសារ .sql

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     */
    public function run(): void
    {
        // ផ្លូវទៅកាន់ File .sql របស់អ្នក
        $sqlPath = database_path('officer_management_system.sql');

        if (File::exists($sqlPath)) {
            // អានទិន្នន័យពីក្នុង File SQL នោះ
            $sql = File::get($sqlPath);

            // បញ្ជាឱ្យបញ្ចូល (Insert) រាល់កូដ SQL ទាំងអស់ចូលទៅក្នុង Database លើ Railway
            DB::unprepared($sql);

            $this->command->info('Imported officer_management_system.sql successfully!');
        } else {
            $this->command->error('File officer_management_system.sql not found.');
        }
    }
}
