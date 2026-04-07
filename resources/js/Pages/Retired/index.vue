<script setup>
import AuthenticatedLayout from "@/Layouts/AuthenticatedLayout.vue";
import { Head, Link, router } from "@inertiajs/vue3";
import { ref, watch } from "vue";
import Pagination from "@/Components/Pagination.vue";
import Swal from "sweetalert2";

const props = defineProps({
    officers: Array,
    filters: Object,
});

const searchTerm = ref(props.filters?.search || "");

const toKhmerNumber = (num) => {
    if (num === null || num === undefined) return "";
    const khmerNumbers = ["០", "១", "២", "៣", "៤", "៥", "៦", "៧", "៨", "៩"];
    return num.toString().replace(/\d/g, (d) => khmerNumbers[d]);
};

const formatKhmerDate = (dateString) => {
    if (!dateString) return "";
    const date = new Date(dateString);
    const day = String(date.getDate()).padStart(2, "0");
    const month = String(date.getMonth() + 1).padStart(2, "0");
    const year = date.getFullYear();
    const formattedDate = `${day}-${month}-${year}`;
    return toKhmerNumber(formattedDate);
};

const handleSearch = () => {
    router.get(
        route("retired.index"),
        { search: searchTerm.value },
        {
            preserveState: true,
            replace: true,
        },
    );
};

const confirmDelete = (id) => {
    Swal.fire({
        title: "តើអ្នកចង់លុបទិន្នន័យនេះមែនទេ?",
        text: "ទិន្នន័យមន្ត្រីនេះនឹងត្រូវលុបចេញពីប្រព័ន្ធ!",
        icon: "warning",
        showCancelButton: true,
        confirmButtonColor: "#ef4444",
        cancelButtonColor: "#6b7280",
        confirmButtonText: "យល់ព្រមលុប",
        cancelButtonText: "បោះបង់",
        reverseButtons: true,
        customClass: {
            title: "font-siemreap",
            htmlContainer: "font-siemreap",
            confirmButton: "font-siemreap",
            cancelButton: "font-siemreap",
        },
    }).then((result) => {
        if (result.isConfirmed) {
            router.delete(route("staff.destroy", id), {
                preserveScroll: true,
                onSuccess: () => {
                    Swal.fire({
                        title: "លុបរួចរាល់!",
                        text: "ទិន្នន័យត្រូវបានលុបដោយជោគជ័យ។",
                        icon: "success",
                        customClass: {
                            title: "font-siemreap",
                            htmlContainer: "font-siemreap",
                            confirmButton: "font-siemreap",
                        },
                    });
                },
            });
        }
    });
};
</script>

