<script setup>
import AuthenticatedLayout from "@/Layouts/AuthenticatedLayout.vue";
import { Link, Head } from "@inertiajs/vue3";
import { computed } from "vue";

const props = defineProps({
    unit: Object,
    officer: Object,
    ranks: Array,
    roles: Array,
    plan: Array,
});


const leader = computed(() =>
    props.unit.officers.filter((o) => o.RoleID === 1)
);
const deputies = computed(() =>
    props.unit.officers.filter((o) => o.RoleID === 2)
);



const goBack = () => {
    window.history.back();
};

const customTitles = {
    1: "ស្នងការ និងស្នងការរង | ស្នងការដ្ឋាននគរបាលខេត្តប៉ៃលិន",
    2: "អធិការ និងអធិការរង | អធិការដ្ឋាននគរបាលក្រុងប៉ៃលិន",
    3: "អធិការ និងអធិការរង | អធិការដ្ឋាននគរបាលស្រុកសាលាក្រៅ",
    4: "មេបញ្ជាការ និងមេបញ្ជាការរង | វរសេនាតូចនគរបាលការពារព្រំដែនគោកលេខ៨២១",
};

const Texts = {
    1: "ស្នងការ និងស្នងការរងនៃស្នងការដ្ឋាននគរបាលខេត្តប៉ៃលិន",
    2: "អធិការ និងអធិការរងនៃអធិការដ្ឋាននគរបាលក្រុងប៉ៃលិន",
    3: "អធិការ និងអធិការរងនៃអធិការដ្ឋាននគរបាលស្រុកសាលាក្រៅ",
    4: "មេបញ្ជាការ និងមេបញ្ជាការរងនៃវរសេនាតូចនគរបាលការពារព្រំដែនគោកលេខ ៨២១",
};
</script>

<template>
    <Head :title="customTitles[unit?.UnitID] || 'ព័ត៌មានអង្គភាព'" />

    <AuthenticatedLayout>
        <!-- Header -->
        <div
            class="flex items-center justify-between bg-white p-4 rounded-lg shadow-sm mb-3 font-siemreap"
        >
            <div class="flex items-center space-x-2">
                <Link
                    :href="route('structure.index')"
                    class="flex items-center text-gray-500 hover:text-[#01AAEB] gap-2 hover:underline hover:font-bold"
                >
                    <span>រចនាសម្ព័ន្ធ</span>
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
                    {{ unit?.UnitName || "ព័ត៌មានលម្អិត" }}
                </span>
            </div>

            <button
                @click="goBack"
                class="flex items-center px-4 py-2 bg-[#01AAEB] text-white rounded-lg hover:bg-[#01a9ebdc]"
            >
                ត្រឡប់ក្រោយ
            </button>
        </div>

        <!-- Title -->
        <div class="bg-white px-4 py-6 rounded-lg shadow-sm mb-6 font-siemreap">
            <h1 class="font-moul text-sm font-medium">
                {{ Texts[unit?.UnitID] }}
            </h1>
        </div>

        <!-- <div class="flex justify-center items-center flex-col">
            <div
                class="flex justify-center items-center bg-white py-4 px-5 rounded-lg shadow-sm mb-3 gap-4"
                v-for="officer in leader"
                :key="officer.ID"
            >
                <div>
                    <img
                        :src="
                            officer.ProfileImage
                                ? '/storage/profiles/' + officer.ProfileImage
                                : '/images/default-avatar.png'
                        "
                        class="w-20 h-28 rounded-md"
                    />
                </div>
                <div>
                    <p class="text-gray-600 font-bold font-siemreap text-md">
                        {{ officer.rank ? officer.rank.RankName : "---" }}
                    </p>

                    <h4 class="text-gray-800 font-medium font-moul">
                        {{ officer.OfficerName }}
                    </h4>

                    <p class="text-gray-600 font-bold font-siemreap text-md">
                        {{ officer.role ? officer.role.RoleName : "---" }}
                    </p>
                </div>
            </div>
            <div class="w-[2px] h-20 bg-black/50"></div>
            <div
                class="flex justify-center items-center bg-white py-4 px-5 rounded-lg shadow-sm mb-3 gap-4"
                v-for="officer in deputies"
                :key="officer.ID"
            >
                <div>
                    <img
                        :src="
                            officer.ProfileImage
                                ? '/storage/profiles/' + officer.ProfileImage
                                : '/images/default-avatar.png'
                        "
                        class="w-20 h-28 rounded-md"
                    />
                </div>
                <div>
                    <p class="text-gray-600 font-bold font-siemreap text-md">
                        {{ officer.rank ? officer.rank.RankName : "---" }}
                    </p>

                    <h4 class="text-gray-800 font-medium font-moul">
                        {{ officer.OfficerName }}
                    </h4>

                    <p class="text-gray-600 font-bold font-siemreap text-md">
                        {{ officer.role ? officer.role.RoleName : "---" }}
                    </p>
                </div>
            </div>
        </div> -->
    </AuthenticatedLayout>
</template>
