<script setup>
import AuthenticatedLayout from "@/Layouts/AuthenticatedLayout.vue";
import { Head } from "@inertiajs/vue3";
// import { ref, computed } from "vue";

// const props = defineProps({
//     documents: Array,
// });

// // --- បន្ថែម Logic ស្វែងរកឯកសារ (Search) ---
// const searchQuery = ref("");

// const filteredDocuments = computed(() => {
//     if (!searchQuery.value) return props.documents;
//     return props.documents.filter(
//         (file) =>
//             file.FileName?.toLowerCase().includes(
//                 searchQuery.value.toLowerCase(),
//             ) ||
//             file.officer?.OfficerName?.toLowerCase().includes(
//                 searchQuery.value.toLowerCase(),
//             ),
//     );
// });

// // --- Logic ឆែកប្រភេទ File ---
// const isImage = (path) => /\.(jpg|jpeg|png|gif)$/i.test(path);
// const isPdf = (path) => /\.pdf$/i.test(path);
// const isDoc = (path) => /\.(doc|docx)$/i.test(path);

// // មុខងារផ្តល់ពណ៌ទៅតាមប្រភេទ File (ដូច Google Drive)
// const getIconColor = (path) => {
//     if (isPdf(path)) return "text-red-500 bg-red-50";
//     if (isDoc(path)) return "text-blue-500 bg-blue-50";
//     if (isImage(path)) return "text-purple-500 bg-purple-50";
//     return "text-gray-500 bg-gray-50";
// };
</script>

<template>
    <Head title="សំណុំលិខិត | ស្នងការដ្ឋាននគរបាលខេត្តប៉ៃលិន" />

    <AuthenticatedLayout>
        <h1>Hello World</h1>
        <!-- <div class="p-6 bg-gray-50 min-h-screen">
            <div
                class="flex flex-col md:flex-row justify-between items-start md:items-center mb-8 gap-4"
            >
                <div>
                    <h2 class="text-xl font-moul text-gray-800">
                        ឯកសារមន្ត្រីទាំងអស់
                    </h2>
                    <p class="text-sm text-gray-500 font-siemreap mt-1">
                        គ្រប់គ្រង និងមើលឯកសារដែលបាន Upload ទាំងអស់
                    </p>
                </div>

                <div class="relative w-full md:w-80">
                    <span
                        class="absolute inset-y-0 left-0 pl-3 flex items-center text-gray-400"
                    >
                        🔍
                    </span>
                    <input
                        v-model="searchQuery"
                        type="text"
                        placeholder="ស្វែងរកតាមឈ្មោះឯកសារ ឬមន្ត្រី..."
                        class="pl-10 rounded-lg border-gray-300 text-sm w-full focus:ring-blue-500 focus:border-blue-500"
                    />
                </div>
            </div>

            <div class="grid grid-cols-2 md:grid-cols-4 lg:grid-cols-6 gap-6">
                <div
                    v-for="file in filteredDocuments"
                    :key="file.DocID"
                    class="group bg-white border border-gray-200 rounded-xl p-4 hover:border-blue-300 hover:shadow-lg transition-all cursor-pointer relative"
                >
                    <div class="flex justify-center mb-4 mt-2">
                        <div
                            v-if="isImage(file.FilePath)"
                            class="relative h-16 w-16 overflow-hidden rounded shadow-sm border border-gray-100"
                        >
                            <img
                                :src="'/storage/' + file.FilePath"
                                class="h-full w-full object-cover transition-transform group-hover:scale-110"
                            />
                        </div>

                        <div
                            v-else
                            :class="[
                                'h-16 w-16 flex items-center justify-center rounded-lg text-3xl transition-transform group-hover:scale-110',
                                getIconColor(file.FilePath),
                            ]"
                        >
                            <span v-if="isPdf(file.FilePath)">📕</span>
                            <span v-else-if="isDoc(file.FilePath)">📘</span>
                            <span v-else>📁</span>
                        </div>
                    </div>

                    <div class="text-center px-1">
                        <p
                            class="text-sm font-siemreap text-gray-800 font-medium truncate w-full mb-1"
                            :title="file.FileName"
                        >
                            {{ file.FileName }}
                        </p>
                        <p
                            class="text-[11px] text-gray-500 truncate font-siemreap bg-gray-100 rounded py-0.5 px-2"
                        >
                            👤
                            {{
                                file.officer?.OfficerName || "មិនស្គាល់មន្ត្រី"
                            }}
                        </p>
                    </div>

                    <div
                        class="absolute top-2 right-2 opacity-0 group-hover:opacity-100 transition-opacity flex gap-1"
                    >
                        <a
                            :href="'/storage/' + file.FilePath"
                            target="_blank"
                            class="p-1.5 bg-white shadow-md rounded-full border border-gray-100 text-blue-500 hover:bg-blue-500 hover:text-white transition-colors"
                            title="មើលឯកសារ"
                        >
                            <svg
                                xmlns="http://www.w3.org/2000/svg"
                                class="h-4 w-4"
                                fill="none"
                                viewBox="0 0 24 24"
                                stroke="currentColor"
                            >
                                <path
                                    stroke-linecap="round"
                                    stroke-linejoin="round"
                                    stroke-width="2"
                                    d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"
                                />
                                <path
                                    stroke-linecap="round"
                                    stroke-linejoin="round"
                                    stroke-width="2"
                                    d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z"
                                />
                            </svg>
                        </a>
                    </div>
                </div>
            </div>

            <div
                v-if="filteredDocuments.length === 0"
                class="flex flex-col items-center justify-center py-32 text-gray-400"
            >
                <div class="text-6xl mb-4">📂</div>
                <p class="font-siemreap text-lg">
                    មិនមានឯកសារដែលអ្នកកំពុងស្វែងរកទេ
                </p>
            </div>
        </div> -->
    </AuthenticatedLayout>
</template>

<!-- <style scoped>
/* សម្រាប់ Font Mouyl ប្រសិនបើមិនទាន់មានក្នុង CSS រួម */
.font-moul {
    font-family: "Moul", cursive;
}
.font-siemreap {
    font-family: "Siemreap", sans-serif;
}
</style> -->
