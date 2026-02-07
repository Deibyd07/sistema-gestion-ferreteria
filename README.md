# 📦 Sistema Integral de Gestión para Ferreterías (SaaS)

Sistema completo de gestión para ferreterías, diseñado como producto SaaS escalable, multi-empresa y preparado para integrar facturación electrónica por API.

## 🎯 Características Principales

- Gestión centralizada de operaciones de ferretería
- Control de inventarios en tiempo real
- Gestión de ventas, compras y clientes
- Cumplimiento normativo fiscal (facturación electrónica)
- Soporte multi-tenant (múltiples ferreterías)
- Sistema de roles y permisos (RBAC)

## 📋 Roles del Sistema

1. **Super Administrador (SaaS)** - Gestión global del producto
2. **Administrador de Ferretería** - Gestión de la ferretería
3. **Empleado / Vendedor** - Operaciones de venta
4. **Encargado de Inventario** - Control de inventario y bodega
5. **Contador** - Área financiera
6. **Auditor** - Auditoría y reportes (opcional)

## �️ Stack Tecnológico

### Backend
- **FastAPI** - Framework web moderno y rápido
- **SQLAlchemy 2.0** - ORM para PostgreSQL
- **Alembic** - Migraciones de base de datos
- **Pydantic 2.0** - Validación de datos
- **Python 3.11+**

### Frontend
- **Next.js 14** - Framework de React con App Router
- **TypeScript** - Tipado estático
- **Tailwind CSS** - Framework CSS utility-first
- **Shadcn/ui** - Componentes UI (próximamente)
- **TanStack Query** - Gestión de estado del servidor (próximamente)

### Base de Datos & Auth
- **Supabase** - PostgreSQL gestionado + Autenticación
- **JWT** - Tokens de autenticación

## 🚀 Inicio Rápido

### Prerrequisitos

- Node.js 18.17+
- Python 3.11+
- PostgreSQL (o cuenta de Supabase)

### 1. Clonar el Repositorio

```bash
git clone https://github.com/Deibyd07/sistema-gestion-ferreteria.git
cd sistema-gestion-ferreteria
```

### 2. Configurar Backend

```bash
# Navegar a la carpeta backend
cd backend

# Crear entorno virtual
python -m venv venv

# Activar entorno virtual
# Windows:
venv\Scripts\activate
# Linux/Mac:
source venv/bin/activate

# Instalar dependencias
pip install -r requirements.txt

# Configurar variables de entorno
copy .env.example .env
# Editar .env con tus credenciales

# Ejecutar servidor de desarrollo
uvicorn app.main:app --reload
```

Backend disponible en: http://localhost:8000
Documentación API: http://localhost:8000/api/docs

### 3. Configurar Frontend

```bash
# Navegar a la carpeta frontend
cd frontend

# Instalar dependencias
npm install

# Configurar variables de entorno
copy .env.example .env.local
# Editar .env.local con tus credenciales

# Ejecutar servidor de desarrollo
npm run dev
```

Frontend disponible en: http://localhost:3000

### 4. Configurar Supabase

Para configurar Supabase (base de datos y autenticación), sigue la guía detallada:

📘 **[Guía de Configuración de Supabase](SUPABASE_SETUP.md)**

Esta guía incluye:
- Creación del proyecto en Supabase
- Obtención de credenciales
- Configuración de autenticación
- Configuración de storage (opcional)
- Verificación de la conexión

## 📁 Estructura del Proyecto

```
sistema-gestion-ferreteria/
├── backend/                    # API Backend (FastAPI)
│   ├── app/
│   │   ├── api/               # Endpoints
│   │   ├── core/              # Configuración
│   │   ├── db/                # Base de datos
│   │   ├── models/            # Modelos SQLAlchemy
│   │   ├── schemas/           # Schemas Pydantic
│   │   ├── services/          # Lógica de negocio
│   │   └── main.py           # Punto de entrada
│   ├── tests/                 # Tests
│   ├── requirements.txt       # Dependencias Python
│   └── README.md
│
├── frontend/                   # Aplicación Frontend (Next.js)
│   ├── src/
│   │   ├── app/              # App Router (páginas)
│   │   ├── components/       # Componentes React
│   │   ├── lib/              # Utilidades
│   │   ├── services/         # API clients
│   │   └── types/            # Tipos TypeScript
│   ├── package.json
│   └── README.md
│
├── docs/                       # Documentación (próximamente)
├── ISSUES.md                   # Listado de issues del proyecto
├── sistema_gestion_ferreteria_completo.md  # Documentación completa
└── README.md                   # Este archivo
```

## 📝 Documentación

- **Documentación Completa**: [sistema_gestion_ferreteria_completo.md](sistema_gestion_ferreteria_completo.md)
- **Issues y Roadmap**: [ISSUES.md](ISSUES.md)
- **Backend README**: [backend/README.md](backend/README.md)
- **Frontend README**: [frontend/README.md](frontend/README.md)

## 🚦 Fase Actual: MVP Core (Fase 1)

Actualmente trabajando en:
- ✅ Configuración inicial del proyecto (Issue #1)
- ✅ Configuración de Supabase (Issue #2)
- ⏳ Modelos de base de datos
- ⏳ Sistema de autenticación
- ⏳ Gestión básica de productos
- ⏳ POS básico
- ⏳ Inventario básico

Ver [ISSUES.md](ISSUES.md) para el roadmap completo.

## 🤝 Contribución

1. Crear rama feature: `git checkout -b feature/nueva-funcionalidad`
2. Hacer commits descriptivos: `git commit -m 'Add: nueva funcionalidad'`
3. Push a la rama: `git push origin feature/nueva-funcionalidad`
4. Crear Pull Request

## 📄 Licencia

Por definir
