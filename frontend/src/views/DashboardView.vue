<template>
  <div 
    ref="containerRef"
    class="relative min-h-screen bg-[#0A0E17] overflow-hidden"
    :class="[customCursorEnabled ? 'cursor-none' : 'cursor-auto']"
    @mousemove="onMouseMove"
  >
    <!-- Custom Cursor -->
    <div
      v-if="customCursorEnabled"
      class="fixed w-8 h-8 rounded-full border-2 border-accent-400 pointer-events-none transition-transform duration-150 ease-out z-[9999]"
      :style="{
        left: `${mouseX}px`,
        top: `${mouseY}px`,
        transform: `translate(-50%, -50%) scale(${cursorScale})`,
      }"
    ></div>
    <div
      v-if="customCursorEnabled"
      class="fixed w-2 h-2 rounded-full bg-accent-400 pointer-events-none z-[9999]"
      :style="{
        left: `${mouseX}px`,
        top: `${mouseY}px`,
        transform: 'translate(-50%, -50%)',
      }"
    ></div>

    <!-- Mouse Spotlight Effect -->
    <div 
      ref="spotlightRef"
      class="fixed w-[800px] h-[800px] rounded-full pointer-events-none transition-opacity duration-300 z-0"
      :style="{
        left: `${mouseX}px`,
        top: `${mouseY}px`,
        transform: 'translate(-50%, -50%)',
        background: 'radial-gradient(circle, rgba(20, 184, 166, 0.1) 0%, transparent 70%)',
        opacity: isHovering ? 1 : 0
      }"
    ></div>



    <!-- Aurora Borealis Effect -->
    <div class="fixed inset-0 overflow-hidden pointer-events-none z-0">
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
    <div class="fixed inset-0 pointer-events-none z-0 film-grain opacity-20"></div>

    <!-- Sophisticated Background -->
    <div class="fixed inset-0 overflow-hidden pointer-events-none">
      <!-- Animated Mesh Gradients with Parallax -->
      <div 
        class="absolute top-0 left-0 right-0 h-[600px] bg-gradient-to-b from-accent-500/5 via-cyan-500/5 to-transparent blur-3xl animate-float"
        style="animation-duration: 8s;"
        :style="{ transform: `translateY(${scrollY * 0.3}px)` }"
      ></div>
      <div 
        class="absolute bottom-0 left-0 w-[600px] h-[600px] bg-violet-500/5 rounded-full blur-3xl animate-float-slow"
        style="animation-duration: 12s; animation-delay: -2s;"
        :style="{ transform: `translateY(${scrollY * -0.2}px) translateX(${scrollY * 0.1}px)` }"
      ></div>
      <div 
        class="absolute top-1/2 right-0 w-[500px] h-[500px] bg-cyan-500/5 rounded-full blur-3xl animate-float"
        style="animation-duration: 10s; animation-delay: -4s;"
        :style="{ transform: `translateY(${scrollY * 0.15}px) translateX(${scrollY * -0.1}px)` }"
      ></div>
      
      <!-- Animated Grid -->
      <div class="absolute inset-0 animate-pulse-subtle" style="background-image: radial-gradient(circle at 1px 1px, rgba(148, 163, 184, 0.05) 1px, transparent 0); background-size: 40px 40px;"></div>
      
      <!-- Floating Particles -->
      <div
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

    <!-- TopNavbar - Fixed at top with high z-index -->
    <TopNavbar @toggleSidebar="sidebarOpen = !sidebarOpen" />
    
    <!-- Scroll Progress Bar -->
    <div class="fixed top-0 left-0 h-1 bg-gradient-to-r from-accent-400 via-cyan-400 to-violet-400 z-[60]" :style="{ width: `${scrollProgress}%` }"></div>
    
    <div class="dashboard-layout relative z-10">
      <Sidebar :isOpen="sidebarOpen" :isMinimized="sidebarMinimized" @closeSidebar="sidebarOpen = false" @toggleMinimize="sidebarMinimized = !sidebarMinimized" />
      
      <main class="dashboard-main" :class="{ 'sidebar-minimized': sidebarMinimized }">

        <!-- Premium Header -->
        <div class="mb-6 animate-fade-in" style="animation-delay: 100ms;">
          <div class="text-center mb-8">
            <h1 class="text-3xl lg:text-4xl font-bold tracking-tight mb-3">
              <span class="text-white block mb-1">Bienvenido, <span class="text-white">{{ userName }}</span></span>
              <span class="bg-gradient-to-r from-accent-400 via-cyan-400 to-violet-400 bg-clip-text text-transparent animate-gradient-shift bg-[length:200%_auto]">
                Tu Dashboard de Negocios
              </span>
            </h1>
            <p class="text-base text-slate-400 max-w-2xl mx-auto">
              {{ currentDate }}
            </p>
          </div>
        </div>

        <!-- KPI Grid - Sophisticated Stats -->
        <div class="kpi-grid mb-8">
          <div v-for="(card, index) in statsCards" :key="index" class="animate-fade-in" :style="{ animationDelay: `${150 + index * 50}ms` }">
            <div 
              class="group relative backdrop-blur-xl bg-gradient-to-br rounded-2xl border p-6 overflow-hidden transition-all duration-700 cursor-default"
              :class="[card.bgColor, card.borderColor]"
              @mouseenter="onCardHover($event, index)"
              @mousemove="onCardMove($event, index)"
              @mouseleave="onCardLeave(index)"
              :style="cardStyles[index]"
            >
              <!-- 3D Perspective Effect -->
              <div class="absolute inset-0 rounded-2xl opacity-0 group-hover:opacity-100 transition-opacity duration-500 pointer-events-none" :class="card.glowClass"></div>
              
              <!-- Animated gradient on hover -->
              <div class="absolute inset-0 bg-gradient-to-r from-transparent via-white/5 to-transparent skew-x-12 translate-x-[-200%] group-hover:translate-x-[200%] transition-transform duration-1000"></div>
              
              <!-- Ripple effect -->
              <span 
                v-for="ripple in cardRipples[index]" 
                :key="ripple.id"
                class="absolute rounded-full bg-white/30 pointer-events-none animate-ping"
                :style="{
                  left: `${ripple.x}px`,
                  top: `${ripple.y}px`,
                  width: `${ripple.size}px`,
                  height: `${ripple.size}px`,
                  transform: 'translate(-50%, -50%)'
                }"
              ></span>
              
              <div class="relative z-10">
                <div class="flex items-start justify-between mb-4">
                  <div class="flex-1">
                    <p class="text-sm font-medium text-slate-400 uppercase tracking-wider mb-2">{{ card.title }}</p>
                    <p class="text-3xl lg:text-4xl font-bold text-white">{{ card.value }}</p>
                  </div>
                  <div :class="['w-12 h-12 rounded-xl flex items-center justify-center group-hover:scale-110 group-hover:rotate-6 transition-all duration-500', card.iconBg]">
                    <span class="text-xl">{{ card.icon }}</span>
                  </div>
                </div>
                <div class="flex items-center gap-2">
                  <span :class="['text-sm font-semibold', card.changeColor]">{{ card.change > 0 ? '+' : '' }}{{ card.change }}%</span>
                  <span class="text-xs text-slate-500">{{ card.period }}</span>
                </div>
              </div>
            </div>
          </div>
        </div>

        <!-- Primary Content Grid -->
        <div class="primary-grid gap-8 mb-8">
          <!-- Premium Chart Card -->
          <div class="animate-fade-in" style="animation-delay: 350ms;">
            <div class="group relative backdrop-blur-xl bg-white/[0.02] rounded-2xl border border-white/10 p-8 overflow-hidden transition-all duration-700 h-full" @mouseenter="isHovering = true" @mouseleave="isHovering = false">
              <div class="absolute inset-0 rounded-2xl bg-gradient-to-br from-accent-500/0 via-accent-500/5 to-cyan-500/0 opacity-0 group-hover:opacity-100 transition-opacity duration-500"></div>
              <div class="absolute inset-0 bg-gradient-to-r from-transparent via-white/5 to-transparent translate-x-[-200%] group-hover:translate-x-[200%] transition-transform duration-1000"></div>
              
              <div class="relative z-10">
                <div class="flex items-center justify-between mb-6">
                  <div>
                    <h3 class="text-2xl font-bold text-white">📈 Resumen de Ventas</h3>
                    <p class="text-sm text-slate-400 mt-1">Tendencia últimos 7 días</p>
                  </div>
                  <div class="flex gap-2">
                    <button class="px-3 py-1.5 rounded-lg text-xs font-semibold bg-accent-500/10 text-accent-400 border border-accent-500/20 hover:bg-accent-500/20 transition-all">Semanal</button>
                    <button class="px-3 py-1.5 rounded-lg text-xs font-semibold bg-white/5 text-slate-400 border border-white/10 hover:bg-white/10 transition-all">Mensual</button>
                  </div>
                </div>
                
                <div class="h-64">
                  <svg class="chart-svg w-full h-full" preserveAspectRatio="none" viewBox="0 0 400 200">
                    <defs>
                      <linearGradient id="chartGrad" x1="0" y1="0" x2="0" y2="1">
                        <stop offset="0%" stop-color="rgba(20,184,166,0.4)" />
                        <stop offset="100%" stop-color="rgba(20,184,166,0.05)" />
                      </linearGradient>
                    </defs>
                    <path d="M0 180 Q50 160, 80 140 T160 100 T240 120 T320 60 T400 80 V200 H0 Z" fill="url(#chartGrad)" />
                    <path d="M0 180 Q50 160, 80 140 T160 100 T240 120 T320 60 T400 80" fill="none" stroke="#14b8a6" stroke-width="2.5" stroke-linecap="round" style="filter: drop-shadow(0 0 20px rgba(20, 184, 166, 0.3))" />
                    <circle cx="80" cy="140" r="3.5" fill="#14b8a6" />
                    <circle cx="160" cy="100" r="3.5" fill="#14b8a6" />
                    <circle cx="240" cy="120" r="3.5" fill="#14b8a6" />
                    <circle cx="320" cy="60" r="3.5" fill="#14b8a6" />
                    <circle cx="400" cy="80" r="3.5" fill="#14b8a6" />
                  </svg>
                </div>
              </div>
            </div>
          </div>

          <!-- Top Products -->
          <div class="animate-fade-in" style="animation-delay: 400ms;">
            <div class="group relative backdrop-blur-xl bg-white/[0.02] rounded-2xl border border-white/10 overflow-hidden transition-all duration-700 h-full flex flex-col" @mouseenter="isHovering = true" @mouseleave="isHovering = false">
              <div class="absolute inset-0 rounded-2xl bg-gradient-to-br from-violet-500/0 via-violet-500/5 to-purple-500/0 opacity-0 group-hover:opacity-100 transition-opacity duration-500"></div>
              <div class="absolute inset-0 bg-gradient-to-r from-transparent via-white/5 to-transparent translate-x-[-200%] group-hover:translate-x-[200%] transition-transform duration-1000"></div>
              
              <div class="relative z-10 p-8 border-b border-white/5">
                <div class="flex items-center justify-between">
                  <h3 class="text-2xl font-bold text-white">🏆 Top Productos</h3>
                  <a href="#" class="text-accent-400 text-sm font-semibold hover:text-accent-300">Ver todos →</a>
                </div>
              </div>

              <div class="relative z-10 flex-1 overflow-y-auto">
                <div v-for="(product, i) in topProducts" :key="i" class="border-b border-white/5 last:border-b-0 p-4 hover:bg-white/5 transition-colors cursor-pointer group">
                  <div class="flex items-center gap-3">
                    <div class="w-10 h-10 rounded-lg flex items-center justify-center text-lg font-bold bg-gradient-to-br from-accent-500 to-cyan-500 text-white group-hover:scale-110 group-hover:rotate-6 transition-all">{{ i + 1 }}</div>
                    <div class="flex-1">
                      <p class="font-semibold text-white text-sm">{{ product.name }}</p>
                      <p class="text-xs text-slate-500">{{ product.sold }} vendidos</p>
                    </div>
                    <p class="font-bold text-accent-400 group-hover:text-cyan-300 transition-colors">${{ product.revenue }}</p>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>

        <!-- Secondary Grid -->
        <div class="secondary-grid gap-8">
          <!-- Quick Stats -->
          <div class="animate-fade-in" style="animation-delay: 450ms;">
            <div class="group relative backdrop-blur-xl bg-white/[0.02] rounded-2xl border border-white/10 p-8 overflow-hidden transition-all duration-700" @mouseenter="isHovering = true" @mouseleave="isHovering = false">
              <div class="absolute inset-0 rounded-2xl bg-gradient-to-br from-cyan-500/0 via-blue-500/5 to-cyan-500/0 opacity-0 group-hover:opacity-100 transition-opacity duration-500"></div>
              
              <h3 class="text-xl font-bold text-white mb-6">📊 Métricas Clave</h3>
              
              <div class="grid grid-cols-2 gap-4 relative z-10">
                <div class="p-4 rounded-lg bg-gradient-to-br from-emerald-500/10 to-emerald-500/5 border border-emerald-500/20 hover:border-emerald-500/40 hover:bg-emerald-500/15 transition-all cursor-pointer group/stat">
                  <p class="text-xs text-emerald-400 font-semibold mb-1">Margen</p>
                  <p class="text-2xl font-bold text-white group-hover/stat:scale-110 transition-transform">32.5%</p>
                </div>
                <div class="p-4 rounded-lg bg-gradient-to-br from-red-500/10 to-red-500/5 border border-red-500/20 hover:border-red-500/40 hover:bg-red-500/15 transition-all cursor-pointer group/stat">
                  <p class="text-xs text-red-400 font-semibold mb-1">Bajos</p>
                  <p class="text-2xl font-bold text-white group-hover/stat:scale-110 transition-transform">12</p>
                </div>
                <div class="p-4 rounded-lg bg-gradient-to-br from-blue-500/10 to-blue-500/5 border border-blue-500/20 hover:border-blue-500/40 hover:bg-blue-500/15 transition-all cursor-pointer group/stat">
                  <p class="text-xs text-blue-400 font-semibold mb-1">Rotación</p>
                  <p class="text-2xl font-bold text-white group-hover/stat:scale-110 transition-transform">4.2x</p>
                </div>
                <div class="p-4 rounded-lg bg-gradient-to-br from-purple-500/10 to-purple-500/5 border border-purple-500/20 hover:border-purple-500/40 hover:bg-purple-500/15 transition-all cursor-pointer group/stat">
                  <p class="text-xs text-purple-400 font-semibold mb-1">Hoy</p>
                  <p class="text-2xl font-bold text-white group-hover/stat:scale-110 transition-transform">Viernes</p>
                </div>
              </div>
            </div>
          </div>

          <!-- Recent Activity -->
          <div class="animate-fade-in" style="animation-delay: 500ms;">
            <div class="group relative backdrop-blur-xl bg-white/[0.02] rounded-2xl border border-white/10 p-8 overflow-hidden transition-all duration-700" @mouseenter="isHovering = true" @mouseleave="isHovering = false">
              <div class="absolute inset-0 rounded-2xl bg-gradient-to-br from-amber-500/0 via-orange-500/5 to-amber-500/0 opacity-0 group-hover:opacity-100 transition-opacity duration-500"></div>
              
              <h3 class="text-xl font-bold text-white mb-6">⏱️ Actividad Reciente</h3>
              
              <div class="space-y-4 relative z-10">
                <div class="flex items-start gap-3 p-3 rounded-lg hover:bg-white/5 transition-colors cursor-pointer group/activity">
                  <div class="w-2 h-2 rounded-full bg-emerald-400 mt-2 group-hover/activity:scale-150 group-hover/activity:shadow-lg group-hover/activity:shadow-emerald-400/50 transition-all"></div>
                  <div class="flex-1">
                    <p class="text-sm font-semibold text-white group-hover/activity:text-emerald-300 transition-colors">Pedido #001247 completado</p>
                    <p class="text-xs text-slate-500">Hace 5 minutos</p>
                  </div>
                </div>
                <div class="flex items-start gap-3 p-3 rounded-lg hover:bg-white/5 transition-colors cursor-pointer group/activity">
                  <div class="w-2 h-2 rounded-full bg-blue-400 mt-2 group-hover/activity:scale-150 group-hover/activity:shadow-lg group-hover/activity:shadow-blue-400/50 transition-all"></div>
                  <div class="flex-1">
                    <p class="text-sm font-semibold text-white group-hover/activity:text-blue-300 transition-colors">Inventario actualizado</p>
                    <p class="text-xs text-slate-500">Hace 23 minutos</p>
                  </div>
                </div>
                <div class="flex items-start gap-3 p-3 rounded-lg hover:bg-white/5 transition-colors cursor-pointer group/activity">
                  <div class="w-2 h-2 rounded-full bg-purple-400 mt-2 group-hover/activity:scale-150 group-hover/activity:shadow-lg group-hover/activity:shadow-purple-400/50 transition-all"></div>
                  <div class="flex-1">
                    <p class="text-sm font-semibold text-white group-hover/activity:text-purple-300 transition-colors">Cliente registrado: Laura M.</p>
                    <p class="text-xs text-slate-500">Hace 1 hora</p>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </main>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, computed, reactive, onMounted, onUnmounted } from 'vue'
