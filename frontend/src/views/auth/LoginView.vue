<template>
  <div class="auth-page">
    <!-- Left: Hero Panel -->
    <div class="auth-hero">
      <div class="auth-hero-gradient"></div>
      <div class="auth-hero-grid"></div>
      <div class="auth-hero-orb auth-hero-orb-1"></div>
      <div class="auth-hero-orb auth-hero-orb-2"></div>

      <div class="auth-hero-content">
         <!-- Logo (visible on mobile only/top) -->
        <div class="auth-logo-mobile">
          <svg width="32" height="32" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2.5" d="M13 10V3L4 14h7v7l9-11h-7z" /></svg>
          <span>FerreCloud</span>
        </div>

        <div class="auth-hero-wrapper">
          <div class="auth-hero-icon-box">
             <svg width="32" height="32" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11 16l-4-4m0 0l4-4m-4 4h14m-5 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h7a3 3 0 013 3v1" /></svg>
          </div>
          
          <h2 class="auth-hero-title">Bienvenido de vuelta</h2>
          <p class="auth-hero-subtitle">Accede a tu panel de control y gestiona tu ferretería con la máxima eficiencia.</p>

          <!-- Feature List -->
          <div class="auth-features">
            <div class="auth-feature-row">
              <div class="auth-feature-check">
                <svg width="12" height="12" fill="currentColor" viewBox="0 0 20 20"><path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd" /></svg>
              </div>
              <div>
                <strong>Acceso Seguro</strong>
                <span>Tus datos están protegidos con encriptación de grado bancario.</span>
              </div>
            </div>
             <div class="auth-feature-row">
              <div class="auth-feature-check">
                <svg width="12" height="12" fill="currentColor" viewBox="0 0 20 20"><path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd" /></svg>
              </div>
              <div>
                <strong>Dashboard en Tiempo Real</strong>
                <span>Visualiza tus ventas e inventario al instante.</span>
              </div>
            </div>
             <div class="auth-feature-row">
              <div class="auth-feature-check">
                <svg width="12" height="12" fill="currentColor" viewBox="0 0 20 20"><path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd" /></svg>
              </div>
              <div>
                <strong>Soporte Prioritario</strong>
                <span>Estamos aquí para ayudarte a crecer.</span>
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- Floating shapes -->
       <div class="auth-shape auth-shape-1"></div>
       <div class="auth-shape auth-shape-2"></div>
    </div>

    <!-- Right: Form Panel -->
    <div class="auth-form-panel">
      <div class="auth-form-bg"></div>
      
      <div class="auth-form-wrapper">
        <div class="auth-header">
          <h1>Iniciar Sesión</h1>
          <p>¿No tienes cuenta? <router-link to="/auth/register" class="auth-link">Regístrate gratis</router-link></p>
        </div>

        <!-- Error Alert -->
        <Transition enter-active-class="auth-alert-enter-active" enter-from-class="auth-alert-enter-from">
          <div v-if="error" class="auth-alert">
            <svg width="18" height="18" fill="currentColor" viewBox="0 0 20 20"><path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zM8.707 7.293a1 1 0 00-1.414 1.414L8.586 10l-1.293 1.293a1 1 0 101.414 1.414L10 11.414l1.293 1.293a1 1 0 001.414-1.414L11.414 10l1.293-1.293a1 1 0 00-1.414-1.414L10 8.586 8.707 7.293z" clip-rule="evenodd" /></svg>
            <span>{{ error }}</span>
          </div>
        </Transition>

        <form @submit.prevent="handleSubmit" class="auth-form">
          <!-- Email -->
          <div class="auth-field">
            <label for="email">Correo electrónico</label>
            <div class="auth-input-wrap">
              <svg class="auth-input-icon" width="18" height="18" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.8" d="M3 8l7.89 5.26a2 2 0 002.22 0L21 8M5 19h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z" /></svg>
              <input id="email" v-model="formData.email" type="email" autocomplete="email" required placeholder="nombre@empresa.com" />
            </div>
          </div>

          <!-- Password -->
          <div class="auth-field">
            <div class="flex items-center justify-between mb-2">
               <label for="password" class="mb-0">Contraseña</label>
               <router-link to="/auth/forgot-password" class="text-xs font-semibold text-accent-400 hover:text-accent-300 no-underline transition-colors">¿Olvidaste?</router-link>
            </div>
            <div class="auth-input-wrap">
              <svg class="auth-input-icon" width="18" height="18" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.8" d="M12 15v2m-6 4h12a2 2 0 002-2v-6a2 2 0 00-2-2H6a2 2 0 00-2 2v6a2 2 0 002 2zm10-10V7a4 4 0 00-8 0v4h8z" /></svg>
              <input id="password" v-model="formData.password" :type="showPassword ? 'text' : 'password'" autocomplete="current-password" required placeholder="Ingresa tu contraseña" />
              <button type="button" @click="showPassword = !showPassword" class="auth-toggle-pw" tabindex="-1">
                <svg v-if="!showPassword" width="18" height="18" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.8" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" /><path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.8" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z" /></svg>
                <svg v-else width="18" height="18" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.8" d="M13.875 18.825A10.05 10.05 0 0112 19c-4.478 0-8.268-2.943-9.543-7a9.97 9.97 0 011.563-3.029m5.858.908a3 3 0 114.243 4.243M9.878 9.878l4.242 4.242M3 3l18 18" /></svg>
              </button>
            </div>
          </div>

          <!-- Submit -->
          <button type="submit" :disabled="isLoading" class="auth-submit">
            <svg v-if="isLoading" class="auth-spinner" width="20" height="20" fill="none" viewBox="0 0 24 24"><circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle><path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path></svg>
            <span>{{ isLoading ? 'Iniciando sesión...' : 'Iniciar sesión' }}</span>
          </button>
        </form>

        <!-- Divider -->
        <div class="auth-divider">
          <div class="auth-divider-line"></div>
          <span>o continúa con</span>
          <div class="auth-divider-line"></div>
        </div>

        <!-- Social -->
        <div class="auth-social">
          <button type="button" class="auth-social-btn">
            <svg height="18" width="18" viewBox="0 0 24 24"><path fill="#4285F4" d="M22.56 12.25c0-.78-.07-1.53-.2-2.25H12v4.26h5.92c-.26 1.37-1.04 2.53-2.21 3.31v2.77h3.57c2.08-1.92 3.28-4.74 3.28-8.09z"/><path fill="#34A853" d="M12 23c2.97 0 5.46-.98 7.28-2.66l-3.57-2.77c-.98.66-2.23 1.06-3.71 1.06-2.86 0-5.29-1.93-6.16-4.53H2.18v2.84C3.99 20.53 7.7 23 12 23z"/><path fill="#FBBC05" d="M5.84 14.09c-.22-.66-.35-1.36-.35-2.09s.13-1.43.35-2.09V7.07H2.18C1.43 8.55 1 10.22 1 12s.43 3.45 1.18 4.93l2.85-2.22.81-.62z"/><path fill="#EA4335" d="M12 5.38c1.62 0 3.06.56 4.21 1.64l3.15-3.15C17.45 2.09 14.97 1 12 1 7.7 1 3.99 3.47 2.18 7.07l3.66 2.84c.87-2.6 3.3-4.53 6.16-4.53z"/></svg>
            Google
          </button>
          <button type="button" class="auth-social-btn">
            <svg height="18" width="18" fill="currentColor" viewBox="0 0 24 24"><path d="M12 2C6.477 2 2 6.484 2 12.017c0 4.425 2.865 8.18 6.839 9.504.5.092.682-.217.682-.483 0-.237-.008-.868-.013-1.703-2.782.605-3.369-1.343-3.369-1.343-.454-1.158-1.11-1.466-1.11-1.466-.908-.62.069-.608.069-.608 1.003.07 1.531 1.032 1.531 1.032.892 1.53 2.341 1.088 2.91.832.092-.647.35-1.088.636-1.338-2.22-.253-4.555-1.113-4.555-4.951 0-1.093.39-1.988 1.029-2.688-.103-.253-.446-1.272.098-2.65 0 0 .84-.27 2.75 1.026A9.564 9.564 0 0112 6.844c.85.004 1.705.115 2.504.337 1.909-1.296 2.747-1.027 2.747-1.027.546 1.379.202 2.398.1 2.651.64.7 1.028 1.595 1.028 2.688 0 3.848-2.339 4.695-4.566 4.943.359.309.678.92.678 1.855 0 1.338-.012 2.419-.012 2.747 0 .268.18.58.688.482A10.019 10.019 0 0022 12.017C22 6.484 17.522 2 12 2z"/></svg>
            GitHub
          </button>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue'
