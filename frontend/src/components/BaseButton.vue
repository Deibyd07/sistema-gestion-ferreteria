<template>
  <button
    :type="type"
    :class="[
      'relative inline-flex items-center justify-center gap-2 font-semibold transition-all duration-200',
      'focus:outline-none focus-visible:ring-2 focus-visible:ring-accent-400 focus-visible:ring-offset-2 focus-visible:ring-offset-surface-base',
      'disabled:opacity-50 disabled:cursor-not-allowed disabled:transform-none',
      'overflow-hidden',
      sizeClasses,
      variantClasses,
      rounded ? 'rounded-full' : 'rounded-xl',
      fullWidth ? 'w-full' : '',
    ]"
    :disabled="loading || disabled"
    @click="handleClick"
  >
    <!-- Loading Spinner -->
    <span v-if="loading" class="absolute inset-0 flex items-center justify-center bg-inherit">
      <svg class="animate-spin h-5 w-5" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
        <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle>
        <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
      </svg>
    </span>

    <!-- Content -->
    <span :class="{ 'opacity-0': loading }" class="flex items-center gap-2">
      <component :is="iconLeft" v-if="iconLeft" :class="iconSize" />
      <slot />
      <component :is="iconRight" v-if="iconRight" :class="iconSize" />
    </span>

    <!-- Ripple Effect -->
    <span 
      v-for="ripple in ripples" 
      :key="ripple.id" 
      :style="ripple.style"
      class="absolute rounded-full bg-white/30 pointer-events-none animate-ripple"
    />
  </button>
</template>

<script setup lang="ts">
import { computed, ref } from 'vue'
import type { Component } from 'vue'

interface Props {
  variant?: 'primary' | 'secondary' | 'outline' | 'ghost' | 'danger' | 'success'
  size?: 'xs' | 'sm' | 'md' | 'lg' | 'xl'
  type?: 'button' | 'submit' | 'reset'
  loading?: boolean
  disabled?: boolean
  rounded?: boolean
  fullWidth?: boolean
  iconLeft?: Component
  iconRight?: Component
}

const props = withDefaults(defineProps<Props>(), {
  variant: 'primary',
  size: 'md',
  type: 'button',
  loading: false,
  disabled: false,
  rounded: false,
  fullWidth: false,
})

const emit = defineEmits<{
  click: [event: MouseEvent]
}>()

const ripples = ref<Array<{ id: number; style: any }>>([])
let rippleId = 0

const handleClick = (event: MouseEvent) => {
  if (props.disabled || props.loading) return
  
  // Create ripple effect
  const button = event.currentTarget as HTMLElement
  const rect = button.getBoundingClientRect()
  const size = Math.max(rect.width, rect.height)
  const x = event.clientX - rect.left - size / 2
  const y = event.clientY - rect.top - size / 2

  ripples.value.push({
    id: rippleId++,
    style: {
      width: `${size}px`,
      height: `${size}px`,
      left: `${x}px`,
      top: `${y}px`,
    }
  })

  setTimeout(() => ripples.value.shift(), 600)
  
  emit('click', event)
}

const sizeClasses = computed(() => ({
  xs: 'h-8 px-3 text-xs',
  sm: 'h-9 px-4 text-sm',
  md: 'h-10 px-5 text-sm',
  lg: 'h-11 px-6 text-base',
  xl: 'h-12 px-8 text-base'
}[props.size]))

const iconSize = computed(() => ({
  xs: 'w-3 h-3',
  sm: 'w-4 h-4',
  md: 'w-4 h-4',
  lg: 'w-5 h-5',
  xl: 'w-5 h-5'
}[props.size]))

const variantClasses = computed(() => ({
  primary: [
    'bg-gradient-to-r from-accent-500 to-cyan-500 text-white',
    'shadow-lg shadow-accent-500/25',
    'hover:shadow-xl hover:shadow-accent-500/40 hover:scale-[1.02]',
    'active:scale-[0.98]',
  ].join(' '),
  secondary: [
    'bg-surface-2 text-slate-200',
    'border border-surface-border',
    'hover:bg-surface-3 hover:text-white',
  ].join(' '),
  outline: [
    'border-2 border-surface-border text-slate-200',
    'hover:border-accent-400 hover:text-accent-400 hover:bg-accent-400/5',
  ].join(' '),
  ghost: [
    'text-slate-300',
    'hover:text-accent-400 hover:bg-surface-hover',
  ].join(' '),
  danger: [
    'bg-gradient-to-r from-danger-500 to-danger-600 text-white',
    'shadow-lg shadow-danger-500/25',
    'hover:shadow-xl hover:shadow-danger-500/40 hover:scale-[1.02]',
    'active:scale-[0.98]',
  ].join(' '),
  success: [
    'bg-gradient-to-r from-success-500 to-success-600 text-white',
    'shadow-lg shadow-success-500/25',
    'hover:shadow-xl hover:shadow-success-500/40 hover:scale-[1.02]',
    'active:scale-[0.98]',
  ].join(' '),
}[props.variant]))
</script>

<style scoped>
@keyframes ripple {
  to {
    transform: scale(4);
    opacity: 0;
  }
}

.animate-ripple {
  animation: ripple 600ms ease-out;
}
</style>