import { useAuthStore } from '@/stores/auth'
import TopNavbar from '@/components/TopNavbar.vue'
import Sidebar from '@/components/Sidebar.vue'

const authStore = useAuthStore()
const containerRef = ref<HTMLElement>()
const spotlightRef = ref<HTMLElement>()
const sidebarOpen = ref(false)
const sidebarMinimized = ref(false)
const cardStyles = reactive<Record<number, any>>({})
const cardRipples = reactive<Record<number, any[]>>({})

// Mouse tracking
const mouseX = ref(0)
const mouseY = ref(0)
const scrollY = ref(0)
const scrollProgress = ref(0)
const cursorScale = ref(1)
const cursorVisible = ref(true)
const isHovering = ref(false)

// Custom cursor - disabled in dashboard (only for login)
const customCursorEnabled = ref(false)

const userName = computed(() => {
  const email = authStore.user?.email || ''
  return email.split('@')[0] || 'Usuario'
})

const currentDate = computed(() => {
  const date = new Date()
  const options: Intl.DateTimeFormatOptions = { weekday: 'long', year: 'numeric', month: 'long', day: 'numeric' }
  return date.toLocaleDateString('es-ES', options)
})

const statsCards = [
  {
    title: 'Ventas del Día',
    value: '$2,847,350',
    icon: '💰',
    change: 12.5,
    period: 'vs ayer',
    bgColor: 'from-teal-500/10 to-cyan-500/5',
    borderColor: 'border-teal-500/20',
    glowClass: 'bg-gradient-to-br from-teal-500/20 via-cyan-500/10 to-transparent',
    iconBg: 'bg-gradient-to-br from-teal-500/20 to-cyan-500/10 text-teal-400',
    changeColor: 'text-emerald-400'
  },
  {
    title: 'Pedidos Hoy',
    value: '48',
    icon: '📦',
    change: 8.2,
    period: 'vs ayer',
    bgColor: 'from-blue-500/10 to-cyan-500/5',
    borderColor: 'border-blue-500/20',
    glowClass: 'bg-gradient-to-br from-blue-500/20 via-cyan-500/10 to-transparent',
    iconBg: 'bg-gradient-to-br from-blue-500/20 to-cyan-500/10 text-blue-400',
    changeColor: 'text-emerald-400'
  },
  {
    title: 'Productos Activos',
    value: '1,248',
    icon: '📊',
    change: 3.1,
    period: 'este mes',
    bgColor: 'from-purple-500/10 to-violet-500/5',
    borderColor: 'border-purple-500/20',
    glowClass: 'bg-gradient-to-br from-purple-500/20 via-violet-500/10 to-transparent',
    iconBg: 'bg-gradient-to-br from-purple-500/20 to-violet-500/10 text-purple-400',
    changeColor: 'text-emerald-400'
  },
  {
    title: 'Clientes Nuevos',
    value: '23',
    icon: '👥',
    change: -2.4,
    period: 'vs ayer',
    bgColor: 'from-orange-500/10 to-amber-500/5',
    borderColor: 'border-orange-500/20',
    glowClass: 'bg-gradient-to-br from-orange-500/20 via-amber-500/10 to-transparent',
    iconBg: 'bg-gradient-to-br from-orange-500/20 to-amber-500/10 text-orange-400',
    changeColor: 'text-red-400'
  }
]

