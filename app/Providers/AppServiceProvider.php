<?php

namespace App\Providers;

use Illuminate\Support\Facades\Vite;
use Illuminate\Support\ServiceProvider;
use Illuminate\Support\Facades\URL; // បន្ថែមសម្រាប់ប្រើប្រាស់ URL Facade

class AppServiceProvider extends ServiceProvider
{
    /**
     * Register any application services.
     */
    public function register(): void
    {
        //
    }

    /**
     * Bootstrap any application services.
     */
    public function boot(): void
    {
        Vite::prefetch(concurrency: 3);

        // បង្ខំឱ្យ Laravel ប្រើប្រាស់ប្រព័ន្ធ HTTPS រាល់ពេលរត់នៅលើ Server (Production)
        if (config('app.env') === 'production') {
            URL::forceScheme('https');
        }
    }
}
