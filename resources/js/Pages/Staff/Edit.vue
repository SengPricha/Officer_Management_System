<script setup>
import AuthenticatedLayout from "@/Layouts/AuthenticatedLayout.vue";
import { useForm, Head } from "@inertiajs/vue3";
import { Link } from "@inertiajs/vue3";
import { ref, watch, onMounted, computed } from "vue";
import flatpickr from "flatpickr";
import "flatpickr/dist/flatpickr.css";
import Swal from "sweetalert2";

const props = defineProps({
    officer: Object,
    ranks: Array,
    roles: Array,
    statuses: Array,
    units: Array,
    plans: Array,
    offices: Array,
    sections: Array,
    posts: Array,
    origin: String,
});

const dobInput = ref(null);
const joiningDateInput = ref(null);
const imageUrl = ref(
    props.officer?.ProfileImage
        ? `/storage/profiles/${props.officer.ProfileImage}`
        : null,
);

const form = useForm({
    _method: "PUT",
    OfficerName: "",
    OfficerID_Code: "",
    RankID: "",
    RoleID: "",
    UnitID: null,
    PlanID: null,
    OfficeID: null,
    SectionID: null,
    PostID: null,
    Gender: "",
    DOB: "",
    StartDate: "",
    StatusID: "",
    StatusNote: "",
    ProfileImage: null,
    documents: [],
});

const handleFileChange = (event) => {
    const selectedFiles = Array.from(event.target.files);
    form.documents.push(...selectedFiles);
};

const viewFile = (file) => {
    if (file) {
        return URL.createObjectURL(file);
    }
    return "#";
};

const removeFile = (index) => {
    form.documents.splice(index, 1);
};

const deleteExistingFile = (docId) => {
    if (confirm("តើអ្នកចង់លុបឯកសារនេះមែនទេ?")) {
        const index = props.officer.documents.findIndex((d) => d.id === docId);
        if (index !== -1) {
            props.officer.documents.splice(index, 1);
        }
    }
};

const filteredPlans = computed(() => {
    const allPlans = props.plans || [];
    if (form.UnitID == 1) {
        return allPlans.filter((plan) => plan.unit_id == 1);
    }
    return [];
});

const filteredOffices = computed(() => {
    const allOffices = props.offices || [];

    // ១. Filter តាម PlanID ធម្មតា
    let filtered = [];
    if (form.PlanID) {
        filtered = allOffices.filter((office) => office.plan_id == form.PlanID);
    }
    if (form.OfficeID) {
        const hasValue = filtered.some((o) => o.id == form.OfficeID);
        if (!hasValue) {
            const currentObj = allOffices.find((o) => o.id == form.OfficeID);
            if (currentObj) {
                filtered.push(currentObj);
            }
        }
    }

    return filtered;
});

const filteredSections = computed(() => {
    const allSections = props.sections || [];
    let filtered = [];
    if (form.UnitID && form.UnitID != 1) {
        filtered = allSections.filter((s) => s.unit_id == form.UnitID);
    } else if (form.UnitID == 1 && form.OfficeID) {
        filtered = allSections.filter((s) => s.office_id == form.OfficeID);
    }
    if (form.SectionID) {
        const hasValue = filtered.some((s) => s.id == form.SectionID);
        if (!hasValue) {
            const currentObj = allSections.find((s) => s.id == form.SectionID);
            if (currentObj) {
                filtered.push(currentObj);
            }
        }
    }

    return filtered;
});

const filteredPosts = computed(() => {
    const allPosts = props.posts || [];
    if (form.UnitID) {
        let results = allPosts.filter((p) => p.unit_id == form.UnitID);
        if (form.PostID) {
            const hasPost = results.some((p) => p.id == form.PostID);
            if (!hasPost) {
                const currentPost = allPosts.find((p) => p.id == form.PostID);
                if (currentPost) results.push(currentPost);
            }
        }
        return results;
    }
    return [];
});

watch(
    () => form.UnitID,
    (newVal, oldVal) => {
        if (oldVal !== undefined && oldVal !== null) {
            form.PlanID = null;
            form.OfficeID = null;
            form.SectionID = null;
            form.PostID = null;
        }
    },
);

const isInitialLoad = ref(true);

watch(
    () => form.PlanID,
    (newVal, oldVal) => {
        if (!isInitialLoad.value && oldVal !== undefined && oldVal !== null) {
            form.OfficeID = null;
            form.SectionID = null;
        }
    },
);

watch(
    () => form.SectionID,
    (newVal) => {
        if (newVal) {
            form.PostID = null;
        }
    },
);
watch(
    () => form.PostID,
    (newVal) => {
        if (newVal) {
            form.SectionID = null;
        }
    },
);

