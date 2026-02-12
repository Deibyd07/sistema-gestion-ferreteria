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
        # Preparar metadata del usuario
        metadata = {}
        if user_data.full_name:
            metadata["full_name"] = user_data.full_name
        if user_data.phone:
            metadata["phone"] = user_data.phone
        
        # Registrar usuario con Supabase
        response = await SupabaseAuth.sign_up(
            email=user_data.email,
            password=user_data.password,
            metadata=metadata
        )
        
        # Formatear respuesta
        user_info = UserResponse(
            id=response["user"].id,
            email=response["user"].email,
            full_name=metadata.get("full_name"),
            phone=metadata.get("phone"),
            email_confirmed=response["user"].email_confirmed_at is not None,
            created_at=response["user"].created_at,
            metadata=response["user"].user_metadata
        )
        
        session_token = None
        if response["session"]:
            session_token = Token(
                access_token=response["session"].access_token,
                refresh_token=response["session"].refresh_token,
                token_type="bearer",
                expires_in=response["session"].expires_in
            )
        
        return AuthResponse(
            user=user_info,
            session=session_token,
            message="Usuario registrado exitosamente. Revisa tu email para confirmar tu cuenta."
        )
    
    except HTTPException:
        raise
    except Exception as e:
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
        # Autenticar con Supabase
        response = await SupabaseAuth.sign_in(
            email=credentials.email,
            password=credentials.password
        )
        
        # Formatear respuesta
        user_info = UserResponse(
            id=response["user"].id,
            email=response["user"].email,
            full_name=response["user"].user_metadata.get("full_name"),
            phone=response["user"].user_metadata.get("phone"),
            email_confirmed=response["user"].email_confirmed_at is not None,
            created_at=response["user"].created_at,
            metadata=response["user"].user_metadata
        )
        
        session_token = Token(
            access_token=response["access_token"],
            refresh_token=response["refresh_token"],
            token_type="bearer",
            expires_in=response["session"].expires_in if response["session"] else None
        )
        
        return AuthResponse(
            user=user_info,
            session=session_token,
            message="Inicio de sesión exitoso"
        )
    
    except HTTPException:
        raise
    except Exception as e:
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
        
        return UserResponse(
            id=user.id,
            email=user.email,
            full_name=user.user_metadata.get("full_name"),
            phone=user.user_metadata.get("phone"),
            email_confirmed=user.email_confirmed_at is not None,
            created_at=user.created_at,
            metadata=user.user_metadata
        )
    
    except HTTPException:
        raise
    except Exception as e:
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail=f"Error al obtener usuario: {str(e)}"
        )