const topProducts = [
  { name: 'Cemento Gris 50kg', sold: 342, revenue: '1,710,000' },
  { name: 'Pintura Blanca 1gal', sold: 256, revenue: '768,000' },
  { name: 'Tubería PVC 1/2"', sold: 198, revenue: '594,000' },
  { name: 'Cable Eléctrico #12', sold: 167, revenue: '501,000' }
]

const onMouseMove = (event: MouseEvent) => {
  mouseX.value = event.clientX
  mouseY.value = event.clientY
}

const onCardHover = (event: MouseEvent, index: number) => {
  const card = event.currentTarget as HTMLElement
  const rect = card.getBoundingClientRect()
  const x = event.clientX - rect.left
  const y = event.clientY - rect.top
  
  cardStyles[index] = {
    '--card-x': `${x}px`,
    '--card-y': `${y}px`
  } as any

  // Create ripple
  if (!cardRipples[index]) cardRipples[index] = []
  cardRipples[index].push({
    id: Date.now(),
    x,
    y,
    size: 20
  })

  setTimeout(() => {
    if (cardRipples[index]) cardRipples[index].shift()
  }, 600)

  cursorScale.value = 1.5
  isHovering.value = true
}

const onCardMove = (event: MouseEvent, index: number) => {
  const card = event.currentTarget as HTMLElement
  const rect = card.getBoundingClientRect()
  const x = event.clientX - rect.left
  const y = event.clientY - rect.top
  
  cardStyles[index] = {
    '--card-x': `${x}px`,
    '--card-y': `${y}px`
  } as any
}

