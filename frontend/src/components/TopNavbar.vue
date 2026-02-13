<template>
  <nav class="navbar">
    <div class="navbar-container">
      <div class="navbar-content">
        <!-- Left: Logo & Toggle -->
        <div class="navbar-left">
          <!-- Mobile sidebar toggle -->
          <button @click="$emit('toggleSidebar')" class="mobile-toggle">
            <svg width="24" height="24" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h16" /></svg>
          </button>

          <!-- Logo -->
          <router-link to="/dashboard" class="navbar-logo-link">
            <div class="navbar-logo-icon">
              <svg width="20" height="20" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2.5" d="M13 10V3L4 14h7v7l9-11h-7z" /></svg>
            </div>
            <div class="navbar-logo-text">
              <p class="logo-title">FerreCloud</p>
              <p class="logo-subtitle">Sistema de Gestión</p>
            </div>
          </router-link>
        </div>

        <!-- Center: Search -->
        <div class="navbar-center">
          <div class="search-wrapper">
            <svg class="search-icon" width="16" height="16" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z" /></svg>
            <input type="text" placeholder="Buscar productos, clientes..." />
            <div class="search-shortcut">⌘K</div>
          </div>
        </div>

        <!-- Right: Actions & Profile -->
        <div class="navbar-right">
          <!-- Notifications -->
          <button class="icon-btn notification-btn">
            <svg width="20" height="20" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 17h5l-1.405-1.405A2.032 2.032 0 0118 14.158V11a6.002 6.002 0 00-4-5.659V5a2 2 0 10-4 0v.341C7.67 6.165 6 8.388 6 11v3.159c0 .538-.214 1.055-.595 1.436L4 17h5m6 0v1a3 3 0 11-6 0v-1m6 0H9" /></svg>
            <span class="notification-dot"></span>
          </button>

          <div class="navbar-divider"></div>

          <!-- User Menu -->
          <div class="user-menu-wrapper">
            <button @click="showUserMenu = !showUserMenu" class="user-btn">
              <div class="user-info">
                <p class="user-name">{{ user?.email?.split('@')[0] || 'Usuario' }}</p>
                <p class="user-role">{{ userRole }}</p>
              </div>
              <div class="user-avatar">
                {{ (user?.email?.charAt(0) || 'U').toUpperCase() }}
              </div>
            </button>

            <!-- Dropdown -->
            <Transition enter-active-class="dropdown-enter-active" enter-from-class="dropdown-enter-from" leave-active-class="dropdown-leave-active" leave-to-class="dropdown-leave-to">
              <div v-if="showUserMenu" class="user-dropdown">
                <div class="dropdown-header">
                  <p class="dropdown-email">{{ user?.email }}</p>
                  <p class="dropdown-role">{{ userRole }}</p>
                </div>
                
                <div class="dropdown-section">
                  <button class="dropdown-item">
                    <svg width="16" height="16" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z" /></svg>
                    Mi Perfil
                  </button>
                  <button class="dropdown-item">
                    <svg width="16" height="16" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10.325 4.317c.426-1.756 2.924-1.756 3.35 0a1.724 1.724 0 002.573 1.066c1.543-.94 3.31.826 2.37 2.37a1.724 1.724 0 001.065 2.572c1.756.426 1.756 2.924 0 3.35a1.724 1.724 0 00-1.066 2.573c.94 1.543-.826 3.31-2.37 2.37a1.724 1.724 0 00-2.572 1.065c-.426 1.756-2.924 1.756-3.35 0a1.724 1.724 0 00-2.573-1.066c-1.543.94-3.31-.826-2.37-2.37a1.724 1.724 0 00-1.065-2.572c-1.756-.426-1.756-2.924 0-3.35a1.724 1.724 0 001.066-2.573c-.94-1.543.826-3.31 2.37-2.37.996.608 2.296.07 2.572-1.065z" /><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" /></svg>
                    Configuración
                  </button>
                  <button class="dropdown-item">
                    <svg width="16" height="16" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8.228 9c.549-1.165 2.03-2 3.772-2 2.21 0 4 1.343 4 3 0 1.4-1.278 2.575-3.006 2.907-.542.104-.994.54-.994 1.093m0 3h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z" /></svg>
                    Ayuda
                  </button>
                </div>
                
                <div class="dropdown-section border-top">
                  <button @click="handleLogout" class="dropdown-item logout">
                    <svg width="16" height="16" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1" /></svg>
                    Cerrar sesión
                  </button>
                </div>
              </div>
            </Transition>
          </div>
        </div>
      </div>
    </div>
    
    <!-- Click outside overlay -->
    <div v-if="showUserMenu" class="dropdown-overlay" @click="showUserMenu = false"></div>
  </nav>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue'
