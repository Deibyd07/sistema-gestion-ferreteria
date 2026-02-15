<template>
  <div 
    :class="cardClasses"
    class="group relative overflow-hidden bg-gradient-to-br from-surface-elevated to-surface-base border border-surface-border rounded-2xl p-6 transition-all duration-300 hover:translate-y-[-4px] hover:shadow-2xl animate-slide-up"
  >
    <!-- Glow effect on hover -->
    <div 
      class="absolute inset-0 bg-gradient-to-br opacity-0 group-hover:opacity-10 transition-opacity duration-300"
      :class="glowGradient"
    />

    <!-- Content -->
    <div class="relative">
      <!-- Header with Icon -->
      <div class="flex items-start justify-between mb-4">
        <div 
          :class="iconWrapperClasses"
          class="flex items-center justify-center rounded-xl transition-all duration-300 group-hover:scale-110"
        >
          <slot name="icon">
            <svg class="w-6 h-6 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 7h8m0 0v8m0-8l-8 8-4-4-6 6" />
            </svg>
          </slot>
        </div>

        <!-- Trend Badge -->
        <div 
          v-if="change !== undefined" 
          :class="trendClasses" 
          class="flex items-center gap-1 px-2.5 py-1 rounded-full text-xs font-semibold"
        >
          <svg v-if="trend === 'up'" class="w-3 h-3" fill="currentColor" viewBox="0 0 20 20">
            <path fill-rule="evenodd" d="M5.293 9.707a1 1 0 010-1.414l4-4a1 1 0 011.414 0l4 4a1 1 0 01-1.414 1.414L11 7.414V15a1 1 0 11-2 0V7.414L6.707 9.707a1 1 0 01-1.414 0z" clip-rule="evenodd"/>
          </svg>
          <svg v-else class="w-3 h-3" fill="currentColor" viewBox="0 0 20 20">
            <path fill-rule="evenodd" d="M14.707 10.293a1 1 0 010 1.414l-4 4a1 1 0 01-1.414 0l-4-4a1 1 0 111.414-1.414L9 12.586V5a1 1 0 012 0v7.586l2.293-2.293a1 1 0 011.414 0z" clip-rule="evenodd"/>
          </svg>
          <span>{{ Math.abs(change) }}%</span>
        </div>
      </div>

      <!-- Title -->
      <p class="text-sm font-medium text-slate-400 uppercase tracking-wider mb-2">
        {{ title }}
      </p>

      <!-- Value with animation -->
      <div class="flex items-baseline gap-2 mb-1">
        <p class="text-3xl font-bold text-slate-100">
          <AnimatedNumber 
            v-if="typeof value === 'number'"
            :value="value" 
            :format="format"
            :decimals="decimals"
          />
          <span v-else>{{ value }}</span>
        </p>
      </div>

      <!-- Period -->
      <p v-if="period" class="text-xs text-slate-500">
        {{ period }}
      </p>
    </div>

    <!-- Loading Overlay -->
    <div 
      v-if="loading" 
      class="absolute inset-0 bg-surface-elevated/80 backdrop-blur-sm flex items-center justify-center"
    >
      <div class="animate-spin rounded-full h-8 w-8 border-2 border-accent-400 border-t-transparent" />
    </div>
  </div>
</template>

<script setup lang="ts">
import { computed } from 'vue'
import AnimatedNumber from './AnimatedNumber.vue'

interface Props {
  title: string
  value: number | string
  format?: 'number' | 'currency' | 'percentage' | 'compact'
  decimals?: number
  change?: number
  period?: string
  color?: 'accent' | 'blue' | 'purple' | 'success' | 'warning' | 'danger' | 'teal' | 'orange'
  loading?: boolean
}

const props = withDefaults(defineProps<Props>(), {
  format: 'number',
  decimals: 0,
  color: 'accent',
  loading: false,
})

const trend = computed(() => {
  if (props.change === undefined) return null
  return props.change >= 0 ? 'up' : 'down'
})

const trendClasses = computed(() => {
  if (trend.value === 'up') {
    return 'bg-success-500/10 text-success-400'
  } else {
    return 'bg-danger-500/10 text-danger-400'
  }
})

