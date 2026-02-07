"""
Configuración de la aplicación usando Pydantic Settings
"""
from typing import List, Optional
from pydantic_settings import BaseSettings, SettingsConfigDict
from pydantic import AnyHttpUrl, field_validator


class Settings(BaseSettings):
    """Configuración general de la aplicación"""
    
    # Información del proyecto
    PROJECT_NAME: str = "Sistema de Gestión de Ferretería"
    VERSION: str = "0.1.0"
    API_V1_STR: str = "/api/v1"
    
    # Seguridad
    SECRET_KEY: str = "CHANGE-THIS-IN-PRODUCTION"  # Cambiar en .env
    ALGORITHM: str = "HS256"
    ACCESS_TOKEN_EXPIRE_MINUTES: int = 30
    
    # CORS
    ALLOWED_ORIGINS: List[str] = ["http://localhost:3000", "http://localhost:5173"]
    
    @field_validator("ALLOWED_ORIGINS", mode="before")
    @classmethod
    def assemble_cors_origins(cls, v: str | List[str]) -> List[str]:
        if isinstance(v, str):
            return [i.strip() for i in v.split(",")]
        elif isinstance(v, list):
            return v
        raise ValueError(v)
    
    # Database - Supabase PostgreSQL
    DATABASE_URL: str = "postgresql://user:password@localhost:5432/ferreteria_db"
    
    # Supabase
    SUPABASE_URL: Optional[str] = None
    SUPABASE_KEY: Optional[str] = None
    SUPABASE_JWT_SECRET: Optional[str] = None
    SUPABASE_SERVICE_ROLE_KEY: Optional[str] = None  # Para operaciones admin
    
    # Supabase Storage
    SUPABASE_STORAGE_BUCKET_LOGOS: str = "company-logos"
    SUPABASE_STORAGE_BUCKET_DOCUMENTS: str = "documents"
    SUPABASE_STORAGE_BUCKET_PRODUCTS: str = "product-images"
    SUPABASE_STORAGE_MAX_FILE_SIZE: int = 5242880  # 5MB en bytes
    
    # Supabase Auth
    SUPABASE_AUTH_REDIRECT_URL: Optional[str] = "http://localhost:3000/auth/callback"
    SUPABASE_AUTH_PASSWORD_MIN_LENGTH: int = 8
    
    # Configuración del entorno
    ENVIRONMENT: str = "development"  # development, staging, production
    DEBUG: bool = True
    
    # Logging
    LOG_LEVEL: str = "INFO"
    
    # Sentry (para monitoreo en producción)
    SENTRY_DSN: Optional[str] = None
    
    model_config = SettingsConfigDict(
        env_file=".env",
        case_sensitive=True,
        extra="allow"
    )


settings = Settings()