const onCardLeave = (index: number) => {
  cardStyles[index] = {}
  cursorScale.value = 1
  isHovering.value = false
}

const handleScroll = () => {
  const main = document.querySelector('.dashboard-main') as HTMLElement
  if (!main) return

  scrollY.value = main.scrollTop
  
  // Calculate scroll progress for progress bar
  const scrollHeight = main.scrollHeight - main.clientHeight
  scrollProgress.value = (main.scrollTop / scrollHeight) * 100
}

onMounted(() => {
  const main = document.querySelector('.dashboard-main') as HTMLElement
  if (main) {
    main.addEventListener('scroll', handleScroll)
  }

  // Global mouse tracking for custom cursor
  window.addEventListener('mousemove', onMouseMove)
})

onUnmounted(() => {
  const main = document.querySelector('.dashboard-main') as HTMLElement
  if (main) {
    main.removeEventListener('scroll', handleScroll)
  }
  
  // Remove global mouse listener
  window.removeEventListener('mousemove', onMouseMove)
})
</script>

<style scoped>
.dashboard-layout {
  display: flex;
  flex: 1;
  overflow: hidden;
  padding-top: 64px; /* Height of TopNavbar */
}

.dashboard-main {
  flex: 1;
  overflow-y: auto;
  padding: 2rem;
  scrollbar-width: thin;
  scrollbar-color: rgba(20, 184, 166, 0.2) transparent;
  position: relative;
}

