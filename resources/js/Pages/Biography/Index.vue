<script setup>
import AuthenticatedLayout from "@/Layouts/AuthenticatedLayout.vue";
import { useForm, Head } from "@inertiajs/vue3";
import { ref, onMounted } from "vue";
import flatpickr from "flatpickr";
import "flatpickr/dist/flatpickr.css";

const props = defineProps({
    officer: Object,
    ranks: Array,
    roles: Array,
});

const form = useForm({
    id: null,
    officer_id: props.officer.ID,
    biography_name: "",
    rank_id: "",
    role_id: "",
    effective_date: "",
    documents: [],
});

const isEditing = ref(false);

const editBiography = (bio) => {
    isEditing.value = true;
    form.id = bio.id;
    form.rank_id = bio.rank_id;
    form.role_id = bio.role_id;
    form.biography_name = bio.biography_name;
    form.effective_date = bio.effective_date;
    window.scrollTo({ top: 0, behavior: "smooth" });
};

const cancelEdit = () => {
    isEditing.value = false;
    form.reset();
    form.id = null;
};

const dateInput = ref(null);

onMounted(() => {
    flatpickr(dateInput.value, {
        disableMobile: "true",
        dateFormat: "Y",
        onReady: function (selectedDates, dateStr, instance) {
            const yearInput =
                instance.calendarContainer.querySelector(".cur-year");
            if (yearInput) {
                yearInput.removeAttribute("readonly");
            }
        },
    });
});

const toKhmerNumbers = (num) => {
    if (!num) return "";
    const khmerNumbers = ["០", "១", "២", "៣", "៤", "៥", "៦", "៧", "៨", "៩"];
    return num.toString().replace(/\d/g, (d) => khmerNumbers[d]);
};

const handleFileChange = (event) => {
    const selectedFiles = Array.from(event.target.files);
    form.documents.push(...selectedFiles);
};

const removeFile = (index) => {
    form.documents.splice(index, 1);
};
const previewLocalFile = (file) => {
    const url = URL.createObjectURL(file);
    window.open(url, "_blank");
};

const goBack = () => {
    window.history.back();
};

const submit = () => {
    if (isEditing.value) {
        form.post(route("biography.update", form.id), {
            forceFormData: true,
            onSuccess: () => {
                cancelEdit();
            },
        });
    } else {
        form.post(route("biography.store"), {
            forceFormData: true,
            onSuccess: () => {
                form.reset(
                    "biography_name",
                    "documents",
                    "effective_date",
                    "rank_id",
                    "role_id"
                );
            },
        });
    }
};
</script>