watch(
    () => props.officer,
    (newVal) => {
        if (newVal) {
            form.OfficerName = newVal.OfficerName || "";
            form.OfficerID_Code = newVal.OfficerID_Code || "";
            form.RankID = newVal.RankID || "";
            form.RoleID = newVal.RoleID || "";
            form.UnitID = newVal.UnitID || null;
            form.PlanID = newVal.PlanID || null;
            form.OfficeID = newVal.OfficeID || null;
            form.SectionID = newVal.SectionID || null;
            form.PostID = newVal.PostID || null;
            form.Gender = newVal.Gender || "";
            form.DOB = newVal.DOB || "";
            form.StartDate = newVal.StartDate || "";
            form.StatusID = newVal.StatusID || "";

            if (newVal.ProfileImage) {
                imageUrl.value = `/storage/profiles/${newVal.ProfileImage}`;
            }
        }
    },
    { immediate: true },
);

onMounted(() => {
    const flatpickrConfig = {
        dateFormat: "Y-m-d",
        altInput: true,
        altFormat: "d-m-Y",
        allowInput: true,
    };

    if (dobInput.value) {
        flatpickr(dobInput.value, {
            ...flatpickrConfig,
            defaultDate: form.DOB,
            onChange: (selectedDates, dateStr) => {
                form.DOB = dateStr;
            },
        });
    }

    if (joiningDateInput.value) {
        flatpickr(joiningDateInput.value, {
            ...flatpickrConfig,
            defaultDate: form.StartDate,
            onChange: (selectedDates, dateStr) => {
                form.StartDate = dateStr;
            },
        });
    }
});

const showPreview = (event) => {
    const file = event.target.files[0];
    if (file) {
        form.ProfileImage = file;
        imageUrl.value = URL.createObjectURL(file);
    }
};

const submit = () => {
    form.transform((data) => ({
        ...data,
        _method: "PUT",
    })).post(route("staff.update", props.officer.ID), {
        forceFormData: true,
        onSuccess: () => {
            Swal.fire({
                title: "ជោគជ័យ!",
                text: "ព័ត៌មានមន្ត្រីត្រូវបានរក្សាទុកដោយជោគជ័យ",
                icon: "success",
                customClass: {
                    title: "font-siemreap",
                    htmlContainer: "font-siemreap",
                    confirmButton: "font-siemreap",
                },
                confirmButtonText: "យល់ព្រម",
                confirmButtonColor: "#01AAEB",
                timer: 3000,
            });

            form.documents = [];
        },
        onError: () => {
            Swal.fire({
                title: "មានបញ្ហា!",
                text: "សូមពិនិត្យមើលទិន្នន័យម្តងទៀត",
                icon: "error",
                customClass: {
                    title: "font-siemreap",
                    htmlContainer: "font-siemreap",
                    confirmButton: "font-siemreap",
                },
                confirmButtonText: "ព្យាយាមម្តងទៀត",
                confirmButtonColor: "#F44336",
            });
        },
    });
};
</script>

