<script setup>
import Dropdown from "@/Components/Dropdown.vue";
import DropdownLink from "@/Components/DropdownLink.vue";
import { Link } from "@inertiajs/vue3";

const Icons = {
    Search: `<svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"/><path d="m21 21-4.3-4.3"/></svg>`,
    Dashboard: `<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><rect width="7" height="9" x="3" y="3" rx="1"/><rect width="7" height="5" x="14" y="3" rx="1"/><rect width="7" height="9" x="14" y="12" rx="1"/><rect width="7" height="5" x="3" y="16" rx="1"/></svg>`,
    Structure: `<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M16 21v-2a4 4 0 0 0-4-4H6a4 4 0 0 0-4 4v2"/><circle cx="9" cy="7" r="4"/><path d="M22 21v-2a4 4 0 0 0-3-3.87"/><path d="M16 3.13a4 4 0 0 1 0 7.75"/></svg>`,
    Folder: `<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M3 9h18v10a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V9Z"/><path d="m3 9 2.45-4.9A2 2 0 0 1 7.24 3h9.52a2 2 0 0 1 1.8 1.1L21 9"/></svg>`,
    Discipline: `<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M2 3h6a4 4 0 0 1 4 4v14a3 3 0 0 0-3-3H2z"/><path d="M22 3h-6a4 4 0 0 0-4 4v14a3 3 0 0 1 3-3h7z"/></svg>`,
    Study: `<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M8 2v4"/><path d="M16 2v4"/><rect width="18" height="18" x="3" y="4" rx="2"/><path d="M3 10h18"/><path d="m9 16 2 2 4-4"/></svg>`,
    Report: `<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><line x1="12" y1="20" x2="12" y2="10"/><line x1="18" y1="20" x2="18" y2="4"/><line x1="6" y1="20" x2="6" y2="16"/></svg>`,
    Logout: `<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4"/><polyline points="16 17 21 12 16 7"/><line x1="21" y1="12" x2="9" y2="12"/></svg>`,
    In_Out: `<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24"><rect width="24" height="24" fill="none"/><g fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5"><path d="M3.53 11.47v2.118a4.235 4.235 0 0 0 4.235 4.236H20.47M3.53 6.176h12.705a4.235 4.235 0 0 1 4.236 4.236v2.117"/><path d="m17.294 14.647l3.177 3.176L17.294 21M6.706 9.353L3.529 6.176L6.706 3"/></g></svg>`,
    Retire: `<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24"><rect width="24" height="24" fill="none"/><path fill="currentColor" d="M18.6 6.62c-1.44 0-2.8.56-3.77 1.53L7.8 14.39c-.64.64-1.49.99-2.4.99C3.53 15.38 2 13.87 2 12s1.53-3.38 3.4-3.38c.91 0 1.76.35 2.44 1.03l1.13 1l1.53-1.34L9.22 8.2A5.37 5.37 0 0 0 5.4 6.62C2.42 6.62 0 9.04 0 12s2.42 5.38 5.4 5.38c1.44 0 2.8-.56 3.77-1.53l7.03-6.24c.64-.64 1.49-.99 2.4-.99c1.87 0 3.4 1.51 3.4 3.38s-1.53 3.38-3.4 3.38c-.9 0-1.76-.35-2.44-1.03L15 13.34l-1.5 1.34l1.28 1.12a5.4 5.4 0 0 0 3.82 1.57c2.98 0 5.4-2.41 5.4-5.37c0-3-2.42-5.38-5.4-5.38"/></svg>`,
    Death: ` <svg width="20" height="20" viewBox="0 0 64 64" fill="currentColor" stroke="currentColor">
    <path d="M32 6c-6 0-11 5-11 11 0 4 2 7 5 9l-8 20h8l6-14 6 14h8l-8-20c3-2 5-5 5-9 0-6-5-11-11-11zm0 4c4 0 7 3 7 7 0 3-2 5-4 6l-3 1-3-1c-2-1-4-3-4-6 0-4 3-7 7-7z"/>
  </svg>`,
    Disabled: `<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24"><rect width="24" height="24" fill="none"/><g fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2"><path d="M9 5a2 2 0 1 0 4 0a2 2 0 1 0-4 0"/><path d="M11 7v8h4l4 5m-8-9h5m-9 .5a5 5 0 1 0 6 7.5"/></g></svg>`,
    Dismissed: `<svg class="fill-current" viewBox="0 0 24 24" width="20" height="20">
    <path d="M16 11a4 4 0 10-8 0 4 4 0 008 0zM4 20a6 6 0 1112 0H4zm13.7-9.3l2.3 2.3 2.3-2.3 1.4 1.4-2.3 2.3 2.3 2.3-1.4 1.4-2.3-2.3-2.3 2.3-1.4-1.4 2.3-2.3-2.3-2.3 1.4-1.4z"/>
  </svg>`,
};
</script>