<template>
    <Head title="សោធននិវត្តន៍ | ស្នងការដ្ឋាននគរបាលខេត្តប៉ៃលិន" />
    <AuthenticatedLayout>
        <div class="py-2">
            <div class="flex justify-center mb-8 font-siemreap mx-5">
                <form
                    @submit.prevent="handleSearch"
                    class="w-full flex gap-2"
                >
                    <div class="w-full items-center flex justify-between gap-10">
                        <div class="w-1/2 bg-white py-4 px-2 rounded-lg"><h1 class="font-siemreap text-lg font-bold">បញ្ជីឈ្មោះមន្ត្រីសោធននិវត្តន៍</h1></div>
                        <div class="flex w-1/2 gap-2">
                            <div class="relative flex-grow">
                                <input
                                    type="text"
                                    v-model="searchTerm"
                                    placeholder="ស្វែងរកអត្តលេខ ឬឈ្មោះមន្រ្តី..."
                                    class="w-full border border-gray-300 rounded-xl px-4 py-3 text-sm leading-7 focus:ring-2 focus:ring-blue-400 outline-none shadow-sm transition-all"
                                />
                                <button
                                    v-if="searchTerm !== ''"
                                    @click="
                                        searchTerm = '';
                                        handleSearch();
                                    "
                                    type="button"
                                    class="absolute inset-y-0 right-0 pr-3 flex items-center text-gray-400 hover:text-red-500"
                                >
                                    <svg
                                        xmlns="http://www.w3.org/2000/svg"
                                        class="h-5 w-5"
                                        viewBox="0 0 20 20"
                                        fill="currentColor"
                                    >
                                        <path
                                            fill-rule="evenodd"
                                            d="M10 18a8 8 0 100-16 8 8 0 000 16zM8.707 7.293a1 1 0 00-1.414 1.414L8.586 10l-1.293 1.293a1 1 0 101.414 1.414L10 11.414l1.293 1.293a1 1 0 001.414-1.414L11.414 10l1.293-1.293a1 1 0 00-1.414-1.414L10 8.586 8.707 7.293z"
                                            clip-rule="evenodd"
                                        />
                                    </svg>
                                </button>
                            </div>
                            <button
                                type="submit"
                                class="bg-[#01AAEB] text-white px-6 py-2 rounded-xl hover:bg-[#079fdb] transition-all shadow-md"
                            >
                                ស្វែងរក
                            </button>
                        </div>
                    </div>
                </form>
            </div>

            <div
                class="bg-white p-4 rounded-xl shadow-md mt-4 overflow-x-auto mx-5 border border-gray-100"
            >
                <table class="min-w-full divide-y divide-gray-200">
                    <thead class="bg-gray-50 font-moul">
                        <tr>
                            <th
                                class="px-4 py-3 text-left text-xs font-medium text-gray-600"
                            >
                                លេខរៀង
                            </th>

                            <th
                                class="px-4 py-3 text-left text-xs font-medium text-gray-600"
                            >
                                ឋានន្តរស័ក្ដិ
                            </th>

                            <th
                                class="px-4 py-3 text-left text-xs font-medium text-gray-600"
                            >
                                ឈ្មោះ
                            </th>

                            <th
                                class="px-4 py-3 text-left text-xs font-medium text-gray-600"
                            >
                                ភេទ
                            </th>

                            <th
                                class="px-4 py-3 text-left text-xs font-medium text-gray-600"
                            >
                                ថ្ងៃខែឆ្នាំកំណើត
                            </th>

                            <th
                                class="px-4 py-3 text-left text-xs font-medium text-gray-600"
                            >
                                អត្តលេខ
                            </th>

                            <th
                                class="px-4 py-3 text-left text-xs font-medium text-gray-600"
                            >
                                តួនាទី
                            </th>

                            <th
                                class="px-4 py-3 text-left text-xs font-medium text-gray-600"
                            >
                                ថ្ងៃចូលនគរបាលជាតិ
                            </th>

                            <th
                                class="px-4 py-3 text-left text-xs font-medium text-gray-600"
                            >
                                ស្ថានភាព
                            </th>

                            <th
                                class="px-4 py-3 text-center text-xs font-medium text-gray-600"
                            >
                                សកម្មភាព
                            </th>
                        </tr>
                    </thead>
                    <tbody
                        class="bg-white divide-y divide-gray-100 font-siemreap text-[13px]"
                    >
                        <template
                            v-if="officers.data && officers.data.length > 0"
                        >
                            <tr
                                v-for="(row, index) in officers.data"
                                :key="row.ID"
                                class="hover:bg-blue-50/30 transition-colors"
                            >
                                <td class="px-4 py-3">
                                    {{ toKhmerNumber(index + 1) }}
                                </td>
                                <td class="px-4 py-3 font-medium">
                                    {{ row.rank?.RankName }}
                                </td>
                                <td class="px-4 py-3">
                                    {{ row.OfficerName }}
                                </td>
                                <td class="px-4 py-3">
                                    {{ row.Gender }}
                                </td>
                                <td class="px-4 py-3">
                                    {{ formatKhmerDate(row.DOB) }}
                                </td>
                                <td class="px-4 py-3">
                                    {{ toKhmerNumber(row.OfficerID_Code) }}
                                </td>
                                <td class="px-4 py-3">
                                    {{ row.role?.RoleName }}
                                </td>
                                <td class="px-4 py-3">
                                    {{ formatKhmerDate(row.StartDate) }}
                                </td>
                                <td class="px-4 py-3">
                                    {{ row.status?.StatusName }}
                                </td>
                                <td class="px-4 py-3">
                                    <div class="flex justify-center gap-4">
                                        <Link
                                            :href="
                                                route('staff.show', {
                                                    id: row.ID,
                                                    origin: 'retired.index',
                                                })
                                            "
                                            class="text-blue-500 hover:scale-125 transition-transform"
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
                                                    d="M15 12a3 3 0 11-6 0 3 3 0 016 0zM2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z"
                                                />
                                            </svg>
                                        </Link>
                                        <Link
                                            :href="
                                                route('staff.edit', {
                                                    id: row.ID,
                                                    origin: 'retired.index',
                                                })
                                            "
                                            class="text-yellow-500 hover:scale-125 transition-transform"
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
                                                    d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z"
                                                />
                                            </svg>
                                        </Link>
                                        <button
                                            @click="confirmDelete(row.ID)"
                                            class="text-red-400 hover:text-red-600 hover:scale-125 transition-all"
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
                                                    d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16"
                                                />
                                            </svg>
                                        </button>
                                    </div>
                                </td>
                            </tr>
                        </template>
                        <tr v-else>
                            <td
                                colspan="10"
                                class="px-6 py-20 text-center text-gray-400"
                            >
                                មិនមានទិន្នន័យមន្ត្រីក្នុងប្រព័ន្ធឡើយ។
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
            <div class="mt-6">
                <Pagination :links="officers.links" />
            </div>
        </div>
    </AuthenticatedLayout>
</template>
