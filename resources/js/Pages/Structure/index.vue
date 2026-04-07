<script setup>
import AuthenticatedLayout from "@/Layouts/AuthenticatedLayout.vue";
import { ref } from "vue";
import { Link, Head } from "@inertiajs/vue3";

const props = defineProps({
    units: Array,
});

const openStates = ref({});

const toggle = (type, id) => {
    const key = `${type}_${id}`;
    openStates.value[key] = !openStates.value[key];
};

const toRoman = (num) => {
    const roman = ["I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX", "X"];
    return roman[num] || num + 1;
};

const toKhmerNum = (num) => {
    const khmerNumbers = ["០", "១", "២", "៣", "៤", "៥", "៦", "៧", "៨", "៩"];
    return num ? num.toString().replace(/\d/g, (d) => khmerNumbers[d]) : "";
};
</script>

<template>
    <Head title="រចនាសម្ព័ន្ធ | ស្នងការដ្ឋាននគរបាលខេត្តប៉ៃលិន" />
    <AuthenticatedLayout>
        <div class="p-6 bg-gray-50 min-h-screen font-siemreap text-gray-800">
            <h2
                class="text-xl font-moul mb-6 text-black border-b-2 border-gray-200 pb-2"
            >
                រចនាសម្ព័ន្ធស្នងការដ្ឋាននគរបាលខេត្តប៉ៃលិន
            </h2>

            <div class="space-y-4">
                <div
                    v-for="(unit, index) in units"
                    :key="'u' + unit.UnitID"
                    class="bg-white rounded-lg shadow-sm border border-gray-200 overflow-hidden"
                >
                    <div
                        class="p-4 flex justify-between items-center hover:bg-blue-50 transition-colors cursor-pointer"
                        @click="toggle('unit', unit.UnitID)"
                    >
                        <Link
                            :href="route('unit.show', { unit: unit.UnitID })"
                            @click.stop
                            class="font-bold text-lg text-gray-800 hover:text-[#01AAEB] hover:underline flex-grow"
                        >
                            {{ toRoman(index) }}. {{ unit.UnitName }}
                        </Link>

                        <div
                            class="p-2 bg-gray-50 rounded-lg border border-gray-200 shadow-sm transition-transform active:scale-95"
                        >
                            <svg
                                v-if="openStates['unit_' + unit.UnitID]"
                                xmlns="http://www.w3.org/2000/svg"
                                width="20"
                                height="20"
                                viewBox="0 0 24 24"
                                fill="none"
                                stroke="currentColor"
                                stroke-width="2.5"
                                stroke-linecap="round"
                                stroke-linejoin="round"
                                class="text-red-500"
                            >
                                <line x1="18" y1="6" x2="6" y2="18"></line>
                                <line x1="6" y1="6" x2="18" y2="18"></line>
                            </svg>
                            <svg
                                v-else
                                xmlns="http://www.w3.org/2000/svg"
                                width="20"
                                height="20"
                                viewBox="0 0 24 24"
                                fill="none"
                                stroke="currentColor"
                                stroke-width="2"
                                stroke-linecap="round"
                                stroke-linejoin="round"
                                class="text-gray-500"
                            >
                                <line x1="3" y1="12" x2="21" y2="12"></line>
                                <line x1="3" y1="6" x2="21" y2="6"></line>
                                <line x1="3" y1="18" x2="21" y2="18"></line>
                            </svg>
                        </div>
                    </div>

                    <div
                        v-if="openStates['unit_' + unit.UnitID]"
                        class="p-4 border-t bg-gray-50/50 space-y-2"
                    >
                        <div
                            v-for="sec in unit.section"
                            :key="'us' + sec.SectionID"
                            class="ml-8 border-l-2 border-gray-300 pl-4 py-1"
                        >
                            <Link
                                :href="
                                    route('unit.section.show', {
                                        unit: unit.UnitID,
                                        section: sec.SectionID,
                                    })
                                "
                                class="text-[#01AAEB] hover:underline font-medium text-sm"
                            >
                                — {{ sec.SectionName }}
                            </Link>
                        </div>

                        <div
                            v-for="post in unit.post"
                            :key="'up' + post.PostID"
                            class="ml-8 border-l-2 border-gray-300 pl-4 py-1"
                        >
                            <Link
                                :href="
                                    route('unit.post.show', {
                                        unit: unit.UnitID,
                                        post: post.PostID,
                                    })
                                "
                                class="text-[#01AAEB] hover:underline font-medium text-sm"
                            >
                                — {{ post.PostName }}
                            </Link>
                        </div>

                        <div
                            v-for="plan in unit.plan"
                            :key="'p' + plan.PlanID"
                            class="ml-8 border-l-2 border-blue-200 pl-4"
                        >
                            <div
                                class="flex items-center justify-between py-2 cursor-pointer group"
                                @click="toggle('plan', plan.PlanID)"
                            >
                                <Link
                                    :href="
                                        route('plan.show', {
                                            unit: unit.UnitID,
                                            plan: plan.PlanID,
                                        })
                                    "
                                    @click.stop
                                    class="font-medium text-[#01AAEB] hover:text-[#01a9ebdc] hover:underline flex-grow"
                                >
                                    {{ toKhmerNum(plan.PlanID) }}-{{
                                        plan.PlanName
                                    }}
                                </Link>
                                <div class="ml-2">
                                    <svg
                                        v-if="openStates['plan_' + plan.PlanID]"
                                        xmlns="http://www.w3.org/2000/svg"
                                        width="16"
                                        height="16"
                                        viewBox="0 0 24 24"
                                        fill="none"
                                        stroke="currentColor"
                                        stroke-width="2.5"
                                        stroke-linecap="round"
                                        stroke-linejoin="round"
                                        class="text-red-500"
                                    >
                                        <line
                                            x1="18"
                                            y1="6"
                                            x2="6"
                                            y2="18"
                                        ></line>
                                        <line
                                            x1="6"
                                            y1="6"
                                            x2="18"
                                            y2="18"
                                        ></line>
                                    </svg>
                                    <svg
                                        v-else
                                        xmlns="http://www.w3.org/2000/svg"
                                        width="16"
                                        height="16"
                                        viewBox="0 0 24 24"
                                        fill="none"
                                        stroke="currentColor"
                                        stroke-width="2"
                                        stroke-linecap="round"
                                        stroke-linejoin="round"
                                        class="text-gray-400"
                                    >
                                        <line
                                            x1="3"
                                            y1="12"
                                            x2="21"
                                            y2="12"
                                        ></line>
                                        <line
                                            x1="3"
                                            y1="6"
                                            x2="21"
                                            y2="6"
                                        ></line>
                                        <line
                                            x1="3"
                                            y1="18"
                                            x2="21"
                                            y2="18"
                                        ></line>
                                    </svg>
                                </div>
                            </div>

                            <div
                                v-if="openStates['plan_' + plan.PlanID]"
                                class="my-2 ml-4 space-y-2"
                            >
                                <div
                                    v-for="office in plan.office"
                                    :key="'o' + office.OfficeID"
                                    class="bg-white p-3 rounded-lg border border-blue-100 shadow-sm"
                                >
                                    <div
                                        class="flex justify-between items-center cursor-pointer"
                                        @click="
                                            toggle('office', office.OfficeID)
                                        "
                                    >
                                        <Link
                                            :href="
                                                route('office.show', {
                                                    unit: unit.UnitID,
                                                    plan: plan.PlanID,
                                                    office: office.OfficeID,
                                                })
                                            "
                                            @click.stop
                                            class="text-sm font-bold text-gray-700 hover:text-blue-600 hover:underline"
                                        >
                                            📁 {{ office.OfficeName }}
                                        </Link>
                                        <div class="ml-2">
                                            <svg
                                                v-if="
                                                    openStates[
                                                        'office_' +
                                                            office.OfficeID
                                                    ]
                                                "
                                                xmlns="http://www.w3.org/2000/svg"
                                                width="14"
                                                height="14"
                                                viewBox="0 0 24 24"
                                                fill="none"
                                                stroke="currentColor"
                                                stroke-width="2.5"
                                                stroke-linecap="round"
                                                stroke-linejoin="round"
                                                class="text-red-500"
                                            >
                                                <line
                                                    x1="18"
                                                    y1="6"
                                                    x2="6"
                                                    y2="18"
                                                ></line>
                                                <line
                                                    x1="6"
                                                    y1="6"
                                                    x2="18"
                                                    y2="18"
                                                ></line>
                                            </svg>
                                            <svg
                                                v-else
                                                xmlns="http://www.w3.org/2000/svg"
                                                width="14"
                                                height="14"
                                                viewBox="0 0 24 24"
                                                fill="none"
                                                stroke="currentColor"
                                                stroke-width="2"
                                                stroke-linecap="round"
                                                stroke-linejoin="round"
                                                class="text-gray-400"
                                            >
                                                <line
                                                    x1="3"
                                                    y1="12"
                                                    x2="21"
                                                    y2="12"
                                                ></line>
                                                <line
                                                    x1="3"
                                                    y1="6"
                                                    x2="21"
                                                    y2="6"
                                                ></line>
                                                <line
                                                    x1="3"
                                                    y1="18"
                                                    x2="21"
                                                    y2="18"
                                                ></line>
                                            </svg>
                                        </div>
                                    </div>

                                    <div
                                        v-if="
                                            openStates[
                                                'office_' + office.OfficeID
                                            ]
                                        "
                                        class="mt-2 ml-6 space-y-1 border-l border-gray-200 pl-3"
                                    >
                                        <div
                                            v-for="sec_office in office.section"
                                            :key="'os' + sec_office.SectionID"
                                        >
                                            <Link
                                                :href="
                                                    route(
                                                        'office.section.show',
                                                        {
                                                            unit: unit.UnitID,
                                                            plan: plan.PlanID,
                                                            office: office.OfficeID,
                                                            section:
                                                                sec_office.SectionID,
                                                        },
                                                    )
                                                "
                                                class="text-xs text-gray-500 hover:text-blue-500 block py-1"
                                            >
                                                🔹 {{ sec_office.SectionName }}
                                            </Link>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </AuthenticatedLayout>
</template>