import { useRouter } from 'vue-router'
import { useAuthStore } from '@/stores/auth'

const router = useRouter()
const authStore = useAuthStore()

const formData = ref({ email: '', password: '' })
const showPassword = ref(false)
const isLoading = ref(false)
const error = ref('')

const handleSubmit = async () => {
  error.value = ''
  isLoading.value = true
  try {
    await authStore.login(formData.value.email, formData.value.password)
    router.push('/dashboard')
  } catch (err: any) {
    console.error('Login error:', err)
    error.value = err.response?.data?.message || 'Correo o contraseña incorrectos'
  } finally {
    isLoading.value = false
  }
}
</script>

<style scoped>
/* ══════════════════════════════════════
   AUTH PAGE — SCOPED CSS (Guaranteed)
   ══════════════════════════════════════ */
.auth-page {
  min-height: 100vh;
  display: flex;
  background: transparent;
  font-family: 'Inter', sans-serif;
  position: relative;
  z-index: 10;
}

/* ── HERO PANEL (Left) ── */
.auth-hero {
  display: none;
  width: 45%;
  position: relative;
  overflow: hidden;
  color: white;
}

@media (min-width: 1024px) { .auth-hero { display: flex; } }

.auth-hero-gradient {
  position: absolute;
  inset: 0;
  background: linear-gradient(135deg, #0f172a 0%, #0d9488 100%);
}

.auth-hero-grid {
  position: absolute;
  inset: 0;
  background-image:
    linear-gradient(rgba(255,255,255,0.03) 1px, transparent 1px),
    linear-gradient(90deg, rgba(255,255,255,0.03) 1px, transparent 1px);
  background-size: 50px 50px;
}

.auth-hero-orb {
  position: absolute;
  border-radius: 50%;
  filter: blur(80px);
}
.auth-hero-orb-1 {
  width: 300px; height: 300px; top: -50px; left: -50px;
  background: rgba(45, 212, 191, 0.15);
}
.auth-hero-orb-2 {
  width: 250px; height: 250px; bottom: 50px; right: -50px;
  background: rgba(139, 92, 246, 0.1);
}

.auth-hero-content {
  position: relative;
  z-index: 10;
  width: 100%;
  display: flex;
  flex-direction: column;
  justify-content: center;
  padding: 4rem;
}

.auth-hero-wrapper { max-width: 480px; }

.auth-hero-icon-box {
  width: 56px; height: 56px;
  background: rgba(255,255,255,0.1);
  border: 1px solid rgba(255,255,255,0.15);
  border-radius: 16px;
  display: flex;
  align-items: center;
  justify-content: center;
  margin-bottom: 2rem;
  backdrop-filter: blur(10px);
}

.auth-hero-title {
  font-family: 'Plus Jakarta Sans', sans-serif;
  font-size: 2.5rem;
  font-weight: 800;
  line-height: 1.2;
  margin-bottom: 1rem;
}

.auth-hero-subtitle {
  font-size: 1.1rem;
  color: rgba(255,255,255,0.7);
  line-height: 1.6;
  margin-bottom: 3rem;
}

.auth-features { display: flex; flex-direction: column; gap: 1.5rem; margin-bottom: 3rem; }

.auth-feature-row { display: flex; gap: 1rem; }
.auth-feature-check {
  width: 24px; height: 24px;
  background: rgba(52, 211, 153, 0.2);
  color: #34d399;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  flex-shrink: 0;
}
.auth-feature-row div:last-child { display: flex; flex-direction: column; }
.auth-feature-row strong { font-weight: 600; display: block; margin-bottom: 0.2rem; }
.auth-feature-row span { font-size: 0.9rem; color: rgba(255,255,255,0.6); }

/* ── FORM PANEL (Right) ── */
.auth-form-panel {
  flex: 1;
  display: flex;
  align-items: center;
  justify-content: center;
  position: relative;
  padding: 2rem;
  overflow-y: auto;
}

.auth-form-bg {
  position: absolute;
  inset: 0;
  background-image: radial-gradient(#1e293b 1px, transparent 1px);
  background-size: 24px 24px;
  opacity: 0.3;
}

.auth-form-wrapper {
  width: 100%;
  max-width: 440px; /* Bit tighter for login */
  position: relative;
  z-index: 5;
}

.auth-header { margin-bottom: 2.5rem; text-align: left; }
.auth-header h1 {
  font-family: 'Plus Jakarta Sans', sans-serif;
  font-size: 2rem;
  font-weight: 800;
  color: white;
  margin-bottom: 0.5rem;
}
.auth-header p { color: #94a3b8; }
.auth-link { color: #2dd4bf; font-weight: 600; text-decoration: none; }
.auth-link:hover { text-decoration: underline; }

.auth-alert {
  background: rgba(244, 63, 94, 0.1);
  border: 1px solid rgba(244, 63, 94, 0.2);
  color: #fb7185;
  padding: 0.75rem 1rem;
  border-radius: 12px;
  display: flex; align-items: center; gap: 0.75rem;
  margin-bottom: 1.5rem;
  font-size: 0.9rem;
}

.auth-form { display: flex; flex-direction: column; gap: 1.5rem; }

.auth-field label {
  display: block;
  font-size: 0.85rem;
  font-weight: 600;
  color: #c1cce0;
  margin-bottom: 0.5rem;
}

.auth-input-wrap { position: relative; }
.auth-input-icon {
  position: absolute; left: 14px; top: 14px;
  color: #64748b;
  pointer-events: none;
  transition: color 0.2s;
}
.auth-input-wrap:focus-within .auth-input-icon { color: #2dd4bf; }

.auth-input-wrap input {
  width: 100%;
  padding: 0.85rem 1rem 0.85rem 2.8rem;
  background: rgba(30, 41, 59, 0.6);
  border: 1px solid rgba(148, 163, 184, 0.1);
  border-radius: 12px;
  color: white;
  font-family: 'Inter', sans-serif;
  font-size: 0.95rem;
  outline: none;
  transition: all 0.2s;
}
.auth-input-wrap input:focus {
  border-color: #2dd4bf;
  box-shadow: 0 0 0 3px rgba(45, 212, 191, 0.15);
  background: rgba(30, 41, 59, 0.9);
}
.auth-input-wrap input::placeholder { color: #475569; }

.auth-toggle-pw {
  position: absolute; right: 12px; top: 12px;
  background: none; border: none; color: #64748b;
  cursor: pointer;
}
.auth-toggle-pw:hover { color: white; }

.auth-submit {
  width: 100%;
  padding: 0.9rem;
  background: linear-gradient(135deg, #14b8a6, #0891b2);
  border: none;
  border-radius: 12px;
  color: white;
  font-weight: 700;
  font-size: 1rem;
  cursor: pointer;
  transition: transform 0.2s, box-shadow 0.2s;
  display: flex; align-items: center; justify-content: center; gap: 0.5rem;
  margin-top: 0.5rem;
}
.auth-submit:hover:not(:disabled) {
  transform: translateY(-2px);
  box-shadow: 0 10px 25px -5px rgba(20, 184, 166, 0.4);
}
.auth-submit:disabled { opacity: 0.6; cursor: not-allowed; }

.auth-spinner { animation: spin 0.8s linear infinite; }
@keyframes spin { to { transform: rotate(360deg); } }

/* Social */
.auth-divider {
  display: flex; align-items: center; gap: 1rem; margin: 2rem 0;
}
.auth-divider-line { flex: 1; height: 1px; background: rgba(255,255,255,0.1); }
.auth-divider span { font-size: 0.8rem; color: #64748b; }

.auth-social { display: grid; grid-template-columns: 1fr 1fr; gap: 1rem; }
.auth-social-btn {
  display: flex; align-items: center; justify-content: center; gap: 0.6rem;
  padding: 0.7rem; border-radius: 12px;
  background: rgba(30, 41, 59, 0.6);
  border: 1px solid rgba(255,255,255,0.08);
  color: #cbd5e1; font-weight: 600; font-size: 0.85rem;
  cursor: pointer; transition: all 0.2s;
}
.auth-social-btn:hover { background: rgba(255,255,255,0.1); border-color: rgba(255,255,255,0.15); color: white; }

/* Mobile Logo */
.auth-logo-mobile {
  display: none;
  align-items: center; gap: 0.5rem; color: #2dd4bf;
  font-weight: 800; font-size: 1.25rem; margin-bottom: 2rem;
}
@media (max-width: 1023px) {
  .auth-logo-mobile { display: flex; justify-content: center; }
}
</style>
