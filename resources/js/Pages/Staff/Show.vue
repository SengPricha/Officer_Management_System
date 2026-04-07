<script setup>
import AuthenticatedLayout from "@/Layouts/AuthenticatedLayout.vue";
import { Head, Link } from "@inertiajs/vue3";

const props = defineProps({
    officer: Object,
    origin: String,
});

const formatKhmerNumber = (num) => {
    if (!num) return "----";
    const khmerNumbers = ["០", "១", "២", "៣", "៤", "៥", "៦", "៧", "៨", "៩"];
    return num.toString().replace(/\d/g, (digit) => khmerNumbers[digit]);
};

const formatKhmerDate = (dateStr) => {
    if (!dateStr) return "----";
    const parts = dateStr.split("-");
    if (parts.length !== 3) return dateStr;
    const formattedDate = `${parts[2]}-${parts[1]}-${parts[0]}`;
    return formatKhmerNumber(formattedDate);
};
</script>
<template>
    <Head title="ព័ត៌មានរបស់មន្ត្រី | ស្នងការដ្ឋាននគរបាលខេត្តប៉ៃលិន" />

    <AuthenticatedLayout>
        <div
            class="flex justify-between items-center bg-white shadow-sm rounded-lg max-w-7xl mx-auto px-8 py-6"
        >
            <h2 class="text-md text-gray-800 font-moul leading-none">
                ព័ត៌មានរបស់មន្ត្រី
            </h2>
            <Link
                :href="route(origin)"
                class="bg-[#01AAEB] hover:bg-[#079fdb] text-white flex justify-center items-center gap-2 px-5 py-2 rounded-lg text-sm font-siemreap shadow-sm transition-all duration-150"
            >
                <span
                    ><svg
                        xmlns="http://www.w3.org/2000/svg"
                        width="12"
                        height="24"
                        viewBox="0 0 12 24"
                    >
                        <rect width="12" height="24" fill="none" />
                        <path
                            fill="currentColor"
                            fill-rule="evenodd"
                            d="m3.343 12l7.071 7.071L9 20.485l-7.778-7.778a1 1 0 0 1 0-1.414L9 3.515l1.414 1.414z"
                        /></svg
                ></span>
                <span>ត្រឡប់ក្រោយ</span>
            </Link>
        </div>

        <div class="mt-5">
            <div class="max-w-7xl mx-auto">
                <div
                    class="bg-white overflow-hidden shadow-sm sm:rounded-2xl p-8"
                >
                    <div class="grid grid-cols-1 md:grid-cols-[1fr_2fr] gap-40">
                        <div class="flex flex-col items-center space-y-6">
                            <div class="w-52 h-60 mx-auto rounded-xl">
                                <img
                                    :src="
                                        officer.ProfileImage
                                            ? `/storage/profiles/${officer.ProfileImage}`
                                            : '/images/default-avatar.png'
                                    "
                                    alt="ProfileImage"
                                    class="w-52 h-60 object-cover mx-auto rounded-xl border-4 border-gray-200 shadow-md"
                                />
                            </div>
                            <div class="text-center space-y-2">
                                <div
                                    class="flex justify-center items-center space-x-2"
                                >
                                    <h3
                                        class="font-bold text-xl text-gray-900 font-siemreap leading-tight"
                                    >
                                        {{ officer.rank?.RankName }}
                                    </h3>
                                    <h1 class="font-moul text-xl">
                                        {{ officer.OfficerName }}
                                    </h1>
                                </div>
                                <div
                                    class="flex justify-center items-center space-x-2"
                                >
                                    <h3
                                        class="font-bold text-md text-gray-900 font-siemreap leading-tight"
                                    >
                                        អត្តលេខ៖
                                    </h3>
                                    <h1 class="font-moul text-md">
                                        {{
                                            formatKhmerNumber(
                                                officer.OfficerID_Code,
                                            )
                                        }}
                                    </h1>
                                </div>
                            </div>
                        </div>

                        <div class="space-y-0 text-gray-800">
                            <div
                                class="grid grid-cols-[200px_1fr] py-4 border-b border-gray-100 items-center gap-4"
                            >
                                <div
                                    class="text-md text-gray-700 font-siemreap flex-shrink-0"
                                >
                                    ភេទ៖
                                </div>
                                <div class="text-md font-moul flex-1">
                                    {{ officer.Gender }}
                                </div>
                            </div>
                            <div
                                class="grid grid-cols-[200px_1fr] py-4 border-b border-gray-100 items-center gap-4"
                            >
                                <div
                                    class="text-md text-gray-700 font-siemreap flex-shrink-0"
                                >
                                    ថ្ងៃខែឆ្នាំកំណើត៖
                                </div>
                                <div class="text-md font-moul flex-1">
                                    {{ formatKhmerDate(officer.DOB) }}
                                </div>
                            </div>
                            <div
                                class="grid grid-cols-[200px_1fr] py-4 border-b border-gray-100 items-center gap-4"
                            >
                                <div
                                    class="text-md text-gray-700 font-siemreap flex-shrink-0"
                                >
                                    តួនាទី៖
                                </div>
                                <div class="text-md font-moul flex-1">
                                    {{ officer.role?.RoleName }}
                                </div>
                            </div>
                            <div
                                v-if="officer.unit"
                                class="grid grid-cols-[200px_1fr] py-4 border-b border-gray-100 items-center gap-4"
                            >
                                <div
                                    class="text-md text-gray-700 font-siemreap flex-shrink-0"
                                >
                                    អង្គភាព៖
                                </div>
                                <div class="text-md font-moul flex-1">
                                    {{ officer.unit.UnitName }}
                                </div>
                            </div>

                            <div
                                v-if="officer.plan"
                                class="grid grid-cols-[200px_1fr] py-4 border-b border-gray-100 items-center gap-4"
                            >
                                <div
                                    class="text-md text-gray-700 font-siemreap flex-shrink-0"
                                >
                                    ផែន៖
                                </div>
                                <div class="text-md font-moul flex-1">
                                    {{ officer.plan.PlanName }}
                                </div>
                            </div>

                            <div
                                v-if="officer.office"
                                class="grid grid-cols-[200px_1fr] py-4 border-b border-gray-100 items-center gap-4"
                            >
                                <div
                                    class="text-md text-gray-700 font-siemreap flex-shrink-0"
                                >
                                    ការិយាល័យ៖
                                </div>
                                <div class="text-md font-moul flex-1">
                                    {{ officer.office.OfficeName }}
                                </div>
                            </div>

                            <div
                                v-if="officer.section"
                                class="grid grid-cols-[200px_1fr] py-4 border-b border-gray-100 items-center gap-4"
                            >
                                <div
                                    class="text-md text-gray-700 font-siemreap flex-shrink-0"
                                >
                                    ផ្នែក៖
                                </div>
                                <div class="text-md font-moul flex-1">
                                    {{ officer.section.SectionName }}
                                </div>
                            </div>

                            <div
                                v-if="officer.post"
                                class="grid grid-cols-[200px_1fr] py-4 border-b border-gray-100 items-center gap-4"
                            >
                                <div
                                    class="text-md text-gray-700 font-siemreap flex-shrink-0"
                                >
                                    ប៉ុស្តិ៍៖
                                </div>
                                <div class="text-md font-moul flex-1">
                                    {{ officer.post.PostName }}
                                </div>
                            </div>
                            <div
                                class="grid grid-cols-[200px_1fr] py-4 border-b border-gray-100 items-center gap-4"
                            >
                                <div
                                    class="text-md text-gray-700 font-siemreap flex-shrink-0"
                                >
                                    ថ្ងៃចូលនគរបាលជាតិ៖
                                </div>
                                <div class="text-md font-moul flex-1">
                                    {{ formatKhmerDate(officer.StartDate) }}
                                </div>
                            </div>
                            <div
                                class="grid grid-cols-[200px_1fr] py-4 items-center gap-4"
                            >
                                <div
                                    class="text-md text-gray-700 font-siemreap flex-shrink-0"
                                >
                                    ស្ថានភាព៖
                                </div>
                                <div class="text-md font-moul flex-1">
                                    {{ officer.status?.StatusName }}
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div
                    class="bg-white overflow-hidden shadow-sm sm:rounded-2xl p-8 space-y-6 mt-4"
                >
                    <div class="flex items-center space-x-3 text-gray-900">
                        <h4
                            class="font-bold text-lg font-siemreap leading-none"
                        >
                            សំណុំលិខិត
                        </h4>
                    </div>

                    <div
                        v-if="officer.documents && officer.documents.length > 0"
                        class="flex flex-wrap gap-4"
                    >
                        <div
                            v-for="doc in officer.documents"
                            :key="doc.id"
                            class="relative w-28 h-36 flex flex-col items-center justify-center border border-gray-100 rounded-xl p-4 bg-blue-100 hover:bg-blue-200 transition-all duration-150"
                        >
                            <div class="absolute top-[-20px] right-1">
                                <a
                                    :href="`/storage/documents/${doc.FileName}`"
                                    download
                                    class="text-red-500 hover:text-red-700 p-1 transition-colors"
                                >
                                    <svg
                                        class="w-5 h-5"
                                        fill="none"
                                        stroke="currentColor"
                                        viewBox="0 0 24 24"
                                    >
                                        <path
                                            stroke-linecap="round"
                                            stroke-linejoin="round"
                                            stroke-width="2"
                                            d="M4 16v1a3 3 0 003 3h10a3 3 0 003-3v-1m-4-4l-4 4m0 0l-4-4m4 4V4"
                                        ></path>
                                    </svg>
                                </a>
                            </div>

                            <div class="py-2">
                                <svg
                                    class="w-10 h-10 text-blue-500"
                                    fill="none"
                                    stroke="currentColor"
                                    viewBox="0 0 24 24"
                                >
                                    <path
                                        stroke-linecap="round"
                                        stroke-linejoin="round"
                                        stroke-width="2"
                                        d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"
                                    ></path>
                                </svg>
                            </div>

                            <a
                                :href="`/storage/documents/${doc.FileName}`"
                                target="_blank"
                                class="w-full text-[12px] text-center text-gray-700 hover:text-blue-600 hover:underline font-siemreap leading-tight truncate px-1"
                            >
                                {{ doc.FileName }}
                            </a>
                        </div>
                    </div>

                    <p
                        v-else
                        class="text-xs text-gray-400 font-siemreap italic pl-8"
                    >
                        គ្មានឯកសារ
                    </p>
                </div>
            </div>
        </div>
    </AuthenticatedLayout>
</template>
