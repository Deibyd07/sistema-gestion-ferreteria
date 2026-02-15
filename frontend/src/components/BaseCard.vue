<template>
  <div :class="cardClasses">
    <!-- Header -->
    <div v-if="$slots.header" :class="headerClasses">
      <slot name="header" />
    </div>

    <!-- Content -->
    <div :class="contentClasses">
      <slot />
    </div>

    <!-- Footer -->
    <div v-if="$slots.footer" :class="footerClasses">
      <slot name="footer" />
    </div>
  </div>
</template>

<script setup lang="ts">
import { computed } from 'vue'

interface Props {
  variant?: 'default' | 'elevated' | 'outlined' | 'glass'
  hover?: 'none' | 'lift' | 'glow' | 'border'
  padding?: 'none' | 'sm' | 'md' | 'lg'
  noPadding?: boolean
}

const props = withDefaults(defineProps<Props>(), {
  variant: 'elevated',
  hover: 'none',
  padding: 'md',
  noPadding: false,
})

const cardClasses = computed(() => {
  const base = [
    'rounded-2xl',
    'overflow-hidden',
    'transition-all duration-300 ease-spring',
  ]

  const variants = {
    default: [
      'bg-surface-base',
      'border border-surface-border',
    ],
    elevated: [
      'bg-gradient-to-b from-surface-elevated to-surface-base',
      'border border-surface-border',
      'shadow-dark-lg',
    ],
    outlined: [
      'bg-transparent',
      'border-2 border-surface-border',
    ],
    glass: [
      'backdrop-blur-xl',
      'bg-surface-elevated/50',
      'border border-white/10',
    ],
  }

  const hovers = {
    none: [],
    lift: [
      'hover:translate-y-[-4px]',
      'hover:shadow-dark-xl',
      'cursor-pointer',
    ],
    glow: [
      'hover:shadow-glow',
      'hover:border-accent-400/30',
      'cursor-pointer',
    ],
    border: [
      'hover:border-accent-400/50',
      'cursor-pointer',
    ],
  }

  return [
    ...base,
    ...variants[props.variant],
    ...hovers[props.hover],
  ]
})

const headerClasses = computed(() => {
  const padding = props.noPadding ? '' : props.padding === 'sm' ? 'p-4' : props.padding === 'lg' ? 'p-8' : 'p-6'
  return [
    padding,
    'border-b border-surface-border',
  ]
})

const contentClasses = computed(() => {
  if (props.noPadding) return ''
  return props.padding === 'sm' ? 'p-4' : props.padding === 'lg' ? 'p-8' : 'p-6'
})

const footerClasses = computed(() => {
  const padding = props.noPadding ? '' : props.padding === 'sm' ? 'p-4' : props.padding === 'lg' ? 'p-8' : 'p-6'
  return [
    padding,
    'border-t border-surface-border',
    'bg-white/[0.02]',
  ]
})
</script>
