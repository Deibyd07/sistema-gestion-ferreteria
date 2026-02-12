'use client';

/**
 * Context de Autenticación - Manejo global del estado de autenticación
 */

import React, { createContext, useContext, useState, useEffect, useCallback } from 'react';
import { authService, type User, type AuthResponse } from '@/services/auth.service';

interface AuthContextType {
  user: User | null;
  accessToken: string | null;
  isLoading: boolean;
  isAuthenticated: boolean;
  login: (email: string, password: string) => Promise<void>;
  register: (data: {
    email: string;
    password: string;
    confirm_password: string;
    full_name?: string;
    phone?: string;
  }) => Promise<void>;
  logout: () => Promise<void>;
  refreshSession: () => Promise<void>;
}

const AuthContext = createContext<AuthContextType | undefined>(undefined);

export function AuthProvider({ children }: { children: React.ReactNode }) {
  const [user, setUser] = useState<User | null>(null);
  const [accessToken, setAccessToken] = useState<string | null>(null);
  const [isLoading, setIsLoading] = useState(true);

  // Inicializar sesión desde localStorage
  useEffect(() => {
    const initializeAuth = async () => {
      try {
        const storedToken = localStorage.getItem('access_token');
        const storedUser = localStorage.getItem('user');

        if (storedToken && storedUser) {
          // Validar token con el servidor
          try {
            const currentUser = await authService.getCurrentUser(storedToken);
            setUser(currentUser);
            setAccessToken(storedToken);
          } catch (error) {
            // Token inválido, limpiar localStorage
            localStorage.removeItem('access_token');
            localStorage.removeItem('refresh_token');
            localStorage.removeItem('user');
          }
        }
      }catch (error) {
        console.error('Error al inicializar autenticación:', error);
      } finally {
        setIsLoading(false);
      }
    };

    initializeAuth();
  }, []);

  // Login
  const login = useCallback(async (email: string, password: string) => {
    setIsLoading(true);
    try {
      const response: AuthResponse = await authService.login({ email, password });
      
      // Guardar en estado
      setUser(response.user);
      setAccessToken(response.session.access_token);

      // Guardar en localStorage
      localStorage.setItem('access_token', response.session.access_token);
      localStorage.setItem('refresh_token', response.session.refresh_token);
      localStorage.setItem('user', JSON.stringify(response.user));
    } catch (error) {
      console.error('Error al iniciar sesión:', error);
      throw error;
    } finally {
      setIsLoading(false);
    }
  }, []);

  // Register
  const register = useCallback(async (data: {
    email: string;
    password: string;
    confirm_password: string;
    full_name?: string;
    phone?: string;
  }) => {
    setIsLoading(true);
    try {
      const response: AuthResponse = await authService.register(data);
      
      // Guardar en estado
      setUser(response.user);
      setAccessToken(response.session.access_token);

      // Guardar en localStorage
      localStorage.setItem('access_token', response.session.access_token);
      localStorage.setItem('refresh_token', response.session.refresh_token);
      localStorage.setItem('user', JSON.stringify(response.user));
    } catch (error) {
      console.error('Error al registrar:', error);
      throw error;
    } finally {
      setIsLoading(false);
    }
  }, []);

  // Logout
  const logout = useCallback(async () => {
    try {
      if (accessToken) {
        await authService.logout(accessToken);
      }
    } catch (error) {
      console.error('Error al cerrar sesión:', error);
    } finally {
      // Limpiar estado y localStorage
      setUser(null);
      setAccessToken(null);
      localStorage.removeItem('access_token');
      localStorage.removeItem('refresh_token');
      localStorage.removeItem('user');
    }
  }, [accessToken]);

  // Refrescar sesión
  const refreshSession = useCallback(async () => {
    try {
      const refreshToken = localStorage.getItem('refresh_token');
      if (!refreshToken) throw new Error('No refresh token');

      const response = await authService.refreshToken(refreshToken);
      
      setAccessToken(response.access_token);
      localStorage.setItem('access_token', response.access_token);
      localStorage.setItem('refresh_token', response.refresh_token);
    } catch (error) {
      console.error('Error al refrescar sesión:', error);
      await logout();
    }
  }, [logout]);

  const value = {
    user,
    accessToken,
    isLoading,
    isAuthenticated: !!user && !!accessToken,
    login,
    register,
    logout,
    refreshSession,
  };

  return <AuthContext.Provider value={value}>{children}</AuthContext.Provider>;
}

export function useAuth() {
  const context = useContext(AuthContext);
  if (context === undefined) {
    throw new Error('useAuth must be used within an AuthProvider');
  }
  return context;
}
