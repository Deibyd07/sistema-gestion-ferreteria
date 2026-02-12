#!/bin/bash

echo "🚀 Configurando proyecto Sistema Gestión Ferretería..."
echo ""

# Colores para output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Backend Setup
echo -e "${YELLOW}📦 Configurando Backend...${NC}"
cd backend

if [ ! -d "venv" ]; then
    echo "Creando entorno virtual..."
    python -m venv venv
fi

echo "Activando entorno virtual..."
source venv/bin/activate 2>/dev/null || source venv/Scripts/activate 2>/dev/null

echo "Instalando dependencias..."
pip install -r requirements.txt

if [ ! -f ".env" ]; then
    echo "Creando archivo .env desde .env.example..."
    cp .env.example .env
    echo -e "${YELLOW}⚠️  Recuerda actualizar las variables en backend/.env${NC}"
fi

echo -e "${GREEN}✓ Backend configurado${NC}"
echo ""

# Frontend Setup
cd ../frontend
echo -e "${YELLOW}📦 Configurando Frontend...${NC}"

echo "Instalando dependencias..."
npm install

if [ ! -f ".env.local" ]; then
    echo "Creando archivo .env.local desde .env.example..."
    cp .env.example .env.local
    echo -e "${YELLOW}⚠️  Recuerda actualizar las variables en frontend/.env.local${NC}"
fi

echo -e "${GREEN}✓ Frontend configurado${NC}"
echo ""

# Git Hooks Setup
cd ..
echo -e "${YELLOW}🔧 Configurando Git Hooks...${NC}"

if [ -f ".hooks/pre-commit" ]; then
    cp .hooks/pre-commit .git/hooks/pre-commit
    chmod +x .git/hooks/pre-commit
    echo -e "${GREEN}✓ Git hooks configurados${NC}"
else
    echo -e "${YELLOW}⚠️  No se encontró .hooks/pre-commit${NC}"
fi

echo ""
echo -e "${GREEN}✅ ¡Configuración completada!${NC}"
echo ""
echo "📝 Próximos pasos:"
echo "1. Actualiza las variables de entorno en backend/.env y frontend/.env.local"
echo "2. Inicia el backend: cd backend && source venv/bin/activate && uvicorn app.main:app --reload"
echo "3. Inicia el frontend: cd frontend && npm run dev"
echo "4. Revisa QUICK_START_CI.md para configurar CI/CD en GitHub"
echo ""