const colorConfig = {
  accent: {
    gradient: 'from-accent-500 to-cyan-500',
    glow: 'from-accent-500/20 to-cyan-500/20',
    shadow: 'shadow-accent-500/20',
  },
  blue: {
    gradient: 'from-blue-500 to-blue-600',
    glow: 'from-blue-500/20 to-blue-600/20',
    shadow: 'shadow-blue-500/20',
  },
  purple: {
    gradient: 'from-purple-500 to-violet-600',
    glow: 'from-purple-500/20 to-violet-600/20',
    shadow: 'shadow-purple-500/20',
  },
  success: {
    gradient: 'from-success-500 to-success-600',
    glow: 'from-success-500/20 to-success-600/20',
    shadow: 'shadow-success-500/20',
  },
  warning: {
    gradient: 'from-warning-500 to-warning-600',
    glow: 'from-warning-500/20 to-warning-600/20',
    shadow: 'shadow-warning-500/20',
  },
  danger: {
    gradient: 'from-danger-500 to-danger-600',
    glow: 'from-danger-500/20 to-danger-600/20',
    shadow: 'shadow-danger-500/20',
  },
  teal: {
    gradient: 'from-teal-500 to-teal-600',
    glow: 'from-teal-500/20 to-teal-600/20',
    shadow: 'shadow-teal-500/20',
  },
  orange: {
    gradient: 'from-orange-500 to-orange-600',
    glow: 'from-orange-500/20 to-orange-600/20',
    shadow: 'shadow-orange-500/20',
  },
}

const config = computed(() => colorConfig[props.color] || colorConfig.accent)

const iconWrapperClasses = computed(() => [
  'w-12 h-12',
  'bg-gradient-to-br',
  config.value.gradient,
  'shadow-lg',
  config.value.shadow,
])

const glowGradient = computed(() => [
  'bg-gradient-to-br',
  config.value.glow,
])

const cardClasses = computed(() => [
  props.loading ? 'pointer-events-none' : '',
])
</script>

<style scoped>
.stat-card {
  position: relative;
  border-radius: 16px;
  background: #1a2332; /* surface-1 */
  border: 1px solid rgba(255, 255, 255, 0.06);
  padding: 1.5rem;
  transition: all 0.3s cubic-bezier(0.16, 1, 0.3, 1);
  overflow: hidden;
}

.stat-card:hover { border-color: rgba(255, 255, 255, 0.12); transform: translateY(-2px); }

.accent-bar {
  position: absolute; left: 0; top: 0; bottom: 0; width: 4px;
  border-top-right-radius: 4px; border-bottom-right-radius: 4px;
}

.stat-content { display: flex; align-items: flex-start; justify-content: space-between; padding-left: 0.75rem; }

.stat-info { flex: 1; }

.stat-title { font-size: 0.875rem; font-weight: 500; color: #94a3b8; margin-bottom: 0.25rem; }

.stat-value {
  font-size: 1.875rem; font-weight: 800; color: #f1f5f9;
  letter-spacing: -0.02em; line-height: 1.2;
}

.stat-change { margin-top: 0.75rem; display: flex; align-items: center; font-size: 0.875rem; }

.change-badge {
  display: inline-flex; align-items: center; gap: 0.25rem;
  padding: 0.15rem 0.5rem; border-radius: 999px;
  font-size: 0.75rem; font-weight: 600;
}

.change-badge.positive { background: rgba(16, 185, 129, 0.1); color: #34d399; }
.change-badge.negative { background: rgba(244, 63, 94, 0.1); color: #fb7185; }

.stat-period { color: #64748b; margin-left: 0.5rem; font-size: 0.75rem; }

.stat-icon {
  width: 48px; height: 48px;
  border-radius: 12px;
  display: flex; align-items: center; justify-content: center;
  flex-shrink: 0;
}

/* Colors */
.stat-card.teal .accent-bar { background: linear-gradient(to bottom, #14b8a6, #0d9488); }
.stat-card.teal .stat-icon { background: rgba(20, 184, 166, 0.1); color: #2dd4bf; }

.stat-card.blue .accent-bar { background: linear-gradient(to bottom, #0ea5e9, #0284c7); }
.stat-card.blue .stat-icon { background: rgba(14, 165, 233, 0.1); color: #38bdf8; }

.stat-card.purple .accent-bar { background: linear-gradient(to bottom, #8b5cf6, #7c3aed); }
.stat-card.purple .stat-icon { background: rgba(139, 92, 246, 0.1); color: #a78bfa; }

.stat-card.orange .accent-bar { background: linear-gradient(to bottom, #f59e0b, #d97706); }
.stat-card.orange .stat-icon { background: rgba(245, 158, 11, 0.1); color: #fbbf24; }
</style>
