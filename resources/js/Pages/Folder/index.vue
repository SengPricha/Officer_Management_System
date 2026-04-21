<script setup>
import { ref, computed } from "vue";
import AuthenticatedLayout from "@/Layouts/AuthenticatedLayout.vue";
import { Head, router } from "@inertiajs/vue3";

const props = defineProps({
    documents: Array, // ឯកសារទាំងអស់បោះមកពី Controller
});

const searchQuery = ref("");

// ១. បង្កើត Logic ដើម្បី Group ឯកសារតាមមន្ត្រី (បង្កើតជា Folder)
const officerFolders = computed(() => {
    const groups = {};

    props.documents.forEach((doc) => {
        const officerId = doc.officer?.ID || "unknown";
        const officerName = doc.officer?.OfficerName || "មិនស្គាល់មន្ត្រី";

        if (!groups[officerId]) {
            groups[officerId] = {
                id: officerId,
                name: officerName,
                files: [],
            };
        }
        groups[officerId].files.push(doc);
    });

    const result = Object.values(groups);
    if (!searchQuery.value) return result;

    return result.filter((folder) =>
        folder.name.toLowerCase().includes(searchQuery.value.toLowerCase()),
    );
});

// ២. គ្រប់គ្រងការបើក Folder
const selectedFolder = ref(null);

const closeFolder = () => {
    selectedFolder.value = null;
};

// ៣. Logic សម្រាប់ File Types & Icons
const isImage = (path) => /\.(jpg|jpeg|png|gif|webp)$/i.test(path);
const isPdf = (path) => /\.pdf$/i.test(path);
const isDoc = (path) => /\.(doc|docx)$/i.test(path);

// ៤. មុខងារលុបឯកសារ
const deleteFile = (id) => {
    if (confirm("តើអ្នកពិតជាចង់លុបឯកសារនេះមែនទេ?")) {
        router.delete(route("documents.destroy", id), {
            onSuccess: () => {
                // ប្រសិនបើលុបក្នុង Folder ត្រូវដកចេញពី UI ភ្លាមៗ
                if (selectedFolder.value) {
                    selectedFolder.value.files =
                        selectedFolder.value.files.filter(
                            (f) => f.DocID !== id,
                        );
                }
            },
        });
    }
};
</script>

