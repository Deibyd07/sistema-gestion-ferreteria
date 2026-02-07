@echo off
REM Script de configuración rápida para Windows
REM Sistema de Gestión de Ferreterías

echo.
echo ╔════════════════════════════════════════════════════╗
echo ║   Sistema de Gestión de Ferreterías - Setup       ║
echo ║                    (Windows)                        ║
echo ╚════════════════════════════════════════════════════╝
echo.

REM Verificar Python
echo [1/5] Verificando Python 3.11+...
python --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ Python no está instalado o no está en PATH
    echo Descárgalo desde: https://www.python.org/downloads/
    pause
    exit /b 1
) else (
    for /f "tokens=2" %%i in ('python --version 2^>^&1') do set PYTHON_VERSION=%%i
    echo ✓ Python %PYTHON_VERSION% detectado
)

REM Verificar Node.js
echo [2/5] Verificando Node.js 18+...
node --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ Node.js no está instalado o no está en PATH
    echo Descárgalo desde: https://nodejs.org/
    pause
    exit /b 1
) else (
    for /f %%i in ('node --version') do set NODE_VERSION=%%i
    echo ✓ Node.js %NODE_VERSION% detectado
)

REM Crear virtualenv para backend
echo.
echo [3/5] Configurando backend (Python)...
if not exist "backend\venv" (
    echo   - Creando entorno virtual...
    cd backend
    python -m venv venv
    cd ..
    echo   - Activando entorno virtual...
    call backend\venv\Scripts\activate.bat
    echo   - Instalando dependencias...
    pip install -r backend\requirements.txt
    echo ✓ Backend configurado
) else (
    echo ✓ Backend ya configurado
)

REM Instalar dependencias frontend
echo.
echo [4/5] Configurando frontend (Node.js)...
if not exist "frontend\node_modules" (
    echo   - Instalando dependencias...
    cd frontend
    call npm install
    cd ..
    echo ✓ Frontend configurado
) else (
    echo ✓ Frontend ya configurado
)

REM Crear archivos .env
echo.
echo [5/5] Creando archivos de configuración...

if not exist "backend\.env" (
    echo Creando backend\.env...
    (
        echo # Backend Configuration
        echo PROJECT_NAME=Sistema de Gestión de Ferretería
        echo VERSION=0.1.0
        echo.
        echo # Security (CHANGE IN PRODUCTION)
        echo SECRET_KEY=change-me-in-production-use-strong-secret
        echo ALGORITHM=HS256
        echo.
        echo # CORS Configuration
        echo ALLOWED_ORIGINS=["http://localhost:3000","http://localhost:5173"]
        echo.
        echo # Database - Supabase PostgreSQL
        echo DATABASE_URL=postgresql://user:password@localhost/db
        echo.
        echo # Supabase
        echo SUPABASE_URL=https://your-project.supabase.co
        echo SUPABASE_KEY=your-anon-key
        echo SUPABASE_JWT_SECRET=your-jwt-secret
        echo.
        echo # Environment
        echo ENVIRONMENT=development
        echo DEBUG=True
    ) > backend\.env
    echo ⚠️  Actualiza backend\.env con tus credenciales de Supabase
) else (
    echo ✓ backend\.env ya existe
)

if not exist "frontend\.env.local" (
    echo Creando frontend\.env.local...
    (
        echo # Frontend Configuration
        echo NEXT_PUBLIC_APP_NAME=Sistema de Gestión de Ferretería
        echo NEXT_PUBLIC_APP_VERSION=0.1.0
        echo.
        echo # API Configuration
        echo NEXT_PUBLIC_API_URL=http://localhost:8000
        echo NEXT_PUBLIC_API_VERSION=v1
        echo.
        echo # Supabase
        echo NEXT_PUBLIC_SUPABASE_URL=https://your-project.supabase.co
        echo NEXT_PUBLIC_SUPABASE_ANON_KEY=your-anon-key
    ) > frontend\.env.local
    echo ⚠️  Actualiza frontend\.env.local con tus credenciales de Supabase
) else (
    echo ✓ frontend\.env.local ya existe
)

echo.
echo ╔════════════════════════════════════════════════════╗
echo ║            ¡Setup completado! ✓                    ║
echo ╚════════════════════════════════════════════════════╝
echo.
echo Pasos siguientes:
echo.
echo 1️⃣  Configura Supabase:
echo    - Crea un proyecto en https://supabase.com
echo    - Copia las credenciales a backend\.env y frontend\.env.local
echo    - Tutorial: Ver SUPABASE_SETUP.md
echo.
echo 2️⃣  Inicia el Backend (Terminal 1):
echo    cd backend
echo    venv\Scripts\activate
echo    uvicorn app.main:app --reload
echo.
echo 3️⃣  Inicia el Frontend (Terminal 2):
echo    cd frontend
echo    npm run dev
echo.
echo 4️⃣  Accede a:
echo    Frontend:       http://localhost:3000
echo    Backend API:    http://localhost:8000
echo    API Docs:       http://localhost:8000/api/docs
echo.
echo Documentación completa en: ANÁLISIS_EJECUCIÓN.md
echo.
pause
