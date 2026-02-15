<template>
  <span>{{ displayValue }}</span>
</template>

<script setup lang="ts">
import { ref, watch, onMounted, computed } from 'vue'

interface Props {
  value: number
  format?: 'number' | 'currency' | 'percentage' | 'compact'
  duration?: number
  locale?: string
  currency?: string
  decimals?: number
}

const props = withDefaults(defineProps<Props>(), {
  format: 'number',
  duration: 800,
  locale: 'en-US',
  currency: 'USD',
  decimals: 0,
})

const currentValue = ref(0)
const startTime = ref<number | null>(null)
const startValue = ref(0)
const targetValue = ref(props.value)

const displayValue = computed(() => {
  const value = currentValue.value

  if (props.format === 'currency') {
    return new Intl.NumberFormat(props.locale, {
      style: 'currency',
      currency: props.currency,
      minimumFractionDigits: props.decimals,
      maximumFractionDigits: props.decimals,
    }).format(value)
  }

  if (props.format === 'percentage') {
    return `${value.toFixed(props.decimals)}%`
  }

  if (props.format === 'compact') {
    return new Intl.NumberFormat(props.locale, {
      notation: 'compact',
      compactDisplay: 'short',
      maximumFractionDigits: 1,
    }).format(value)
  }

  return new Intl.NumberFormat(props.locale, {
    minimumFractionDigits: props.decimals,
    maximumFractionDigits: props.decimals,
  }).format(Math.round(value))
})

const easeOutQuart = (t: number): number => {
  return 1 - Math.pow(1 - t, 4)
}

const animate = (timestamp: number) => {
  if (!startTime.value) {
    startTime.value = timestamp
  }

  const elapsed = timestamp - startTime.value
  const progress = Math.min(elapsed / props.duration, 1)
  const easedProgress = easeOutQuart(progress)

  currentValue.value = startValue.value + (targetValue.value - startValue.value) * easedProgress

  if (progress < 1) {
    requestAnimationFrame(animate)
  } else {
    currentValue.value = targetValue.value
    startTime.value = null
  }
}

const startAnimation = (newValue: number) => {
  startValue.value = currentValue.value
  targetValue.value = newValue
  startTime.value = null
  requestAnimationFrame(animate)
}

watch(() => props.value, (newValue) => {
  startAnimation(newValue)
})

onMounted(() => {
  startAnimation(props.value)
})
</script>