@media (min-width: 1024px) {
  .dashboard-main {
    margin-left: 260px; /* Width of Sidebar */
    transition: margin-left 0.3s cubic-bezier(0.16, 1, 0.3, 1);
  }
  
  .dashboard-main.sidebar-minimized {
    margin-left: 80px; /* Width of minimized sidebar */
  }
}

@media (max-width: 1024px) {
  .dashboard-main {
    padding: 1.5rem;
  }
}

.dashboard-main::-webkit-scrollbar {
  width: 8px;
}

.dashboard-main::-webkit-scrollbar-track {
  background: transparent;
}

.dashboard-main::-webkit-scrollbar-thumb {
  background: rgba(20, 184, 166, 0.2);
  border-radius: 4px;
}

/* Cinematic Effects */
.cinematic-vignette {
  background: radial-gradient(ellipse at center, transparent 0%, rgba(10, 14, 23, 0.3) 100%);
}

.film-grain {
  background-image: url("data:image/svg+xml,%3Csvg viewBox='0 0 400 400' xmlns='http://www.w3.org/2000/svg'%3E%3Cfilter id='noiseFilter'%3E%3CfeTurbulence baseFrequency='0.9' numOctaves='4' /%3E%3C/filter%3E%3Crect width='400' height='400' filter='url(%23noiseFilter)' opacity='0.1'/%3E%3C/svg%3E");
}

