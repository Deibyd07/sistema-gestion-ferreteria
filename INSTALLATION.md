# 🛠️ Guía de Instalación Detallada

Esta guía te ayudará a configurar el proyecto desde cero, ya sea para desarrollo o producción.

## 📋 Tabla de Contenidos

- [Prerrequisitos](#prerrequisitos)
- [Instalación del Backend](#instalación-del-backend)
- [Instalación del Frontend](#instalación-del-frontend)
- [Configuración de Supabase](#configuración-de-supabase)
- [Configuración de Base de Datos](#configuración-de-base-de-datos)
- [Verificación de la Instalación](#verificación-de-la-instalación)
- [Problemas Comunes](#problemas-comunes)

## 📦 Prerrequisitos

Antes de comenzar, asegúrate de tener instalado lo siguiente:

### Software Requerido

1. **Python 3.11 o superior**
   - Descarga: https://www.python.org/downloads/
   - Verifica la instalación: `python --version`

2. **Node.js 18.17 o superior**
   - Descarga: https://nodejs.org/
   - Verifica la instalación: `node --version`
   - npm vendrá incluido con Node.js

3. **Git**
   - Descarga: https://git-scm.com/downloads
   - Verifica la instalación: `git --version`

4. **Cuenta de Supabase** (gratuita)
   - Regístrate en: https://supabase.com
   - Crea un nuevo proyecto

### Herramientas Opcionales (Recomendadas)

- **VS Code**: Editor de código recomendado
- **Postman** o **Insomnia**: Para probar la API
- **DBeaver** o **pgAdmin**: Para gestionar la base de datos

## 🔧 Instalación del Backend

### 1. Clonar el Repositorio

```bash
# Clonar el repositorio
git clone https://github.com/tuusuario/Proyecto-Ferreteria.git

# Navegar al directorio del proyecto
cd Proyecto-Ferreteria
```

### 2. Configurar el Entorno Virtual de Python

#### En Windows:

```bash
# Navegar al directorio backend
cd backend

# Crear entorno virtual
python -m venv venv

# Activar entorno virtual
venv\Scripts\activate

# Deberías ver (venv) en tu terminal
```

#### En Linux/Mac:

```bash
# Navegar al directorio backend
cd backend

# Crear entorno virtual
python3 -m venv venv

# Activar entorno virtual
source venv/bin/activate

# Deberías ver (venv) en tu terminal
```

### 3. Instalar Dependencias de Python

```bash
# Asegúrate de estar en la carpeta backend con el entorno virtual activado
pip install --upgrade pip

# Instalar todas las dependencias
pip install -r requirements.txt

# Verificar que se instalaron correctamente
pip list
```

### 4. Configurar Variables de Entorno del Backend

```bash
# Copiar el archivo de ejemplo
# Windows:
copy .env.example .env

# Linux/Mac:
cp .env.example .env
```

Edita el archivo `.env` con tus credenciales:

```env
# Configuración de la Aplicación
PROJECT_NAME="Sistema de Gestión de Ferretería"
VERSION="1.0.0"
API_V1_STR="/api/v1"
DEBUG=True
ENVIRONMENT=development

# Supabase Configuration
SUPABASE_URL=https://tu-proyecto.supabase.co
SUPABASE_ANON_KEY=tu-anon-key
SUPABASE_SERVICE_ROLE_KEY=tu-service-role-key
SUPABASE_JWT_SECRET=tu-jwt-secret

# Database Configuration
DATABASE_URL=postgresql://postgres:tu-password@db.tu-proyecto.supabase.co:5432/postgres

# Security
SECRET_KEY=genera-un-secret-key-seguro-aqui
ALGORITHM=HS256
ACCESS_TOKEN_EXPIRE_MINUTES=30

# CORS
BACKEND_CORS_ORIGINS=["http://localhost:3000","http://localhost:8000"]

# Sentry (Opcional para monitoreo de errores)
SENTRY_DSN=
SENTRY_ENVIRONMENT=development
```

**⚠️ Importante**: 
- Nunca compartas tu archivo `.env` 
- Genera un `SECRET_KEY` seguro usando: `openssl rand -hex 32`

### 5. Configurar la Base de Datos

Ejecuta los scripts SQL en Supabase siguiendo la [guía de configuración de Supabase](#configuración-de-supabase).

### 6. Ejecutar Migraciones (Opcional)

```bash
# Si usas Alembic para migraciones
alembic upgrade head
```

### 7. Iniciar el Servidor de Desarrollo

```bash
# Asegúrate de estar en la carpeta backend con el entorno virtual activado
uvicorn app.main:app --reload --host 0.0.0.0 --port 8000
```

Deberías ver:

```
INFO:     Uvicorn running on http://0.0.0.0:8000 (Press CTRL+C to quit)
INFO:     Started reloader process [xxxxx] using StatReload
INFO:     Started server process [xxxxx]
INFO:     Waiting for application startup.
INFO:     Application startup complete.
```

**URLs importantes:**
- API: http://localhost:8000
- Documentación interactiva: http://localhost:8000/api/docs
- Redoc: http://localhost:8000/api/redoc

## 🎨 Instalación del Frontend

### 1. Navegar al Directorio Frontend

```bash
# Desde la raíz del proyecto
cd frontend
```

### 2. Instalar Dependencias de Node.js

```bash
# Instalar todas las dependencias
npm install

# Espera a que termine la instalación
```

### 3. Configurar Variables de Entorno del Frontend

```bash
# Copiar el archivo de ejemplo
# Windows:
copy .env.example .env.local

# Linux/Mac:
cp .env.example .env.local
```

Edita el archivo `.env.local`:

```env
# Supabase Configuration
NEXT_PUBLIC_SUPABASE_URL=https://tu-proyecto.supabase.co
NEXT_PUBLIC_SUPABASE_ANON_KEY=tu-anon-key

# API Backend
NEXT_PUBLIC_API_URL=http://localhost:8000/api/v1

# Sentry (Opcional)
NEXT_PUBLIC_SENTRY_DSN=
SENTRY_AUTH_TOKEN=
SENTRY_ORG=
SENTRY_PROJECT=
```

### 4. Iniciar el Servidor de Desarrollo

```bash
# Asegúrate de estar en la carpeta frontend
npm run dev
```

Deberías ver:

```
   ▲ Next.js 14.x.x
   - Local:        http://localhost:3000
   - Ready in 2.5s
```

Abre tu navegador en: http://localhost:3000

## 🗄️ Configuración de Supabase

### 1. Crear un Proyecto en Supabase

1. Ve a https://supabase.com
2. Inicia sesión o crea una cuenta
3. Crea un nuevo proyecto:
   - Nombre: "Ferreteria SaaS"
   - Password: Elige una contraseña segura para la base de datos
   - Región: Selecciona la más cercana a tus usuarios

### 2. Obtener Credenciales

En tu proyecto de Supabase, ve a **Settings** → **API**:

- **URL del Proyecto**: `SUPABASE_URL`
- **anon/public key**: `SUPABASE_ANON_KEY`
- **service_role key**: `SUPABASE_SERVICE_ROLE_KEY`

En **Settings** → **Project Settings** → **JWT Settings**:
- **JWT Secret**: `SUPABASE_JWT_SECRET`

En **Settings** → **Database**:
- Construye tu `DATABASE_URL` usando:
  - Host: `db.tu-proyecto.supabase.co`
  - Port: `5432`
  - Database: `postgres`
  - User: `postgres`
  - Password: La que elegiste al crear el proyecto

### 3. Ejecutar Scripts SQL

Ve a **SQL Editor** en Supabase y ejecuta los siguientes scripts en orden:

1. **Schema de Base de Datos**:
   ```bash
   # Copia el contenido de:
   docs/database/database_schema.sql
   ```

2. **Políticas RLS** (Row Level Security):
   ```bash
   # Copia el contenido de:
   docs/database/rls_policies.sql
   ```

3. **Políticas de Storage**:
   ```bash
   # Copia el contenido de:
   docs/database/storage_policies.sql
   ```

4. **Verificar RLS**:
   ```bash
   # Copia el contenido de:
   docs/database/verify_rls.sql
   ```

Consulta [GUIA_EJECUCION_BD.md](docs/setup/GUIA_EJECUCION_BD.md) para detalles.

### 4. Configurar Storage

1. Ve a **Storage** en Supabase
2. Crea los siguientes buckets:
   - `product-images` (público)
   - `company-logos` (público)
   - `invoices` (privado)
   - `reports` (privado)

## ✅ Verificación de la Instalación

### Verificar Backend

```bash
# Desde la carpeta backend con entorno virtual activado
python verify_supabase_setup.py
```

Este script verificará:
- ✅ Conexión a Supabase
- ✅ Autenticación
- ✅ Acceso a la base de datos
- ✅ Políticas RLS configuradas

### Verificar Frontend

1. Abre http://localhost:3000 en tu navegador
2. Deberías ver la página de inicio
3. Intenta registrarte o iniciar sesión

### Probar la API

1. Abre http://localhost:8000/api/docs
2. Prueba el endpoint `/api/v1/health`
3. Deberías obtener: `{"status": "healthy"}`

## 🐛 Problemas Comunes

### Backend: ModuleNotFoundError

**Problema**: `ModuleNotFoundError: No module named 'fastapi'`

**Solución**:
```bash
# Verifica que el entorno virtual esté activado
# Deberías ver (venv) en tu terminal

# Reinstala las dependencias
pip install -r requirements.txt
```

### Backend: Error de conexión a la base de datos

**Problema**: `Could not connect to database`

**Solución**:
- Verifica que tu `DATABASE_URL` esté correcta en el archivo `.env`
- Asegúrate de que tu IP esté en la whitelist de Supabase (Settings → Database → Connection Pooling)
- Verifica que el password de la base de datos sea correcto

### Frontend: npm install falla

**Problema**: Errores durante `npm install`

**Solución**:
```bash
# Limpia caché de npm
npm cache clean --force

# Elimina node_modules y package-lock.json
rm -rf node_modules package-lock.json

# Vuelve a instalar
npm install
```

### Puerto ya en uso

**Problema**: `Error: Port 8000 is already in use`

**Solución**:

En Windows:
```bash
# Encuentra el proceso usando el puerto
netstat -ano | findstr :8000

# Mata el proceso (reemplaza PID con el número del proceso)
taskkill /PID <PID> /F
```

En Linux/Mac:
```bash
# Encuentra y mata el proceso
lsof -ti:8000 | xargs kill -9
```

### Variables de entorno no funcionan

**Problema**: La aplicación no lee las variables de entorno

**Solución**:
- Verifica que el archivo `.env` (backend) o `.env.local` (frontend) esté en la carpeta correcta
- Reinicia el servidor después de cambiar las variables
- No uses comillas en los valores a menos que sean necesarias

### Error de CORS

**Problema**: `CORS policy: No 'Access-Control-Allow-Origin' header`

**Solución**:
- Verifica que `BACKEND_CORS_ORIGINS` en el `.env` del backend incluya `http://localhost:3000`
- Reinicia el servidor backend

## 📚 Próximos Pasos

Una vez completada la instalación:

1. Lee la [Guía de Contribución](docs/CONTRIBUIR.md) para entender cómo contribuir
2. Revisa la [Estrategia de Branching](docs/project/ESTRATEGIA_RAMAS.md)
3. Consulta la [Documentación del Proyecto](docs/project/sistema_gestion_ferreteria_completo.md)
4. Únete a las discusiones del proyecto en GitHub

## 🆘 Obtener Ayuda

Si tienes problemas que no están listados aquí:

1. Revisa los [Issues del proyecto](https://github.com/tuusuario/Proyecto-Ferreteria/issues)
2. Crea un nuevo issue describiendo tu problema
3. Incluye:
   - Sistema operativo
   - Versiones de Python/Node.js
   - Mensaje de error completo
   - Pasos para reproducir el problema

---

**¿Instalación exitosa?** ¡Bienvenido al equipo! 🎉
