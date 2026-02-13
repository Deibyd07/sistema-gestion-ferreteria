<template>
  <div class="space-y-2">
    <div class="flex gap-2">
      <div class="flex-1 flex gap-1">
        <input
          v-for="(digit, index) in digits"
          :key="index"
          type="text"
          maxlength="1"
          inputmode="numeric"
          :value="digit"
          @input="handleInput(index, $event)"
          @keydown="handleKeydown(index, $event)"
          class="w-12 h-12 text-center text-2xl font-bold border border-neutral-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-all"
        />
      </div>
    </div>
    <p v-if="hint" class="text-sm text-neutral-500">{{ hint }}</p>
  </div>
</template>

<script setup lang="ts">
import { ref, watch } from 'vue'

const props = defineProps({
  modelValue: { type: String, default: '' },
  length: { type: Number, default: 6 },
  hint: String
})

const emit = defineEmits(['update:modelValue'])

const digits = ref<string[]>(props.modelValue.split('').concat(Array(props.length - props.modelValue.length).fill('')))

watch(() => props.modelValue, (newVal) => {
  digits.value = newVal.split('').concat(Array(props.length - newVal.length).fill(''))
})

const updateValue = () => {
  emit('update:modelValue', digits.value.join(''))
}

const handleInput = (index: number, event: Event) => {
  const target = event.target as HTMLInputElement
  let value = target.value

  if (value && /^\d$/.test(value)) {
    digits.value[index] = value
    updateValue()

    // Move to next input
    if (index < props.length - 1 && value) {
      const nextInput = document.querySelector(`input[data-index="${index + 1}"]`) as HTMLInputElement
      nextInput?.focus()
    }
  } else {
    digits.value[index] = ''
    updateValue()
  }
}

const handleKeydown = (index: number, event: KeyboardEvent) => {
  if (event.key === 'Backspace' && !digits.value[index] && index > 0) {
    const prevInput = document.querySelector(`input[data-index="${index - 1}"]`) as HTMLInputElement
    prevInput?.focus()
  }
}
</script>
