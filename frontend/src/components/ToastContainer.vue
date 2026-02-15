<template>
  <teleport to="body">
    <div class="fixed top-4 right-4 z-[100] flex flex-col gap-3 w-96 max-w-[calc(100vw-2rem)] pointer-events-none">
      <TransitionGroup name="toast">
        <div
          v-for="toast in toasts"
          :key="toast.id"
          :class="[toastClasses(toast), 'pointer-events-auto']"
          class="flex items-start gap-3 p-4 rounded-xl border shadow-2xl backdrop-blur-xl cursor-pointer"
          @click="!toast.action && remove(toast.id)"
        >
          <!-- Icon -->
          <div :class="iconClasses(toast)" class="flex-shrink-0 mt-0.5">
            <!-- Success Icon -->
            <svg v-if="toast.variant === 'success'" class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z" />
            </svg>
            <!-- Error Icon -->
            <svg v-else-if="toast.variant === 'error'" class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 14l2-2m0 0l2-2m-2 2l-2-2m2 2l2 2m7-2a9 9 0 11-18 0 9 9 0 0118 0z" />
            </svg>
            <!-- Warning Icon -->
            <svg v-else-if="toast.variant === 'warning'" class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-3L13.732 4c-.77-1.333-2.694-1.333-3.464 0L3.34 16c-.77 1.333.192 3 1.732 3z" />
            </svg>
            <!-- Info Icon -->
            <svg v-else class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
            </svg>
          </div>

          <!-- Content -->
          <div class="flex-1 min-w-0">
            <p class="font-semibold text-sm text-slate-100">{{ toast.title }}</p>
            <p v-if="toast.description" class="text-xs text-slate-400 mt-1">{{ toast.description }}</p>
          </div>

          <!-- Action Button -->
          <button
            v-if="toast.action"
            @click.stop="toast.action.onClick(); remove(toast.id)"
            class="text-xs font-semibold hover:underline transition-colors"
            :class="actionColorClass(toast)"
          >
            {{ toast.action.label }}
          </button>

          <!-- Close Button -->
          <button
            @click.stop="remove(toast.id)"
            class="text-slate-500 hover:text-slate-300 transition-colors"
          >
            <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
            </svg>
          </button>

          <!-- Progress Bar -->
          <div
            v-if="toast.duration > 0"
            class="absolute bottom-0 left-0 h-1 rounded-full opacity-30"
            :class="progressColorClass(toast)"
            :style="{ 
              animation: `progress ${toast.duration}ms linear`,
              width: '100%'
            }"
          />
        </div>
      </TransitionGroup>
    </div>
  </teleport>
</template>

<script setup lang="ts">
import { useToast, type Toast } from '@/composables/useToast'

const { toasts, remove } = useToast()

type ToastVariant = 'success' | 'error' | 'warning' | 'info'

const toastClasses = (toast: Toast) => {
  const variants: Record<ToastVariant, string> = {
    success: 'bg-success-500/10 border-success-500/20',
    error: 'bg-danger-500/10 border-danger-500/20',
    warning: 'bg-warning-500/10 border-warning-500/20',
    info: 'bg-blue-500/10 border-blue-500/20',
  }
  return variants[toast.variant]
}

const iconClasses = (toast: Toast) => {
  const variants: Record<ToastVariant, string> = {
    success: 'text-success-400',
    error: 'text-danger-400',
    warning: 'text-warning-400',
    info: 'text-blue-400',
  }
  return variants[toast.variant]
}

const actionColorClass = (toast: Toast) => {
  const variants: Record<ToastVariant, string> = {
    success: 'text-success-400 hover:text-success-300',
    error: 'text-danger-400 hover:text-danger-300',
    warning: 'text-warning-400 hover:text-warning-300',
    info: 'text-blue-400 hover:text-blue-300',
  }
  return variants[toast.variant]
}

const progressColorClass = (toast: Toast) => {
  const variants: Record<ToastVariant, string> = {
    success: 'bg-success-400',
    error: 'bg-danger-400',
    warning: 'bg-warning-400',
    info: 'bg-blue-400',
  }
  return variants[toast.variant]
}
</script>

<style scoped>
@keyframes progress {
  from { width: 100%; }
  to { width: 0%; }
}

.toast-enter-active,
.toast-leave-active {
  transition: all 300ms cubic-bezier(0.16, 1, 0.3, 1);
}

.toast-enter-from {
  opacity: 0;
  transform: translateX(100%) scale(0.9);
}

.toast-leave-to {
  opacity: 0;
  transform: translateX(100%) scale(0.9);
}

.toast-move {
  transition: transform 300ms cubic-bezier(0.16, 1, 0.3, 1);
}
</style>
