<template>
  <aside :class="['sidebar', isOpen ? 'open' : '', isMinimized ? 'minimized' : '']">
    <div class="sidebar-spacer"></div>

    <!-- Toggle Button -->
    <button @click="toggleMinimize" class="sidebar-toggle" :title="isMinimized ? 'Expandir sidebar' : 'Minimizar sidebar'">
      <svg v-if="!isMinimized" width="16" height="16" fill="none" stroke="currentColor" viewBox="0 0 24 24">
        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2.5" d="M11 19l-7-7 7-7m8 14l-7-7 7-7" />
      </svg>
      <svg v-else width="16" height="16" fill="none" stroke="currentColor" viewBox="0 0 24 24">
        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2.5" d="M13 5l7 7-7 7M5 5l7 7-7 7" />
      </svg>
    </button>

    <!-- Separator Line -->
    <div class="sidebar-separator"></div>

    <nav class="sidebar-nav">
      <!-- Main Section -->
      <div class="sidebar-section">
        <p v-show="!isMinimized" class="sidebar-label">Principal</p>

        <router-link to="/dashboard" class="sidebar-link" exact-active-class="active" :title="isMinimized ? 'Dashboard' : ''">
          <div class="sidebar-icon">
            <svg width="18" height="18" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 5a1 1 0 011-1h4a1 1 0 011 1v5a1 1 0 01-1 1H5a1 1 0 01-1-1V5zM14 5a1 1 0 011-1h4a1 1 0 011 1v3a1 1 0 01-1 1h-4a1 1 0 01-1-1V5zM4 15a1 1 0 011-1h4a1 1 0 011 1v3a1 1 0 01-1 1H5a1 1 0 01-1-1v-3zM14 13a1 1 0 011-1h4a1 1 0 011 1v5a1 1 0 01-1 1h-4a1 1 0 01-1-1v-5z" /></svg>
          </div>
          <span v-show="!isMinimized">Dashboard</span>
        </router-link>
      </div>

      <!-- Operaciones Section -->
      <div class="sidebar-section">
        <p v-show="!isMinimized" class="sidebar-label">Operaciones</p>

        <router-link to="/productos" class="sidebar-link" active-class="active" :title="isMinimized ? 'Productos' : ''">
          <div class="sidebar-icon">
            <svg width="18" height="18" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M20 7l-8-4-8 4m16 0l-8 4m8-4v10l-8 4m0-10L4 7m8 4v10M4 7v10l8 4" /></svg>
          </div>
          <span v-show="!isMinimized">Productos</span>
          <span v-show="!isMinimized" class="sidebar-badge">1,248</span>
        </router-link>

        <router-link to="/ventas" class="sidebar-link" active-class="active" :title="isMinimized ? 'Ventas' : ''">
          <div class="sidebar-icon">
            <svg width="18" height="18" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8c-1.657 0-3 .895-3 2s1.343 2 3 2 3 .895 3 2-1.343 2-3 2m0-8c1.11 0 2.08.402 2.599 1M12 8V7m0 1v8m0 0v1m0-1c-1.11 0-2.08-.402-2.599-1M21 12a9 9 0 11-18 0 9 9 0 0118 0z" /></svg>
          </div>
          <span v-show="!isMinimized">Ventas</span>
        </router-link>

        <router-link to="/inventario" class="sidebar-link" active-class="active" :title="isMinimized ? 'Inventario' : ''">
          <div class="sidebar-icon">
            <svg width="18" height="18" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M20 13V6a2 2 0 00-2-2H6a2 2 0 00-2 2v7m16 0v5a2 2 0 01-2 2H6a2 2 0 01-2-2v-5m16 0h-2.586a1 1 0 00-.707.293l-2.414 2.414a1 1 0 01-.707.293h-3.172a1 1 0 01-.707-.293l-2.414-2.414A1 1 0 006.586 13H4" /></svg>
          </div>
          <span v-show="!isMinimized">Inventario</span>
          <span v-show="!isMinimized" class="sidebar-dot" title="Alertas de stock"></span>
        </router-link>

        <router-link to="/clientes" class="sidebar-link" active-class="active" :title="isMinimized ? 'Clientes' : ''">
          <div class="sidebar-icon">
            <svg width="18" height="18" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 20h5v-2a3 3 0 00-5.997-1A7 7 0 0021 9m-9-4a3 3 0 11-6 0 3 3 0 016 0zM15 20h-2.243a3 3 0 00-3-3H7a3 3 0 00-3 3v2h12z" /></svg>
          </div>
          <span v-show="!isMinimized">Clientes</span>
        </router-link>
      </div>

      <!-- Administration Section -->
      <div class="sidebar-section">
        <p v-show="!isMinimized" class="sidebar-label">Administración</p>

        <router-link to="/reportes" class="sidebar-link" active-class="active" :title="isMinimized ? 'Reportes' : ''">
          <div class="sidebar-icon">
            <svg width="18" height="18" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 19v-6a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2a2 2 0 002-2zm0 0V9a2 2 0 012-2h2a2 2 0 012 2v10m-6 0a2 2 0 002 2h2a2 2 0 002-2m0 0V5a2 2 0 012-2h2a2 2 0 012 2v14a2 2 0 01-2 2h-2a2 2 0 01-2-2z" /></svg>
          </div>
          <span v-show="!isMinimized">Reportes</span>
        </router-link>

        <router-link to="/configuracion" class="sidebar-link" active-class="active" :title="isMinimized ? 'Configuración' : ''">
          <div class="sidebar-icon">
            <svg width="18" height="18" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10.325 4.317c.426-1.756 2.924-1.756 3.35 0a1.724 1.724 0 002.573 1.066c1.543-.94 3.31.826 2.37 2.37a1.724 1.724 0 001.065 2.572c1.756.426 1.756 2.924 0 3.35a1.724 1.724 0 00-1.066 2.573c.94 1.543-.826 3.31-2.37 2.37a1.724 1.724 0 00-2.572 1.065c-.426 1.756-2.924 1.756-3.35 0a1.724 1.724 0 00-2.573-1.066c-1.543.94-3.31-.826-2.37-2.37a1.724 1.724 0 00-1.065-2.572c-1.756-.426-1.756-2.924 0-3.35a1.724 1.724 0 001.066-2.573c-.94-1.543.826-3.31 2.37-2.37.996.608 2.296.07 2.572-1.065z" /><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" /></svg>
          </div>
          <span v-show="!isMinimized">Configuración</span>
        </router-link>
      </div>

      <!-- Plan Card -->
      <div v-show="!isMinimized" class="sidebar-plan">
        <div class="plan-card">
          <div class="plan-header">
            <div class="plan-icon">
              <svg width="16" height="16" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 10V3L4 14h7v7l9-11h-7z" /></svg>
            </div>
            <div>
              <p class="plan-title">FerreCloud Pro</p>
              <p class="plan-version">v1.0.0</p>
            </div>
          </div>
          <div class="plan-progress">
             <div class="plan-progress-bar" style="width: 65%"></div>
          </div>
          <p class="plan-text">65% del plan utilizado</p>
        </div>
      </div>
    </nav>
  </aside>

  <!-- Mobile Overlay -->
  <Transition enter-active-class="fade-enter-active" enter-from-class="fade-enter-from" leave-active-class="fade-leave-active" leave-to-class="fade-leave-to">
    <div v-if="isOpen" class="sidebar-overlay" @click="$emit('closeSidebar')"></div>
  </Transition>
