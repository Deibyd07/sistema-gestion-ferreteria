<template>
  <div class="flex flex-col items-center justify-center py-12 px-6 text-center animate-fade-in">
    <!-- Icon/Illustration -->
    <div 
      :class="[
        'w-16 h-16 rounded-2xl flex items-center justify-center mb-6 transition-all duration-300',
        iconBgClass
      ]"
    >
      <component 
        :is="icon" 
        v-if="icon" 
        :class="['w-8 h-8', iconColorClass]"
      />
      <slot v-else name="icon">
        <svg class="w-8 h-8 text-slate-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M20 13V6a2 2 0 00-2-2H6a2 2 0 00-2 2v7m16 0v5a2 2 0 01-2 2H6a2 2 0 01-2-2v-5m16 0h-2.586a1 1 0 00-.707.293l-2.414 2.414a1 1 0 01-.707.293h-3.172a1 1 0 01-.707-.293l-2.414-2.414A1 1 0 006.586 13H4" />
        </svg>
      </slot>
    </div>

    <!-- Title -->
    <h3 class="text-xl font-semibold text-slate-100 mb-2">
      <slot name="title">{{ title }}</slot>
    </h3>

    <!-- Description -->
    <p class="text-slate-400 mb-6 max-w-md">
      <slot name="description">{{ description }}</slot>
    </p>

    <!-- Actions -->
    <div v-if="$slots.actions" class="flex flex-col sm:flex-row gap-3">
      <slot name="actions" />
    </div>

    <!-- Footer (for additional help/links) -->
    <div v-if="$slots.footer" class="mt-8">
      <slot name="footer" />
    </div>
  </div>
</template>

<script setup lang="ts">
import { computed } from 'vue'
import type { Component } from 'vue'

interface Props {
  title?: string
  description?: string
  icon?: Component
  variant?: 'default' | 'info' | 'warning' | 'success'
}

const props = withDefaults(defineProps<Props>(), {
  title: 'No data found',
  description: 'There is nothing to display yet.',
  variant: 'default',
})

const iconBgClass = computed(() => {
  const variants = {
    default: 'bg-surface-2',
    info: 'bg-blue-500/10',
    warning: 'bg-warning-500/10',
    success: 'bg-success-500/10',
  }
  return variants[props.variant]
})

const iconColorClass = computed(() => {
  const variants = {
    default: 'text-slate-600',
    info: 'text-blue-400',
    warning: 'text-warning-400',
    success: 'text-success-400',
  }
  return variants[props.variant]
})
</script>
