<template>
  <div v-if="enabled" class="fixed inset-0 pointer-events-none z-0">
    <!-- Custom Cursor -->
    <div
      v-if="showCursor"
      class="fixed w-8 h-8 rounded-full border-2 border-accent-400 pointer-events-none transition-transform duration-150 ease-out z-[9999] mix-blend-difference"
      :style="{
        left: `${mouseX}px`,
        top: `${mouseY}px`,
        opacity: cursorVisible ? 1 : 0,
        transform: `translate(-50%, -50%) scale(${cursorScale})`,
      }"
    ></div>
    <div
      v-if="showCursor"
      class="fixed w-2 h-2 rounded-full bg-accent-400 pointer-events-none z-[9999] mix-blend-difference"
      :style="{
        left: `${mouseX}px`,
        top: `${mouseY}px`,
        opacity: cursorVisible ? 1 : 0,
        transform: 'translate(-50%, -50%)',
      }"
    ></div>

    <!-- Spotlight -->
    <div
      v-if="showSpotlight"
      class="fixed w-[800px] h-[800px] rounded-full pointer-events-none transition-opacity duration-300 z-0"
      :style="{
        left: `${mouseX}px`,
        top: `${mouseY}px`,
        transform: 'translate(-50%, -50%)',
        background: 'radial-gradient(circle, rgba(20, 184, 166, 0.08) 0%, transparent 70%)',
        opacity: cursorVisible ? 1 : 0
      }"
    ></div>

    <!-- Cursor Trail -->
    <div
      v-if="showTrail"
      v-for="(particle, index) in cursorTrail"
      :key="index"
      class="fixed w-1 h-1 rounded-full bg-cyan-400 pointer-events-none z-[9998]"
      :style="{
        left: `${particle.x}px`,
        top: `${particle.y}px`,
        opacity: particle.opacity,
        transform: 'translate(-50%, -50%)',
      }"
    ></div>

    <!-- Click Particles -->
    <div
      v-if="showClickParticles"
      v-for="(particle, index) in clickParticles"
      :key="`click-${index}`"
      class="fixed w-2 h-2 rounded-full pointer-events-none z-[9998]"
      :style="{
        left: `${particle.x}px`,
        top: `${particle.y}px`,
        background: particle.color,
        opacity: particle.opacity,
        transform: `translate(-50%, -50%) scale(${particle.scale})`,
        transition: 'all 0.1s ease-out'
      }"
    ></div>

    <!-- Aurora -->
    <div v-if="showAurora" class="fixed inset-0 overflow-hidden pointer-events-none z-0">
      <div
        class="absolute w-full h-full"
        style="
          background:
            radial-gradient(ellipse 80% 50% at 50% -20%, rgba(20, 184, 166, 0.15), transparent),
            radial-gradient(ellipse 60% 50% at 80% 50%, rgba(139, 92, 246, 0.10), transparent),
            radial-gradient(ellipse 60% 50% at 20% 80%, rgba(34, 211, 238, 0.10), transparent);
          animation: aurora 15s ease-in-out infinite;
        "
      ></div>
    </div>

    <!-- Cinematic Overlays -->
    <div class="fixed inset-0 pointer-events-none z-0 cinematic-vignette"></div>
    <div v-if="showFilmGrain" class="fixed inset-0 pointer-events-none z-0 film-grain opacity-20"></div>

    <!-- Background Mesh + Grid -->
    <div class="fixed inset-0 overflow-hidden pointer-events-none">
      <div
        class="absolute top-0 left-0 right-0 h-[600px] bg-gradient-to-b from-accent-500/5 via-cyan-500/5 to-transparent blur-3xl animate-float"
        style="animation-duration: 8s;"
      ></div>
      <div
        class="absolute bottom-0 left-0 w-[600px] h-[600px] bg-violet-500/5 rounded-full blur-3xl animate-float-slow"
        style="animation-duration: 12s; animation-delay: -2s;"
      ></div>
      <div
        class="absolute top-1/2 right-0 w-[500px] h-[500px] bg-cyan-500/5 rounded-full blur-3xl animate-float"
        style="animation-duration: 10s; animation-delay: -4s;"
      ></div>

      <div class="absolute inset-0 animate-pulse-subtle" style="background-image: radial-gradient(circle at 1px 1px, rgba(148, 163, 184, 0.05) 1px, transparent 0); background-size: 40px 40px;"></div>

      <div
        v-if="!lowPerfMode"
        v-for="n in 20"
        :key="n"
        class="absolute w-1 h-1 rounded-full bg-accent-400/20"
        :style="{
          left: `${Math.random() * 100}%`,
          top: `${Math.random() * 100}%`,
          animation: `float ${5 + Math.random() * 5}s ease-in-out infinite`,
          animationDelay: `${Math.random() * 5}s`
        }"
      ></div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { computed, onMounted, onUnmounted, ref, watch } from 'vue'