</template>

<script setup lang="ts">
import { watch } from 'vue'

const props = defineProps({
  isOpen: {
    type: Boolean,
    default: false
  },
  isMinimized: {
    type: Boolean,
    default: false
  }
})

const emit = defineEmits(['closeSidebar', 'toggleMinimize'])

const toggleMinimize = () => {
  emit('toggleMinimize')
}

// Close sidebar on mobile when minimizing on desktop
watch(() => props.isMinimized, (newVal) => {
  if (window.innerWidth < 1024 && newVal) {
    emit('closeSidebar')
  }
})
</script>

<style scoped>
.sidebar {
  position: fixed;
  top: 64px; /* Height of TopNavbar */
  left: 0;
  height: calc(100vh - 64px);
  width: 260px;
  background: rgba(10, 14, 23, 0.98);
  backdrop-filter: blur(20px) saturate(180%);
  border-right: 1px solid rgba(20, 184, 166, 0.1);
  box-shadow: 4px 0 20px rgba(0, 0, 0, 0.3);
  z-index: 40;
  overflow-y: auto;
  overflow-x: hidden;
  transition: all 0.3s cubic-bezier(0.16, 1, 0.3, 1);
  transform: translateX(-100%);
  scrollbar-width: thin;
  scrollbar-color: rgba(20, 184, 166, 0.2) transparent;
}