<template>
    <div class="flex h-screen bg-gray-100 font-seimreap">
        <aside
            class="w-76 bg-white border-r border-gray-100 flex flex-col fixed h-full z-20 shadow-sm"
        >
            <div
                class="flex items-center gap-1 p-2 border-b border-gray-200 bg-white h-28"
            >
                <img
                    src="/images/logo1.png"
                    alt="Logo"
                    class="w-20 h-auto object-contain"
                />

                <div class="leading-tight">
                    <h1 class="text-[12px] text-gray-800 font-moul">
                        ស្នងការដ្ឋាននគរបាលខេត្តប៉ៃលិន
                    </h1>
                    <h2
                        class="text-[12px] font-semibold text-gray-600 uppercase tracking-wide"
                    >
                        Commission de Police Pailin
                    </h2>
                </div>
            </div>

            <nav class="flex-1 px-6 space-y-2 mt-4 font-siemreap">
                <Link
                    :href="route('dashboard')"
                    :class="
                        route().current('dashboard')
                            ? 'bg-[#01AAEB] text-white shadow-lg shadow-blue-100'
                            : 'text-gray-500 hover:bg-[#01AAEB] hover:text-white'
                    "
                    class="flex items-center px-4 py-3 rounded-xl font-bold transition-all duration-300"
                >
                    <span class="mr-3" v-html="Icons.Dashboard"></span>
                    ផ្ទាំងគ្រប់គ្រង
                </Link>
                <Link
                    :href="route('structure.index')"
                    :class="
                        route().current('structure.*') ||
                        route().current('unit.*') ||
                        route().current('plan.*') ||
                        route().current('office.*')
                            ? 'bg-[#01AAEB] text-white shadow-lg shadow-blue-100'
                            : 'text-gray-500 hover:bg-[#01AAEB] hover:text-white'
                    "
                    class="flex items-center px-4 py-3 rounded-xl font-bold transition-all duration-300"
                >
                    <span class="mr-3" v-html="Icons.Structure"></span>
                    រចនាសម្ព័ន្ធ
                </Link>
                <Link
                    :href="route('folder.index')"
                    :class="
                        route().current('folder.*')
                            ? 'bg-[#01AAEB] text-white shadow-lg shadow-blue-100'
                            : 'text-gray-500 hover:bg-[#01AAEB] hover:text-white'
                    "
                    class="flex items-center px-4 py-3 rounded-xl font-bold transition-all duration-300"
                >
                    <span class="mr-3" v-html="Icons.Folder"></span>
                    សំណុំលិខិត
                </Link>
                <Link
                    :href="route('training.index')"
                    :class="
                        route().current('training.*')
                            ? 'bg-[#01AAEB] text-white shadow-lg shadow-blue-100'
                            : 'text-gray-500 hover:bg-[#01AAEB] hover:text-white'
                    "
                    class="flex items-center px-4 py-3 rounded-xl font-bold transition-all duration-300"
                >
                    <span class="mr-3" v-html="Icons.Study"></span>
                    ការងារសិក្សា
                </Link>

                <Link
                    :href="route('discipline.index')"
                    :class="
                        route().current('discipline.*')
                            ? 'bg-[#01AAEB] text-white shadow-lg shadow-blue-100'
                            : 'text-gray-500 hover:bg-[#01AAEB] hover:text-white'
                    "
                    class="flex items-center px-4 py-3 rounded-xl font-bold transition-all duration-300"
                >
                    <span class="mr-3" v-html="Icons.Discipline"></span>វិន័យ
                </Link>

                <Link
                    :href="route('retired.index')"
                    :class="
                        route().current('retired.*')
                            ? 'bg-[#01AAEB] text-white shadow-lg shadow-blue-100'
                            : 'text-gray-500 hover:bg-[#01AAEB] hover:text-white'
                    "
                    class="flex items-center px-4 py-3 rounded-xl font-bold transition-all duration-300"
                >
                    <span class="mr-3" v-html="Icons.Retire"></span>
                    សោធននិវត្តន៍
                </Link>
                <Link
                    :href="route('transferin.index')"
                    :class="
                        route().current('transferin.*')
                            ? 'bg-[#01AAEB] text-white shadow-lg shadow-blue-100'
                            : 'text-gray-500 hover:bg-[#01AAEB] hover:text-white'
                    "
                    class="flex items-center px-4 py-3 rounded-xl font-bold transition-all duration-300"
                >
                    <span class="mr-3" v-html="Icons.In_Out"></span>
                    ផ្ទេរចូល
                </Link>
                <Link
                    :href="route('transferout.index')"
                    :class="
                        route().current('transferout.*')
                            ? 'bg-[#01AAEB] text-white shadow-lg shadow-blue-100'
                            : 'text-gray-500 hover:bg-[#01AAEB] hover:text-white'
                    "
                    class="flex items-center px-4 py-3 rounded-xl font-bold transition-all duration-300"
                >
                    <span class="mr-3" v-html="Icons.In_Out"></span>
                    ផ្ទេរចេញ
                </Link>
                <Link
                    :href="route('death.index')"
                    :class="
                        route().current('death.*')
                            ? 'bg-[#01AAEB] text-white shadow-lg shadow-blue-100'
                            : 'text-gray-500 hover:bg-[#01AAEB] hover:text-white'
                    "
                    class="flex items-center px-4 py-3 rounded-xl font-bold transition-all duration-300"
                >
                    <span class="mr-3" v-html="Icons.Death"></span>
                    មរណៈ
                </Link>
                <Link
                    :href="route('dismiss.index')"
                    :class="
                        route().current('dismiss.*')
                            ? 'bg-[#01AAEB] text-white shadow-lg shadow-blue-100'
                            : 'text-gray-500 hover:bg-[#01AAEB] hover:text-white'
                    "
                    class="flex items-center px-4 py-3 rounded-xl font-bold transition-all duration-300"
                >
                    <span class="mr-3" v-html="Icons.Dismissed"></span>
                    កាត់/បណ្ដេញចេញពីក្របខណ្ឌ
                </Link>
                <Link
                    :href="route('disabled.index')"
                    :class="
                        route().current('disabled.*')
                            ? 'bg-[#01AAEB] text-white shadow-lg shadow-blue-100'
                            : 'text-gray-500 hover:bg-[#01AAEB] hover:text-white'
                    "
                    class="flex items-center px-4 py-3 rounded-xl font-bold transition-all duration-300"
                >
                    <span class="mr-3" v-html="Icons.Disabled"></span>
                    ពិការ/បាត់បង់សមត្ថភាព
                </Link>
                <Link
                    :href="route('suspend.index')"
                    :class="
                        route().current('suspend.*')
                            ? 'bg-[#01AAEB] text-white shadow-lg shadow-blue-100'
                            : 'text-gray-500 hover:bg-[#01AAEB] hover:text-white'
                    "
                    class="flex items-center px-4 py-3 rounded-xl font-bold transition-all duration-300"
                >
                    <span class="mr-3" v-html="Icons.Report"></span>
                    ព្យួរក្របខណ្ឌ
                </Link>
            </nav>

            <div class="p-6 border-t border-gray-200">
                <Link
                    :href="route('logout')"
                    method="post"
                    as="button"
                    class="w-full flex items-center justify-center px-4 py-3 bg-red-500 font-siemreap text-white text-sm hover:bg-red-400 rounded-xl transition-all"
                >
                    <span class="mr-3" v-html="Icons.Logout"></span>
                    ចាកចេញពីប្រព័ន្ធ
                </Link>
            </div>
        </aside>

        <div class="flex-1 flex flex-col overflow-hidden">
            <header
                class="bg-white shadow-sm h-28 flex items-center justify-between px-8"
            >
                <h2 class="text-xl font-bold text-gray-700">
                    <slot name="header" />
                </h2>

                <div class="flex items-center">
                    <Dropdown align="right" width="48">
                        <template #trigger>
                            <button
                                class="flex items-center text-sm font-medium text-gray-500 hover:text-gray-700 focus:outline-none transition"
                            >
                                {{ $page.props.auth.user.name }}
                                <svg
                                    class="ml-2 -mr-0.5 h-4 w-4"
                                    fill="currentColor"
                                    viewBox="0 0 20 20"
                                >
                                    <path
                                        fill-rule="evenodd"
                                        d="M5.293 7.293a1 1 0 011.414 0L10 10.586l3.293-3.293a1 1 0 111.414 1.414l-4 4a1 1 0 01-1.414 0l-4-4a1 1 0 010-1.414z"
                                        clip-rule="evenodd"
                                    />
                                </svg>
                            </button>
                        </template>
                        <template #content>
                            <DropdownLink
                                :href="route('profile.edit')"
                                class="font-siemreap"
                                >ព័ត៌មានផ្ទាល់ខ្លួន</DropdownLink
                            >
                            <DropdownLink
                                :href="route('logout')"
                                method="post"
                                as="button"
                                class="font-siemreap"
                                >ចាកចេញ</DropdownLink
                            >
                        </template>
                    </Dropdown>
                </div>
            </header>

            <main
                class="flex-1 overflow-x-hidden overflow-y-auto bg-gray-100 p-5 ml-[300px]"
            >
                <slot />
            </main>
        </div>
    </div>
</template>
