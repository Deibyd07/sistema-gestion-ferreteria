/**
 * Servicio de autenticación - Comunicación con API Backend
 */

import apiClient from "./api-client";

export interface RegisterData {
  email: string;
  password: string;
  confirm_password: string;
  full_name?: string;
  phone?: string;
}

export interface LoginData {
  email: string;
  password: string;
}

export interface User {
  id: string;
  email: string;
  full_name?: string;
  phone?: string;
  email_confirmed: boolean;
  created_at: string;
  metadata?: Record<string, any>;
}

export interface AuthResponse {
  user: User;
  session: {
    access_token: string;
    refresh_token: string;
    token_type: string;
    expires_in?: number;
  };
  message: string;
}

class AuthService {
  /**
   * Registrar nuevo usuario
   */
  async register(data: RegisterData): Promise<AuthResponse> {
    const response = await apiClient.post<AuthResponse>("/auth/register", data);
    return response.data;
  }

  /**
   * Iniciar sesión
   */
  async login(data: LoginData): Promise<AuthResponse> {
    const response = await apiClient.post<AuthResponse>("/auth/login", data);
    return response.data;
  }

  /**
   * Cerrar sesión
   */
  async logout(accessToken: string): Promise<void> {
    await apiClient.post(
      "/auth/logout",
      {},
      {
        headers: {
          Authorization: `Bearer ${accessToken}`,
        },
      },
    );
  }

  /**
   * Obtener usuario actual
   */
  async getCurrentUser(accessToken: string): Promise<User> {
    const response = await apiClient.get<User>("/auth/me", {
      headers: {
        Authorization: `Bearer ${accessToken}`,
      },
    });
    return response.data;
  }

  /**
   * Refrescar token
   */
  async refreshToken(
    refreshToken: string,
  ): Promise<{ access_token: string; refresh_token: string; expires_in?: number }> {
    const response = await apiClient.post("/auth/refresh-token", {
      refresh_token: refreshToken,
    });
    return response.data;
  }

  /**
   * Solicitar recuperación de contraseña
   */
  async forgotPassword(email: string): Promise<{ message: string }> {
    const response = await apiClient.post("/auth/forgot-password", { email });
    return response.data;
  }

  /**
   * Resetear contraseña
   */
  async resetPassword(
    token: string,
    newPassword: string,
    confirmPassword: string,
  ): Promise<{ message: string }> {
    const response = await apiClient.post("/auth/reset-password", {
      token,
      new_password: newPassword,
      confirm_password: confirmPassword,
    });
    return response.data;
  }
}

export const authService = new AuthService();
