<template>
  <div class="space-y-2">
    <label v-if="label" class="block text-sm font-semibold text-neutral-900">
      {{ label }}
      <span v-if="required" class="text-red-500">*</span>
    </label>
    <select
      :value="modelValue"
      @change="$emit('update:modelValue', $event.target.value)"
      :disabled="disabled"
      :class="[
        'w-full px-4 py-2.5 rounded-xl border transition-all duration-200',
        'focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent',
        'disabled:bg-neutral-100 disabled:text-neutral-500 disabled:cursor-not-allowed',
        error ? 'border-red-300 focus:ring-red-500' : 'border-neutral-300 hover:border-neutral-400'
      ]"
    >
      <option v-if="!modelValue" value="">{{ placeholder }}</option>
      <option v-for="option in options" :key="option.value" :value="option.value">
        {{ option.label }}
      </option>
    </select>
    <p v-if="error" class="text-sm text-red-600 font-medium">{{ error }}</p>
  </div>
</template>

<script setup lang="ts">
interface Option {
  label: string
  value: string | number
}

defineProps({
  modelValue: [String, Number],
  label: String,
  placeholder: { type: String, default: 'Selecciona una opción' },
  options: { type: Array as () => Option[], required: true },
  error: String,
  required: Boolean,
  disabled: Boolean
})

defineEmits(['update:modelValue'])
</script>
