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


# TODO: Incluir routers cuando estén implementados
# from app.api.v1.api import api_router
# app.include_router(api_router, prefix="/api/v1")
