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
  <div v-else>
    <CinematicEffects :enabled="effectsEnabled" />
    <main class="app-main">
      <RouterView v-slot="{ Component }">
        <Transition name="page" mode="out-in">
          <component :is="Component" />
        </Transition>
      </RouterView>
    </main>
  </div>
  
  <!-- Toast Notifications -->
  <ToastContainer />
  
  <!-- Dev Tools - Showcase Button (Only in dev mode) -->
  <RouterLink
    v-if="isDevMode"
    to="/showcase"
    class="fixed bottom-4 left-4 z-50 bg-gradient-to-br from-purple-500 to-violet-600 text-white px-4 py-2 rounded-xl shadow-xl hover:shadow-2xl hover:scale-105 transition-all duration-300 text-sm font-semibold flex items-center gap-2 group border border-purple-400/20 backdrop-blur-sm"
  >
    <svg class="w-4 h-4 group-hover:rotate-12 transition-transform" fill="none" stroke="currentColor" viewBox="0 0 24 24">
      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M7 21a4 4 0 01-4-4V5a2 2 0 012-2h4a2 2 0 012 2v12a4 4 0 01-4 4zm0 0h12a2 2 0 002-2v-4a2 2 0 00-2-2h-2.343M11 7.343l1.657-1.657a2 2 0 012.828 0l2.829 2.829a2 2 0 010 2.828l-8.486 8.485M7 17h.01" />
    </svg>
    <span>Design System</span>
  </RouterLink>
</template>

<script setup lang="ts">
import { computed, ref, onMounted } from 'vue'
import { RouterView, RouterLink, useRoute } from 'vue-router'
import { useAuthStore } from '@/stores/auth'
import ToastContainer from '@/components/ToastContainer.vue'
import CinematicEffects from '@/components/CinematicEffects.vue'

const authStore = useAuthStore()
const isLoading = ref(true)
const isDevMode = import.meta.env.DEV
const route = useRoute()
const effectsEnabled = computed(() => route.name === 'login' || route.name === 'home')

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
  z-index: 10;
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