.sidebar::-webkit-scrollbar {
  width: 6px;
}

.sidebar::-webkit-scrollbar-track {
  background: transparent;
}

.sidebar::-webkit-scrollbar-thumb {
  background: rgba(20, 184, 166, 0.2);
  border-radius: 3px;
}

@media (min-width: 1024px) {
  .sidebar {
    transform: translateX(0);
    position: fixed;
  }
}

.sidebar.open { transform: translateX(0); }

.sidebar.minimized {
  width: 80px;
}

.sidebar.minimized .sidebar-link {
  justify-content: center;
  padding: 0.65rem 0.5rem;
  gap: 0;
}

.sidebar.minimized .sidebar-icon {
  margin: 0;
  width: 36px;
  height: 36px;
}

.sidebar.minimized .sidebar-section {
  padding-top: 0.25rem;
}

.sidebar-spacer { height: 4rem; }

/* Separator Line */
.sidebar-separator {
  height: 1px;
  background: linear-gradient(90deg, transparent, rgba(20, 184, 166, 0.2) 50%, transparent);
  margin: 0 1rem 0.5rem;
}

.sidebar.minimized .sidebar-separator {
  margin: 0 0.5rem 0.5rem;
}

/* Toggle Button */
.sidebar-toggle {
  position: absolute;
  top: 1.25rem;
  right: 1rem;
  width: 32px;
  height: 32px;
  background: linear-gradient(135deg, rgba(20, 184, 166, 0.15), rgba(6, 182, 212, 0.15));
  border: 1.5px solid rgba(20, 184, 166, 0.25);
  border-radius: 10px;
  display: flex;
  align-items: center;
  justify-content: center;
  color: #5eead4;
  cursor: pointer;
  transition: all 0.25s cubic-bezier(0.16, 1, 0.3, 1);
  z-index: 10;
  backdrop-filter: blur(10px);
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
}

.sidebar-toggle:hover {
  background: linear-gradient(135deg, rgba(20, 184, 166, 0.25), rgba(6, 182, 212, 0.25));
  border-color: rgba(20, 184, 166, 0.4);
  transform: scale(1.08);
  box-shadow: 0 4px 16px rgba(20, 184, 166, 0.25), 0 0 20px rgba(20, 184, 166, 0.15);
}

.sidebar-toggle:active {
  transform: scale(0.98);
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
}

.sidebar-toggle svg {
  transition: transform 0.25s cubic-bezier(0.16, 1, 0.3, 1);
}

.sidebar-toggle:hover svg {
  transform: translateX(1px);
}

.sidebar.minimized .sidebar-toggle {
  right: 50%;
  transform: translateX(50%);
}

.sidebar.minimized .sidebar-toggle:hover {
  transform: translateX(50%) scale(1.08);
}

.sidebar.minimized .sidebar-toggle:hover svg {
  transform: translateX(0);
}

.sidebar.minimized .sidebar-toggle:active {
  transform: translateX(50%) scale(0.98);
}

.sidebar-nav { padding: 0.75rem 0.75rem 1.5rem; display: flex; flex-direction: column; gap: 0.5rem; }

.sidebar-section { padding-top: 0.5rem; margin-bottom: 0.5rem; }

.sidebar-label {
  padding: 0 0.75rem;
  margin-bottom: 0.5rem;
  font-size: 0.65rem;
  font-weight: 700;
  text-transform: uppercase;
  letter-spacing: 0.15em;
  color: #64748b;
  transition: opacity 0.2s, transform 0.2s;
}

.sidebar.minimized .sidebar-label {
  opacity: 0;
  transform: translateX(-10px);
  height: 0;
  margin: 0;
  padding: 0;
  overflow: hidden;
}

.sidebar-link {
  display: flex; align-items: center; gap: 0.75rem;
  padding: 0.65rem 0.75rem;
  border-radius: 12px;
  color: #94a3b8;
  font-size: 0.875rem;
  font-weight: 500;
  text-decoration: none;
  transition: all 0.2s;
  border: 1px solid transparent;
  position: relative;
  white-space: nowrap;
  overflow: hidden;
}

