<script setup>
import AuthenticatedLayout from "@/Layouts/AuthenticatedLayout.vue";
import { Head, Link, router } from "@inertiajs/vue3"; // បន្ថែម router សម្រាប់ប្រើក្នុង deleteFile
import { ref, onMounted, onUnmounted } from "vue";

const props = defineProps({
    officer: Object,
    origin: String,
});

const activeMenu = ref(null);

// បិទ/បើក Menu (ប្រើ id ឱ្យចំជាមួយ doc.id ក្នុង template)
const toggleMenu = (id) => {
    activeMenu.value = activeMenu.value === id ? null : id;
};

const closeMenu = () => {
    activeMenu.value = null;
};

// បិទ Menu ពេលចុចខាងក្រៅ
const handleOutsideClick = (event) => {
    if (activeMenu.value !== null && !event.target.closest(".menu-container")) {
        closeMenu();
    }
};

onMounted(() => {
    window.addEventListener("click", handleOutsideClick);
});

onUnmounted(() => {
    window.removeEventListener("click", handleOutsideClick);
});

// មុខងារប្តូរលេខ និងថ្ងៃខែជាភាសាខ្មែរ
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

// មុខងារឆែកប្រភេទ File
const isImage = (fileName) => {
    if (!fileName) return false;
    const extension = fileName.split(".").pop().toLowerCase();
    const imageExtensions = ["jpg", "jpeg", "png", "gif", "webp", "bmp", "svg"];
    return imageExtensions.includes(extension);
};

const isPDF = (fileName) => {
    if (!fileName) return false;
    return fileName.split(".").pop().toLowerCase() === "pdf";
};

// មើល File (បើក Tab ថ្មី)
const viewFile = (filePath) => {
    if (!filePath) return;
    // ប្រើ Path ផ្ទាល់ពី database (FilePath ជាទូទៅមានពាក្យ documents/ រួចជាស្រេច)
    window.open(`/storage/${filePath}`, "_blank");
};

