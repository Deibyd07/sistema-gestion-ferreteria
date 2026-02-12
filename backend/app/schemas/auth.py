"""
Schemas de Pydantic para autenticación
"""
from typing import Optional, Dict, Any
from pydantic import BaseModel, EmailStr, Field, validator


class UserRegister(BaseModel):
    """Schema para registro de usuario"""
    email: EmailStr = Field(..., description="Email del usuario")
    password: str = Field(
        ..., 
        min_length=8,
        description="Contraseña (mínimo 8 caracteres)"
    )
    confirm_password: str = Field(..., description="Confirmación de contraseña")
    full_name: Optional[str] = Field(None, description="Nombre completo del usuario")
    phone: Optional[str] = Field(None, description="Teléfono del usuario")
    
    @validator('confirm_password')
    def passwords_match(cls, v, values):
        """Validar que las contraseñas coincidan"""
        if 'password' in values and v != values['password']:
            raise ValueError('Las contraseñas no coinciden')
        return v
    
    @validator('password')
    def password_strength(cls, v):
        """Validar fortaleza de la contraseña"""
        if len(v) < 8:
            raise ValueError('La contraseña debe tener al menos 8 caracteres')
        if not any(char.isdigit() for char in v):
            raise ValueError('La contraseña debe contener al menos un número')
        if not any(char.isupper() for char in v):
            raise ValueError('La contraseña debe contener al menos una mayúscula')
        if not any(char.islower() for char in v):
            raise ValueError('La contraseña debe contener al menos una minúscula')
        return v


class UserLogin(BaseModel):
    """Schema para login de usuario"""
    email: EmailStr = Field(..., description="Email del usuario")
    password: str = Field(..., description="Contraseña del usuario")


class Token(BaseModel):
    """Schema para respuesta de token"""
    access_token: str = Field(..., description="Token de acceso JWT")
    refresh_token: str = Field(..., description="Token de refresh")
    token_type: str = Field(default="bearer", description="Tipo de token")
    expires_in: Optional[int] = Field(None, description="Tiempo de expiración en segundos")


class TokenRefresh(BaseModel):
    """Schema para refresh de token"""
    refresh_token: str = Field(..., description="Token de refresh")


class PasswordResetRequest(BaseModel):
    """Schema para solicitud de recuperación de contraseña"""
    email: EmailStr = Field(..., description="Email del usuario")


class PasswordReset(BaseModel):
    """Schema para resetear contraseña"""
    token: str = Field(..., description="Token de recuperación")
    new_password: str = Field(
        ..., 
        min_length=8,
        description="Nueva contraseña (mínimo 8 caracteres)"
    )
    confirm_password: str = Field(..., description="Confirmación de nueva contraseña")
    
    @validator('confirm_password')
    def passwords_match(cls, v, values):
        """Validar que las contraseñas coincidan"""
        if 'new_password' in values and v != values['new_password']:
            raise ValueError('Las contraseñas no coinciden')
        return v
    
    @validator('new_password')
    def password_strength(cls, v):
        """Validar fortaleza de la contraseña"""
        if len(v) < 8:
            raise ValueError('La contraseña debe tener al menos 8 caracteres')
        if not any(char.isdigit() for char in v):
            raise ValueError('La contraseña debe contener al menos un número')
        if not any(char.isupper() for char in v):
            raise ValueError('La contraseña debe contener al menos una mayúscula')
        if not any(char.islower() for char in v):
            raise ValueError('La contraseña debe contener al menos una minúscula')
        return v


class UserResponse(BaseModel):
    """Schema para respuesta de usuario"""
    id: str = Field(..., description="ID del usuario")
    email: str = Field(..., description="Email del usuario")
    full_name: Optional[str] = Field(None, description="Nombre completo")
    phone: Optional[str] = Field(None, description="Teléfono")
    email_confirmed: bool = Field(default=False, description="Email confirmado")
    created_at: Optional[str] = Field(None, description="Fecha de creación")
    metadata: Optional[Dict[str, Any]] = Field(default_factory=dict, description="Metadata adicional")


class AuthResponse(BaseModel):
    """Schema para respuesta de autenticación completa"""
    user: UserResponse
    session: Token
    message: str = Field(default="Autenticación exitosa")


class MessageResponse(BaseModel):
    """Schema para respuestas de mensaje simple"""
    message: str = Field(..., description="Mensaje de respuesta")
    success: bool = Field(default=True, description="Indica si la operación fue exitosa")
