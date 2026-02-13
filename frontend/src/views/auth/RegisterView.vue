<template>
  <div class="auth-page">
    <!-- Left: Hero Panel (Register starts with Hero on left for variety) -->
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
             <svg width="32" height="32" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 10V3L4 14h7v7l9-11h-7z" /></svg>
          </div>
          
          <h2 class="auth-hero-title">Únete a la revolución ferretera</h2>
          <p class="auth-hero-subtitle">Plataforma integral para gestión de inventarios, facturación y clientes diseñada para el futuro.</p>

          <!-- Feature List -->
          <div class="auth-features">
            <div v-for="f in features" :key="f.title" class="auth-feature-row">
              <div class="auth-feature-check">
                <svg width="12" height="12" fill="currentColor" viewBox="0 0 20 20"><path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd" /></svg>
              </div>
              <div>
                <strong>{{ f.title }}</strong>
                <span>{{ f.desc }}</span>
              </div>
            </div>
          </div>

          <!-- Trust -->
          <div class="auth-trust">
            <div class="auth-trust-avatars">
              <div class="auth-trust-avatar"><span>A</span></div>
              <div class="auth-trust-avatar"><span>B</span></div>
              <div class="auth-trust-avatar"><span>C</span></div>
            </div>
            <p>+500 empresas registradas este mes</p>
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
          <h1>Crear cuenta nueva</h1>
          <p>¿Ya tienes cuenta? <router-link to="/auth/login" class="auth-link">Inicia sesión</router-link></p>
        </div>

         <!-- Error Alert -->
        <Transition enter-active-class="auth-alert-enter-active" enter-from-class="auth-alert-enter-from">
          <div v-if="error" class="auth-alert">
            <svg width="18" height="18" fill="currentColor" viewBox="0 0 20 20"><path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zM8.707 7.293a1 1 0 00-1.414 1.414L8.586 10l-1.293 1.293a1 1 0 101.414 1.414L10 11.414l1.293 1.293a1 1 0 001.414-1.414L11.414 10l1.293-1.293a1 1 0 00-1.414-1.414L10 8.586 8.707 7.293z" clip-rule="evenodd" /></svg>
            <span>{{ error }}</span>
          </div>
        </Transition>

        <form @submit.prevent="handleSubmit" class="auth-form">
          <div class="auth-grid">
            <!-- Full Name -->
            <div class="auth-field">
              <label for="full_name">Nombre completo <span class="required">*</span></label>
              <div class="auth-input-wrap">
                <svg class="auth-input-icon" width="18" height="18" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.8" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z" /></svg>
                <input id="full_name" v-model="formData.full_name" type="text" required placeholder="Ej. Juan Pérez" />
              </div>
            </div>

            <!-- Phone -->
            <div class="auth-field">
              <label for="phone">Teléfono</label>
              <div class="auth-input-wrap">
                 <svg class="auth-input-icon" width="18" height="18" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.8" d="M3 5a2 2 0 012-2h3.28a1 1 0 01.948.684l1.498 4.493a1 1 0 01-.502 1.21l-2.257 1.13a11.042 11.042 0 005.516 5.516l1.13-2.257a1 1 0 011.21-.502l4.493 1.498a1 1 0 01.684.949V19a2 2 0 01-2 2h-1C9.716 21 3 14.284 3 6V5z" /></svg>
                <input id="phone" v-model="formData.phone" type="tel" placeholder="+57 300..." />
              </div>
            </div>
          </div>

          <!-- Email -->
          <div class="auth-field">
            <label for="email">Correo electrónico <span class="required">*</span></label>
            <div class="auth-input-wrap">
              <svg class="auth-input-icon" width="18" height="18" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.8" d="M3 8l7.89 5.26a2 2 0 002.22 0L21 8M5 19h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z" /></svg>
              <input id="email" v-model="formData.email" type="email" required placeholder="tu@empresa.com" />
            </div>
          </div>

          <div class="auth-grid">
            <!-- Password -->
            <div class="auth-field">
              <label for="password">Contraseña <span class="required">*</span></label>
              <div class="auth-input-wrap">
                <svg class="auth-input-icon" width="18" height="18" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.8" d="M12 15v2m-6 4h12a2 2 0 002-2v-6a2 2 0 00-2-2H6a2 2 0 00-2 2v6a2 2 0 002 2zm10-10V7a4 4 0 00-8 0v4h8z" /></svg>
                <input id="password" v-model="formData.password" :type="showPassword ? 'text' : 'password'" required placeholder="Min 8 caracteres" @input="calculatePasswordStrength" />
                <button type="button" @click="showPassword = !showPassword" class="auth-toggle-pw" tabindex="-1">
                  <svg v-if="!showPassword" width="18" height="18" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.8" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" /><path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.8" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z" /></svg>
                  <svg v-else width="18" height="18" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.8" d="M13.875 18.825A10.05 10.05 0 0112 19c-4.478 0-8.268-2.943-9.543-7a9.97 9.97 0 011.563-3.029m5.858.908a3 3 0 114.243 4.243M9.878 9.878l4.242 4.242M3 3l18 18" /></svg>
                </button>
              </div>
            </div>

            <!-- Confirm Password -->
            <div class="auth-field">
              <label for="confirm_password">Confirmar <span class="required">*</span></label>
              <div class="auth-input-wrap">
                <svg class="auth-input-icon" width="18" height="18" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.8" d="M9 12l2 2 4-4m5.618-4.016A11.955 11.955 0 0112 2.944a11.955 11.955 0 01-8.618 3.04A12.02 12.02 0 003 9c0 5.591 3.824 10.29 9 11.622 5.176-1.332 9-6.03 9-11.622 0-1.042-.133-2.052-.382-3.016z" /></svg>
                <input id="confirm_password" v-model="formData.confirm_password" type="password" required placeholder="Repite la contraseña" />
              </div>
            </div>
          </div>

          <!-- Password Strength Meter -->
          <div v-if="formData.password" class="auth-strength">
             <div class="auth-strength-header">
               <span>Seguridad:</span>
               <span :class="strengthClass">{{ strengthText }}</span>
             </div>
             <div class="auth-strength-bar">
               <div class="auth-strength-fill" :class="strengthClass" :style="{ width: passwordStrength + '%' }"></div>
             </div>
          </div>

          <!-- Terms -->
           <div class="auth-terms">
             <input type="checkbox" id="terms" v-model="acceptedTerms" required />
             <label for="terms">Acepto los <a href="#">Términos de Servicio</a> y la <a href="#">Política de Privacidad</a>.</label>
           </div>

          <!-- Submit -->
          <button type="submit" :disabled="isLoading || !acceptedTerms" class="auth-submit">
            <svg v-if="isLoading" class="auth-spinner" width="20" height="20" fill="none" viewBox="0 0 24 24"><circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle><path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path></svg>
            <span>Crear cuenta</span>
          </button>
        </form>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue'
