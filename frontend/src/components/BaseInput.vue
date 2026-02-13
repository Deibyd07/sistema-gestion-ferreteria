<template>
  <div class="space-y-1.5">
    <label v-if="label" :for="inputId" class="block text-sm font-medium text-slate-300">
      {{ label }}
      <span v-if="required" class="text-accent-400 ml-0.5">*</span>
    </label>
    <div class="relative group">
      <!-- Icon Left -->
      <div v-if="$slots.icon" class="absolute left-3.5 top-1/2 -translate-y-1/2 text-slate-500 group-focus-within:text-accent-400 transition-colors">
        <slot name="icon" />
      </div>
      <input
        :id="inputId"
        :type="type"
        :placeholder="placeholder"
        :value="modelValue"
        :disabled="disabled"
        :autocomplete="autocomplete"
        @input="$emit('update:modelValue', ($event.target as HTMLInputElement).value)"
        :class="[
          'w-full rounded-xl bg-surface-1 text-slate-100 placeholder:text-slate-500 transition-all duration-200',
          'border border-white/[0.06] hover:border-white/[0.12]',
          'focus:outline-none focus:border-accent-500/50 focus:ring-2 focus:ring-accent-500/20',
          'disabled:bg-surface-0 disabled:text-slate-600 disabled:cursor-not-allowed disabled:border-transparent',
          sizeClasses,
          $slots.icon ? 'pl-11' : '',
          $slots.append ? 'pr-11' : '',
          error ? 'border-danger-500/40 focus:border-danger-500/60 focus:ring-danger-500/20' : '',
        ]"
      />
      <!-- Append Slot (for toggle password, etc) -->
      <div v-if="$slots.append" class="absolute right-3 top-1/2 -translate-y-1/2">
        <slot name="append" />
      </div>
    </div>
    <p v-if="error" class="text-xs text-danger-400 font-medium flex items-center gap-1">
      <svg class="w-3.5 h-3.5 flex-shrink-0" fill="currentColor" viewBox="0 0 20 20">
        <path fill-rule="evenodd" d="M18 10a8 8 0 11-16 0 8 8 0 0116 0zm-7 4a1 1 0 11-2 0 1 1 0 012 0zm-1-9a1 1 0 00-1 1v4a1 1 0 102 0V6a1 1 0 00-1-1z" clip-rule="evenodd" />
      </svg>
      {{ error }}
    </p>
    <p v-else-if="hint" class="text-xs text-slate-500">{{ hint }}</p>
  </div>
</template>

<script setup lang="ts">
import { computed } from 'vue'

const props = defineProps({
  modelValue: String,
  type: { type: String, default: 'text' },
  label: String,
  placeholder: String,
  error: String,
  hint: String,
  required: Boolean,
  disabled: Boolean,
  autocomplete: String,
  size: { type: String, default: 'md' },
  id: String,
})

defineEmits(['update:modelValue'])

const inputId = computed(() => props.id || `input-${Math.random().toString(36).substring(2, 9)}`)

const sizeClasses = computed(() => ({
  sm: 'px-3.5 py-2 text-sm',
  md: 'px-4 py-3 text-base',
  lg: 'px-4 py-3.5 text-base',
}[props.size] || 'px-4 py-3 text-base'))
</script>
