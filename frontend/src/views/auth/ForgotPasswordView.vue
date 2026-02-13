<template>
  <div class="forgot-page">
    <div class="forgot-bg"></div>
    <div class="forgot-orb forgot-orb-1"></div>
    <div class="forgot-orb forgot-orb-2"></div>

    <div class="forgot-card-wrapper">
      <div class="forgot-logo">
        <router-link to="/" class="forgot-logo-link">
          <div class="forgot-logo-icon">
            <svg width="24" height="24" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2.5" d="M13 10V3L4 14h7v7l9-11h-7z" /></svg>
          </div>
          <span>FerreCloud</span>
        </router-link>
      </div>

      <div class="forgot-card">
        <div class="forgot-header">
          <div class="forgot-icon-circle">
            <svg width="32" height="32" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 7a2 2 0 012 2m4 0a6 6 0 01-7.743 5.743L11 17H9v2H7v2H4a1 1 0 01-1-1v-2.586a1 1 0 01.293-.707l5.964-5.964A6 6 0 1121 9z" /></svg>
          </div>
          <h1>¿Olvidaste tu contraseña?</h1>
          <p>Ingresa tu correo electrónico y te enviaremos instrucciones para restablecerla.</p>
        </div>

        <Transition enter-active-class="fade-enter-active" enter-from-class="fade-enter-from">
          <div v-if="submitted" class="forgot-success">
            <div class="success-icon">
              <svg width="24" height="24" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="3" d="M5 13l4 4L19 7" /></svg>
            </div>
            <h3>¡Correo enviado!</h3>
            <p>Revisa tu bandeja de entrada y sigue las instrucciones.</p>
            <button @click="submitted = false" class="forgot-btn-secondary">Enviar a otro correo</button>
          </div>

          <form v-else @submit.prevent="handleSubmit" class="forgot-form">
            <div v-if="error" class="forgot-alert">
              <svg width="18" height="18" fill="currentColor" viewBox="0 0 20 20"><path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zM8.707 7.293a1 1 0 00-1.414 1.414L8.586 10l-1.293 1.293a1 1 0 101.414 1.414L10 11.414l1.293 1.293a1 1 0 001.414-1.414L11.414 10l1.293-1.293a1 1 0 00-1.414-1.414L10 8.586 8.707 7.293z" clip-rule="evenodd" /></svg>
              <span>{{ error }}</span>
            </div>

            <div class="forgot-field">
              <label for="email">Correo electrónico</label>
              <div class="forgot-input-wrap">
                <svg class="forgot-input-icon" width="20" height="20" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 8l7.89 5.26a2 2 0 002.22 0L21 8M5 19h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z" /></svg>
                <input id="email" v-model="email" type="email" required placeholder="tu@empresa.com" />
              </div>
            </div>

            <button type="submit" :disabled="isLoading" class="forgot-btn-primary">
              <span v-if="!isLoading">Enviar instrucciones</span>
              <span v-else class="flex-center">
                 <svg class="spinner" width="20" height="20" fill="none" viewBox="0 0 24 24"><circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle><path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path></svg>
                 Enviando...
              </span>
            </button>
          </form>
        </Transition>

        <div class="forgot-footer">
          <router-link to="/auth/login" class="forgot-back-link">
            <svg width="16" height="16" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 19l-7-7m0 0l7-7m-7 7h18" /></svg>
            Volver al inicio de sesión
          </router-link>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue'

const email = ref('')
const isLoading = ref(false)
const submitted = ref(false)
const error = ref('')

const handleSubmit = async () => {
  error.value = ''
  isLoading.value = true
  try {
    // Simulate API call
    await new Promise(resolve => setTimeout(resolve, 1500))
    submitted.value = true
  } catch (err: any) {
    error.value = err.message || 'Error al enviar el correo. Intenta de nuevo.'
  } finally {
    isLoading.value = false
  }
}
</script>

<style scoped>
/* ══════════════════════════════════════
   FORGOT PASSWORD — SCOPED CSS
   ══════════════════════════════════════ */
.forgot-page {
  min-height: 100vh;
  display: flex;
  align-items: center;
  justify-content: center;
  background: #080e1e;
  font-family: 'Inter', sans-serif;
  position: relative;
  overflow: hidden;
  padding: 1rem;
}

.forgot-bg {
  position: absolute; inset: 0;
  background-image: radial-gradient(rgba(255,255,255,0.03) 1px, transparent 1px);
  background-size: 32px 32px;
}

.forgot-orb {
  position: absolute; border-radius: 50%; filter: blur(100px);
}
.forgot-orb-1 {
  width: 400px; height: 400px; top: -100px; left: -100px;
  background: rgba(45, 212, 191, 0.08); /* Teal */
}
.forgot-orb-2 {
  width: 300px; height: 300px; bottom: -50px; right: -50px;
  background: rgba(124, 58, 237, 0.06); /* Violet */
}

.forgot-card-wrapper {
  width: 100%; max-width: 440px;
  position: relative; z-index: 10;
  display: flex; flex-direction: column; align-items: center; gap: 2rem;
}