import { useRouter } from 'vue-router'
import { useAuthStore } from '@/stores/auth'

const router = useRouter()
const authStore = useAuthStore()

const features = [
  { title: 'Inventario en tiempo real', desc: 'Control total de tu stock desde cualquier lugar.' },
  { title: 'Facturación POS', desc: 'Sistema de punto de venta rápido y eficiente.' },
  { title: 'Reportes avanzados', desc: 'Toma decisiones basadas en datos reales.' },
]

const formData = ref({ email: '', password: '', confirm_password: '', full_name: '', phone: '' })
const showPassword = ref(false)
const passwordStrength = ref(0)
const isLoading = ref(false)
const error = ref('')
const acceptedTerms = ref(false)

const calculatePasswordStrength = () => {
  let s = 0; const p = formData.value.password || ''
  if (p.length >= 6) s += 20
  if (p.length >= 10) s += 20
  if (/[A-Z]/.test(p)) s += 20
  if (/[0-9]/.test(p)) s += 20
  if (/[^A-Za-z0-9]/.test(p)) s += 20
  passwordStrength.value = s
}

const strengthText = computed(() => {
  if (passwordStrength.value  >= 80) return 'Excelente'
  if (passwordStrength.value  >= 60) return 'Fuerte'
  if (passwordStrength.value  >= 40) return 'Media'
  return 'Débil'
})

