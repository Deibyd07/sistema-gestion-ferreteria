@echo off
echo 🚀 Configurando proyecto Sistema Gestión Ferretería...
echo.

REM Backend Setup
echo 📦 Configurando Backend...
cd backend

if not exist "venv" (
    echo Creando entorno virtual...
    python -m venv venv
)

echo Activando entorno virtual...
call venv\Scripts\activate.bat

echo Instalando dependencias...
pip install -r requirements.txt

if not exist ".env" (
    echo Creando archivo .env desde .env.example...
    copy .env.example .env
    echo ⚠️  Recuerda actualizar las variables en backend\.env
)

echo ✓ Backend configurado
echo.

REM Frontend Setup
cd ..\frontend
echo 📦 Configurando Frontend...

echo Instalando dependencias...
call npm install

if not exist ".env.local" (
    echo Creando archivo .env.local desde .env.example...
    copy .env.example .env.local
    echo ⚠️  Recuerda actualizar las variables en frontend\.env.local
)

echo ✓ Frontend configurado
echo.

REM Git Hooks Setup
cd ..
echo 🔧 Configurando Git Hooks...

if exist ".hooks\pre-commit" (
    copy .hooks\pre-commit .git\hooks\pre-commit
    echo ✓ Git hooks configurados
) else (
    echo ⚠️  No se encontró .hooks\pre-commit
)

echo.
echo ✅ ¡Configuración completada!
echo.
echo 📝 Próximos pasos:
echo 1. Actualiza las variables de entorno en backend\.env y frontend\.env.local
echo 2. Inicia el backend: cd backend ^&^& venv\Scripts\activate ^&^& uvicorn app.main:app --reload
echo 3. Inicia el frontend: cd frontend ^&^& npm run dev
echo 4. Revisa QUICK_START_CI.md para configurar CI/CD en GitHub
echo.
pause
