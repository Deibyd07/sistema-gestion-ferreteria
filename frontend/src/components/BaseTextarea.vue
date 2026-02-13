<template>
  <div class="space-y-4">
    <label v-if="label" class="block text-sm font-semibold text-neutral-900">
      {{ label }}
      <span v-if="required" class="text-red-500">*</span>
    </label>
    <div class="relative">
      <textarea
        :value="modelValue"
        :placeholder="placeholder"
        :rows="rows"
        :disabled="disabled"
        @input="$emit('update:modelValue', $event.target.value)"
        :class="[
          'w-full px-4 py-2.5 rounded-xl border transition-all duration-200 resize-none',
          'focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent',
          'disabled:bg-neutral-100 disabled:text-neutral-500 disabled:cursor-not-allowed',
          error ? 'border-red-300 focus:ring-red-500' : 'border-neutral-300 hover:border-neutral-400'
        ]"
      />
    </div>
    <p v-if="error" class="text-sm text-red-600 font-medium">{{ error }}</p>
    <p v-if="hint" class="text-sm text-neutral-500">{{ hint }}</p>
  </div>
</template>

<script setup lang="ts">
defineProps({
  modelValue: String,
  label: String,
  placeholder: String,
  rows: { type: Number, default: 4 },
  error: String,
  hint: String,
  required: Boolean,
  disabled: Boolean
})

defineEmits(['update:modelValue'])
</script>