import { useMouse, useRafFn } from '@vueuse/core'

const props = withDefaults(defineProps<{ enabled?: boolean }>(), {
  enabled: true,
})

const { x: mouseX, y: mouseY } = useMouse({ type: 'client' })

const cursorScale = ref(1)
const cursorVisible = ref(false)
const customCursorEnabled = ref(false)
const reducedMotion = ref(false)
const lowPerfMode = ref(false)
const trailIntervalMs = 24
let lastTrailTime = 0
let cursorMediaQuery: MediaQueryList | null = null
let reducedMotionQuery: MediaQueryList | null = null
let cursorListenersAttached = false

const showCursor = computed(() => props.enabled && customCursorEnabled.value)
const showSpotlight = computed(() => props.enabled && !lowPerfMode.value)
const showTrail = computed(() => props.enabled && customCursorEnabled.value && !lowPerfMode.value)
const showClickParticles = computed(() => props.enabled && customCursorEnabled.value && !lowPerfMode.value)
const showAurora = computed(() => props.enabled && !lowPerfMode.value)
const showFilmGrain = computed(() => props.enabled && !lowPerfMode.value)

const handlePointerMove = () => {
  if (!props.enabled) return
  cursorVisible.value = true
}

const handlePointerLeave = () => {
  cursorVisible.value = false
}

const handleWindowBlur = () => {
  cursorVisible.value = false
}

const isInteractiveElement = (el: Element | null) => !!el?.closest('button, a, input, [role="button"]')

const updateCursorScale = (isHovering: boolean) => {
  cursorScale.value = isHovering ? 1.5 : 1
}

const handlePointerOver = (event: MouseEvent) => {
  if (isInteractiveElement(event.target as Element)) {
    updateCursorScale(true)
  }
}

const handlePointerOut = (event: MouseEvent) => {
  const target = event.target as Element
  const related = event.relatedTarget as Element | null
  if (isInteractiveElement(target) && !isInteractiveElement(related)) {
    updateCursorScale(false)
  }
}

const attachCursorListeners = () => {
  if (cursorListenersAttached || typeof window === 'undefined') return
  window.addEventListener('mousemove', handlePointerMove)
  window.addEventListener('mouseleave', handlePointerLeave)
  window.addEventListener('blur', handleWindowBlur)
  document.addEventListener('mouseover', handlePointerOver)
  document.addEventListener('mouseout', handlePointerOut)
  cursorListenersAttached = true
}

const detachCursorListeners = () => {
  if (!cursorListenersAttached || typeof window === 'undefined') return
  window.removeEventListener('mousemove', handlePointerMove)
  window.removeEventListener('mouseleave', handlePointerLeave)
  window.removeEventListener('blur', handleWindowBlur)
  document.removeEventListener('mouseover', handlePointerOver)
  document.removeEventListener('mouseout', handlePointerOut)
  cursorListenersAttached = false
}

const updateCursorCapability = () => {
  if (typeof window === 'undefined' || !cursorMediaQuery) return
  const enabled = props.enabled && cursorMediaQuery.matches && !lowPerfMode.value && !reducedMotion.value
  if (enabled !== customCursorEnabled.value) {
    customCursorEnabled.value = enabled
    if (enabled) {
      attachCursorListeners()
    } else {
      detachCursorListeners()
      cursorVisible.value = false
    }
  }
}

const updatePerfMode = () => {
  if (typeof window === 'undefined') return
  const memory = (navigator as any).deviceMemory || 0
  const cores = navigator.hardwareConcurrency || 0
  const lowPerf = memory > 0 ? memory <= 4 : cores > 0 ? cores <= 4 : false
  lowPerfMode.value = lowPerf || reducedMotion.value
  updateCursorCapability()
}

interface CursorParticle {
  x: number
  y: number
  opacity: number
}

const cursorTrail = ref<CursorParticle[]>([])
const maxTrailLength = 15

interface ClickParticle {
  id: number
  x: number
  y: number
  color: string
  opacity: number
  scale: number
  vx: number
  vy: number
}

const clickParticles = ref<ClickParticle[]>([])
let particleId = 0
let lastClickTime = 0
const clickCooldownMs = 300
const maxClickParticles = 60
let burstCount = 0
let burstWindowStart = 0
const burstLimit = 4
const burstWindowMs = 1000
const burstCooldownMs = 2000