.sidebar-link span {
  transition: opacity 0.2s, transform 0.2s;
}

.sidebar.minimized .sidebar-link span {
  opacity: 0;
  transform: translateX(-10px);
  width: 0;
}

.sidebar-link:hover {
  background: rgba(255, 255, 255, 0.04);
  color: #e2e8f0;
}

.sidebar-link.active {
  background: rgba(20, 184, 166, 0.15);
  color: #5eead4;
  border-color: rgba(20, 184, 166, 0.3);
  box-shadow: 0 0 20px rgba(20, 184, 166, 0.1);
}

/* Tooltips for minimized state */
.sidebar.minimized .sidebar-link[title]:hover::after {
  content: attr(title);
  position: absolute;
  left: calc(100% + 12px);
  top: 50%;
  transform: translateY(-50%);
  background: rgba(10, 14, 23, 0.98);
  color: #e2e8f0;
  padding: 0.5rem 0.75rem;
  border-radius: 8px;
  border: 1px solid rgba(20, 184, 166, 0.2);
  font-size: 0.875rem;
  white-space: nowrap;
  z-index: 100;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.3);
  animation: tooltipFadeIn 0.2s ease;
}

.sidebar-icon {
  width: 32px; height: 32px;
  flex-shrink: 0;
  border-radius: 8px;
  background: rgba(255, 255, 255, 0.04);
  display: flex; align-items: center; justify-content: center;
  color: #64748b;
  transition: all 0.2s;
}

.sidebar-link:hover .sidebar-icon {
  background: rgba(255, 255, 255, 0.06);
  color: #cbd5e1;
}

.sidebar-link.active .sidebar-icon {
  background: rgba(20, 184, 166, 0.15);
  color: #2dd4bf;
}

.sidebar-badge {
  margin-left: auto;
  background: rgba(20, 184, 166, 0.1);
  color: #2dd4bf;
  font-size: 0.65rem;
  font-weight: 700;
  padding: 0.15rem 0.5rem;
  border-radius: 999px;
  transition: opacity 0.2s, transform 0.2s;
}

.sidebar.minimized .sidebar-badge {
  opacity: 0;
  transform: scale(0.8);
}

.sidebar-dot {
  margin-left: auto;
  width: 8px; height: 8px;
  background: #fbbf24;
  border-radius: 50%;
}

/* Plan Card */
.sidebar-plan { margin-top: auto; padding-top: 1.5rem; }

.plan-card {
  background: linear-gradient(135deg, rgba(20, 184, 166, 0.1), rgba(6, 182, 212, 0.1));
  border: 1px solid rgba(20, 184, 166, 0.15);
  border-radius: 16px;
  padding: 1rem;
}

.plan-header { display: flex; gap: 0.75rem; margin-bottom: 0.75rem; align-items: center; }

.plan-icon {
  width: 32px; height: 32px;
  background: rgba(20, 184, 166, 0.2);
  border-radius: 8px;
  display: flex; align-items: center; justify-content: center;
  color: #2dd4bf;
}

.plan-title { font-size: 0.75rem; font-weight: 700; color: #e2e8f0; }
.plan-version { font-size: 0.65rem; color: #64748b; }

.plan-progress {
  height: 6px;
  background: #1e293b;
  border-radius: 3px;
  overflow: hidden;
  margin-bottom: 0.35rem;
}

.plan-progress-bar {
  height: 100%;
  background: linear-gradient(90deg, #2dd4bf, #22d3ee);
  border-radius: 3px;
}

.plan-text { font-size: 0.65rem; color: #64748b; }

/* Overlay */
.sidebar-overlay {
  position: fixed;
  inset: 0;
  top: 64px; /* Start below navbar */
  background: rgba(0, 0, 0, 0.6);
  backdrop-filter: blur(4px);
  z-index: 35;
}

.fade-enter-active, .fade-leave-active { transition: opacity 0.3s; }
.fade-enter-from, .fade-leave-to { opacity: 0; }

@keyframes tooltipFadeIn {
  from {
    opacity: 0;
    transform: translateY(-50%) translateX(-5px);
  }
  to {
    opacity: 1;
    transform: translateY(-50%) translateX(0);
  }
}
</style>
