"""
FastAPI Application - Sistema de Gestion de Ferreteria
"""
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
import sentry_sdk
from sentry_sdk.integrations.fastapi import FastApiIntegration
from app.core.config import settings

if settings.SENTRY_DSN:
    sentry_sdk.init(
        dsn=settings.SENTRY_DSN,
        environment=settings.ENVIRONMENT,
        release=f"{settings.PROJECT_NAME}@{settings.VERSION}",
        traces_sample_rate=settings.SENTRY_TRACES_SAMPLE_RATE,
        profiles_sample_rate=settings.SENTRY_PROFILES_SAMPLE_RATE,
        integrations=[FastApiIntegration()],
    )

app = FastAPI(
    title=settings.PROJECT_NAME,
    version=settings.VERSION,
    description="API para Sistema de Gestión de Ferreterías (SaaS Multi-tenant)",
    docs_url="/api/docs",
    redoc_url="/api/redoc",
    openapi_url="/api/openapi.json"
)

# Configurar CORS
app.add_middleware(
    CORSMiddleware,
    allow_origins=settings.ALLOWED_ORIGINS,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


@app.get("/")
async def root():
    """Health check endpoint"""
    return {
        "message": "Sistema de Gestión de Ferretería API",
        "version": settings.VERSION,
        "status": "running"
    }


@app.get("/health")
async def health_check():
    """Health check para monitoring"""
    return {"status": "healthy"}


# Test endpoint para debug
@app.get("/debug/config")
async def debug_config():
    """Debug: verificar configuración"""
    from app.core.supabase_client import SupabaseClient
    try:
        client = SupabaseClient.get_client()
        return {
            "supabase_url": settings.SUPABASE_URL,
            "cors_origins": settings.ALLOWED_ORIGINS,
            "client_initialized": True
        }
    except Exception as e:
        return {
            "error": str(e),
            "supabase_url": settings.SUPABASE_URL
        }


# Incluir routers de la API
from app.api.v1.endpoints import auth

app.include_router(auth.router, prefix=settings.API_V1_STR, tags=["auth"])
