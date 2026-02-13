"""
Endpoints de autenticación
"""
from fastapi import APIRouter, HTTPException, status, Header
from typing import Optional

from app.schemas.auth import (
    UserRegister,
    UserLogin,
    Token,
    TokenRefresh,
    PasswordResetRequest,
    PasswordReset,
    UserResponse,
    AuthResponse,
    MessageResponse,
)
from app.core.supabase_auth import SupabaseAuth

router = APIRouter(prefix="/auth", tags=["Autenticación"])


@router.post(
    "/register",
    response_model=AuthResponse,
    status_code=status.HTTP_201_CREATED,
    summary="Registrar nuevo usuario",
    description="Crea una nueva cuenta de usuario en el sistema"
)
async def register(user_data: UserRegister):
    """
    Registra un nuevo usuario en el sistema.
    
    - **email**: Email único del usuario (será validado)
    - **password**: Contraseña (mínimo 8 caracteres, debe incluir mayúsculas, minúsculas y números)
    - **confirm_password**: Confirmación de la contraseña
    - **full_name**: Nombre completo del usuario (opcional)
    - **phone**: Teléfono del usuario (opcional)
    
    Retorna la información del usuario creado y tokens de sesión.
    """
    try:
        # Registrar usuario en Supabase Auth
        metadata = {
            "full_name": user_data.full_name,
            "phone": user_data.phone
        }
        
        response = await SupabaseAuth.sign_up(
            email=user_data.email,
            password=user_data.password,
            metadata=metadata
        )
        
        # Formatear respuesta
        # Convertir created_at a string si es un datetime
        created_at_str = None
        if hasattr(response["user"], 'created_at') and response["user"].created_at:
            if isinstance(response["user"].created_at, str):
                created_at_str = response["user"].created_at
            else:
                created_at_str = response["user"].created_at.isoformat()
        
        user_info = UserResponse(
            id=response["user"].id,
            email=response["user"].email,
            full_name=response["user"].user_metadata.get("full_name"),
            phone=response["user"].user_metadata.get("phone"),
            email_confirmed=response["user"].email_confirmed_at is not None,
            created_at=created_at_str,
            metadata=response["user"].user_metadata
        )
        
        # Manejar el caso cuando no hay sesión inmediata (confirmación de email requerida)
        if response.get("session") is None:
            # Si no hay sesión, generar tokens temporales para login posterior
            session_token = Token(
                access_token="",
                refresh_token="",
                token_type="bearer",
                expires_in=None
            )
            message = "Usuario registrado exitosamente. Revisa tu email para confirmar tu cuenta y luego inicia sesión."
        else:
            session_token = Token(
                access_token=response["session"].access_token,
                refresh_token=response["session"].refresh_token,
                token_type="bearer",
                expires_in=response["session"].expires_in if hasattr(response["session"], 'expires_in') else None
            )
            message = "Usuario registrado exitosamente e iniciado sesión."
        
        return AuthResponse(
            user=user_info,
            session=session_token,
            message=message
        )
    
    except HTTPException:
        raise
    except Exception as e:
        import traceback
        import logging
        logger = logging.getLogger(__name__)
        logger.error(f"Error al registrar usuario: {str(e)}", exc_info=True)
        traceback.print_exc()
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail=f"Error al registrar usuario: {str(e)}"
        )


@router.post(
    "/login",
    response_model=AuthResponse,
    status_code=status.HTTP_200_OK,
    summary="Iniciar sesión",
    description="Autentica un usuario existente y obtiene tokens de acceso"
)
async def login(credentials: UserLogin):
    """
    Inicia sesión con email y contraseña.
    
    - **email**: Email del usuario registrado
    - **password**: Contraseña del usuario
    
    Retorna la información del usuario y tokens de sesión (access_token y refresh_token).
    """
    try:
        import logging
        logger = logging.getLogger(__name__)
        logger.info(f"Intentando login con email: {credentials.email}")
        
        # Autenticar con Supabase
        response = await SupabaseAuth.sign_in(
            email=credentials.email,
            password=credentials.password
        )
        
        logger.info(f"Login exitoso para: {credentials.email}")
        
        # Formatear respuesta
        # Convertir created_at a string si es un datetime
        created_at_str = None
        if hasattr(response["user"], 'created_at') and response["user"].created_at:
            if isinstance(response["user"].created_at, str):
                created_at_str = response["user"].created_at
            else:
                created_at_str = response["user"].created_at.isoformat()
        
        user_info = UserResponse(
            id=response["user"].id,
            email=response["user"].email,
            full_name=response["user"].user_metadata.get("full_name") if response["user"].user_metadata else None,
            phone=response["user"].user_metadata.get("phone") if response["user"].user_metadata else None,
            email_confirmed=response["user"].email_confirmed_at is not None,
            created_at=created_at_str,
            metadata=response["user"].user_metadata if response["user"].user_metadata else {}
        )
        
        # Manejar caso donde session puede ser None
        expires_in = None
        if response.get("session") and hasattr(response["session"], 'expires_in'):
            expires_in = response["session"].expires_in
        
        session_token = Token(
            access_token=response.get("access_token", ""),
            refresh_token=response.get("refresh_token", ""),
            token_type="bearer",
            expires_in=expires_in
        )
        
        return AuthResponse(
            user=user_info,
            session=session_token,
            message="Inicio de sesión exitoso"
        )
    
    except HTTPException:
        raise
    except Exception as e:
        import logging
        import traceback
        logger = logging.getLogger(__name__)
        logger.error(f"Error al iniciar sesión: {str(e)}", exc_info=True)
        traceback.print_exc()
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail=f"Error al iniciar sesión: {str(e)}"
        )


