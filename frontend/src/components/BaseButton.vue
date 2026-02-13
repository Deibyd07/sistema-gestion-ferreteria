<template>
  <button
    :class="[
      'inline-flex items-center justify-center gap-2 font-semibold transition-all duration-200',
      'focus:outline-none focus-visible:ring-2 focus-visible:ring-accent-500 focus-visible:ring-offset-2 focus-visible:ring-offset-surface-0',
      'disabled:opacity-40 disabled:cursor-not-allowed disabled:transform-none',
      sizeClasses,
      variantClasses,
      rounded ? 'rounded-full' : 'rounded-xl',
    ]"
    :disabled="loading || disabled"
  >
    <!-- Loading Spinner -->
    <svg v-if="loading" class="animate-spin h-4 w-4" fill="none" viewBox="0 0 24 24">
      <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle>
      <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
    </svg>
    <slot />
  </button>
</template>

<script setup lang="ts">
import { computed } from 'vue'

const props = defineProps({
  variant: {
    type: String,
    default: 'primary',
    validator: (v: string) => ['primary', 'secondary', 'outline', 'ghost', 'danger', 'accent'].includes(v)
  },
  size: {
    type: String,
    default: 'md',
    validator: (v: string) => ['xs', 'sm', 'md', 'lg', 'xl'].includes(v)
  },
  loading: Boolean,
  disabled: Boolean,
  rounded: Boolean,
})

const sizeClasses = computed(() => ({
  xs: 'px-2.5 py-1 text-xs',
  sm: 'px-3.5 py-1.5 text-sm',
  md: 'px-5 py-2.5 text-sm',
  lg: 'px-6 py-3 text-base',
  xl: 'px-8 py-3.5 text-lg'
}[props.size]))

const variantClasses = computed(() => ({
  primary: [
    'bg-gradient-to-r from-accent-500 to-cyan-500 text-white',
    'shadow-lg shadow-accent-500/20',
    'hover:shadow-xl hover:shadow-accent-500/30 hover:-translate-y-0.5',
    'active:shadow-md active:translate-y-0',
  ].join(' '),
  secondary: [
    'bg-surface-3 text-slate-200',
    'border border-white/5',
    'hover:bg-surface-4 hover:text-white',
  ].join(' '),
  outline: [
    'border border-slate-600 text-slate-300',
    'hover:border-accent-500/50 hover:text-accent-400 hover:bg-accent-500/5',
  ].join(' '),
  ghost: [
    'text-slate-400',
    'hover:text-slate-200 hover:bg-white/5',
  ].join(' '),
  danger: [
    'bg-danger-500/10 text-danger-400 border border-danger-500/20',
    'hover:bg-danger-500/20 hover:border-danger-500/40',
  ].join(' '),
  accent: [
    'bg-accent-500/10 text-accent-400 border border-accent-500/20',
    'hover:bg-accent-500/20 hover:border-accent-500/40',
  ].join(' '),
}[props.variant]))
</script>