/* Grid Layouts */
.kpi-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
  gap: 1.5rem;
  margin-bottom: 2rem;
}

@media (min-width: 1024px) {
  .kpi-grid {
    grid-template-columns: repeat(4, 1fr);
  }
}

.primary-grid {
  display: grid;
  grid-template-columns: 1fr;
  gap: 2rem;
  margin-bottom: 2rem;
}

@media (min-width: 1024px) {
  .primary-grid {
    grid-template-columns: 2fr 1fr;
  }
}

.secondary-grid {
  display: grid;
  grid-template-columns: 1fr;
  gap: 2rem;
}

@media (min-width: 1024px) {
  .secondary-grid {
    grid-template-columns: 2fr 1fr;
  }
}

/* Animations */
@keyframes aurora {
  0% {
    background: radial-gradient(ellipse 80% 50% at 50% -20%, rgba(20, 184, 166, 0.15), transparent),
                radial-gradient(ellipse 80% 50% at 50% 120%, rgba(34, 211, 238, 0.1), transparent),
                radial-gradient(ellipse 80% 50% at 50% 50%, rgba(139, 92, 246, 0.05), transparent);
  }
  25% {
    background: radial-gradient(ellipse 80% 50% at 45% -15%, rgba(20, 184, 166, 0.12), transparent),
                radial-gradient(ellipse 80% 50% at 55% 125%, rgba(34, 211, 238, 0.12), transparent),
                radial-gradient(ellipse 80% 50% at 50% 45%, rgba(139, 92, 246, 0.08), transparent);
  }
  50% {
    background: radial-gradient(ellipse 80% 50% at 50% -10%, rgba(20, 184, 166, 0.18), transparent),
                radial-gradient(ellipse 80% 50% at 50% 115%, rgba(34, 211, 238, 0.15), transparent),
                radial-gradient(ellipse 80% 50% at 50% 55%, rgba(139, 92, 246, 0.1), transparent);
  }
  75% {
    background: radial-gradient(ellipse 80% 50% at 55% -15%, rgba(20, 184, 166, 0.12), transparent),
                radial-gradient(ellipse 80% 50% at 45% 120%, rgba(34, 211, 238, 0.12), transparent),
                radial-gradient(ellipse 80% 50% at 50% 50%, rgba(139, 92, 246, 0.08), transparent);
  }
  100% {
    background: radial-gradient(ellipse 80% 50% at 50% -20%, rgba(20, 184, 166, 0.15), transparent),
                radial-gradient(ellipse 80% 50% at 50% 120%, rgba(34, 211, 238, 0.1), transparent),
                radial-gradient(ellipse 80% 50% at 50% 50%, rgba(139, 92, 246, 0.05), transparent);
  }
}

