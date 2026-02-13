"""
Utilidades para autenticación con Supabase Auth
"""
from typing import Optional, Dict, Any
from fastapi import HTTPException, status
from gotrue.errors import AuthApiError
from app.core.supabase_client import supabase_client, supabase_admin_client
from app.core.config import settings


class SupabaseAuth:
    """Clase para manejar autenticación con Supabase"""
    
    @staticmethod
    async def sign_up(email: str, password: str, metadata: Optional[Dict[str, Any]] = None):
        """
        Registra un nuevo usuario en Supabase Auth.
        El trigger de Supabase crea automáticamente el registro en la tabla usuarios.
        
        Args:
            email: Email del usuario
            password: Contraseña (mínimo 8 caracteres recomendado)
            metadata: Metadata adicional del usuario (nombre, rol, etc.)
                     Puede incluir: full_name, phone, etc.
        
        Returns:
            Dict con información del usuario y sesión
        
        Raises:
            HTTPException: Si hay error en el registro
        """
        try:
            import logging
            logger = logging.getLogger(__name__)
            
            client = supabase_client()
            
            # Validar contraseña
            if len(password) < settings.SUPABASE_AUTH_PASSWORD_MIN_LENGTH:
                raise HTTPException(
                    status_code=status.HTTP_400_BAD_REQUEST,
                    detail=f"La contraseña debe tener al menos {settings.SUPABASE_AUTH_PASSWORD_MIN_LENGTH} caracteres"
                )
            
            logger.info(f"Registrando usuario: {email}")
            
            # Registrar usuario en Supabase Auth
            # El trigger de Supabase (handle_new_user) creará automáticamente el registro en usuarios
            response = client.auth.sign_up({
                "email": email,
                "password": password,
                "options": {
                    "data": metadata or {}
                }
            })
            
            logger.info(f"Usuario {email} registrado exitosamente en Auth")
            
            return {
                "user": response.user,
                "session": response.session
            }
            
        except AuthApiError as e:
            import logging
            logger = logging.getLogger(__name__)
            logger.error(f"Error de API Supabase: {str(e)}", exc_info=True)
            raise HTTPException(
                status_code=status.HTTP_400_BAD_REQUEST,
                detail=f"Error al registrar usuario: {str(e)}"
            )
        except HTTPException:
            raise
        except Exception as e:
            import logging
            import traceback
            logger = logging.getLogger(__name__)
            logger.error(f"Error inesperado: {str(e)}", exc_info=True)
            traceback.print_exc()
            raise HTTPException(
                status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
                detail=f"Error interno: {str(e)}"
            )
    
    @staticmethod
    async def sign_in(email: str, password: str):
        """
        Inicia sesión con email y contraseña.
        
        Args:
            email: Email del usuario
            password: Contraseña
        
        Returns:
            Dict con información del usuario y sesión (incluye access_token)
        
        Raises:
            HTTPException: Si las credenciales son inválidas
        """
        try:
            import logging
            logger = logging.getLogger(__name__)
            
            client = supabase_client()
            
            logger.info(f"Iniciando sign_in para: {email}")
            
            response = client.auth.sign_in_with_password({
                "email": email,
                "password": password
            })
            
            logger.info(f"Sign_in exitoso para: {email}")
            
            # Asegurarse de que session existe
            if not response.session:
                logger.warning(f"No hay sesión para: {email}")
                raise HTTPException(
                    status_code=status.HTTP_401_UNAUTHORIZED,
                    detail="No se pudo obtener la sesión. Asegúrate de confirmar tu email."
                )
            
            return {
                "user": response.user,
                "session": response.session,
                "access_token": response.session.access_token,
                "refresh_token": response.session.refresh_token
            }
            
        except AuthApiError as e:
            import logging
            logger = logging.getLogger(__name__)
            logger.error(f"Error de autenticación: {str(e)}", exc_info=True)
            raise HTTPException(
                status_code=status.HTTP_401_UNAUTHORIZED,
                detail="Email o contraseña incorrectos"
            )
        except HTTPException:
            raise
        except Exception as e:
            import logging
            import traceback
            logger = logging.getLogger(__name__)
            logger.error(f"Error inesperado en sign_in: {str(e)}", exc_info=True)
            traceback.print_exc()
            raise HTTPException(
                status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
                detail=f"Error interno: {str(e)}"
            )
    
    @staticmethod
    async def sign_out(access_token: str):
        """
        Cierra la sesión del usuario.
        
        Args:
            access_token: Token de acceso del usuario
        """
        try:
            client = supabase_client()
            client.auth.sign_out()
            
        except Exception as e:
            raise HTTPException(
                status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
                detail=f"Error al cerrar sesión: {str(e)}"
            )
    
    @staticmethod
    async def refresh_token(refresh_token: str):
        """
        Refresca el access token usando el refresh token.
        
        Args:
            refresh_token: Token de refresh
        
        Returns:
            Dict con nueva sesión y tokens
        """
        try:
            client = supabase_client()
            
            response = client.auth.refresh_session(refresh_token)
            
            return {
                "user": response.user,
                "session": response.session,
                "access_token": response.session.access_token,
                "refresh_token": response.session.refresh_token
            }
            
        except AuthApiError as e:
            raise HTTPException(
                status_code=status.HTTP_401_UNAUTHORIZED,
                detail="Token de refresh inválido"
            )
    
    @staticmethod
    async def get_user_from_token(access_token: str):
        """
        Obtiene la información del usuario desde el access token.
        
        Args:
            access_token: Token de acceso
        
        Returns:
            Dict con información del usuario
        """
        try:
            client = supabase_client()
            
            response = client.auth.get_user(access_token)
            return response.user
            
        except AuthApiError as e:
            raise HTTPException(
                status_code=status.HTTP_401_UNAUTHORIZED,
                detail="Token inválido o expirado"
            )
    
    @staticmethod
    async def reset_password_email(email: str):
        """
        Envía email para recuperación de contraseña.
        
        Args:
            email: Email del usuario
        """
        try:
            client = supabase_client()
            
            client.auth.reset_password_email(
                email,
                options={
                    "redirect_to": settings.SUPABASE_AUTH_REDIRECT_URL
                }
            )
            
        except Exception as e:
            # No revelamos si el email existe o no por seguridad
            pass
    
    @staticmethod
    async def update_user(access_token: str, data: Dict[str, Any]):
        """
        Actualiza la información del usuario.
        
        Args:
            access_token: Token de acceso
            data: Datos a actualizar (email, password, metadata, etc.)
        """
        try:
            client = supabase_client()
            
            response = client.auth.update_user(
                access_token,
                data
            )
            
            return response.user
            
        except AuthApiError as e:
            raise HTTPException(
                status_code=status.HTTP_400_BAD_REQUEST,
                detail=f"Error al actualizar usuario: {str(e)}"
            )
    
    @staticmethod
    async def delete_user_admin(user_id: str):
        """
        Elimina un usuario (requiere privilegios de admin).
        
        Args:
            user_id: ID del usuario a eliminar
        """
        try:
            client = supabase_admin_client()
            
            client.auth.admin.delete_user(user_id)
            
        except Exception as e:
            raise HTTPException(
                status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
                detail=f"Error al eliminar usuario: {str(e)}"
            )