<template>
    <Head title="កែប្រែព័ត៌មានមន្ត្រី | ស្នងការដ្ឋាននគរបាលខេត្តប៉ៃលិន" />
    <AuthenticatedLayout>
        <div class="max-w-7xl mx-auto">
            <form
                @submit.prevent="submit"
                class="flex flex-col md:flex-row gap-6"
            >
                <div
                    class="bg-white p-6 rounded-2xl shadow-sm w-full md:w-1/3 flex flex-col items-center justify-start"
                >
                    <div class="flex flex-col items-center">
                        <div class="relative">
                            <div
                                v-if="!imageUrl"
                                class="w-52 h-60 rounded-xl bg-blue-300 flex items-center justify-center border-4 border-white shadow-md overflow-hidden"
                            >
                                <svg
                                    xmlns="http://www.w3.org/2000/svg"
                                    width="128"
                                    height="128"
                                    viewBox="0 0 128 128"
                                >
                                    <rect
                                        width="128"
                                        height="128"
                                        fill="none"
                                    />
                                    <path
                                        fill="#2a56c6"
                                        d="M17.5 118.45v10h93.87v-10c0-15.34-23.4-23.13-46.94-23.1c-23.38.02-46.93 6.85-46.93 23.1"
                                    />
                                    <path
                                        fill="#004373"
                                        d="M64.52 95.27c-8.69 0-14.54 1.06-14.54 1.06l6 31.67h8.54z"
                                    />
                                    <path
                                        fill="#004373"
                                        d="M64.08 95.27c8.4 0 14.12 1.05 14.12 1.05L72.73 128h-8.65z"
                                    />
                                    <path
                                        fill="#c48e6a"
                                        d="M64 90.08h-9.08v9.59c0 4.34 3.7 7.86 8.26 7.86h1.65c4.56 0 8.26-3.52 8.26-7.86v-9.59z"
                                    />
                                    <path
                                        fill="#fc0"
                                        d="M67.16 114.09h-5.64l-1.77-7.5h9.12zm2 18.29h-9.64l2-18.29h5.64z"
                                    />
                                    <path
                                        fill="#bfa055"
                                        d="M26.74 54.93s-.01-8.39-.01-19.81c0-11.94 8.76-28.47 38.04-28.47c20.44 0 28.08 8.09 28.08 13.48c0 0 7.59 1.36 8.34 11.09c.52 6.83-.15 23.25-.15 23.25s-.83-.73-1.76-1.16c-.5-.23-1-.33-1-.33l-1.38 9.37l-10.15-19.68a.32.32 0 0 0-.32-.17l-4.12.49a156.6 156.6 0 0 1-35.75.13L41 42.5a.33.33 0 0 0-.32.18L31.3 62.29l-1.42-9.54s-.98.39-1.86 1.07c-.83.64-1.28 1.11-1.28 1.11"
                                    />
                                    <path
                                        fill="#c48e6a"
                                        d="M97.09 52.31s6.06 1.05 6.06 7.57c0 5.75-4.42 8.03-8.84 8.03v-15.6zm-66.06 0s-6.06 1.05-6.06 7.57c0 5.75 4.42 8.03 8.84 8.03v-15.6z"
                                    />
                                    <path
                                        fill="#e0bb95"
                                        d="M64.06 9.59c-26.1 0-32.93 20.23-32.93 48.66c0 29.48 18.95 37.1 32.93 37.1c13.78 0 32.93-7.4 32.93-37.1C97 29.83 90.17 9.59 64.06 9.59"
                                    />
                                    <path
                                        fill="#4c3734"
                                        d="M73.5 77.88H54.64c-1.08 0-1.55.73-.83 1.82c1 1.52 4.72 4.46 10.26 4.46s9.26-2.93 10.26-4.46c.71-1.09.25-1.82-.83-1.82"
                                    />
                                    <path
                                        fill="#5d4037"
                                        d="M73.5 77.88H54.64c-1.08 0-1.55.73-.83 1.82c1 1.52 4.72 4.46 10.26 4.46s9.26-2.93 10.26-4.46c.71-1.09.25-1.82-.83-1.82"
                                    />
                                    <path
                                        fill="#c48e6a"
                                        d="M68.62 69.86c-1.61.45-3.27.68-4.56.68s-2.95-.22-4.56-.68c-.69-.19-.96.46-.71.89c.51.9 2.56 2.7 5.27 2.7s4.76-1.81 5.27-2.7c.25-.43-.02-1.08-.71-.89"
                                    />
                                    <path
                                        fill="#5d4037"
                                        d="M53.33 60.11c0 2.9-1.94 5.26-4.35 5.26s-4.36-2.36-4.36-5.26c0-2.91 1.96-5.27 4.36-5.27c2.41 0 4.35 2.36 4.35 5.27m21.46 0c0 2.9 1.95 5.26 4.36 5.26c2.4 0 4.36-2.36 4.36-5.26c0-2.91-1.96-5.27-4.36-5.27-2.41 0-4.36 2.36-4.36 5.27"
                                    />
                                    <path
                                        fill="#bfa055"
                                        d="M31.13 60.11L29.39 49.4S25.62 8.1 64.96 8.1s33.21 43.09 33.21 43.09l-1.2 8.92L86.75 42.8s-19.42 1.56-44.64-.33z"
                                    />
                                    <path
                                        d="M64 39.75c-18.69.13-35.62 3.51-35.62 3.51S37.09 53.2 64 53.41c26.91-.21 35.62-10.15 35.62-10.15S82.69 39.88 64 39.75"
                                    />
                                    <path
                                        fill="#2a56c6"
                                        d="M103.02 22.38c-2.3-2.94-4.11-4.72-7.08-6.87c-9.26-6.66-22.11-9.65-31.59-9.65c-.11 0-.23.01-.35.01c-.11 0-.24-.01-.35-.01c-9.48 0-22.33 2.99-31.59 9.65c-2.98 2.15-4.78 3.93-7.08 6.87c-3.38 4.32-4.08 10.96-1.97 16.55c1.69 4.47 3.69 7.52 3.69 7.52c1.87-3.79 4.52-6.13 8.15-7.14c3.72-1.03 17.24-2.16 29.15-2.67c11.91.5 25.43 1.64 29.15 2.67c3.63 1.01 6.27 3.35 8.15 7.14c0 0 2.01-3.05 3.69-7.52c2.11-5.59 1.42-12.23-1.97-16.55"
                                    />
                                    <path
                                        fill="#3b78e7"
                                        d="M97.54 32.72S82.96 23.99 64 23.89c-18.96.1-33.54 8.83-33.54 8.83l-1.6 10.54s16.15-3.53 35.13-3.57c18.98.04 35.13 3.57 35.13 3.57z"
                                    />
                                    <path
                                        fill="#f7cb4d"
                                        d="M71.59 16.55c-.27 0-.51.14-.65.36c-.57.91-1.4 1.53-2.87 1.53c-1.43 0-2.47-1.39-3.1-2.26c-.2-.27-.51-.44-.84-.44c-.34 0-.65.17-.85.45c-.61.86-1.61 2.25-3.03 2.25c-1.47 0-2.3-.62-2.87-1.53a.76.76 0 0 0-.65-.36c-.25 0-.48.12-.63.32l-.32.44c-.38.52-.44 1.22-.15 1.8c.43.87.66 1.83.66 2.8v3.79c0 2.76 4.26 8.41 7.87 8.41s7.87-5.65 7.87-8.41v-3.8c0-.97.23-1.93.66-2.8c.29-.58.23-1.27-.15-1.8l-.32-.44 a.82.82 0 0 0-.63-.31"
                                    />
                                    <path
                                        fill="#004373"
                                        d="M45.18 103.91c-9.37 2.11-14.35 2.11-23.72 0c-1.34-.3-2.17-1.52-1.86-2.66c.29-1.08.44-1.62.74-2.69c.31-1.14 1.5-1.79 2.67-1.53c8.15 1.83 12.48 1.83 20.63 0c1.17-.26 2.35.4 2.67 1.53c.29 1.08.44 1.62.74 2.69c.3 1.13-.53 2.36-1.87 2.66m38.11 0c9.37 2.11 14.35 2.11 23.72 0c1.34-.3 2.17-1.52 1.86-2.66c-.29-1.08-.44-1.62-.74-2.69c-.31-1.14-1.5-1.79-2.67-1.53c-8.15 1.83-12.48 1.83-20.63 0c-1.17-.26-2.35.4-2.67 1.53c-.29 1.08-.44 1.62-.74 2.69c-.29 1.13.53 2.36 1.87 2.66"
                                    />
                                    <path
                                        fill="#3b78e7"
                                        d="M73.27 95.67c0 1.53-1.31 4.42-3.4 6.82c-2.12 2.44-5.65 3.95-5.65 3.95l13.24 11.08l.87-21.19c0 .01-3.08-.47-5.06-.66"
                                    />
                                    <path
                                        fill="#3b78e7"
                                        d="M55.25 95.66c0 1.53 1.31 4.42 3.4 6.82c2.12 2.44 5.65 3.95 5.65 3.95l-13.55 11.09l-.56-21.21s3.03-.48 5.06-.65"
                                    />
                                </svg>
                            </div>

                            <img
                                v-else
                                :src="imageUrl"
                                :key="imageUrl"
                                class="w-52 h-60 object-cover mx-auto rounded-xl border-4 border-gray-200 shadow-md"
                            />
                        </div>

                        <label
                            for="file-upload"
                            class="mt-6 cursor-pointer bg-[#8cc63f] hover:bg-[#7ab336] text-white px-6 py-2 rounded-xl flex items-center gap-2 transition-all shadow-sm"
                        >
                            <svg
                                xmlns="http://www.w3.org/2000/svg"
                                width="24"
                                height="24"
                                viewBox="0 0 24 24"
                            >
                                <path
                                    fill="#fff"
                                    d="M21 19V5c0-1.1-.9-2-2-2H5c-1.1 0-2 .9-2 2v14c0 1.1.9 2 2 2h14c1.1 0 2-.9 2-2M8.5 13.5l2.5 3.01L14.5 12l4.5 6H5z"
                                />
                            </svg>
                            <span class="font-siemreap text-sm"
                                >ប្តូររូបភាព</span
                            >
                        </label>

                        <input
                            id="file-upload"
                            type="file"
                            class="hidden"
                            accept="image/*"
                            @change="showPreview"
                        />

                        <p
                            v-if="form.errors.ProfileImage"
                            class="text-red-500 text-xs mt-2 font-siemreap"
                        >
                            {{ form.errors.ProfileImage }}
                        </p>
                    </div>
                </div>
                <div class="bg-white p-8 rounded-2xl shadow-sm w-full md:w-3/4">
                    <h3 class="text-black mb-6 text-md pb-10 font-moul">
                        កែប្រែព័ត៌មានមន្រ្តី
                    </h3>
                    <div class="grid grid-cols-1 gap-4 mx-20 font-siemreap">
                        <div class="flex justify-between items-center">
                            <label class="block text-md text-gray-700 w-72"
                                >ឋានន្ដរស័ក្ដិ*:</label
                            >

                            <select
                                v-model="form.RankID"
                                :class="[
                                    'mt-1 block w-full leading-7 border border-gray-300 outline-none transition-all focus:border-blue-500 focus:ring-2 focus:ring-blue-200 rounded-md px-2 py-2 text-sm cursor-pointer',

                                    form.RankID === ''
                                        ? 'text-gray-500'
                                        : 'text-gray-900',
                                ]"
                                required
                            >
                                <option value="" disabled>
                                    ជ្រើសរើសឋានន្ដរស័ក្ដិ
                                </option>

                                <option
                                    v-for="rank in ranks"
                                    :key="rank.id"
                                    :value="rank.id"
                                >
                                    {{ rank.name }}
                                </option>
                            </select>
                        </div>
                        <div class="flex flex-col md:flex-row md:items-center">
                            <label class="block w-72 text-gray-700"
                                >ឈ្មោះ*:</label
                            >

                            <input
                                v-model="form.OfficerName"
                                type="text"
                                class="mt-1 block w-full outline-none leading-7 transition-all focus:border-blue-500 focus:ring-2 focus:ring-blue-200 border border-gray-300 rounded-md p-2 text-sm"
                            />
                        </div>
                        <div
                            v-if="form.errors.OfficerName"
                            class="text-red-500 text-xs mt-1 ml-0 md:ml-52"
                        >
                            {{ form.errors.OfficerName }}
                        </div>
                        <div class="flex flex-col md:flex-row md:items-center">
                            <label class="w-72 text-gray-700">ភេទ*:</label>

                            <select
                                v-model="form.Gender"
                                :class="[
                                    'mt-1 block w-full border border-gray-300 outline-none leading-7 transition-all focus:border-blue-500 focus:ring-2 focus:ring-blue-200 rounded-md p-2 text-sm cursor-pointer',
                                    form.Gender === ''
                                        ? 'text-gray-500'
                                        : 'text-gray-900',
                                ]"
                            >
                                <option value="" disabled>ជ្រើសរើសភេទ</option>

                                <option value="ប្រុស">ប្រុស</option>
                                <option value="ស្រី">ស្រី</option>
                            </select>
                        </div>
                        <div class="flex flex-col md:flex-row md:items-center">
                            <label class="w-72 text-gray-700"
                                >ថ្ងៃខែឆ្នាំកំណើត*:</label
                            >
                            <input
                                ref="dobInput"
                                v-model="form.DOB"
                                type="text"
                                class="mt-1 block w-full border border-gray-300 leading-7 outline-none transition-all focus:border-blue-500 focus:ring-2 focus:ring-blue-200 rounded-md p-2 text-sm cursor-pointer bg-white"
                            />
                        </div>
                        <div class="flex flex-col">
                            <div
                                class="flex flex-col md:flex-row md:items-center"
                            >
                                <label class="w-72 text-gray-700"
                                    >អត្តលេខ*:</label
                                >
                                <input
                                    readonly=""
                                    v-model="form.OfficerID_Code"
                                    type="text"
                                    :class="{
                                        'border-red-500 focus:ring-red-200':
                                            form.errors.OfficerID_Code,
                                    }"
                                    class="mt-1 block w-full border border-gray-300 leading-7 outline-none transition-all focus:border-blue-500 focus:ring-2 focus:ring-blue-200 rounded-md p-2 text-sm"
                                />
                            </div>

                            <div
                                v-if="form.errors.OfficerID_Code"
                                class="text-red-500 text-xs mt-1 ml-0 md:ml-72 font-siemreap"
                            >
                                {{ form.errors.OfficerID_Code }}
                            </div>
                        </div>
                        <div class="flex flex-col md:flex-row md:items-center">
                            <label class="w-72 text-gray-700">តួនាទី*:</label>
                            <div class="w-full">
                                <select
                                    v-model="form.RoleID"
                                    :class="[
                                        'mt-1 block w-full border border-gray-300 leading-7 outline-none transition-all focus:border-blue-500 focus:ring-2 focus:ring-blue-200 rounded-md p-2 text-sm cursor-pointer',
                                        form.RoleID === ''
                                            ? 'text-gray-500'
                                            : 'text-gray-900',
                                        form.errors.RoleID
                                            ? 'border-red-500'
                                            : 'border-gray-300',
                                    ]"
                                >
                                    <option value="" disabled>
                                        ជ្រើសរើសតួនាទី
                                    </option>
                                    <option
                                        v-for="role in props.roles"
                                        :key="role.id"
                                        :value="role.id"
                                    >
                                        {{ role.name }}
                                    </option>
                                </select>
                                <p
                                    v-if="form.errors.RoleID"
                                    class="text-red-500 text-xs mt-1"
                                >
                                    {{ form.errors.RoleID }}
                                </p>
                            </div>
                        </div>
                        <div class="flex flex-col md:flex-row md:items-center">
                            <label class="w-72 text-gray-700 font-siemreap"
                                >អង្គភាព*:</label
                            >
                            <div class="w-full">
                                <select
                                    v-model="form.UnitID"
                                    required
                                    class="mt-1 block w-full border border-gray-300 leading-7 outline-none transition-all focus:border-blue-500 focus:ring-2 focus:ring-blue-200 rounded-md p-2 text-sm cursor-pointer"
                                    :class="{
                                        'text-gray-500': form.UnitID === '',
                                        'text-gray-900': form.UnitID !== '',
                                        'border-red-500': form.errors.UnitID,
                                    }"
                                >
                                    <option value="" disabled>
                                        ជ្រើសរើសអង្គភាព
                                    </option>
                                    <option
                                        v-for="unit in props.units"
                                        :key="unit.id"
                                        :value="unit.id"
                                    >
                                        {{ unit.name }}
                                    </option>
                                </select>
                                <p
                                    v-if="form.errors.UnitID"
                                    class="text-red-500 text-xs mt-1"
                                >
                                    {{ form.errors.UnitID }}
                                </p>
                            </div>
                        </div>

                        <div class="flex flex-col md:flex-row md:items-center">
                            <label class="w-72 text-gray-700 font-siemreap"
                                >ផែន*:</label
                            >
                            <div class="w-full">
                                <select
                                    v-model="form.PlanID"
                                    :disabled="form.UnitID != 1"
                                    class="mt-1 block w-full border border-gray-300 leading-7 outline-none transition-all focus:border-blue-500 focus:ring-2 focus:ring-blue-200 rounded-md p-2 text-sm"
                                    :class="[
                                        form.UnitID != 1
                                            ? 'bg-gray-100 cursor-not-allowed text-gray-400'
                                            : 'bg-white cursor-pointer focus:border-blue-500 focus:ring-2 focus:ring-blue-200',

                                        !form.PlanID
                                            ? 'text-gray-500'
                                            : 'text-gray-900',
                                        {
                                            'border-red-500':
                                                form.errors.PlanID,
                                        },
                                    ]"
                                >
                                    <option :value="null">ជ្រើសរើសផែន</option>

                                    <option
                                        v-for="plan in filteredPlans"
                                        :key="plan.id"
                                        :value="plan.id"
                                    >
                                        {{ plan.name }}
                                    </option>
                                </select>
                            </div>
                        </div>

                        <div class="flex flex-col md:flex-row md:items-center">
                            <label class="w-72 text-gray-700 font-siemreap"
                                >ការិយាល័យ*:</label
                            >
                            <div class="w-full">
                                <select
                                    v-model="form.OfficeID"
                                    :disabled="!form.PlanID"
                                    class="mt-1 block w-full border border-gray-300 leading-7 outline-none transition-all focus:border-blue-500 focus:ring-2 focus:ring-blue-200 rounded-md p-2 text-sm"
                                    :class="[
                                        !form.PlanID
                                            ? 'bg-gray-100 cursor-not-allowed text-gray-400'
                                            : 'bg-white cursor-pointer focus:border-blue-500 focus:ring-2 focus:ring-blue-200',
                                        !form.OfficeID
                                            ? 'text-gray-500'
                                            : 'text-gray-900',
                                        {
                                            'border-red-500':
                                                form.errors.OfficeID,
                                        },
                                    ]"
                                >
                                    <option :value="null">
                                        ជ្រើសរើសការិយាល័យ
                                    </option>

                                    <option
                                        v-for="office in filteredOffices"
                                        :key="office.id"
                                        :value="office.id"
                                    >
                                        {{ office.name }}
                                    </option>
                                </select>
                            </div>
                        </div>

                        <div class="flex flex-col md:flex-row md:items-center">
                            <label class="w-72 text-gray-700 font-siemreap"
                                >ផ្នែក*:</label
                            >
                            <div class="w-full">
                                <select
                                    v-model="form.SectionID"
                                    :disabled="
                                        (form.UnitID == 1 &&
                                            (!form.PlanID || !form.OfficeID)) ||
                                        !!form.PostID ||
                                        !form.UnitID
                                    "
                                    class="mt-1 block w-full border border-gray-300 leading-7 outline-none transition-all rounded-md p-2 text-sm"
                                    :class="[
                                        (form.UnitID == 1 &&
                                            (!form.PlanID || !form.OfficeID)) ||
                                        !!form.PostID ||
                                        !form.UnitID
                                            ? 'bg-gray-100 cursor-not-allowed text-gray-400'
                                            : 'bg-white cursor-pointer focus:border-blue-500 focus:ring-2 focus:ring-blue-200',
                                        !form.SectionID
                                            ? 'text-gray-500'
                                            : 'text-gray-900',
                                        {
                                            'border-red-500':
                                                form.errors.SectionID,
                                        },
                                    ]"
                                >
                                    <option :value="null">ជ្រើសរើសផ្នែក</option>
                                    <option
                                        v-for="section in filteredSections"
                                        :key="section.id"
                                        :value="section.id"
                                    >
                                        {{ section.name }}
                                    </option>
                                </select>
                            </div>
                        </div>

                        <div class="flex flex-col md:flex-row md:items-center">
                            <label class="w-72 text-gray-700 font-siemreap"
                                >ប៉ុស្តិ៍*:</label
                            >
                            <div class="w-full">
                                <select
                                    v-model="form.PostID"
                                    :disabled="
                                        !form.UnitID ||
                                        form.UnitID == 1 ||
                                        !!form.SectionID
                                    "
                                    class="mt-1 block w-full border border-gray-300 leading-7 outline-none transition-all rounded-md p-2 text-sm"
                                    :class="[
                                        !form.UnitID ||
                                        form.UnitID == 1 ||
                                        !!form.SectionID
                                            ? 'bg-gray-100 cursor-not-allowed text-gray-400'
                                            : 'bg-white cursor-pointer focus:border-blue-500 focus:ring-2 focus:ring-blue-200',
                                        !form.PostID
                                            ? 'text-gray-500'
                                            : 'text-gray-900',
                                        {
                                            'border-red-500':
                                                form.errors.PostID,
                                        },
                                    ]"
                                >
                                    <option :value="null">
                                        ជ្រើសរើសប៉ុស្តិ៍
                                    </option>
                                    <option
                                        v-for="post in filteredPosts"
                                        :key="post.id"
                                        :value="post.id"
                                    >
                                        {{ post.name }}
                                    </option>
                                </select>
                            </div>
                        </div>
                        <div class="flex flex-col md:flex-row md:items-center">
                            <label class="w-72 text-gray-700"
                                >ថ្ងៃចូលនគរបាលជាតិ*:</label
                            >
                            <div class="w-full">
                                <input
                                    type="text"
                                    ref="joiningDateInput"
                                    v-model="form.StartDate"
                                    class="mt-1 block w-full border border-gray-300 leading-7 outline-none transition-all focus:border-blue-500 focus:ring-2 focus:ring-blue-200 rounded-md p-2 text-sm bg-white cursor-pointer"
                                />
                            </div>
                        </div>
                        <div class="flex flex-col gap-4">
                            <div
                                class="flex flex-col md:flex-row md:items-center"
                            >
                                <label class="w-72 text-gray-700 font-siemreap"
                                    >ស្ថានភាព*:</label
                                >

                                <div class="w-full">
                                    <select
                                        v-model="form.StatusID"
                                        required
                                        class="mt-1 block w-full border leading-7 outline-none transition-all focus:border-blue-500 focus:ring-2 focus:ring-blue-200 rounded-md p-2 text-sm cursor-pointer"
                                        :class="[
                                            form.StatusID === '' ||
                                            form.StatusID === null
                                                ? 'text-gray-500'
                                                : 'text-gray-900',
                                            form.errors.StatusID
                                                ? 'border-red-500'
                                                : 'border-gray-300',
                                        ]"
                                    >
                                        <option value="" disabled>
                                            ជ្រើសរើសស្ថានភាព
                                        </option>
                                        <option
                                            v-for="status in statuses"
                                            :key="status.id"
                                            :value="status.id"
                                        >
                                            {{ status.name }}
                                        </option>
                                    </select>

                                    <p
                                        v-if="form.errors.StatusID"
                                        class="text-red-500 text-[11px] mt-1 font-siemreap"
                                    >
                                        {{ form.errors.StatusID }}
                                    </p>
                                </div>
                            </div>

                            <div
                                v-if="
                                    [4, 5, 6, 12].includes(
                                        Number(form.StatusID),
                                    )
                                "
                                class="flex flex-col md:flex-row md:items-center animate-fade-in"
                            >
                                <label class="w-72 text-gray-700 font-siemreap"
                                    >បញ្ជាក់*:</label
                                >
                                <div class="w-full">
                                    <input
                                        type="text"
                                        v-model="form.StatusNote"
                                        placeholder="បញ្ជាក់មូលហេតុ ឬព័ត៌មានបន្ថែម..."
                                        class="mt-1 block w-full border border-gray-300 leading-7 outline-none transition-all focus:border-blue-500 focus:ring-2 focus:ring-blue-200 rounded-md p-2 text-sm font-siemreap"
                                        :class="
                                            form.errors.StatusNote
                                                ? 'border-red-500'
                                                : 'border-gray-300'
                                        "
                                    />
                                    <p
                                        v-if="form.errors.StatusNote"
                                        class="text-red-500 text-[11px] mt-1 font-siemreap"
                                    >
                                        {{ form.errors.StatusNote }}
                                    </p>
                                </div>
                            </div>
                        </div>
                        <div class="flex justify-between items-start gap-4">
                            <label
                                class="block text-md font-medium text-gray-700 w-64 mt-2 font-siemreap"
                            >
                                សំណុំឯកសារ* :
                            </label>

                            <div class="w-full">
                                <label
                                    for="multi-upload"
                                    class="flex flex-col items-center justify-center w-full h-32 border-2 border-dashed border-gray-300 rounded-xl bg-gray-50 hover:bg-blue-50 hover:border-blue-400 transition-all cursor-pointer group"
                                >
                                    <div
                                        class="flex flex-col items-center justify-center pt-5 pb-6"
                                    >
                                        <svg
                                            class="w-10 h-10 mb-3 text-gray-400 group-hover:text-blue-500 transition-colors"
                                            fill="none"
                                            stroke="currentColor"
                                            viewBox="0 0 24 24"
                                        >
                                            <path
                                                stroke-linecap="round"
                                                stroke-linejoin="round"
                                                stroke-width="2"
                                                d="M7 16a4 4 0 01-.88-7.903A5 5 0 1115.9 6L16 6a5 5 0 011 9.9M15 13l-3-3m0 0l-3 3m3-3v12"
                                            ></path>
                                        </svg>
                                        <p
                                            class="mb-1 text-sm text-gray-500 font-siemreap"
                                        >
                                            <span
                                                class="font-semibold text-blue-600"
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

                                <div class="mt-3 space-y-2">
                                    <div
                                        v-for="doc in props.officer.documents"
                                        :key="'old-' + doc.DocID"
                                        class="flex items-center justify-between p-3 bg-white border border-gray-200 rounded-lg shadow-sm w-full"
                                    >
                                        <div class="flex items-center gap-3">
                                            <svg
                                                class="w-6 h-6 text-blue-500"
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
                                            <a
                                                :href="
                                                    '/storage/' + doc.FilePath
                                                "
                                                target="_blank"
                                                class="text-sm font-medium text-gray-700 hover:text-blue-600 hover:underline truncate max-w-md transition-all"
                                            >
                                                {{ doc.FileName }}
                                            </a>
                                        </div>
                                        <button
                                            type="button"
                                            @click="
                                                deleteExistingFile(doc.DocID)
                                            "
                                            class="p-1 hover:bg-red-50 rounded-full transition-colors group"
                                        >
                                            <svg
                                                class="w-5 h-5 text-gray-400 group-hover:text-red-500"
                                                fill="none"
                                                stroke="currentColor"
                                                viewBox="0 0 24 24"
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

                                    <div
                                        v-for="(file, index) in form.documents"
                                        :key="'new-' + index"
                                        class="flex items-center justify-between p-3 bg-white border border-gray-200 rounded-lg shadow-sm w-full"
                                    >
                                        <div class="flex items-center gap-3">
                                            <svg
                                                class="w-6 h-6 text-blue-500"
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
                                            <div class="flex flex-col">
                                                <a
                                                    :href="viewFile(file)"
                                                    target="_blank"
                                                    class="text-sm font-medium text-gray-700 hover:text-blue-600 hover:underline truncate max-w-md transition-all"
                                                >
                                                    {{ file.name }}
                                                </a>
                                            </div>
                                        </div>
                                        <button
                                            type="button"
                                            @click="removeFile(index)"
                                            class="p-1 hover:bg-red-50 rounded-full transition-colors group"
                                        >
                                            <svg
                                                class="w-5 h-5 text-gray-400 group-hover:text-red-500"
                                                fill="none"
                                                stroke="currentColor"
                                                viewBox="0 0 24 24"
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
                        <form
                            @submit.prevent="submit"
                            enctype="multipart/form-data"
                        >
                            <div
                                class="pt-6 border-t border-gray-50 flex justify-start items-center gap-4"
                            >
                                <button
                                    type="submit"
                                    :disabled="form.processing"
                                    class="bg-[#01AAEB] text-white px-6 py-2 rounded-xl text-md font-siemreap hover:scale-105 transition-all shadow-lg shadow-blue-100 active:scale-95 flex items-center gap-2 cursor-pointer disabled:opacity-50 disabled:cursor-not-allowed"
                                >
                                    <svg
                                        xmlns="http://www.w3.org/2000/svg"
                                        width="24"
                                        height="24"
                                        viewBox="0 0 24 24"
                                    >
                                        <path
                                            fill="#fff"
                                            d="M21 7v12q0 .825-.587 1.413T19 21H5q-.825 0-1.412-.587T3 19V5q0-.825.588-1.412T5 3h12zm-6.875 10.125Q15 16.25 15 15t-.875-2.125T12 12t-2.125.875T9 15t.875 2.125T12 18t2.125-.875M6 10h9V6H6z"
                                        /></svg
                                    ><span>{{
                                        form.processing
                                            ? "កំពុងរក្សាទុក..."
                                            : "រក្សាទុក"
                                    }}</span>
                                </button>

                                <Link
                                    :href="route(origin)"
                                    class="bg-[#F44336] text-white px-6 py-2 rounded-xl text-md font-siemreap hover:scale-105 transition-all shadow-lg shadow-red-100 active:scale-95 flex items-center gap-2 cursor-pointer"
                                >
                                    <svg
                                        xmlns="http://www.w3.org/2000/svg"
                                        width="24"
                                        height="24"
                                        viewBox="0 0 24 24"
                                    >
                                        <path
                                            fill="#fff"
                                            d="M19 6.41L17.59 5 12 10.59 6.41 5 5 6.41 10.59 12 5 17.59 6.41 19 12 13.41 17.59 19 19 17.59 13.41 12z"
                                        />
                                    </svg>
                                    <span>បោះបង់</span>
                                </Link>
                            </div>
                        </form>
                    </div>
                </div>
            </form>
        </div>
    </AuthenticatedLayout>
</template>