import { useRouter } from 'vue-router'
import { useAuthStore } from '@/stores/auth'

defineEmits(['toggleSidebar'])

const router = useRouter()
const authStore = useAuthStore()
const showUserMenu = ref(false)

const user = computed(() => authStore.user)
const userRole = computed(() => authStore.user?.metadata?.role || 'Administrador')

const handleLogout = async () => {
  showUserMenu.value = false
  if (authStore.accessToken) {
    await authStore.logout()
  }
  router.push('/auth/login')
}
</script>

<style scoped>
.navbar {
  position: sticky; top: 0; z-index: 40;
  background: rgba(15, 23, 42, 0.85);
  backdrop-filter: blur(20px);
  border-bottom: 1px solid rgba(255, 255, 255, 0.06);
}

.navbar-container {
  max-width: 1600px; margin: 0 auto;
  padding: 0 1.5rem;
}

.navbar-content {
  display: flex; align-items: center; justify-content: space-between;
  height: 64px;
}

/* LEFT */
.navbar-left { display: flex; align-items: center; gap: 1rem; }

.mobile-toggle {
  display: none; padding: 0.5rem; color: #94a3b8;
  border-radius: 8px; transition: color 0.2s, background 0.2s;
}
.mobile-toggle:hover { color: #e2e8f0; background: rgba(255,255,255,0.05); }
@media (max-width: 1023px) { .mobile-toggle { display: block; } }

.navbar-logo-link {
  display: flex; align-items: center; gap: 0.75rem;
  text-decoration: none;
}

.navbar-logo-icon {
  width: 36px; height: 36px;
  background: linear-gradient(135deg, #2dd4bf, #22d3ee);
  border-radius: 12px;
  display: flex; align-items: center; justify-content: center;
  color: #0f172a;
  box-shadow: 0 4px 12px rgba(45, 212, 191, 0.2);
}

.navbar-logo-text { display: none; }
@media (min-width: 640px) { .navbar-logo-text { display: block; } }

.logo-title { font-family: 'Plus Jakarta Sans', sans-serif; font-weight: 700; color: #f1f5f9; line-height: 1.2; }
.logo-subtitle { font-size: 0.65rem; color: #64748b; text-transform: uppercase; letter-spacing: 0.05em; font-weight: 600; }

/* CENTER */
.navbar-center { flex: 1; display: none; justify-content: center; max-width: 480px; margin: 0 2rem; }
@media (min-width: 768px) { .navbar-center { display: flex; } }

.search-wrapper {
  position: relative; width: 100%;
}

.search-icon {
  position: absolute; left: 14px; top: 50%; transform: translateY(-50%);
  color: #64748b; pointer-events: none; transition: color 0.2s;
}

.search-wrapper input {
  width: 100%; padding: 0.5rem 3rem 0.5rem 2.5rem;
  border-radius: 12px;
  background: #1a2332; /* surface-1 */
  border: 1px solid rgba(255, 255, 255, 0.06);
  color: #e2e8f0; font-size: 0.875rem;
  outline: none; transition: all 0.2s;
}

.search-wrapper input:focus {
  border-color: rgba(45, 212, 191, 0.4);
  box-shadow: 0 0 0 1px rgba(45, 212, 191, 0.2);
  background: #1e293b;
}
.search-wrapper:focus-within .search-icon { color: #2dd4bf; }

.search-shortcut {
  position: absolute; right: 12px; top: 50%; transform: translateY(-50%);
  display: none; align-items: center;
  font-size: 0.65rem; color: #64748b;
  background: #273548; border: 1px solid rgba(255,255,255,0.06);
  border-radius: 4px; padding: 2px 5px; font-family: monospace;
}
@media (min-width: 640px) { .search-shortcut { display: flex; } }

/* RIGHT */
.navbar-right { display: flex; align-items: center; gap: 0.5rem; }

.icon-btn {
  padding: 0.6rem; color: #94a3b8; border-radius: 12px;
  transition: all 0.2s; cursor: pointer;
  position: relative;
}
.icon-btn:hover { color: #e2e8f0; background: rgba(255,255,255,0.05); }

.notification-dot {
  position: absolute; top: 8px; right: 8px;
  width: 8px; height: 8px;
  background: #2dd4bf; border-radius: 50%;
  border: 2px solid #0f172a;
}

.navbar-divider {
  width: 1px; height: 32px; background: rgba(255,255,255,0.06);
  margin: 0 0.5rem; display: none;
}
@media (min-width: 640px) { .navbar-divider { display: block; } }

.user-menu-wrapper { position: relative; }

.user-btn {
  display: flex; align-items: center; gap: 0.75rem;
  padding: 0.35rem; border-radius: 12px;
  transition: background 0.2s; cursor: pointer;
}
.user-btn:hover { background: rgba(255,255,255,0.05); }

.user-info { text-align: right; display: none; }
@media (min-width: 640px) { .user-info { display: block; } }

.user-name { font-size: 0.875rem; font-weight: 500; color: #e2e8f0; line-height: 1.2; }
.user-role { font-size: 0.7rem; color: #64748b; }

.user-avatar {
  width: 36px; height: 36px;
  background: linear-gradient(135deg, #14b8a6, #06b6d4);
  border-radius: 10px;
  display: flex; align-items: center; justify-content: center;
  color: white; font-weight: 600; font-size: 0.875rem;
  box-shadow: 0 4px 10px rgba(20, 184, 166, 0.15);
}

/* Dropdown */
.user-dropdown {
  position: absolute; top: 120%; right: 0; width: 220px;
  background: #1e293b; /* surface-2 */
  border: 1px solid rgba(255,255,255,0.08);
  border-radius: 16px;
  box-shadow: 0 10px 40px rgba(0,0,0,0.5);
  overflow: hidden; z-index: 50;
}

.dropdown-header { padding: 0.75rem 1rem; border-bottom: 1px solid rgba(255,255,255,0.06); }
.dropdown-email { font-size: 0.875rem; font-weight: 500; color: #e2e8f0; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; }
.dropdown-role { font-size: 0.75rem; color: #64748b; margin-top: 0.1rem; }

.dropdown-section { padding: 0.35rem; }
.border-top { border-top: 1px solid rgba(255,255,255,0.06); }

.dropdown-item {
  width: 100%; display: flex; align-items: center; gap: 0.75rem;
  padding: 0.65rem 1rem; border-radius: 8px;
  color: #cbd5e1; font-size: 0.875rem; text-align: left;
  transition: all 0.2s;
}
.dropdown-item:hover { background: rgba(255,255,255,0.05); color: white; }

.logout { color: #fb7185; }
.logout:hover { background: rgba(244, 63, 94, 0.05); color: #f43f5e; }

.dropdown-overlay { fixed: inset-0; z-index: 40; }

.dropdown-enter-active, .dropdown-leave-active { transition: all 0.2s ease; }
.dropdown-enter-from, .dropdown-leave-to { opacity: 0; transform: translateY(-10px) scale(0.95); }
</style>