.forgot-logo-link {
  display: flex; align-items: center; gap: 0.75rem;
  color: white; text-decoration: none;
  font-family: 'Plus Jakarta Sans', sans-serif;
  font-weight: 800; font-size: 1.5rem;
}
.forgot-logo-icon {
  width: 40px; height: 40px;
  background: linear-gradient(135deg, #2dd4bf, #06b6d4);
  border-radius: 12px;
  display: flex; align-items: center; justify-content: center;
  color: #080e1e;
  box-shadow: 0 4px 12px rgba(45, 212, 191, 0.3);
}

.forgot-card {
  width: 100%;
  background: rgba(15, 23, 42, 0.6);
  backdrop-filter: blur(16px);
  border: 1px solid rgba(255, 255, 255, 0.08);
  border-radius: 20px;
  padding: 2.5rem;
  box-shadow: 0 8px 32px rgba(0, 0, 0, 0.4);
}

.forgot-header { text-align: center; margin-bottom: 2rem; }
.forgot-icon-circle {
  width: 64px; height: 64px;
  background: rgba(45, 212, 191, 0.1);
  border: 1px solid rgba(45, 212, 191, 0.2);
  border-radius: 50%;
  border-radius: 20px; /* Squircle */
  display: flex; align-items: center; justify-content: center;
  color: #2dd4bf;
  margin: 0 auto 1.5rem;
  animation: pulse 3s infinite;
}
@keyframes pulse { 0%, 100% { box-shadow: 0 0 0 0 rgba(45, 212, 191, 0); } 50% { box-shadow: 0 0 0 10px rgba(45, 212, 191, 0.1); } }

.forgot-header h1 {
  font-family: 'Plus Jakarta Sans', sans-serif;
  font-size: 1.5rem; font-weight: 700; color: white; margin-bottom: 0.75rem;
}
.forgot-header p {
  font-size: 0.95rem; color: #94a3b8; line-height: 1.5;
}

/* Success State */
.forgot-success { text-align: center; padding: 1rem 0; animation: scaleIn 0.4s ease-out; }
@keyframes scaleIn { from { transform: scale(0.9); opacity: 0; } to { transform: scale(1); opacity: 1; } }

.success-icon {
  width: 56px; height: 56px;
  background: rgba(52, 211, 153, 0.2);
  color: #34d399;
  border-radius: 50%;
  display: flex; align-items: center; justify-content: center;
  margin: 0 auto 1rem;
}
.forgot-success h3 { color: white; font-size: 1.25rem; font-weight: 700; margin-bottom: 0.5rem; }
.forgot-success p { color: #94a3b8; margin-bottom: 1.5rem; }

.forgot-btn-secondary {
  background: transparent; border: 1px solid rgba(45, 212, 191, 0.3);
  color: #2dd4bf; padding: 0.6rem 1.2rem; border-radius: 10px;
  font-weight: 600; cursor: pointer; transition: all 0.2s;
}
.forgot-btn-secondary:hover { background: rgba(45, 212, 191, 0.1); }

/* Form */
.forgot-form { display: flex; flex-direction: column; gap: 1.5rem; }

.forgot-alert {
  background: rgba(244, 63, 94, 0.1); border: 1px solid rgba(244, 63, 94, 0.2);
  color: #fb7185; padding: 0.75rem; border-radius: 10px;
  display: flex; align-items: center; gap: 0.75rem; font-size: 0.9rem;
}

.forgot-field label {
  display: block; font-size: 0.85rem; font-weight: 600; color: #cbd5e1; margin-bottom: 0.5rem;
}

.forgot-input-wrap { position: relative; }
.forgot-input-icon {
  position: absolute; left: 14px; top: 12px; color: #64748b; transition: color 0.2s;
}
.forgot-input-wrap:focus-within .forgot-input-icon { color: #2dd4bf; }

.forgot-input-wrap input {
  width: 100%; padding: 0.8rem 1rem 0.8rem 2.8rem;
  background: rgba(15, 23, 42, 0.8);
  border: 1px solid rgba(148, 163, 184, 0.1);
  border-radius: 12px;
  color: white; font-family: 'Inter', sans-serif; font-size: 1rem;
  outline: none; transition: all 0.2s;
}
.forgot-input-wrap input:focus {
  border-color: #2dd4bf;
  box-shadow: 0 0 0 3px rgba(45, 212, 191, 0.15);
}
.forgot-input-wrap input::placeholder { color: #475569; }

.forgot-btn-primary {
  width: 100%; padding: 0.9rem;
  background: linear-gradient(135deg, #14b8a6, #0891b2);
  border: none; border-radius: 12px;
  color: white; font-weight: 700; font-size: 1rem;
  cursor: pointer; transition: all 0.2s;
  box-shadow: 0 4px 15px rgba(20, 184, 166, 0.3);
}
.forgot-btn-primary:hover:not(:disabled) {
  transform: translateY(-2px);
  box-shadow: 0 8px 20px rgba(20, 184, 166, 0.4);
}
.forgot-btn-primary:disabled { opacity: 0.6; cursor: not-allowed; }

.forgot-footer { text-align: center; margin-top: 1rem; }
.forgot-back-link {
  display: inline-flex; align-items: center; gap: 0.5rem;
  color: #64748b; text-decoration: none; font-size: 0.9rem; font-weight: 500;
  transition: color 0.2s;
}
.forgot-back-link:hover { color: white; }

.flex-center { display: flex; align-items: center; justify-content: center; gap: 0.5rem; }
.spinner { animation: spin 0.8s linear infinite; }
@keyframes spin { to { transform: rotate(360deg); } }
</style>