@router.post(
    "/logout",
    response_model=MessageResponse,
    status_code=status.HTTP_200_OK,
    summary="Cerrar sesión",
    description="Cierra la sesión del usuario actual invalidando el token"
)
async def logout(authorization: Optional[str] = Header(None)):
    """
    Cierra la sesión del usuario actual.
    
    Requiere el token de acceso en el header Authorization.
    """
    try:
        if not authorization or not authorization.startswith("Bearer "):
            raise HTTPException(
                status_code=status.HTTP_401_UNAUTHORIZED,
                detail="Token de autorización no proporcionado"
            )
        
        # Extraer token
        access_token = authorization.replace("Bearer ", "")
        
        # Cerrar sesión con Supabase
        await SupabaseAuth.sign_out(access_token)
        
        return MessageResponse(
            message="Sesión cerrada exitosamente",
            success=True
        )
    
    except HTTPException:
        raise
    except Exception as e:
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail=f"Error al cerrar sesión: {str(e)}"
        )


@router.post(
    "/refresh-token",
    response_model=Token,
    status_code=status.HTTP_200_OK,
    summary="Refrescar token de acceso",
    description="Obtiene un nuevo access_token usando el refresh_token"
)
async def refresh_token(token_data: TokenRefresh):
    """
    Refresca el access_token usando el refresh_token.
    
    - **refresh_token**: Token de refresh obtenido en login o registro
    
    Retorna un nuevo access_token y refresh_token.
    """
    try:
        # Refrescar token con Supabase
        response = await SupabaseAuth.refresh_token(token_data.refresh_token)
        
        return Token(
            access_token=response["access_token"],
            refresh_token=response["refresh_token"],
            token_type="bearer",
            expires_in=response["session"].expires_in if response["session"] else None
        )
    
    except HTTPException:
        raise
    except Exception as e:
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail=f"Error al refrescar token: {str(e)}"
        )


@router.post(
    "/forgot-password",
    response_model=MessageResponse,
    status_code=status.HTTP_200_OK,
    summary="Solicitar recuperación de contraseña",
    description="Envía un email con enlace para resetear la contraseña"
)
async def forgot_password(request: PasswordResetRequest):
    """
    Solicita recuperación de contraseña.
    
    - **email**: Email del usuario que olvidó su contraseña
    
    Envía un email con un enlace para resetear la contraseña.
    Por seguridad, siempre retorna éxito aunque el email no exista.
    """
    try:
        # Enviar email de recuperación con Supabase
        await SupabaseAuth.reset_password_email(request.email)
        
        return MessageResponse(
            message="Si el email existe en nuestro sistema, recibirás un enlace para resetear tu contraseña",
            success=True
        )
    
    except Exception as e:
        # Por seguridad, siempre retornamos éxito
        return MessageResponse(
            message="Si el email existe en nuestro sistema, recibirás un enlace para resetear tu contraseña",
            success=True
        )


@router.post(
    "/reset-password",
    response_model=MessageResponse,
    status_code=status.HTTP_200_OK,
    summary="Resetear contraseña",
    description="Establece una nueva contraseña usando el token de recuperación"
)
async def reset_password(reset_data: PasswordReset):
    """
    Resetea la contraseña del usuario.
    
    - **token**: Token de recuperación recibido por email
    - **new_password**: Nueva contraseña (mínimo 8 caracteres)
    - **confirm_password**: Confirmación de la nueva contraseña
    
    Establece una nueva contraseña para el usuario.
    """
    try:
        # Actualizar contraseña con Supabase
        await SupabaseAuth.update_user(
            access_token=reset_data.token,
            data={"password": reset_data.new_password}
        )
        
        return MessageResponse(
            message="Contraseña actualizada exitosamente",
            success=True
        )
    
    except HTTPException:
        raise
    except Exception as e:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail=f"Error al resetear contraseña: {str(e)}"
        )


@router.get(
    "/me",
    response_model=UserResponse,
    status_code=status.HTTP_200_OK,
    summary="Obtener usuario actual",
    description="Obtiene la información del usuario autenticado actualmente"
)
async def get_current_user(authorization: Optional[str] = Header(None)):
    """
    Obtiene la información del usuario actual.
    
    Requiere el token de acceso en el header Authorization.
    """
    try:
        if not authorization or not authorization.startswith("Bearer "):
            raise HTTPException(
                status_code=status.HTTP_401_UNAUTHORIZED,
                detail="Token de autorización no proporcionado"
            )
        
        # Extraer token
        access_token = authorization.replace("Bearer ", "")
        
        # Obtener usuario con Supabase
        user = await SupabaseAuth.get_user_from_token(access_token)
        
        # Convertir created_at a string si es un datetime
        created_at_str = None
        if hasattr(user, 'created_at') and user.created_at:
            if isinstance(user.created_at, str):
                created_at_str = user.created_at
            else:
                created_at_str = user.created_at.isoformat()
        
        return UserResponse(
            id=user.id,
            email=user.email,
            full_name=user.user_metadata.get("full_name") if user.user_metadata else None,
            phone=user.user_metadata.get("phone") if user.user_metadata else None,
            email_confirmed=user.email_confirmed_at is not None,
            created_at=created_at_str,
            metadata=user.user_metadata if user.user_metadata else {}
        )
    
    except HTTPException:
        raise
    except Exception as e:
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail=f"Error al obtener usuario: {str(e)}"
        )
