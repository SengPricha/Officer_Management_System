<script setup>
import AuthenticatedLayout from "@/Layouts/AuthenticatedLayout.vue";
import { Head } from "@inertiajs/vue3";
import { computed } from "vue";

const props = defineProps({
    totalOfficers: {
        type: Number,
        default: 0,
    },
    activeOfficers: {
        type: Number,
        default: 0,
    },
    maleOfficers: {
        type: Number,
        default: 0,
    },
    femaleOfficers: {
        type: Number,
        default: 0,
    },
});

const toKhmerNumber = (num) => {
    const khmerDigits = ["០", "១", "២", "៣", "៤", "៥", "៦", "៧", "៨", "៩"];
    return num.toString().replace(/\d/g, (digit) => khmerDigits[digit]);
};

const totalOfficersKhmer = computed(() => toKhmerNumber(props.totalOfficers));
const activeOfficersKhmer = computed(() => toKhmerNumber(props.activeOfficers));
</script>

<template>
    <Head title="ផ្ទាំងគ្រប់គ្រង | ស្នងការដ្ឋាននគរបាលខេត្តប៉ៃលិន" />
    <AuthenticatedLayout>
        <div class="py-4 md:py-2">
            <div
                class="grid grid-cols-2 md:grid-cols-2 lg:grid-cols-4 md:gap-6 gap-2 mx-auto px-6 xl:px-8"
            >
                <div
                    class="bg-[#01AAEB] md:p-7 p-4 rounded-2xl shadow-sm flex items-center justify-start transition transform hover:scale-105 md:h-full h-20"
                >
                    <div>
                        <p
                            class="text-sm xl:text-lg font-medium text-white xl:mb-2 mb-0 font-siemreap"
                        >
                            ចំនួនមន្រ្តីសរុប
                        </p>
                        <p
                            class="xl:text-2xl text-xl font-bold text-white mt-2 font-siemreap"
                        >
                            {{ totalOfficersKhmer }} នាក់
                        </p>
                    </div>
                </div>
                <div
                    class="bg-[#8BC34A] md:p-7 p-4 rounded-2xl shadow-sm flex items-center justify-start transition transform hover:scale-105 md:h-full h-20"
                >
                    <div>
                        <p
                            class="text-sm xl:text-lg font-medium text-white xl:mb-2 mb-0 font-siemreap"
                        >
                            សរុបមន្រ្តីសកម្ម
                        </p>
                        <p
                            class="xl:text-2xl text-xl font-bold text-white mt-2 font-siemreap"
                        >
                            {{ activeOfficersKhmer }} នាក់
                        </p>
                    </div>
                </div>
                <div
                    class="bg-[#FFC107] md:p-7 p-4 rounded-2xl shadow-sm flex items-center justify-start transition transform hover:scale-105 md:h-full h-20"
                >
                    <div>
                        <p
                            class="text-sm xl:text-lg font-medium text-white xl:mb-2 mb-0 font-siemreap"
                        >
                            សរុបមន្រ្តីប្រុស
                        </p>
                        <p
                            class="xl:text-2xl text-xl font-bold text-white mt-2 font-siemreap"
                        >
                            {{ toKhmerNumber(props.maleOfficers) }} នាក់
                        </p>
                    </div>
                </div>
                <div
                    class="bg-[#F44336] md:p-7 p-4 rounded-2xl shadow-sm flex items-center justify-start transition transform hover:scale-105 md:h-full h-20"
                >
                    <div>
                        <p
                            class="text-sm xl:text-lg font-medium text-white xl:mb-2 mb-0 font-siemreap"
                        >
                            សរុបមន្រ្តីស្រី
                        </p>
                        <p
                            class="xl:text-2xl text-xl font-bold text-white mt-2 font-siemreap"
                        >
                            {{ toKhmerNumber(props.femaleOfficers) }} នាក់
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </AuthenticatedLayout>
</template>
