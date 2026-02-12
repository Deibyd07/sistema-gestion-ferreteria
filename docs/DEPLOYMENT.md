# 🚀 Guía de Despliegue (Deployment)

Guía completa para desplegar el Sistema de Gestión para Ferreterías en diferentes entornos.

## 📋 Tabla de Contenidos

- [Arquitectura de Despliegue](#arquitectura-de-despliegue)
- [Prerrequisitos](#prerrequisitos)
- [Entornos](#entornos)
- [Despliegue de Backend](#despliegue-de-backend)
- [Despliegue de Frontend](#despliegue-de-frontend)
- [Variables de Entorno](#variables-de-entorno)
- [CI/CD Automático](#cicd-automático)
- [Monitoreo](#monitoreo)
- [Rollback](#rollback)
- [Troubleshooting](#troubleshooting)

## 🏗️ Arquitectura de Despliegue

```
┌─────────────────────────────────────────────────────────┐
│                        INTERNET                          │
└──────────────────┬──────────────────────────────────────┘
                   │
┌──────────────────▼─────────────────────────────────────┐
│                   Vercel / Netlify                       │
│              (Frontend - Next.js App)                    │
│                                                          │
│  • Static Assets (CDN)                                   │
│  • Server-Side Rendering                                 │
│  • Edge Functions                                        │
└──────────────────┬──────────────────────────────────────┘
                   │ HTTPS API Calls
┌──────────────────▼─────────────────────────────────────┐
│               Azure / AWS / GCP                          │
│           (Backend - FastAPI Container)                  │
│                                                          │
│  • Container Instance / App Service                      │
│  • Load Balancer                                         │
│  • Auto-scaling                                          │
└──────────────────┬──────────────────────────────────────┘
                   │
┌──────────────────▼─────────────────────────────────────┐
│                   Supabase                               │
│           (Database + Auth + Storage)                    │
│                                                          │
│  • PostgreSQL Database                                   │
│  • Authentication Service                                │
│  • File Storage                                          │
│  • Row Level Security                                    │
└──────────────────────────────────────────────────────────┘
```

## ✅ Prerrequisitos

### Cuentas y Servicios

- [ ] Cuenta de GitHub (código y CI/CD)
- [ ] Cuenta de Vercel/Netlify (frontend)
- [ ] Cuenta de Azure/AWS/GCP (backend)
- [ ] Cuenta de Supabase (database + auth)
- [ ] Cuenta de Sentry (monitoreo - opcional)
- [ ] Cuenta de CodeCov (coverage - opcional)

### Herramientas Locales

```bash
# Git
git --version

# Node.js (v20+)
node --version
npm --version

# Python (v3.11+)
python --version
pip --version

# Docker (opcional pero recomendado)
docker --version
docker-compose --version

# Vercel CLI
npm install -g vercel

# Azure CLI (si usas Azure)
az --version

# AWS CLI (si usas AWS)
aws --version
```

## 🌍 Entornos

### Development (Local)
- **Backend:** `http://localhost:8000`
- **Frontend:** `http://localhost:3000`
- **Database:** Supabase (proyecto de desarrollo)

### Staging
- **Backend:** `https://api-staging.tu-dominio.com`
- **Frontend:** `https://staging.tu-dominio.com`
- **Database:** Supabase (proyecto de staging)

### Production
- **Backend:** `https://api.tu-dominio.com`
- **Frontend:** `https://tu-dominio.com`
- **Database:** Supabase (proyecto de producción)

## 🐍 Despliegue de Backend

### Opción 1: Azure App Service

#### 1. Preparar aplicación

```bash
cd backend

# Crear Dockerfile
cat > Dockerfile << 'EOF'
FROM python:3.11-slim

WORKDIR /app

# Install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy application
COPY . .

# Expose port
EXPOSE 8000

# Run application
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]
EOF
```

#### 2. Deploy con Azure CLI

```bash
# Login
az login

# Crear resource group
az group create --name rg-ferreteria --location eastus

# Crear container registry
az acr create --resource-group rg-ferreteria \
  --name acrferreteria --sku Basic

# Build y push imagen
az acr build --registry acrferreteria \
  --image backend:latest .

# Crear App Service Plan
az appservice plan create --name plan-ferreteria \
  --resource-group rg-ferreteria \
  --is-linux --sku B1

# Crear Web App
az webapp create --resource-group rg-ferreteria \
  --plan plan-ferreteria --name api-ferreteria \
  --deployment-container-image-name acrferreteria.azurecr.io/backend:latest

# Configurar variables de entorno
az webapp config appsettings set --resource-group rg-ferreteria \
  --name api-ferreteria \
  --settings \
    DATABASE_URL="postgresql://..." \
    SECRET_KEY="..." \
    SUPABASE_URL="..." \
    SUPABASE_KEY="..."
```

### Opción 2: AWS ECS

```bash
# Crear repository en ECR
aws ecr create-repository --repository-name ferreteria-backend

# Login to ECR
aws ecr get-login-password --region us-east-1 | \
  docker login --username AWS --password-stdin \
  123456789.dkr.ecr.us-east-1.amazonaws.com

# Build y push
docker build -t ferreteria-backend .
docker tag ferreteria-backend:latest \
  123456789.dkr.ecr.us-east-1.amazonaws.com/ferreteria-backend:latest
docker push 123456789.dkr.ecr.us-east-1.amazonaws.com/ferreteria-backend:latest

# Crear cluster y service (usar AWS Console o CloudFormation)
```

### Opción 3: Google Cloud Run

```bash
# Configure gcloud
gcloud init

# Build y deploy
cd backend
gcloud run deploy ferreteria-backend \
  --source . \
  --platform managed \
  --region us-central1 \
  --allow-unauthenticated \
  --set-env-vars "DATABASE_URL=...,SECRET_KEY=...,SUPABASE_URL=...,SUPABASE_KEY=..."
```

### Opción 4: Docker Compose (VPS)

```yaml
# docker-compose.yml
version: '3.8'

services:
  backend:
    build: ./backend
    ports:
      - "8000:8000"
    environment:
      - DATABASE_URL=${DATABASE_URL}
      - SECRET_KEY=${SECRET_KEY}
      - SUPABASE_URL=${SUPABASE_URL}
      - SUPABASE_KEY=${SUPABASE_KEY}
    restart: unless-stopped
    
  nginx:
    image: nginx:alpine
    volumes:
      - ./nginx.conf:/etc/nginx/nginx.conf
    ports:
      - "80:80"
      - "443:443"
    depends_on:
      - backend
    restart: unless-stopped
```

```bash
# Deploy
docker-compose up -d

# Ver logs
docker-compose logs -f

# Update
git pull
docker-compose down
docker-compose build
docker-compose up -d
```

## ⚛️ Despliegue de Frontend

### Opción 1: Vercel (Recomendado)

#### Vía CLI

```bash
cd frontend

# Login
vercel login

# Deploy a staging
vercel

# Deploy a producción
vercel --prod
```

#### Vía GitHub (Automático)

1. Ir a [vercel.com](https://vercel.com)
2. Click "New Project"
3. Import desde GitHub
4. Seleccionar repositorio
5. Configurar:
   - **Framework Preset:** Next.js
   - **Root Directory:** `frontend`
   - **Build Command:** `npm run build`
   - **Output Directory:** `.next`

6. Agregar variables de entorno:
   ```
   NEXT_PUBLIC_SUPABASE_URL=https://xxx.supabase.co
   NEXT_PUBLIC_SUPABASE_ANON_KEY=xxx
   NEXT_PUBLIC_API_URL=https://api.tu-dominio.com
   ```

7. Deploy automático en cada push a `main`

### Opción 2: Netlify

```bash
cd frontend

# Install Netlify CLI
npm install -g netlify-cli

# Login
netlify login

# Init
netlify init

# Deploy
netlify deploy --prod
```

#### netlify.toml

```toml
[build]
  base = "frontend"
  command = "npm run build"
  publish = ".next"

[build.environment]
  NODE_VERSION = "20"

[[redirects]]
  from = "/*"
  to = "/index.html"
  status = 200

[context.production.environment]
  NEXT_PUBLIC_API_URL = "https://api.tu-dominio.com"
```

### Opción 3: Azure Static Web Apps

```bash
# Login
az login

# Deploy
cd frontend
az staticwebapp create \
  --name swa-ferreteria \
  --resource-group rg-ferreteria \
  --source . \
  --location "eastus2" \
  --branch main \
  --app-location "/" \
  --output-location ".next"
```

## 🔐 Variables de Entorno

### Backend

**Production (.env o cloud config):**
```bash
# Database
DATABASE_URL=postgresql://user:password@host:5432/database
SUPABASE_URL=https://xxx.supabase.co
SUPABASE_KEY=xxx
SUPABASE_JWT_SECRET=xxx

# Security
SECRET_KEY=your-super-secret-key-min-32-chars
ALGORITHM=HS256
ACCESS_TOKEN_EXPIRE_MINUTES=30

# Environment
ENVIRONMENT=production
DEBUG=False
ALLOWED_HOSTS=api.tu-dominio.com,*.tu-dominio.com

# Monitoring (opcional)
SENTRY_DSN=https://xxx@sentry.io/xxx
```

### Frontend

**Production (.env.production o Vercel config):**
```bash
NEXT_PUBLIC_SUPABASE_URL=https://xxx.supabase.co
NEXT_PUBLIC_SUPABASE_ANON_KEY=xxx
NEXT_PUBLIC_API_URL=https://api.tu-dominio.com
NEXT_PUBLIC_ENVIRONMENT=production
```

### Gestión Segura de Secrets

**Usando Azure Key Vault:**
```bash
# Crear Key Vault
az keyvault create --name kv-ferreteria \
  --resource-group rg-ferreteria \
  --location eastus

# Agregar secrets
az keyvault secret set --vault-name kv-ferreteria \
  --name DATABASE-URL \
  --value "postgresql://..."

# Usar en App Service
az webapp config appsettings set \
  --resource-group rg-ferreteria \
  --name api-ferreteria \
  --settings DATABASE_URL="@Microsoft.KeyVault(SecretUri=https://kv-ferreteria.vault.azure.net/secrets/DATABASE-URL/)"
```

**Usando AWS Secrets Manager:**
```bash
# Crear secret
aws secretsmanager create-secret \
  --name ferreteria/database-url \
  --secret-string "postgresql://..."

# Usar en ECS task definition
```

## 🤖 CI/CD Automático

### GitHub Actions Deployment

**Crear workflow de deployment:**

```yaml
# .github/workflows/deploy-production.yml
name: Deploy to Production

on:
  push:
    branches: [main]
  workflow_dispatch:

jobs:
  deploy-backend:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      
      - name: Login to Azure
        uses: azure/login@v1
        with:
          creds: ${{ secrets.AZURE_CREDENTIALS }}
      
      - name: Build and push Docker image
        run: |
          cd backend
          az acr build --registry ${{ secrets.ACR_NAME }} \
            --image backend:${{ github.sha }} \
            --image backend:latest .
      
      - name: Deploy to App Service
        run: |
          az webapp config container set \
            --name ${{ secrets.WEBAPP_NAME }} \
            --resource-group ${{ secrets.RESOURCE_GROUP }} \
            --docker-custom-image-name ${{ secrets.ACR_NAME }}.azurecr.io/backend:${{ github.sha }}
      
      - name: Restart App Service
        run: |
          az webapp restart \
            --name ${{ secrets.WEBAPP_NAME }} \
            --resource-group ${{ secrets.RESOURCE_GROUP }}

  deploy-frontend:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      
      - name: Setup Node.js
        uses: actions/setup-node@v4
        with:
          node-version: '20'
      
      - name: Deploy to Vercel
        uses: amondnet/vercel-action@v25
        with:
          vercel-token: ${{ secrets.VERCEL_TOKEN }}
          vercel-org-id: ${{ secrets.VERCEL_ORG_ID }}
          vercel-project-id: ${{ secrets.VERCEL_PROJECT_ID }}
          working-directory: ./frontend
          vercel-args: '--prod'
```

### Secrets Necesarios en GitHub

```bash
# Configurar en GitHub Settings → Secrets → Actions

# Azure
AZURE_CREDENTIALS        # Service principal JSON
ACR_NAME                 # Container registry name
WEBAPP_NAME              # App service name
RESOURCE_GROUP           # Resource group name

# Vercel
VERCEL_TOKEN            # Vercel auth token
VERCEL_ORG_ID           # Organization ID
VERCEL_PROJECT_ID       # Project ID

# Supabase (para migrations)
SUPABASE_URL
SUPABASE_KEY
SUPABASE_DB_PASSWORD

# Otros
SENTRY_DSN              # Sentry monitoring
CODECOV_TOKEN           # Code coverage
```

## 📊 Monitoreo

### Application Insights (Azure)

```python
# backend/app/main.py
from opencensus.ext.azure.log_exporter import AzureLogHandler
import logging

# Configure logging
logger = logging.getLogger(__name__)
logger.addHandler(AzureLogHandler(
    connection_string='InstrumentationKey=xxx'
))

@app.get("/health")
async def health_check():
    logger.info("Health check called")
    return {"status": "healthy"}
```

### Sentry (Error Tracking)

```python
# backend/app/main.py
import sentry_sdk
from sentry_sdk.integrations.fastapi import FastApiIntegration

sentry_sdk.init(
    dsn=settings.SENTRY_DSN,
    integrations=[FastApiIntegration()],
    traces_sample_rate=1.0,
    environment=settings.ENVIRONMENT
)
```

```typescript
// frontend/src/app/layout.tsx
import * as Sentry from "@sentry/nextjs";

Sentry.init({
  dsn: process.env.NEXT_PUBLIC_SENTRY_DSN,
  environment: process.env.NEXT_PUBLIC_ENVIRONMENT,
  tracesSampleRate: 1.0,
});
```

### Health Checks

```python
# backend/app/main.py
@app.get("/health")
async def health_check():
    return {
        "status": "healthy",
        "version": "1.0.0",
        "timestamp": datetime.utcnow().isoformat()
    }

@app.get("/health/db")
async def db_health_check(db: Session = Depends(get_db)):
    try:
        db.execute("SELECT 1")
        return {"status": "healthy", "database": "connected"}
    except Exception as e:
        raise HTTPException(status_code=503, detail=str(e))
```

## 🔄 Rollback

### Backend Rollback

**Azure App Service:**
```bash
# Listar deployments
az webapp deployment list --name api-ferreteria \
  --resource-group rg-ferreteria

# Rollback a versión anterior
az webapp deployment source config-zip rollback \
  --resource-group rg-ferreteria \
  --name api-ferreteria
```

**Container Rollback:**
```bash
# Desplegar versión anterior
az webapp config container set \
  --name api-ferreteria \
  --resource-group rg-ferreteria \
  --docker-custom-image-name acrferreteria.azurecr.io/backend:previous-sha
```

### Frontend Rollback

**Vercel:**
```bash
# Ver deployments
vercel ls

# Rollback a despliegue específico
vercel rollback [deployment-url]
```

**Netlify:**
```bash
# Ver deployments
netlify deploy:list

# Restaurar deployment
netlify deploy:restore [deploy-id]
```

## 🔧 Troubleshooting

### Backend No Responde

```bash
# Verificar logs
az webapp log tail --name api-ferreteria \
  --resource-group rg-ferreteria

# Verificar health endpoint
curl https://api.tu-dominio.com/health

# Restart service
az webapp restart --name api-ferreteria \
  --resource-group rg-ferreteria
```

### Frontend Build Failing

```bash
# Clear cache
rm -rf .next node_modules package-lock.json
npm install
npm run build

# Verificar variables de entorno
vercel env ls

# Ver build logs
vercel logs [deployment-url]
```

### Database Connection Issues

```bash
# Verificar connection string
echo $DATABASE_URL

# Test conexión
psql $DATABASE_URL -c "SELECT version();"

# Verificar firewall rules (Azure)
az postgres server firewall-rule list \
  --resource-group rg-ferreteria \
  --server-name postgres-ferreteria
```

### SSL Certificate Issues

```bash
# Verificar certificado
openssl s_client -connect tu-dominio.com:443

# Reiniciar binding (Azure)
az webapp config ssl unbind --name api-ferreteria
az webapp config ssl bind --name api-ferreteria \
  --certificate-name cert-ferreteria
```

## 📚 Checklist de Deployment

### Pre-Deployment

- [ ] Todos los tests pasan
- [ ] Coverage > 80%
- [ ] No security vulnerabilities
- [ ] Database migrations preparadas
- [ ] Variables de entorno configuradas
- [ ] Secrets configurados
- [ ] Backup de database
- [ ] Documentación actualizada

### During Deployment

- [ ] Activar maintenance mode (si aplica)
- [ ] Deploy backend primero
- [ ] Verificar health checks
- [ ] Ejecutar migrations
- [ ] Deploy frontend
- [ ] Smoke tests

### Post-Deployment

- [ ] Verificar aplicación funcionando
- [ ] Revisar logs por errores
- [ ] Monitorear métricas
- [ ] Verificar integraciones
- [ ] Desactivar maintenance mode
- [ ] Notificar al equipo
- [ ] Actualizar changelog

## 📝 Comandos Útiles

```bash
# Ver logs en tiempo real (Azure)
az webapp log tail -n api-ferreteria -g rg-ferreteria

# Restart services
az webapp restart -n api-ferreteria -g rg-ferreteria
vercel rollback

# Database backup
pg_dump $DATABASE_URL > backup_$(date +%Y%m%d).sql

# Restore database
psql $DATABASE_URL < backup_20260209.sql

# Ver status de servicios
curl https://api.tu-dominio.com/health
curl https://tu-dominio.com/api/health
```

## 📚 Recursos

- [Azure App Service Docs](https://docs.microsoft.com/azure/app-service/)
- [Vercel Deployment](https://vercel.com/docs/deployments/overview)
- [Docker Documentation](https://docs.docker.com/)
- [Supabase CLI](https://supabase.com/docs/reference/cli)
- [GitHub Actions](https://docs.github.com/en/actions)

---

**Última actualización:** Febrero 2026
