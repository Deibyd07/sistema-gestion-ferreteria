<template>
  <div class="stat-card" :class="color">
    <!-- Accent bar left -->
    <div class="accent-bar"></div>

    <div class="stat-content">
      <div class="stat-info">
        <!-- Title -->
        <p class="stat-title">{{ title }}</p>

        <!-- Value -->
        <p class="stat-value">{{ value }}</p>

        <!-- Change -->
        <div v-if="change !== undefined" class="stat-change">
          <span :class="['change-badge', change >= 0 ? 'positive' : 'negative']">
            <svg v-if="change >= 0" width="12" height="12" fill="currentColor" viewBox="0 0 20 20">
              <path fill-rule="evenodd" d="M5.293 9.707a1 1 0 010-1.414l4-4a1 1 0 011.414 0l4 4a1 1 0 01-1.414 1.414L11 7.414V15a1 1 0 11-2 0V7.414L6.707 9.707a1 1 0 01-1.414 0z" clip-rule="evenodd"/>
            </svg>
            <svg v-else width="12" height="12" fill="currentColor" viewBox="0 0 20 20">
              <path fill-rule="evenodd" d="M14.707 10.293a1 1 0 010 1.414l-4 4a1 1 0 01-1.414 0l-4-4a1 1 0 111.414-1.414L9 12.586V5a1 1 0 012 0v7.586l2.293-2.293a1 1 0 011.414 0z" clip-rule="evenodd"/>
            </svg>
            {{ Math.abs(change) }}%
          </span>
          <span class="stat-period">{{ period }}</span>
        </div>
      </div>

      <!-- Icon -->
      <div class="stat-icon">
        <slot name="icon" />
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
defineProps({
  title: { type: String, required: true },
  value: { type: String, required: true },
  color: { type: String, default: 'teal' },
  change: Number,
  period: { type: String, default: 'vs última semana' }
})
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