// លុបឯកសារ
const deleteFile = (id) => {
    if (confirm("តើអ្នកពិតជាចង់លុបឯកសារនេះមែនទេ?")) {
        // កែតម្រូវ route ទៅតាម backend របស់អ្នក
        router.delete(route("officer.documents.destroy", id), {
            preserveScroll: true,
            onSuccess: () => {
                activeMenu.value = null;
                alert("ឯកសារត្រូវបានលុបដោយជោគជ័យ");
            },
        });
    }
};
</script>
<template>
    <Head title="ព័ត៌មានរបស់មន្ត្រី | ស្នងការដ្ឋាននគរបាលខេត្តប៉ៃលិន" />

    <AuthenticatedLayout>
        <div
            class="flex justify-between items-center bg-white shadow-sm rounded-lg max-w-8xl mx-auto px-8 py-4 mb-4"
        >
            <h2 class="text-md text-gray-800 font-moul leading-none font-medium">
                ព័ត៌មានលម្អិតរបស់មន្ត្រី
            </h2>
            <Link
                :href="route(origin)"
                class="bg-[#01AAEB] hover:bg-[#4fbbfa] text-white flex items-center gap-2 px-4 py-2 rounded-md text-sm font-siemreap transition-all"
            >
                <svg
                    xmlns="http://www.w3.org/2000/svg"
                    width="16"
                    height="16"
                    viewBox="0 0 24 24"
                    fill="none"
                    stroke="currentColor"
                    stroke-width="2"
                    stroke-linecap="round"
                    stroke-linejoin="round"
                >
                    <path d="m15 18-6-6 6-6" />
                </svg>
                <span>ត្រឡប់ក្រោយ</span>
            </Link>
        </div>

        <div
            class="max-w-8xl mx-auto grid grid-cols-1 md:grid-cols-[650px_1fr] gap-4"
        >
            <div class="space-y-4">
                <div
                    class="bg-white shadow-sm border border-gray-200 rounded-lg overflow-hidden"
                >
                    <div
                        class="p-6 flex flex-col items-center border-b border-gray-100"
                    >
                        <img
                            :src="
                                officer.ProfileImage
                                    ? `/storage/profiles/${officer.ProfileImage}`
                                    : '/images/default-avatar.png'
                            "
                            class="w-48 h-56 object-cover rounded-md border border-gray-200 mb-4"
                        />
                        <div class="text-center">
                            <div class="flex justify-center gap-2 items-center">
                                <p
                                    class="font-siemreap text-gray-900 text-lg font-bold"
                                >
                                    {{ officer.rank?.RankName }}
                                </p>
                                <h1 class="font-moul text-xl text-gray-900">
                                    {{ officer.OfficerName }}
                                </h1>
                            </div>

                            <p class="font-moul text-gray-900 text-md mt-1">
                                <span
                                    class="font-siemreap text-gray-900 text-md font-bold"
                                    >អត្តលេខ៖</span
                                >
                                {{ formatKhmerNumber(officer.OfficerID_Code) }}
                            </p>
                        </div>
                    </div>

                    <div class="text-sm font-siemreap">
                        <div
                            class="grid grid-cols-[30%_70%] border-b border-gray-100"
                        >
                            <div
                                class="p-3 bg-gray-50 border-r border-gray-100 text-gray-600"
                            >
                                ភេទ៖
                            </div>
                            <div class="p-3 text-gray-900 font-moul font-medium">
                                {{ officer.Gender }}
                            </div>
                        </div>
                        <div
                            class="grid grid-cols-[30%_70%] border-b border-gray-100"
                        >
                            <div
                                class="p-3 bg-gray-50 border-r border-gray-100 text-gray-600"
                            >
                                ថ្ងៃខែឆ្នាំកំណើត៖
                            </div>
                            <div class="p-3 text-gray-900 font-moul">
                                {{ formatKhmerDate(officer.DOB) }}
                            </div>
                        </div>
                        <div
                            class="grid grid-cols-[30%_70%] border-b border-gray-100"
                        >
                            <div
                                class="p-3 bg-gray-50 border-r border-gray-100 text-gray-600"
                            >
                                តួនាទី៖
                            </div>
                            <div class="p-3 text-gray-900 font-moul">
                                {{ officer.role?.RoleName }}
                            </div>
                        </div>
                        <div
                            class="grid grid-cols-[30%_70%] border-b border-gray-100"
                        >
                            <div
                                class="p-3 bg-gray-50 border-r border-gray-100 text-gray-600"
                            >
                                អង្គភាព៖
                            </div>
                            <div class="p-3 text-gray-900 font-moul">
                                {{ officer.unit?.UnitName }}
                            </div>
                        </div>

                        <div
                            v-if="officer.plan"
                            class="grid grid-cols-[30%_70%] border-b border-gray-100"
                        >
                            <div
                                class="p-3 bg-gray-50 border-r border-gray-100 text-gray-600"
                            >
                                ផែន៖
                            </div>
                            <div class="p-3 text-gray-900 font-moul">
                                {{ officer.plan.PlanName }}
                            </div>
                        </div>

                        <div
                            v-if="officer.office"
                            class="grid grid-cols-[30%_70%] border-b border-gray-100"
                        >
                            <div
                                class="p-3 bg-gray-50 border-r border-gray-100 text-gray-600"
                            >
                                ការិយាល័យ៖
                            </div>
                            <div class="p-3 text-gray-900 font-moul">
                                {{ officer.office.OfficeName }}
                            </div>
                        </div>

                        <div
                            v-if="officer.section"
                            class="grid grid-cols-[30%_70%] border-b border-gray-100"
                        >
                            <div
                                class="p-3 bg-gray-50 border-r border-gray-100 text-gray-600"
                            >
                                ផ្នែក៖
                            </div>
                            <div class="p-3 text-gray-900 font-moul">
                                {{ officer.section.SectionName }}
                            </div>
                        </div>

                        <div
                            v-if="officer.post"
                            class="grid grid-cols-[30%_70%] border-b border-gray-100"
                        >
                            <div
                                class="p-3 bg-gray-50 border-r border-gray-100 text-gray-600"
                            >
                                ប៉ុស្តិ៍៖
                            </div>
                            <div class="p-3 text-gray-900 font-moul">
                                {{ officer.post.PostName }}
                            </div>
                        </div>

                        <div
                            class="grid grid-cols-[30%_70%] border-b border-gray-100"
                        >
                            <div
                                class="p-3 bg-gray-50 border-r border-gray-100 text-gray-600"
                            >
                                ថ្ងៃចូលនគរបាលជាតិ៖
                            </div>
                            <div class="p-3 text-gray-900 font-moul">
                                {{ formatKhmerDate(officer.StartDate) }}
                            </div>
                        </div>
                        <div class="grid grid-cols-[30%_70%]">
                            <div
                                class="p-3 bg-gray-50 border-r border-gray-100 text-gray-600"
                            >
                                ស្ថានភាព៖
                            </div>
                            <div class="p-3 text-gray-900 font-moul">
                                {{ officer.status?.StatusName }}
                                <span
                                    v-if="officer.StatusNote"
                                    class="block text-[10px] text-gray-500 italic"
                                    >({{ officer.StatusNote }})</span
                                >
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="space-y-4">
                <div
                    class="lg:col-span-7 bg-white rounded-xl shadow-sm overflow-hidden border border-gray-100"
                >
                    <h3
                        class="font-moul text-sm p-6 border-b text-gray-700 bg-gray-50/50"
                    >
                        ជីវប្រវត្តិ
                    </h3>
                    <div class="overflow-x-auto">
                        <table class="w-full text-left font-siemreap">
                            <thead class="bg-gray-200 border-b font-moul">
                                <tr>
                                    <th
                                        class="px-4 py-4 text-sm text-gray-500 font-medium text-center"
                                    >
                                        ឋានន្តរស័ក្តិ
                                    </th>
                                    <th
                                        class="px-4 py-4 text-sm text-gray-500 font-medium text-center"
                                    >
                                        តួនាទី
                                    </th>
                                    <th
                                        class="px-4 py-4 text-sm text-gray-500 font-medium text-center"
                                    >
                                        ឯកសារ
                                    </th>
                                    <th
                                        class="px-4 py-4 text-sm text-gray-500 font-medium text-center"
                                    >
                                        កាលបរិច្ឆេទ
                                    </th>
                                </tr>
                            </thead>
                            <tbody class="divide-y divide-gray-200">
                                <tr
                                    v-for="bio in officer.biographies"
                                    :key="bio.id"
                                    class="hover:bg-gray-50 transition-colors"
                                >
                                    <td class="px-4 py-4 text-center">
                                        <div
                                            class="text-sm font-medium text-gray-900"
                                        >
                                            {{ bio.rank?.RankName }}
                                        </div>
                                    </td>
                                    <td class="px-4 py-4 text-center">
                                        <div class="text-sm text-gray-700">
                                            {{ bio.role?.RoleName }}
                                        </div>
                                    </td>
                                    <td class="px-4 py-4 text-center">
                                        <div
                                            class="text-sm text-gray-900 font-siemreap"
                                        >
                                            {{ bio.biography_name }}
                                        </div>
                                    </td>
                                    <td
                                        class="px-4 py-4 text-md text-gray-600 whitespace-nowrap text-center font-siemreap"
                                    >
                                        {{
                                            formatKhmerNumber(
                                                bio.effective_date,
                                            )
                                        }}
                                    </td>
                                </tr>
                                <tr v-if="!officer.biographies?.length">
                                    <td
                                        colspan="4"
                                        class="px-4 py-8 text-center text-gray-400 text-sm italic"
                                    >
                                        មិនទាន់មានទិន្នន័យជីវប្រវត្តិនៅឡើយ
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>

                <div
                    class="bg-white shadow-sm border border-gray-200 rounded-lg p-6"
                >
                    <h3
                        class="font-moul text-sm text-gray-800 border-b pb-3 mb-6 text-start"
                    >
                        សំណុំលិខិត
                    </h3>

                    <div
                        v-if="officer.documents && officer.documents.length > 0"
                        class="grid grid-cols-1 sm:grid-cols-2 gap-3"
                    >
                        <div
                            v-for="doc in officer.documents"
                            :key="doc.id"
                            class="relative flex items-center p-2 bg-[#f0f5fa] rounded-xl border border-blue-50 group hover:bg-[#e4edf5] transition-all duration-200"
                        >
                            <div
                                @click="viewFile(doc.FilePath)"
                                class="cursor-pointer flex-shrink-0 w-12 h-12 bg-white rounded-lg flex items-center justify-center border border-gray-100 shadow-sm relative overflow-hidden"
                            >
                                <svg
                                    v-if="isPDF(doc.FileName)"
                                    class="w-8 h-8 text-red-500"
                                    fill="currentColor"
                                    viewBox="0 0 24 24"
                                >
                                    <path
                                        d="M14 2H6a2 2 0 00-2 2v16a2 2 0 002 2h12a2 2 0 002-2V8l-6-6zM13 9V3.5L18.5 9H13z"
                                    />
                                </svg>

                                <div
                                    v-else-if="isImage(doc.FileName)"
                                    class="w-full h-full"
                                >
                                    <img
                                        :src="`/storage/${doc.FilePath}`"
                                        class="w-full h-full object-cover"
                                    />
                                </div>

                                <svg
                                    v-else
                                    class="w-8 h-8 text-blue-500"
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

                            <div
                                @click="viewFile(doc.FilePath)"
                                class="ml-3 flex-1 cursor-pointer overflow-hidden"
                            >
                                <h4
                                    class="text-[12px] font-semibold text-gray-800 truncate font-siemreap"
                                >
                                    {{ doc.FileName }}
                                </h4>
                                <p
                                    class="text-[10px] text-gray-500 uppercase font-siemreap"
                                >
                                    {{ doc.FileName.split(".").pop() }} • ឯកសារ
                                </p>
                            </div>

                            <div class="relative menu-container">
                                <button
                                    @click.stop="toggleMenu(doc.DocID)"
                                    class="p-2 hover:bg-gray-200/50 rounded-full transition-colors"
                                >
                                    <svg
                                        class="w-5 h-5 text-gray-500"
                                        fill="currentColor"
                                        viewBox="0 0 24 24"
                                    >
                                        <path
                                            d="M12 8c1.1 0 2-.9 2-2s-.9-2-2-2-2 .9-2 2 .9 2 2 2zm0 2c-1.1 0-2 .9-2 2s.9 2 2 2 2-.9 2-2-.9-2-2-2zm0 6c-1.1 0-2 .9-2 2s.9 2 2 2 2-.9 2-2-.9-2-2-2z"
                                        ></path>
                                    </svg>
                                </button>

                                <div
                                    v-if="activeMenu === doc.DocID"
                                    class="absolute right-0 mt-1 w-32 bg-white border border-gray-100 rounded-lg shadow-xl z-[100] overflow-hidden font-siemreap"
                                >
                                    <button
                                        @click="viewFile(doc.FilePath)"
                                        class="w-full text-left px-4 py-2 text-[12px] hover:bg-gray-50 border-b"
                                    >
                                        មើល
                                    </button>
                                    <a
                                        :href="`/storage/${doc.FilePath}`"
                                        download
                                        class="w-full text-left px-4 py-2 text-[12px] hover:bg-gray-50 border-b block"
                                    >
                                        ទាញយក
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div
                        v-else
                        class="flex flex-col items-center justify-center h-64 text-gray-400 italic border-2 border-dashed border-gray-100 rounded-xl font-siemreap"
                    >
                        <p>គ្មានឯកសារក្នុងប្រព័ន្ធ</p>
                    </div>
                </div>
            </div>
        </div>
    </AuthenticatedLayout>
</template>