const strengthClass = computed(() => {
  if (passwordStrength.value  >= 80) return 'strength-success'
  if (passwordStrength.value  >= 60) return 'strength-good'
  if (passwordStrength.value  >= 40) return 'strength-warning'
  return 'strength-danger'
})

const handleSubmit = async () => {
  if (formData.value.password !== formData.value.confirm_password) {
    error.value = 'Las contraseñas no coinciden'
    return
  }
  error.value = ''
  isLoading.value = true
  try {
    const { confirm_password, ...data } = formData.value
    await authStore.register(data)
    router.push('/dashboard')
  } catch (err: any) {
    error.value = err.message || 'Error al registrar usuario'
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
  background: #080e1e;
  font-family: 'Inter', sans-serif;
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

.auth-trust {
  display: flex; align-items: center; gap: 1rem;
  padding-top: 2rem; border-top: 1px solid rgba(255,255,255,0.1);
}
.auth-trust-avatars { display: flex; margin-left: 0.5rem; }
.auth-trust-avatar {
  width: 32px; height: 32px;
  border-radius: 50%;
  background: #cbd5e1;
  border: 2px solid #0f172a;
  margin-left: -0.5rem;
  display: flex; align-items: center; justify-content: center;
  font-size: 0.7rem; font-weight: 700; color: #1e293b;
}
.auth-trust p { font-size: 0.9rem; font-weight: 500; }

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
  max-width: 500px;
  position: relative;
  z-index: 5;
}

.auth-header { margin-bottom: 2rem; text-align: center; }
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

.auth-form { display: flex; flex-direction: column; gap: 1.25rem; }

.auth-grid { display: grid; grid-template-columns: 1fr; gap: 1.25rem; }
@media (min-width: 640px) { .auth-grid { grid-template-columns: 1fr 1fr; } }

.auth-field label {
  display: block;
  font-size: 0.85rem;
  font-weight: 600;
  color: #c1cce0;
  margin-bottom: 0.5rem;
}
.required { color: #2dd4bf; margin-left: 2px; }

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

/* Password Strength */
.auth-strength { background: rgba(0,0,0,0.2); padding: 0.75rem; border-radius: 10px; }
.auth-strength-header { display: flex; justify-content: space-between; font-size: 0.75rem; margin-bottom: 0.4rem; color: #94a3b8; }
.auth-strength-bar { height: 4px; background: #334155; border-radius: 2px; overflow: hidden; }
.auth-strength-fill { height: 100%; transition: width 0.3s ease, background-color 0.3s ease; }
.strength-success { color: #34d399; }
.strength-good { color: #facc15; }
.strength-warning { color: #fb923c; }
.strength-danger { color: #f43f5e; }

.auth-strength-fill.strength-success { background-color: #34d399; }
.auth-strength-fill.strength-good { background-color: #facc15; }
.auth-strength-fill.strength-warning { background-color: #fb923c; }
.auth-strength-fill.strength-danger { background-color: #f43f5e; }

.auth-terms { display: flex; gap: 0.75rem; font-size: 0.85rem; color: #94a3b8; align-items: flex-start; }
.auth-terms input { margin-top: 3px; accent-color: #2dd4bf; }
.auth-terms a { color: #2dd4bf; text-decoration: none; }

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
  margin-top: 1rem;
}
.auth-submit:hover:not(:disabled) {
  transform: translateY(-2px);
  box-shadow: 0 10px 25px -5px rgba(20, 184, 166, 0.4);
}
.auth-submit:disabled { opacity: 0.6; cursor: not-allowed; }

.auth-spinner { animation: spin 0.8s linear infinite; }
@keyframes spin { to { transform: rotate(360deg); } }

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
