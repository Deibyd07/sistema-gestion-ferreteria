"""
Configuración de la aplicación usando Pydantic Settings
"""
from typing import List, Optional, Union
from pydantic_settings import BaseSettings, SettingsConfigDict
from pydantic import AnyHttpUrl, field_validator


class Settings(BaseSettings):
    """Configuración general de la aplicación"""
    
    model_config = SettingsConfigDict(
        env_file=".env",
        env_file_encoding="utf-8",
        case_sensitive=True,
        extra="allow"
    )
    
    # Información del proyecto
    PROJECT_NAME: str = "Sistema de Gestión de Ferretería"
    VERSION: str = "0.1.0"
    API_V1_STR: str = "/api/v1"
    
    # Seguridad
    SECRET_KEY: str = "CHANGE-THIS-IN-PRODUCTION"  # Cambiar en .env
    ALGORITHM: str = "HS256"
    ACCESS_TOKEN_EXPIRE_MINUTES: int = 30
    
    # CORS - Puede ser string separado por comas o lista
    ALLOWED_ORIGINS: Union[str, List[str]] = "http://localhost:3000,http://localhost:5173"
    
    @field_validator("ALLOWED_ORIGINS", mode="before")
    @classmethod
    def assemble_cors_origins(cls, v: Union[str, List[str]]) -> List[str]:
        if isinstance(v, str):
            # Si es un string, dividir por comas
            return [origin.strip() for origin in v.split(",") if origin.strip()]
        elif isinstance(v, list):
            return v
        raise ValueError(f"ALLOWED_ORIGINS debe ser string o lista, se recibió: {type(v)}")
    
    # Database - Supabase PostgreSQL
    DATABASE_URL: str = "postgresql://user:password@localhost:5432/ferreteria_db"
    
    # Supabase
    SUPABASE_URL: Optional[str] = None
    SUPABASE_KEY: Optional[str] = None
    SUPABASE_JWT_SECRET: Optional[str] = None
    
    # Configuración del entorno
    ENVIRONMENT: str = "development"  # development, staging, production
    DEBUG: bool = True
    
    # Logging
    LOG_LEVEL: str = "INFO"
    
    # Sentry (para monitoreo en producción)
    SENTRY_DSN: Optional[str] = None


settings = Settings()