<template>
    <Head title="បញ្ចូលជីវប្រវត្តិមន្រ្តី | ស្នងការដ្ឋាននគរបាលខេត្តប៉ៃលិន" />
    <AuthenticatedLayout>
        <div class="p-6">
            <div class="flex justify-between items-center mb-8">
                <div class="flex items-center gap-2 mx-5">
                    <span class="font-siemreap font-bold text-gray-900">
                        {{ officer.rank?.RankName }}
                    </span>
                    <h2 class="font-moul text-lg">
                        {{ officer.OfficerName }}
                    </h2>
                </div>
                <button
                    @click="goBack"
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
                </button>
            </div>

            <div class="grid grid-cols-1 lg:grid-cols-12 gap-6 items-start">
                <div
                    class="lg:col-span-5 bg-white p-6 rounded-xl shadow-sm border border-gray-100"
                >
                    <h3
                        class="font-moul text-sm mb-6 border-b pb-3 font-medium"
                    >
                        បញ្ចូលជីវប្រវត្តិថ្មី
                    </h3>

                    <form
                        @submit.prevent="submit"
                        class="flex flex-col gap-4 font-siemreap px-5"
                    >
                        <div class="flex justify-between items-center">
                            <label class="block text-sm text-gray-700 w-60"
                                >ឋានន្តរស័ក្តិ*:</label
                            >
                            <div class="flex flex-col w-full">
                                <select
                                    v-model="form.rank_id"
                                    :class="[
                                        'mt-1 block w-full leading-7 border border-gray-300 outline-none transition-all focus:border-blue-500 focus:ring-2 focus:ring-blue-200 rounded-md px-2 py-2 text-sm cursor-pointer',
                                        form.rank_id === ''
                                            ? 'text-gray-500'
                                            : 'text-gray-900',
                                        form.errors.rank_id
                                            ? 'border-red-500 ring-red-200'
                                            : '',
                                    ]"
                                >
                                    <option value="" disabled>
                                        ជ្រើសរើសឋានន្តរស័ក្តិ
                                    </option>
                                    <option
                                        v-for="rank in ranks"
                                        :key="rank.RankID"
                                        :value="rank.RankID"
                                    >
                                        {{ rank.RankName }}
                                    </option>
                                </select>

                                <p
                                    v-if="form.errors.rank_id"
                                    class="mt-1 text-[11px] text-red-600"
                                >
                                    {{ form.errors.rank_id }}
                                </p>
                            </div>
                        </div>
                        <div class="flex justify-between items-center">
                            <label class="block text-sm text-gray-700 w-60"
                                >តួនាទី*:</label
                            >
                            <div class="flex flex-col w-full">
                                <select
                                    v-model="form.role_id"
                                    :class="[
                                        'mt-1 block w-full leading-7 border border-gray-300 outline-none transition-all focus:border-blue-500 focus:ring-2 focus:ring-blue-200 rounded-md px-2 py-2 text-sm cursor-pointer',
                                        form.role_id === ''
                                            ? 'text-gray-500'
                                            : 'text-gray-900',
                                    ]"
                                >
                                    <option value="" disabled>
                                        ជ្រើសរើសតួនាទី
                                    </option>
                                    <option
                                        v-for="role in roles"
                                        :key="role.RoleID"
                                        :value="role.RoleID"
                                        class="text-gray-900"
                                    >
                                        {{ role.RoleName }}
                                    </option>
                                </select>
                                <p
                                    v-if="form.errors.role_id"
                                    class="mt-2 text-[11px] text-red-600 leading-none"
                                >
                                    {{ form.errors.role_id }}
                                </p>
                            </div>
                        </div>
                        <div class="flex justify-between items-center">
                            <label class="block text-sm text-gray-700 w-60"
                                >ឈ្មោះឯកសារ*:</label
                            >
                            <div class="flex flex-col w-full">
                                <input
                                    v-model="form.biography_name"
                                    type="text"
                                    class="mt-1 block w-full leading-7 border border-gray-300 outline-none transition-all focus:border-blue-500 focus:ring-2 focus:ring-blue-200 rounded-md px-2 py-2 text-sm"
                                    placeholder="ឈ្មោះឯកសារ..."
                                />
                                <p
                                    v-if="form.errors.biography_name"
                                    class="mt-2 text-[11px] text-red-600 leading-none"
                                >
                                    {{ form.errors.biography_name }}
                                </p>
                            </div>
                        </div>

                        <div class="flex justify-between items-center">
                            <label class="block text-sm text-gray-700 w-60"
                                >កាលបរិច្ឆេទ*:</label
                            >
                            <div class="flex flex-col w-full">
                                <input
                                    ref="dateInput"
                                    v-model="form.effective_date"
                                    type="text"
                                    placeholder="ជ្រើសរើសឆ្នាំ"
                                    class="mt-1 block w-full leading-7 border border-gray-300 outline-none transition-all focus:border-blue-500 focus:ring-2 focus:ring-blue-200 rounded-md px-2 py-2 text-sm"
                                />
                                <p
                                    v-if="form.errors.effective_date"
                                    class="mt-2 text-[11px] text-red-600 leading-none"
                                >
                                    {{ form.errors.effective_date }}
                                </p>
                            </div>
                        </div>

                        <div
                            class="flex justify-between items-start gap-4 font-siemreap mt-2"
                        >
                            <label
                                class="block text-sm font-medium text-gray-700 w-36 mt-2"
                            >
                                សំណុំឯកសារ* :
                            </label>

                            <div class="flex-1">
                                <label
                                    for="multi-upload"
                                    class="flex flex-col items-center justify-center w-full h-24 border-2 border-dashed border-gray-300 rounded-xl bg-gray-50 hover:bg-blue-50 hover:border-[#01AAEB] transition-all cursor-pointer group"
                                >
                                    <div
                                        class="flex flex-col items-center justify-center pt-5 pb-6"
                                    >
                                        <svg
                                            class="w-10 h-10 mb-3 text-gray-400 group-hover:text-[#01AAEB] transition-colors"
                                            fill="none"
                                            stroke="currentColor"
                                            viewBox="0 0 24 24"
                                            xmlns="http://www.w3.org/2000/svg"
                                        >
                                            <path
                                                stroke-linecap="round"
                                                stroke-linejoin="round"
                                                stroke-width="2"
                                                d="M7 16a4 4 0 01-.88-7.903A5 5 0 1115.9 6L16 6a5 5 0 011 9.9M15 13l-3-3m0 0l-3 3m3-3v12"
                                            ></path>
                                        </svg>
                                        <p class="mb-1 text-sm text-gray-500">
                                            <span
                                                class="font-semibold text-[#01AAEB]"
                                                >ចុចដើម្បីបញ្ចូលឯកសារ</span
                                            >
                                        </p>
                                    </div>

                                    <input
                                        id="multi-upload"
                                        type="file"
                                        class="hidden"
                                        multiple
                                        @change="handleFileChange"
                                    />
                                </label>

                                <div
                                    v-if="form.documents.length > 0"
                                    class="mt-3 space-y-2"
                                >
                                    <div
                                        v-for="(file, index) in form.documents"
                                        :key="index"
                                        class="flex items-center justify-between p-3 bg-blue-50/50 border border-blue-100 rounded-xl shadow-sm"
                                    >
                                        <div class="flex items-center gap-3">
                                            <svg
                                                class="w-6 h-6 text-blue-500"
                                                fill="none"
                                                stroke="currentColor"
                                                viewBox="0 0 24 24"
                                                xmlns="http://www.w3.org/2000/svg"
                                            >
                                                <path
                                                    stroke-linecap="round"
                                                    stroke-linejoin="round"
                                                    stroke-width="2"
                                                    d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"
                                                ></path>
                                            </svg>
                                            <button
                                                type="button"
                                                @click="previewLocalFile(file)"
                                                class="text-blue-600 hover:text-blue-800 underline text-xs decoration-1 underline-offset-4 truncate max-w-[150px]"
                                            >
                                                {{ file.name }}
                                            </button>
                                        </div>

                                        <button
                                            type="button"
                                            @click="removeFile(index)"
                                            class="text-gray-400 hover:text-red-500 transition-colors"
                                        >
                                            <svg
                                                class="w-5 h-5"
                                                fill="none"
                                                stroke="currentColor"
                                                viewBox="0 0 24 24"
                                                xmlns="http://www.w3.org/2000/svg"
                                            >
                                                <path
                                                    stroke-linecap="round"
                                                    stroke-linejoin="round"
                                                    stroke-width="2"
                                                    d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16"
                                                ></path>
                                            </svg>
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="pt-4 flex gap-2">
                            <button
                                v-if="isEditing"
                                type="button"
                                @click="cancelEdit"
                                class="flex-1 bg-red-500 text-white py-2 rounded-lg text-sm font-medium hover:bg-red-600 transition-colors"
                            >
                                បោះបង់
                            </button>

                            <button
                                type="submit"
                                :disabled="form.processing"
                                :class="[
                                    'flex-1 py-2 rounded-lg text-sm font-medium transition-colors shadow-sm disabled:opacity-50 text-white',
                                    isEditing
                                        ? 'bg-[#01AAEB] hover:bg-[#018fc2]'
                                        : 'bg-[#01AAEB] hover:bg-[#018fc2]',
                                ]"
                            >
                                {{
                                    form.processing
                                        ? "កំពុងរក្សាទុក..."
                                        : isEditing
                                        ? "ធ្វើបច្ចុប្បន្នភាព"
                                        : "រក្សាទុកទិន្នន័យ"
                                }}
                            </button>
                        </div>
                    </form>
                </div>

                <div
                    class="lg:col-span-7 bg-white rounded-xl shadow-sm overflow-hidden border border-gray-100"
                >
                    <h3
                        class="font-moul text-sm p-6 border-b text-gray-700 bg-gray-50/50"
                    >
                        ជីវប្រវត្តិ
                    </h3>
                    <div class="overflow-visible">
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
                                    <th
                                        class="px-4 py-4 text-sm text-gray-500 font-medium text-center"
                                    >
                                        ផ្សេងៗ
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
                                        {{ toKhmerNumbers(bio.effective_date) }}
                                    </td>
                                    <td class="px-4 py-4 text-center">
                                        <button
                                            @click="editBiography(bio)"
                                            class="inline-flex items-center px-3 py-1.5 text-[#D4A906] gap-1.5 group"
                                        >
                                            <svg
                                                class="w-4 h-4 group-hover:scale-110 transition-transform"
                                                fill="none"
                                                stroke="currentColor"
                                                viewBox="0 0 24 24"
                                                xmlns="http://www.w3.org/2000/svg"
                                            >
                                                <path
                                                    stroke-linecap="round"
                                                    stroke-linejoin="round"
                                                    stroke-width="2"
                                                    d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z"
                                                />
                                            </svg>
                                            <span class="text-xs font-medium"
                                                >កែប្រែ</span
                                            >
                                        </button>
                                    </td>
                                </tr>
                                <tr v-if="!officer.biographies?.length">
                                    <td
                                        colspan="5"
                                        class="px-4 py-8 text-center text-gray-400 text-sm italic"
                                    >
                                        មិនទាន់មានទិន្នន័យជីវប្រវត្តិនៅឡើយ
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </AuthenticatedLayout>
</template>