@keyframes float {
  0%, 100% { transform: translateY(0px); }
  50% { transform: translateY(20px); }
}

@keyframes float-slow {
  0%, 100% { transform: translateX(-50%) translateY(0px); }
  25% { transform: translateX(-45%) translateY(15px); }
  50% { transform: translateX(-50%) translateY(30px); }
  75% { transform: translateX(-55%) translateY(15px); }
  100% { transform: translateX(-50%) translateY(0px); }
}

@keyframes pulse-subtle {
  0%, 100% { opacity: 1; }
  50% { opacity: 0.8; }
}

@keyframes fade-in {
  from {
    opacity: 0;
    transform: translateY(10px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

@keyframes gradient-shift {
  0% { background-position: 0% center; }
  100% { background-position: 200% center; }
}

@keyframes ping {
  0% {
    transform: scale(1);
    opacity: 1;
  }
  75%, 100% {
    transform: scale(2);
    opacity: 0;
  }
}

.animate-float {
  animation: float 6s ease-in-out infinite;
}

.animate-float-slow {
  animation: float-slow 8s ease-in-out infinite;
}

.animate-pulse-subtle {
  animation: pulse-subtle 3s ease-in-out infinite;
}

.animate-fade-in {
  animation: fade-in 0.6s ease-out forwards;
  opacity: 0;
}

.animate-gradient-shift {
  animation: gradient-shift 3s ease infinite;
  background-size: 200% auto;
}

.animate-ping {
  animation: ping 1s cubic-bezier(0, 0, 0.2, 1) infinite;
}

/* Chart Styling */
.chart-svg {
  filter: drop-shadow(0 0 20px rgba(20, 184, 166, 0.1));
}

/* Responsive */
@media (max-width: 768px) {
  .dashboard-main {
    padding: 1rem;
  }

  .kpi-grid {
    grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
    gap: 1rem;
  }

  .primary-grid,
  .secondary-grid {
    grid-template-columns: 1fr;
    gap: 1.5rem;
  }
}
</style>