const createParticleExplosion = (x: number, y: number) => {
  const now = typeof performance !== 'undefined' ? performance.now() : Date.now()
  if (burstWindowStart === 0 || now - burstWindowStart > burstWindowMs) {
    burstWindowStart = now
    burstCount = 0
  }
  if (burstCount >= burstLimit) {
    if (now - burstWindowStart < burstCooldownMs) return
    burstWindowStart = now
    burstCount = 0
  }
  if (now - lastClickTime < clickCooldownMs) return
  lastClickTime = now
  if (clickParticles.value.length > maxClickParticles) {
    clickParticles.value = clickParticles.value.slice(-maxClickParticles)
  }
  const colors = ['#14b8a6', '#22d3ee', '#8b5cf6', '#a855f7', '#ec4899']
  const particleCount = 6

  burstCount += 1
  for (let i = 0; i < particleCount; i++) {
    const angle = (Math.PI * 2 * i) / particleCount
    const velocity = 2 + Math.random() * 3
    const color = colors[Math.floor(Math.random() * colors.length)] ?? '#14b8a6'

    clickParticles.value.push({
      id: particleId++,
      x,
      y,
      color,
      opacity: 1,
      scale: 1,
      vx: Math.cos(angle) * velocity,
      vy: Math.sin(angle) * velocity
    })
  }
}

const handleClickExplosion = (e: MouseEvent) => {
  if (!customCursorEnabled.value || lowPerfMode.value || !props.enabled) return
  createParticleExplosion(e.clientX, e.clientY)
}

watch([mouseX, mouseY], () => {
  if (!customCursorEnabled.value || !cursorVisible.value || lowPerfMode.value || !props.enabled) return
  const now = typeof performance !== 'undefined' ? performance.now() : Date.now()
  if (now - lastTrailTime < trailIntervalMs) return
  lastTrailTime = now
  cursorTrail.value.push({
    x: mouseX.value,
    y: mouseY.value,
    opacity: 0.8
  })

  if (cursorTrail.value.length > maxTrailLength) {
    cursorTrail.value.shift()
  }
})

useRafFn(() => {
  if (lowPerfMode.value || !props.enabled) return
  clickParticles.value = clickParticles.value.map(p => ({
    ...p,
    x: p.x + p.vx,
    y: p.y + p.vy,
    vx: p.vx * 0.98,
    vy: p.vy * 0.98 + 0.1,
    opacity: p.opacity * 0.95,
    scale: p.scale * 0.97
  })).filter(p => p.opacity > 0.01)
})

useRafFn(() => {
  if (!customCursorEnabled.value || lowPerfMode.value || !props.enabled) return
  cursorTrail.value = cursorTrail.value.map(particle => ({
    ...particle,
    opacity: particle.opacity * 0.92
  })).filter(particle => particle.opacity > 0.05)
})

watch(showCursor, (value) => {
  if (typeof document === 'undefined') return
  document.documentElement.classList.toggle('cursor-none', value)
})

watch(lowPerfMode, (value) => {
  if (typeof document === 'undefined') return
  document.documentElement.classList.toggle('low-perf', value)
})

watch(() => props.enabled, () => {
  updateCursorCapability()
})

onMounted(() => {
  if (typeof window !== 'undefined') {
    reducedMotionQuery = window.matchMedia('(prefers-reduced-motion: reduce)')
    reducedMotion.value = reducedMotionQuery.matches
    reducedMotionQuery.addEventListener('change', (event) => {
      reducedMotion.value = event.matches
      updatePerfMode()
    })

    const memory = (navigator as any).deviceMemory || 0
    const cores = navigator.hardwareConcurrency || 0
    lowPerfMode.value = memory > 0 ? memory <= 4 : cores > 0 ? cores <= 4 : false

    cursorMediaQuery = window.matchMedia('(hover: hover) and (pointer: fine)')
    updateCursorCapability()
    cursorMediaQuery.addEventListener('change', updateCursorCapability)

    document.addEventListener('click', handleClickExplosion)
  }
})

onUnmounted(() => {
  if (cursorMediaQuery) {
    cursorMediaQuery.removeEventListener('change', updateCursorCapability)
  }
  if (reducedMotionQuery) {
    reducedMotionQuery.removeEventListener('change', updatePerfMode)
  }
  document.removeEventListener('click', handleClickExplosion)
  detachCursorListeners()
  if (typeof document !== 'undefined') {
    document.documentElement.classList.remove('cursor-none')
    document.documentElement.classList.remove('low-perf')
  }
})
</script>
