/**
 * Store de Autenticación con Pinia
 * Manejo global del estado de autenticación
 */

import { defineStore } from 'pinia'
import { ref, computed } from 'vue'
import { authService, type User, type AuthResponse, type RegisterData } from '@/services/auth.service'
import { useRouter } from 'vue-router'

export const useAuthStore = defineStore('auth', () => {
  // State
  const user = ref<User | null>(null)
  const accessToken = ref<string | null>(null)
  const isLoading = ref(true)

  // Getters
  const isAuthenticated = computed(() => !!user.value && !!accessToken.value)

  // Actions
  /**
   * Inicializar autenticación desde localStorage
   */
  const initializeAuth = async () => {
    try {
      const storedToken = localStorage.getItem('access_token')
      const storedUser = localStorage.getItem('user')

      if (storedToken && storedUser) {
        // Validar token con el servidor
        try {
          const currentUser = await authService.getCurrentUser(storedToken)
          user.value = currentUser
          accessToken.value = storedToken
        } catch (error) {
          // Token inválido, limpiar localStorage
          localStorage.removeItem('access_token')
          localStorage.removeItem('refresh_token')
          localStorage.removeItem('user')
        }
      }
    } catch (error) {
      console.error('Error al inicializar autenticación:', error)
    } finally {
      isLoading.value = false
    }
  }

  /**
   * Login
   */
  const login = async (email: string, password: string) => {
    isLoading.value = true
    try {
      const response: AuthResponse = await authService.login({ email, password })

      // Guardar en estado
      user.value = response.user
      accessToken.value = response.session.access_token

      // Guardar en localStorage
      localStorage.setItem('access_token', response.session.access_token)
      localStorage.setItem('refresh_token', response.session.refresh_token)
      localStorage.setItem('user', JSON.stringify(response.user))
    } catch (error) {
      console.error('Error al iniciar sesión:', error)
      throw error
    } finally {
      isLoading.value = false
    }
  }

  /**
   * Register
   */
  const register = async (data: RegisterData) => {
    isLoading.value = true
    try {
      const response: AuthResponse = await authService.register(data)

      // Guardar en estado
      user.value = response.user
      accessToken.value = response.session.access_token

      // Guardar en localStorage
      localStorage.setItem('access_token', response.session.access_token)
      localStorage.setItem('refresh_token', response.session.refresh_token)
      localStorage.setItem('user', JSON.stringify(response.user))
    } catch (error) {
      console.error('Error al registrar:', error)
      throw error
    } finally {
      isLoading.value = false
    }
  }

  /**
   * Logout
   */
  const logout = async () => {
    try {
      if (accessToken.value) {
        await authService.logout(accessToken.value)
      }
    } catch (error) {
      console.error('Error al cerrar sesión:', error)
    } finally {
      // Limpiar estado y localStorage
      user.value = null
      accessToken.value = null
      localStorage.removeItem('access_token')
      localStorage.removeItem('refresh_token')
      localStorage.removeItem('user')
    }
  }

  /**
   * Refrescar sesión
   */
  const refreshSession = async () => {
    try {
      const refreshToken = localStorage.getItem('refresh_token')
      if (!refreshToken) throw new Error('No refresh token')

      const response = await authService.refreshToken(refreshToken)

      accessToken.value = response.access_token
      localStorage.setItem('access_token', response.access_token)
      localStorage.setItem('refresh_token', response.refresh_token)
    } catch (error) {
      console.error('Error al refrescar sesión:', error)
      await logout()
    }
  }

  return {
    // State
    user,
    accessToken,
    isLoading,
    // Getters
    isAuthenticated,
    // Actions
    initializeAuth,
    login,
    register,
    logout,
    refreshSession,
  }
})