<template>
    <Head title="សំណុំលិខិត | ស្នងការដ្ឋាននគរបាលខេត្តប៉ៃលិន" />
    <AuthenticatedLayout>
        <div class="p-6 bg-gray-50 min-h-screen font-siemreap">
            <div
                class="flex flex-col md:flex-row justify-between items-start md:items-center mb-8 gap-4"
            >
                <div class="flex items-center gap-4">
                    <button
                        v-if="selectedFolder"
                        @click="closeFolder"
                        class="p-2.5 bg-white border border-gray-200 hover:bg-gray-100 rounded-xl transition-all shadow-sm"
                    >
                        <svg
                            xmlns="http://www.w3.org/2000/svg"
                            class="h-5 w-5 text-gray-600"
                            fill="none"
                            viewBox="0 0 24 24"
                            stroke="currentColor"
                        >
                            <path
                                stroke-linecap="round"
                                stroke-linejoin="round"
                                stroke-width="2"
                                d="M15 19l-7-7 7-7"
                            />
                        </svg>
                    </button>
                    <div>
                        <h2 class="text-md font-siemreap text-gray-800">
                            {{
                                selectedFolder
                                    ? "សំណុំលិខិតឯកសាររបស់៖ " + selectedFolder.name
                                    : "សំណុំលិខិតឯកសារមន្ត្រី"
                            }}
                        </h2>
                        <p class="text-xs text-gray-500 mt-1">
                            {{
                                selectedFolder
                                    ? selectedFolder.files.length + " File"
                                    : officerFolders.length + " Folder"
                            }}
                        </p>
                    </div>
                </div>

                <div
                    v-if="!selectedFolder"
                    class="relative w-full md:w-96 group"
                >
                    <div
                        class="absolute inset-y-0 left-0 pl-3.5 flex items-center pointer-events-none"
                    >
                        <svg
                            class="h-5 w-5 text-gray-400 group-focus-within:text-blue-500 transition-colors"
                            xmlns="http://www.w3.org/2000/svg"
                            fill="none"
                            viewBox="0 0 24 24"
                            stroke="currentColor"
                        >
                            <path
                                stroke-linecap="round"
                                stroke-linejoin="round"
                                stroke-width="2"
                                d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"
                            />
                        </svg>
                    </div>
                    <input
                        v-model="searchQuery"
                        type="text"
                        placeholder="ស្វែងរកឈ្មោះមន្ត្រី..."
                        class="block w-full pl-11 pr-10 py-4 bg-white border border-gray-200 rounded-2xl text-sm text-gray-700 placeholder-gray-400 shadow-sm transition-all duration-300 hover:border-gray-300 focus:ring-4 focus:ring-blue-500/10 focus:border-blue-500 focus:outline-none"
                    />
                    <button
                        v-if="searchQuery"
                        @click="searchQuery = ''"
                        class="absolute inset-y-0 right-0 pr-3 flex items-center text-gray-400 hover:text-gray-600"
                    >
                        <svg
                            class="h-4 w-4"
                            fill="none"
                            viewBox="0 0 24 24"
                            stroke="currentColor"
                        >
                            <path
                                stroke-linecap="round"
                                stroke-linejoin="round"
                                stroke-width="2"
                                d="M6 18L18 6M6 6l12 12"
                            />
                        </svg>
                    </button>
                </div>
            </div>

            <div
                v-if="!selectedFolder"
                class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-4"
            >
                <div
                    v-for="folder in officerFolders"
                    :key="folder.id"
                    @click="selectedFolder = folder"
                    class="flex items-center p-4 bg-white border border-gray-100 rounded-2xl cursor-pointer hover:shadow-md transition-all group"
                >
                    <div
                        class="p-3 bg-gray-50 rounded-xl group-hover:bg-blue-50 mr-4 transition-colors"
                    >
                        <svg
                            xmlns="http://www.w3.org/2000/svg"
                            class="h-8 w-8 text-gray-400 group-hover:text-blue-500 transition-colors"
                            fill="currentColor"
                            viewBox="0 0 24 24"
                        >
                            <path
                                d="M10 4H4c-1.1 0-1.99.9-1.99 2L2 18c0 1.1.9 2 2 2h16c1.1 0 2-.9 2-2V8c0-1.1-.9-2-2-2h-8l-2-2z"
                            />
                        </svg>
                    </div>
                    <div class="flex-1 min-w-0">
                        <p class="text-sm text-gray-700 font-medium truncate">
                            {{ folder.name }}
                        </p>
                        <p class="text-xs text-gray-400">
                            {{ folder.files.length }} ឯកសារ
                        </p>
                    </div>
                    <div class="text-gray-300 group-hover:text-gray-400">
                        <svg
                            xmlns="http://www.w3.org/2000/svg"
                            class="h-5 w-5"
                            viewBox="0 0 20 20"
                            fill="currentColor"
                        >
                            <path
                                d="M10 6a2 2 0 110-4 2 2 0 010 4zM10 12a2 2 0 110-4 2 2 0 010 4zM10 18a2 2 0 110-4 2 2 0 010 4z"
                            />
                        </svg>
                    </div>
                </div>
            </div>

            <div
                v-else
                class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-5"
            >
                <div
                    v-for="file in selectedFolder.files"
                    :key="file.DocID"
                    class="bg-white border border-gray-200 rounded-2xl overflow-hidden hover:shadow-lg transition-all group flex flex-col"
                >
                    <div
                        class="bg-blue-50/50 px-4 py-3 flex items-center justify-between border-b border-gray-100"
                    >
                        <div class="flex items-center gap-2 min-w-0">
                            <svg
                                v-if="isPdf(file.FilePath)"
                                class="h-5 w-5 text-red-500 flex-shrink-0"
                                fill="none"
                                viewBox="0 0 24 24"
                                stroke="currentColor"
                            >
                                <path
                                    stroke-linecap="round"
                                    stroke-linejoin="round"
                                    stroke-width="2"
                                    d="M7 21h10a2 2 0 002-2V9.414a1 1 0 00-.293-.707l-5.414-5.414A1 1 0 0012.586 3H7a2 2 0 00-2 2v14a2 2 0 002 2z"
                                />
                            </svg>
                            <svg
                                v-else-if="isDoc(file.FilePath)"
                                class="h-5 w-5 text-blue-500 flex-shrink-0"
                                fill="none"
                                viewBox="0 0 24 24"
                                stroke="currentColor"
                            >
                                <path
                                    stroke-linecap="round"
                                    stroke-linejoin="round"
                                    stroke-width="2"
                                    d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"
                                />
                            </svg>
                            <svg
                                v-else
                                class="h-5 w-5 text-gray-400 flex-shrink-0"
                                fill="none"
                                viewBox="0 0 24 24"
                                stroke="currentColor"
                            >
                                <path
                                    stroke-linecap="round"
                                    stroke-linejoin="round"
                                    stroke-width="2"
                                    d="M4 16l4.586-4.586a2 2 0 012.828 0L16 16m-2-2l1.586-1.586a2 2 0 012.828 0L20 14m-6-6h.01M6 20h12a2 2 0 002-2V6a2 2 0 00-2-2H6a2 2 0 00-2 2v12a2 2 0 002 2z"
                                />
                            </svg>

                            <span
                                class="text-[13px] text-gray-700 truncate font-medium"
                                :title="file.FileName"
                            >
                                {{ file.FileName }}
                            </span>
                        </div>

                        <div class="relative group/menu">
                            <button
                                class="p-1 hover:bg-blue-100 rounded-full text-gray-400 transition-colors"
                            >
                                <svg
                                    xmlns="http://www.w3.org/2000/svg"
                                    class="h-5 w-5"
                                    viewBox="0 0 20 20"
                                    fill="currentColor"
                                >
                                    <path
                                        d="M10 6a2 2 0 110-4 2 2 0 010 4zM10 12a2 2 0 110-4 2 2 0 010 4zM10 18a2 2 0 110-4 2 2 0 010 4z"
                                    />
                                </svg>
                            </button>

                            <div
                                class="absolute right-0 w-36 bg-white rounded-xl shadow-xl py-2 z-10 hidden group-hover/menu:block border border-gray-100"
                            >
                                <a
                                    :href="'/storage/' + file.FilePath"
                                    target="_blank"
                                    class="flex items-center px-4 py-2 text-xs text-gray-600 hover:bg-blue-50"
                                >
                                    មើលឯកសារ
                                </a>
                                <a
                                    :href="'/storage/' + file.FilePath"
                                    download
                                    class="flex items-center px-4 py-2 text-xs text-gray-600 hover:bg-blue-50"
                                >
                                    ទាញយក
                                </a>
                                <hr class="my-1 border-gray-50" />
                                <button
                                    @click="deleteFile(file.DocID)"
                                    class="flex items-center w-full px-4 py-2 text-xs text-red-500 hover:bg-red-50"
                                >
                                    លុបឯកសារ
                                </button>
                            </div>
                        </div>
                    </div>

                    <div
                        class="p-2 flex items-center justify-center bg-white h-32 overflow-hidden"
                    >
                        <img
                            v-if="isImage(file.FilePath)"
                            :src="'/storage/' + file.FilePath"
                            class="w-full h-full object-cover rounded-lg group-hover:scale-105 transition-transform"
                        />
                        <div
                            v-else
                            class="flex flex-col items-center opacity-20 group-hover:opacity-30 transition-opacity"
                        >
                            <svg
                                class="h-12 w-12 text-gray-400"
                                fill="none"
                                viewBox="0 0 24 24"
                                stroke="currentColor"
                            >
                                <path
                                    stroke-linecap="round"
                                    stroke-linejoin="round"
                                    stroke-width="1"
                                    d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"
                                />
                            </svg>
                        </div>
                    </div>
                </div>
            </div>

            <div
                v-if="officerFolders.length === 0"
                class="flex flex-col items-center justify-center py-32 text-gray-400"
            >
                <svg
                    class="w-16 h-16 mb-4 opacity-20"
                    fill="currentColor"
                    viewBox="0 0 20 20"
                >
                    <path
                        d="M2 6a2 2 0 012-2h5l2 2h5a2 2 0 012 2v6a2 2 0 01-2 2H4a2 2 0 01-2-2V6z"
                    ></path>
                </svg>
                <p class="text-lg">មិនមានឯកសារនៅក្នុងប្រព័ន្ធឡើយ</p>
            </div>
        </div>
    </AuthenticatedLayout>
</template>

<style scoped>
.animate-fade-in {
    animation: fadeIn 0.3s ease-out;
}
@keyframes fadeIn {
    from {
        opacity: 0;
        transform: translateY(10px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}
</style>
