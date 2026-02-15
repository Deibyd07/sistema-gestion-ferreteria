<template>
  <div class="space-y-1.5">
    <label v-if="label" :for="inputId" class="block text-sm font-medium text-slate-300">
      {{ label }}
      <span v-if="required" class="text-accent-400 ml-0.5">*</span>
    </label>
    <div class="relative group">
      <!-- Icon Left -->
      <div 
        v-if="icon || $slots.icon" 
        class="absolute left-3.5 top-1/2 -translate-y-1/2 transition-colors"
        :class="[
          error ? 'text-danger-400' : success ? 'text-success-400' : 'text-slate-500 group-focus-within:text-accent-400'
        ]"
      >
        <component :is="icon" v-if="icon" class="w-5 h-5" />
        <slot v-else name="icon" />
      </div>
      
      <input
        :id="inputId"
        :type="type"
        :placeholder="placeholder"
        :value="modelValue"
        :disabled="disabled"
        :autocomplete="autocomplete"
        @input="$emit('update:modelValue', ($event.target as HTMLInputElement).value)"
        @blur="$emit('blur')"
        @focus="$emit('focus')"
        :class="[
          'w-full rounded-xl bg-surface-1 text-slate-100 placeholder:text-slate-500 transition-all duration-200',
          'border hover:border-white/[0.12]',
          'focus:outline-none focus:ring-2',
          'disabled:bg-surface-0 disabled:text-slate-600 disabled:cursor-not-allowed disabled:border-transparent',
          sizeClasses,
          icon || $slots.icon ? 'pl-11' : '',
          $slots.suffix ? 'pr-11' : '',
          error 
            ? 'border-danger-500/40 focus:border-danger-500/60 focus:ring-danger-500/20' 
            : success 
              ? 'border-success-500/40 focus:border-success-500/60 focus:ring-success-500/20'
              : 'border-white/[0.06] focus:border-accent-500/50 focus:ring-accent-500/20',
        ]"
      />
      
      <!-- Suffix Slot (for icons, success/error indicators) -->
      <div v-if="$slots.suffix || error || success" class="absolute right-3 top-1/2 -translate-y-1/2">
        <slot name="suffix">
          <!-- Auto success/error icons -->
          <svg v-if="success" class="w-5 h-5 text-success-400" fill="currentColor" viewBox="0 0 20 20">
            <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd" />
          </svg>
          <svg v-else-if="error" class="w-5 h-5 text-danger-400" fill="currentColor" viewBox="0 0 20 20">
            <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zM8.707 7.293a1 1 0 00-1.414 1.414L8.586 10l-1.293 1.293a1 1 0 101.414 1.414L10 11.414l1.293 1.293a1 1 0 001.414-1.414L11.414 10l1.293-1.293a1 1 0 00-1.414-1.414L10 8.586 8.707 7.293z" clip-rule="evenodd" />
          </svg>
        </slot>
      </div>
    </div>
    
    <!-- Error Message -->
    <p v-if="error" class="text-xs text-danger-400 font-medium flex items-center gap-1 animate-slide-down">
      <svg class="w-3.5 h-3.5 flex-shrink-0" fill="currentColor" viewBox="0 0 20 20">
        <path fill-rule="evenodd" d="M18 10a8 8 0 11-16 0 8 8 0 0116 0zm-7 4a1 1 0 11-2 0 1 1 0 012 0zm-1-9a1 1 0 00-1 1v4a1 1 0 102 0V6a1 1 0 00-1-1z" clip-rule="evenodd" />
      </svg>
      {{ error }}
    </p>
    
    <!-- Success Message -->
    <p v-else-if="successMessage" class="text-xs text-success-400 font-medium flex items-center gap-1 animate-slide-down">
      <svg class="w-3.5 h-3.5 flex-shrink-0" fill="currentColor" viewBox="0 0 20 20">
        <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd" />
      </svg>
      {{ successMessage }}
    </p>
    
    <!-- Hint -->
    <p v-else-if="hint" class="text-xs text-slate-500">{{ hint }}</p>
  </div>
</template>

<script setup lang="ts">
import { computed } from 'vue'
import type { Component } from 'vue'

interface Props {
  modelValue?: string | number
  type?: string
  label?: string
  placeholder?: string
  error?: string
  success?: boolean
  successMessage?: string
  hint?: string
  required?: boolean
  disabled?: boolean
  autocomplete?: string
  size?: 'sm' | 'md' | 'lg'
  id?: string
  icon?: Component
}

const props = withDefaults(defineProps<Props>(), {
  type: 'text',
  size: 'md',
})

defineEmits(['update:modelValue', 'blur', 'focus'])

const inputId = computed(() => props.id || `input-${Math.random().toString(36).substring(2, 9)}`)

const sizeClasses = computed(() => ({
  sm: 'px-3.5 py-2 text-sm',
  md: 'px-4 py-3 text-base',
  lg: 'px-4 py-3.5 text-base',
}[props.size]))
</script>
