<template>
  <div class="animate-pulse" :class="containerClass">
    <component :is="skeletonComponent" v-if="type !== 'custom'" />
    <slot v-else />
  </div>
</template>

<script setup lang="ts">
import { computed, h } from 'vue'

interface Props {
  type?: 'card' | 'table' | 'list' | 'stat' | 'text' | 'custom'
  count?: number
  rows?: number
}

const props = withDefaults(defineProps<Props>(), {
  type: 'card',
  count: 1,
  rows: 3,
})

const containerClass = computed(() => {
  if (props.type === 'list' || props.type === 'table') {
    return 'space-y-4'
  }
  return ''
})

const skeletonComponent = computed(() => {
  switch (props.type) {
    case 'card':
      return h('div', { class: 'bg-surface-elevated rounded-2xl p-6 border border-surface-border' }, [
        h('div', { class: 'flex items-center gap-4 mb-4' }, [
          h('div', { class: 'w-12 h-12 bg-surface-2 rounded-xl' }),
          h('div', { class: 'flex-1 space-y-2' }, [
            h('div', { class: 'h-4 bg-surface-2 rounded w-1/2' }),
            h('div', { class: 'h-3 bg-surface-2 rounded w-1/3' }),
          ]),
        ]),
        h('div', { class: 'space-y-3' }, [
          h('div', { class: 'h-3 bg-surface-2 rounded w-full' }),
          h('div', { class: 'h-3 bg-surface-2 rounded w-5/6' }),
          h('div', { class: 'h-3 bg-surface-2 rounded w-4/6' }),
        ]),
      ])

    case 'stat':
      return h('div', { class: 'bg-surface-elevated rounded-2xl p-6 border border-surface-border' }, [
        h('div', { class: 'flex items-start justify-between mb-4' }, [
          h('div', { class: 'w-12 h-12 bg-surface-2 rounded-xl' }),
          h('div', { class: 'px-2 py-1 bg-surface-2 rounded-full w-16 h-6' }),
        ]),
        h('div', { class: 'space-y-2' }, [
          h('div', { class: 'h-3 bg-surface-2 rounded w-1/2' }),
          h('div', { class: 'h-8 bg-surface-2 rounded w-3/4 mt-2' }),
          h('div', { class: 'h-2 bg-surface-2 rounded w-1/3 mt-2' }),
        ]),
      ])

    case 'table':
      return h('div', { class: 'bg-surface-elevated rounded-xl border border-surface-border overflow-hidden' }, [
        // Header
        h('div', { class: 'border-b border-surface-border p-4 flex gap-4' }, 
          Array.from({ length: 4 }).map(() => 
            h('div', { class: 'h-4 bg-surface-2 rounded flex-1' })
          )
        ),
        // Rows
        ...Array.from({ length: props.rows }).map(() =>
          h('div', { class: 'border-b border-surface-border p-4 flex gap-4' }, 
            Array.from({ length: 4 }).map(() => 
              h('div', { class: 'h-4 bg-surface-2 rounded flex-1' })
            )
          )
        ),
      ])

    case 'list':
      return h('div', { class: 'space-y-3' },
        Array.from({ length: props.count }).map(() =>
          h('div', { class: 'bg-surface-elevated rounded-xl p-4 border border-surface-border flex items-center gap-4' }, [
            h('div', { class: 'w-10 h-10 bg-surface-2 rounded-lg flex-shrink-0' }),
            h('div', { class: 'flex-1 space-y-2' }, [
              h('div', { class: 'h-4 bg-surface-2 rounded w-2/3' }),
              h('div', { class: 'h-3 bg-surface-2 rounded w-1/2' }),
            ]),
          ])
        )
      )

    case 'text':
      return h('div', { class: 'space-y-2' },
        Array.from({ length: props.rows }).map(() =>
          h('div', { class: 'h-4 bg-surface-2 rounded w-full' })
        )
      )

    default:
      return h('div', { class: 'h-20 bg-surface-2 rounded' })
  }
})
</script>
