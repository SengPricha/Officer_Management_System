<script setup>
import AuthenticatedLayout from "@/Layouts/AuthenticatedLayout.vue";
import { Link, Head } from "@inertiajs/vue3";

const props = defineProps({
    post: Object,
});

const goBack = () => {
    window.history.back();
};

const staticPart = "ស្នងការដ្ឋាននគរបាលខេត្តប៉ៃលិន";
</script>

<template>
    <Head :title="`${post.PostName} | ${staticPart}`" />

    <AuthenticatedLayout>
        <div
            class="flex items-center justify-between bg-white p-4 rounded-lg shadow-sm mb-3 font-siemreap"
        >
            <div class="flex items-center space-x-2">
                <Link
                    :href="route('structure.index')"
                    class="flex items-center text-gray-500 hover:text-[#01AAEB] transition-colors justify-center gap-2 hover:underline hover:font-bold"
                >
                    <svg
                        xmlns="http://www.w3.org/2000/svg"
                        width="20"
                        height="20"
                        viewBox="0 0 24 24"
                        fill="none"
                        stroke="currentColor"
                        stroke-width="2"
                        stroke-linecap="round"
                        stroke-linejoin="round"
                    >
                        <path d="M16 21v-2a4 4 0 0 0-4-4H6a4 4 0 0 0-4 4v2" />
                        <circle cx="9" cy="7" r="4" />
                        <path d="M22 21v-2a4 4 0 0 0-3-3.87" />
                        <path d="M16 3.13a4 4 0 0 1 0 7.75" />
                    </svg>
                    <span class="text-md">រចនាសម្ព័ន្ធ</span>
                </Link>

                <span class="text-gray-400">
                    <svg
                        xmlns="http://www.w3.org/2000/svg"
                        width="16"
                        height="16"
                        viewBox="0 0 24 24"
                    >
                        <path
                            fill="currentColor"
                            d="M6.23 20.23L8 22l10-10L8 2L6.23 3.77L14.46 12z"
                        />
                    </svg>
                </span>

                <Link
                    v-if="post.unit"
                    :href="route('unit.show', post.UnitID)"
                    class="text-gray-500 text-md hover:underline hover:text-[#01AAEB] transition-colors hover:font-bold"
                >
                    {{ post.unit.UnitName }}
                </Link>

                <span class="text-gray-400">
                    <svg
                        xmlns="http://www.w3.org/2000/svg"
                        width="16"
                        height="16"
                        viewBox="0 0 24 24"
                    >
                        <path
                            fill="currentColor"
                            d="M6.23 20.23L8 22l10-10L8 2L6.23 3.77L14.46 12z"
                        />
                    </svg>
                </span>

                <span class="text-[#01AAEB] font-bold text-md">
                    {{ post.PostName }}
                </span>
            </div>

            <button
                @click="goBack"
                class="flex items-center px-4 py-3 bg-[#01AAEB] text-white rounded-lg hover:bg-[#01a9ebdc] transition-all shadow-md text-sm"
            >
                <svg
                    xmlns="http://www.w3.org/2000/svg"
                    class="h-5 w-5 mr-1"
                    fill="none"
                    viewBox="0 0 24 24"
                    stroke="currentColor"
                >
                    <path
                        stroke-linecap="round"
                        stroke-linejoin="round"
                        stroke-width="2"
                        d="M15 19l-7-7 7-7"
                    />
                </svg>
                ត្រឡប់ក្រោយ
            </button>
        </div>

        <div
            class="flex flex-col bg-white px-4 py-6 rounded-lg shadow-sm mb-6 font-siemreap"
        >
            <h1 class="font-moul text-black leading-loose">
                {{ post.PostName }}
            </h1>
        </div>
    </AuthenticatedLayout>
</template>
