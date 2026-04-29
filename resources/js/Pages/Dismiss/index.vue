<script setup>
import AuthenticatedLayout from "@/Layouts/AuthenticatedLayout.vue";
import { Head, Link, router } from "@inertiajs/vue3";
import { ref, watch } from "vue";
import { onMounted, onUnmounted } from "vue";
import Pagination from "@/Components/Pagination.vue";
import Swal from "sweetalert2";
import debounce from "lodash/debounce";

const props = defineProps({
    officers: Array,
    filters: Object,
});

const openDropdownId = ref(null);

const toggleDropdown = (id) => {
    if (openDropdownId.value === id) {
        openDropdownId.value = null;
    } else {
        openDropdownId.value = id;
    }
};

const closeDropdown = (e) => {
    if (!e.target.closest(".dropdown-container")) {
        openDropdownId.value = null;
    }
};

onMounted(() => window.addEventListener("click", closeDropdown));
onUnmounted(() => window.removeEventListener("click", closeDropdown));

const goToDetail = (id) => {
    router.visit(route("staff.show", { id: id, origin: "dismiss.index" }));
};

const searchTerm = ref(props.filters.search || "");

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

const handleSearch = debounce(() => {
    router.get(
        route("dismiss.index"),
        { search: searchTerm.value },
        {
            preserveState: true,
            replace: true,
        },
    );
}, 300);

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
watch([searchTerm], () => {
    handleSearch();
});
</script>

<template>
    <Head title="បណ្ដេញចេញពីក្របខណ្ឌ | ស្នងការដ្ឋាននគរបាលខេត្តប៉ៃលិន" />
    <AuthenticatedLayout>
        <div class="py-2">
            <div class="flex justify-between mb-8 font-siemreap mx-5">
                <div class="w-1/2 bg-white py-3.5 px-2 rounded-lg">
                    <h1 class="font-siemreap text-md font-bold">
                        បញ្ជីឈ្មោះមន្ត្រីបណ្ដេញចេញពីក្របខណ្ឌ
                    </h1>
                </div>
                <div class="relative flex-grow max-w-[550px]">
                    <input
                        type="text"
                        v-model="searchTerm"
                        placeholder="ស្វែងរកអត្តលេខ ឬឈ្មោះមន្រ្តី..."
                        class="w-full border border-gray-300 rounded-xl px-4 py-3.5 text-sm focus:ring-2 focus:ring-blue-400 outline-none shadow-sm transition-all"
                    />
                    <button
                        v-if="searchTerm !== ''"
                        @click="searchTerm = ''"
                        type="button"
                        class="absolute inset-y-0 right-0 pr-3 flex items-center text-gray-400 hover:text-red-500 transition-colors"
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
            </div>

            <div
                class="bg-white p-4 rounded-xl shadow-md mt-4 overflow-visible mx-5 border border-gray-100"
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
                                @click="
                                    router.visit(
                                        route('staff.show', {
                                            id: row.ID,
                                            origin: 'dismiss.index',
                                        }),
                                    )
                                "
                                class="hover:bg-blue-50/50 transition-colors cursor-pointer group"
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
                                <td class="px-4 py-3 font-siemreap text-sm">
                                    <div class="flex items-center gap-1">
                                        <span class="font-medium text-gray-900">
                                            {{ row.status?.StatusName }}
                                        </span>

                                        <span
                                            v-if="row.StatusNote"
                                            class="text-gray-500"
                                        >
                                            ({{ row.StatusNote }})
                                        </span>
                                    </div>
                                </td>
                                <td class="px-4 py-2 text-center" @click.stop>
                                    <div
                                        class="relative dropdown-container inline-block text-left"
                                    >
                                        <button
                                            @click="toggleDropdown(row.ID)"
                                            class="p-2 hover:bg-gray-100 rounded-full transition-colors focus:outline-none"
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
                                                class="text-gray-600"
                                            >
                                                <circle cx="12" cy="12" r="1" />
                                                <circle cx="12" cy="5" r="1" />
                                                <circle cx="12" cy="19" r="1" />
                                            </svg>
                                        </button>

                                        <div
                                            v-if="openDropdownId === row.ID"
                                            class="absolute right-0 mt-2 w-40 bg-white border border-gray-200 rounded-lg shadow-xl z-50 overflow-hidden font-siemreap"
                                        >
                                            <div class="flex flex-col py-1">
                                                <Link
                                                    :href="
                                                        route(
                                                            'biography.index',
                                                            { id: row.ID },
                                                        )
                                                    "
                                                    class="flex items-center gap-3 px-4 py-2 text-sm text-blue-600 hover:bg-blue-50 transition-colors"
                                                >
                                                    <svg
                                                        class="w-4 h-4"
                                                        fill="none"
                                                        stroke="currentColor"
                                                        viewBox="0 0 24 24"
                                                        xmlns="http://www.w3.org/2000/svg"
                                                    >
                                                        <path
                                                            stroke-linecap="round"
                                                            stroke-linejoin="round"
                                                            stroke-width="2"
                                                            d="M12 6.253v13m0-13C10.832 5.477 9.246 5 7.5 5S4.168 5.477 3 6.253v13C4.168 18.477 5.754 18 7.5 18s3.332.477 4.5 1.253m0-13C13.168 5.477 14.754 5 16.5 5c1.747 0 3.332.477 4.5 1.253v13C19.832 18.477 18.247 18 16.5 18c-1.746 0-3.332.477-4.5 1.253"
                                                        />
                                                    </svg>
                                                    <span
                                                        >បញ្ចូលជីវប្រវត្តិ</span
                                                    >
                                                </Link>
                                                <Link
                                                    :href="
                                                        route('staff.edit', {
                                                            id: row.ID,
                                                            origin: 'dismiss.index',
                                                        })
                                                    "
                                                    class="flex items-center gap-3 px-4 py-2 text-sm text-yellow-600 hover:bg-yellow-50 transition-colors"
                                                    ><svg
                                                        class="w-4 h-4"
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
                                                    <span>កែប្រែ</span>
                                                </Link>
                                                <button
                                                    @click="
                                                        confirmDelete(row.ID)
                                                    "
                                                    class="flex items-center gap-3 px-4 py-2 text-sm text-red-600 hover:bg-red-50 transition-colors w-full text-left"
                                                >
                                                    <svg
                                                        class="w-4 h-4"
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
                                                    <span>លុបមន្ត្រី</span>
                                                </button>
                                            </div>
                                        </div>
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
