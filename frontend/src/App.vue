<template>
  <div v-if="isLoading" class="fixed inset-0 bg-surface-base flex items-center justify-center z-50">
    <div class="flex flex-col items-center gap-6 animate-fade-in">
      <div class="relative">
        <div class="w-14 h-14 bg-gradient-to-br from-accent-400 to-cyan-400 rounded-2xl flex items-center justify-center shadow-xl shadow-accent-500/25 animate-bounce-subtle">
          <svg class="w-7 h-7 text-surface-base" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2.5" d="M13 10V3L4 14h7v7l9-11h-7z" />
          </svg>
        </div>
        <div class="absolute inset-0 bg-gradient-to-br from-accent-400 to-cyan-400 rounded-2xl blur-lg opacity-30 animate-glow-pulse"></div>
      </div>
      <div class="text-center">
        <p class="text-slate-300 font-display font-semibold text-lg">FerreCloud</p>
        <p class="text-slate-500 text-xs mt-1">Cargando tu espacio de trabajo...</p>
      </div>
    </div>
  </div>
  <main v-else class="app-main">
    <RouterView v-slot="{ Component }">
      <Transition name="page" mode="out-in">
        <component :is="Component" />
      </Transition>
    </RouterView>
  </main>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue'
import { RouterView } from 'vue-router'
import { useAuthStore } from '@/stores/auth'

const authStore = useAuthStore()
const isLoading = ref(true)

onMounted(async () => {
  await authStore.initializeAuth()
  isLoading.value = false
})
</script>

<style>
.app-main {
  width: 100%;
  min-height: 100vh;
  overflow-x: hidden;
  position: relative;
}

/* Page Transition Animations: 3D Perspective */
.page-enter-active,
.page-leave-active {
  transition: all 0.5s cubic-bezier(0.23, 1, 0.32, 1);
  position: absolute;
  width: 100%;
  backface-visibility: hidden;
}

.page-enter-from {
  opacity: 0;
  transform: perspective(1000px) rotateY(15deg) translateZ(-100px) translateX(20px);
}

.page-leave-to {
  opacity: 0;
  transform: perspective(1000px) rotateY(-15deg) translateZ(-100px) translateX(-20px);
}
</style>
