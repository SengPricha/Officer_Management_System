<template>
    <div
        v-if="links.length > 3"
        class="flex flex-wrap justify-center items-center mt-8 gap-2"
    >
        <template v-for="(link, key) in links" :key="key">
            <div
                v-if="link.url === null"
                class="px-4 py-2 text-sm text-gray-400 bg-white border border-gray-200 rounded-lg cursor-not-allowed font-siemreap"
                v-html="cleanLabel(link.label)"
            />

            <Link
                v-else
                :href="link.url"
                class="px-4 py-2 text-sm border rounded-lg transition-all duration-200 font-siemreap shadow-sm"
                :class="{
                    'bg-[#01AAEB] text-white border-[#01AAEB] scale-105 shadow-md':
                        link.active,
                    'bg-white text-gray-700 hover:bg-blue-50 border-gray-200 hover:border-blue-300':
                        !link.active,
                }"
                v-html="cleanLabel(link.label)"
                preserve-scroll
            />
        </template>
    </div>
</template>

<script setup>
import { Link } from "@inertiajs/vue3";

defineProps({
    links: Array,
});
const cleanLabel = (label) => {
    let newLabel = label
        .replace("&laquo; Previous", "ថយក្រោយ")
        .replace("Next &raquo;", "បន្ទាប់");
    if (!isNaN(newLabel)) {
        return toKhmerNumber(newLabel);
    }
    return newLabel;
};
const toKhmerNumber = (num) => {
    const khmerNumbers = ["០", "១", "២", "៣", "៤", "៥", "៦", "៧", "៨", "៩"];
    return num.toString().replace(/[0-9]/g, (n) => khmerNumbers[n]);
};
</script>
