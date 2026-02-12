# Backend - Sistema de Gestión de Ferretería

API RESTful construida con FastAPI para el sistema de gestión de ferreterías (SaaS Multi-tenant).

## 🚀 Tecnologías

- **FastAPI** 0.109+ - Framework web moderno y rápido
- **SQLAlchemy** 2.0+ - ORM para PostgreSQL
- **Alembic** - Migraciones de base de datos
- **Pydantic** 2.0+ - Validación de datos
- **Supabase** - PostgreSQL gestionado + Auth
- **JWT** - Autenticación basada en tokens

## 📁 Estructura del Proyecto

```
backend/
├── app/
│   ├── api/                    # Endpoints de la API
│   │   └── v1/
│   │       └── endpoints/      # Endpoints organizados por dominio
│   ├── core/                   # Configuración central
│   │   ├── config.py          # Configuración de la app
│   │   └── security.py        # Utilidades de seguridad
│   ├── db/                     # Base de datos
│   │   ├── base.py            # Base para modelos
│   │   └── session.py         # Sesión de SQLAlchemy
│   ├── models/                 # Modelos SQLAlchemy
│   ├── schemas/                # Schemas Pydantic (DTOs)
│   ├── services/               # Lógica de negocio
│   ├── repositories/           # Acceso a datos (patrón Repository)
│   ├── middleware/             # Middlewares personalizados
│   ├── utils/                  # Utilidades generales
│   └── main.py                # Punto de entrada de la aplicación
├── alembic/                    # Migraciones de BD
├── tests/                      # Tests unitarios e integración
├── requirements.txt            # Dependencias Python
├── pyproject.toml             # Configuración de herramientas
├── .env.example               # Variables de entorno ejemplo
└── README.md                  # Este archivo
```

## 🛠️ Instalación y Configuración

### 1. Requisitos Previos

- Python 3.11+
- PostgreSQL (o cuenta de Supabase)
- pip y virtualenv

### 2. Configurar Entorno Virtual

```bash
# Crear entorno virtual
python -m venv venv

# Activar entorno virtual
# En Windows:
venv\Scripts\activate
# En Linux/Mac:
source venv/bin/activate
```

### 3. Instalar Dependencias

```bash
pip install -r requirements.txt
```

### 4. Configurar Variables de Entorno

```bash
# Copiar archivo de ejemplo
copy .env.example .env

# Editar .env con tus credenciales
# - DATABASE_URL (conexión a PostgreSQL/Supabase)
# - SUPABASE_URL, SUPABASE_KEY, SUPABASE_JWT_SECRET
# - SUPABASE_SERVICE_ROLE_KEY (para operaciones admin)
# - SECRET_KEY (generar con: openssl rand -hex 32)
# - SENTRY_DSN (opcional, para monitoreo)
# - SENTRY_TRACES_SAMPLE_RATE (opcional, default 0.1)
```

**📖 Guía detallada**: Ver [SETUP_SUPABASE.md](../docs/setup/SETUP_SUPABASE.md) para configurar Supabase completamente.

### Sentry (Opcional)

Para habilitar monitoreo en produccion:

1. Crea un proyecto en Sentry.
2. Agrega `SENTRY_DSN` y ajusta `SENTRY_TRACES_SAMPLE_RATE` en tu `.env`.
3. Reinicia la app.

### 5. Verificar Configuración de Supabase

```bash
# Verificar que Supabase esté configurado correctamente
python verify_supabase_setup.py
```

Este script verificará:
- ✅ Variables de entorno
- ✅ Conexión con Supabase
- ✅ Conexión con base de datos
- ✅ Buckets de Storage
- ✅ Módulos de Auth y Storage

### 6. Ejecutar Migraciones

```bash
# Cuando estén configuradas las migraciones de Alembic:
alembic upgrade head
```

## 🚀 Ejecutar la Aplicación

### Modo Desarrollo

```bash
uvicorn app.main:app --reload --host 0.0.0.0 --port 8000
```

### Modo Producción

```bash
uvicorn app.main:app --host 0.0.0.0 --port 8000 --workers 4
```

La API estará disponible en:
- **API**: http://localhost:8000
- **Documentación Swagger**: http://localhost:8000/api/docs
- **Documentación ReDoc**: http://localhost:8000/api/redoc

## 🧪 Testing

```bash
# Ejecutar todos los tests
pytest

# Ejecutar con cobertura
pytest --cov=app --cov-report=html

# Ejecutar tests específicos
pytest tests/test_auth.py
```

## 🎨 Linting y Formateo

```bash
# Formatear código con Black
black app/

# Linting con Ruff
ruff check app/

# Type checking con mypy
mypy app/
```

## 📊 Arquitectura

Este proyecto sigue los principios de **Clean Architecture** y **Domain-Driven Design**:

- **API Layer**: Controladores FastAPI (endpoints)
- **Service Layer**: Lógica de negocio
- **Repository Layer**: Acceso a datos
- **Model Layer**: Entidades de dominio (SQLAlchemy)
- **Schema Layer**: DTOs con Pydantic

### Principios Aplicados

- ✅ Separación de responsabilidades
- ✅ Inyección de dependencias
- ✅ SOLID principles
- ✅ Repository pattern
- ✅ Multi-tenancy
- ✅ RBAC (Role-Based Access Control)

## 🔐 Seguridad

- Autenticación JWT con Supabase Auth
- Passwords hasheados con bcrypt
- CORS configurado
- Rate limiting (próximamente)
- SQL injection prevention (SQLAlchemy ORM)

## 📝 Convenciones de Código

- Usar **snake_case** para funciones y variables
- Usar **PascalCase** para clases
- Documentar funciones con docstrings
- Type hints en todas las funciones
- Máximo 100 caracteres por línea

## 🤝 Contribución

1. Crear rama feature: `git checkout -b feature/nueva-funcionalidad`
2. Commit cambios: `git commit -m 'Add: nueva funcionalidad'`
3. Push a la rama: `git push origin feature/nueva-funcionalidad`
4. Crear Pull Request

## 📄 Licencia

Por definir
