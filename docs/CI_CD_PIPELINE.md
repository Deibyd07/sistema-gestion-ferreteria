# 🚀 CI/CD Pipeline Documentation

Documentación completa del sistema de Integración Continua y Despliegue Continuo (CI/CD) del Sistema de Gestión para Ferreterías.

## 📋 Tabla de Contenidos

- [Visión General](#visión-general)
- [Workflows Disponibles](#workflows-disponibles)
- [Pipeline de Pull Request](#pipeline-de-pull-request)
- [Backend CI](#backend-ci)
- [Frontend CI](#frontend-ci)
- [Auto-Format](#auto-format)
- [Integration Tests](#integration-tests)
- [Reportes y Métricas](#reportes-y-métricas)
- [Troubleshooting](#troubleshooting)
- [Best Practices](#best-practices)

## 🎯 Visión General

Nuestro sistema CI/CD está diseñado para:

- ✅ **Automatizar pruebas** en cada cambio de código
- ✅ **Validar código** con linters y formatters
- ✅ **Escanear seguridad** para detectar vulnerabilidades
- ✅ **Generar reportes** de cobertura de código
- ✅ **Prevenir errores** antes de llegar a producción
- ✅ **Mantener calidad** del código consistente

### Arquitectura del Pipeline

```
┌─────────────────────────────────────────────────────────────┐
│                      PULL REQUEST                            │
└──────────────────┬──────────────────────────────────────────┘
                   │
┌──────────────────▼────────────────────────────────────────┐
│                    PR Validation                           │
│  • Formato de título (Conventional Commits)                │
│  • Conflictos de merge                                     │
│  • Archivos grandes (>5MB)                                 │
└──────────────────┬────────────────────────────────────────┘
                   │
        ┌──────────┴──────────┐
        │                     │
┌───────▼────────┐   ┌───────▼────────┐
│    BACKEND     │   │   FRONTEND     │
└───────┬────────┘   └───────┬────────┘
        │                    │
┌───────▼────────┐   ┌───────▼────────┐
│ Lint & Format  │   │ Lint & Format  │
│ • Black        │   │ • ESLint       │
│ • Ruff         │   │ • Prettier     │
│ • MyPy         │   │ • TypeScript   │
└───────┬────────┘   └───────┬────────┘
        │                    │
┌───────▼────────┐   ┌───────▼────────┐
│ Security Scan  │   │ Security Scan  │
│ • Bandit       │   │ • npm audit    │
│ • TruffleHog   │   │ • TruffleHog   │
└───────┬────────┘   └───────┬────────┘
        │                    │
┌───────▼────────┐   ┌───────▼────────┐
│     Tests      │   │     Tests      │
│ • pytest       │   │ • Jest         │
│ • PostgreSQL   │   │ • React Test   │
│ • Coverage     │   │ • Coverage     │
└───────┬────────┘   └───────┬────────┘
        │                    │
        │            ┌───────▼────────┐
        │            │     Build      │
        │            │ • Next.js      │
        │            │ • Artifacts    │
        │            └───────┬────────┘
        │                    │
        └──────────┬─────────┘
                   │
┌──────────────────▼────────────────────┐
│           PR Summary Report            │
│ • Status de todos los jobs             │
│ • Cobertura de código                  │
│ • Comentario automático en PR          │
└────────────────────────────────────────┘
```

## 📦 Workflows Disponibles

### 1. **Pull Request CI** (`pull-request.yml`)
- **Trigger:** Pull requests a `main` o `develop`
- **Propósito:** Validación completa antes de merge
- **Duración estimada:** 5-10 minutos

### 2. **Backend CI** (`backend-ci.yml`)
- **Trigger:** Push a `main`/`develop` o PR que afecte backend
- **Propósito:** Validación específica del backend
- **Duración estimada:** 3-5 minutos

### 3. **Frontend CI** (`frontend-ci.yml`)
- **Trigger:** Push a `main`/`develop` o PR que afecte frontend
- **Propósito:** Validación específica del frontend
- **Duración estimada:** 4-6 minutos

### 4. **Auto-Format** (`auto-format.yml`)
- **Trigger:** Push a cualquier rama (excepto `main`)
- **Propósito:** Formateo automático de código
- **Duración estimada:** 2-3 minutos

### 5. **Integration Tests** (`integration-tests.yml`)
- **Trigger:** Schedule diario (2 AM UTC) o manual
- **Propósito:** Pruebas de integración completas
- **Duración estimada:** 10-15 minutos

### 6. **CI/CD Pipeline** (`ci-cd.yml`)
- **Trigger:** Push a `main` o PR a `main`
- **Propósito:** Pipeline completo para producción
- **Duración estimada:** 8-12 minutos

## 🔍 Pipeline de Pull Request (Detallado)

### Job 1: PR Validation 📋

**Propósito:** Validar requisitos básicos del PR

```yaml
Checks:
  ✓ Título con formato Conventional Commits
  ✓ No hay conflictos de merge
  ✓ No hay archivos grandes (>5MB)
```

**Formato de título requerido:**
```
feat: agregar nueva funcionalidad
fix: corregir bug en autenticación
docs: actualizar README
```

**Acciones si falla:**
- ❌ PR bloqueado hasta corrección
- 💬 Comentario automático con el error
- 📝 Instrucciones para corregir

### Job 2: Backend Lint 🐍

**Propósito:** Validar estilo y calidad del código Python

```yaml
Tools:
  • Black (formato)
  • Ruff (linting)
  • MyPy (type checking)
```

**Comandos ejecutados:**
```bash
# Format check
black --check .

# Linting
ruff check . --output-format=github

# Type checking
mypy app/ --no-error-summary
```

**Criterios de éxito:**
- ✅ Código formateado según Black
- ✅ No errores de linting (Ruff)
- ⚠️ Warnings de MyPy (no bloquean)

### Job 3: Backend Security 🔒

**Propósito:** Detectar vulnerabilidades de seguridad

```yaml
Tools:
  • Bandit (security linter para Python)
  • TruffleHog (detecta secrets)
```

**Escaneos realizados:**
```bash
# Security scan
bandit -r app/ -f json -o bandit-report.json

# Secrets detection
trufflehog --path ./backend
```

**Detecta:**
- 🔑 Credenciales hardcodeadas
- 🚨 Vulnerabilidades SQL injection
- ⚠️ Uso inseguro de funciones
- 🔐 Secrets expuestos

### Job 4: Backend Tests 🧪

**Propósito:** Ejecutar suite de tests con cobertura

```yaml
Environment:
  • PostgreSQL 15
  • Python 3.11
  • pytest con coverage
```

**Proceso:**
```bash
# 1. Levantar PostgreSQL en container
# 2. Instalar dependencias
# 3. Crear .env para tests
# 4. Ejecutar tests con coverage
pytest tests/backend/ \
  --cov=backend/app \
  --cov-report=xml \
  --cov-report=term \
  --cov-report=html

# 5. Subir coverage a Codecov
# 6. Comentar resultados en PR
```

**Métricas generadas:**
- 📊 Cobertura de código (líneas, branches, functions)
- 📈 Diferencia vs. branch base
- 🎯 Target: >80% cobertura

### Job 5: Frontend Lint ⚛️

**Propósito:** Validar estilo y tipos en Frontend

```yaml
Tools:
  • ESLint (linting)
  • Prettier (formato)
  • TypeScript (type checking)
```

**Comandos ejecutados:**
```bash
# Linting
npm run lint

# Format check
npx prettier --check "src/**/*.{ts,tsx,js,jsx,json,css}"

# Type checking
npm run type-check
```

**Criterios de éxito:**
- ✅ No errores de ESLint
- ✅ Código formateado según Prettier
- ✅ No errores de TypeScript

### Job 6: Frontend Security 🔒

**Propósito:** Detectar vulnerabilidades en dependencias

```yaml
Tools:
  • npm audit (vulnerabilities)
  • TruffleHog (secrets)
```

**Escaneos:**
```bash
# Dependency vulnerabilities
npm audit --audit-level=high

# Secrets detection
trufflehog --path ./frontend
```

**Detecta:**
- 📦 Dependencias vulnerables
- 🔑 API keys expuestas
- 🚨 High/Critical CVEs

### Job 7: Frontend Tests 🧪

**Propósito:** Ejecutar tests de React/Next.js

```yaml
Tools:
  • Jest
  • React Testing Library
  • Coverage reporter
```

**Proceso:**
```bash
# 1. Instalar dependencias
npm ci

# 2. Crear .env.local para tests
# 3. Ejecutar tests con coverage
npm run test:coverage

# 4. Subir coverage a Codecov
```

### Job 8: Frontend Build 🏗️

**Propósito:** Verificar que la app construye correctamente

```yaml
Process:
  1. npm ci (install)
  2. Crear .env.local
  3. npm run build
  4. Analizar tamaño de build
  5. Subir artifacts
```

**Artifacts generados:**
- 📦 `.next/` build folder
- 📊 Build size report
- ⏱️ Retention: 3 días

### Job 9: PR Summary 📊

**Propósito:** Generar reporte consolidado

**Información incluida:**
```markdown
## 🚀 CI/CD Pipeline Summary

### Job Status
- ✅ **pr-validation**: success
- ✅ **backend-lint**: success
- ✅ **backend-tests**: success
- ✅ **frontend-lint**: success
- ✅ **frontend-tests**: success
- ✅ **frontend-build**: success

### Coverage Reports
- Backend: 85% (+2%)
- Frontend: 78% (+1%)

### Next Steps
✅ All checks passed! This PR is ready for review.
```

**Características:**
- 🔄 Se actualiza automáticamente en cada push
- 💬 Comentario único (no spam)
- 📊 Links a reportes detallados
- 🎯 Estado general del PR

## 🐍 Backend CI (Detallado)

### Lint and Format Job

**Dependencias instaladas:**
```bash
pip install -r requirements.txt
```

**Includes:**
- fastapi
- sqlalchemy
- pydantic
- black (formateo)
- ruff (linting)
- mypy (type checking)
- pytest (testing)

**Configuración:** Ver `backend/pyproject.toml`

### Test Job

**Servicios:**
```yaml
postgres:
  image: postgres:15
  env:
    POSTGRES_USER: test_user
    POSTGRES_PASSWORD: test_password
    POSTGRES_DB: test_db
  ports:
    - 5432:5432
```

**Variables de entorno:**
```bash
DATABASE_URL=postgresql://test_user:test_password@localhost:5432/test_db
SECRET_KEY=test-secret-key-for-ci
SUPABASE_URL=https://example.supabase.co
SUPABASE_KEY=test-key
SUPABASE_JWT_SECRET=test-jwt-secret
```

## ⚛️ Frontend CI (Detallado)

### Lint and Format Job

**Dependencias:**
```bash
npm ci  # Instala desde package-lock.json
```

**Checks realizados:**
1. **ESLint:** Reglas de código
2. **TypeScript:** Verificación de tipos
3. **Prettier:** Formato consistente

### Build Job

**Variables de entorno:**
```bash
NEXT_PUBLIC_SUPABASE_URL=https://example.supabase.co
NEXT_PUBLIC_SUPABASE_ANON_KEY=example-anon-key
NEXT_PUBLIC_API_URL=http://localhost:8000
```

**Build artifacts:**
- Ubicación: `frontend/.next`
- Tamaño típico: ~15-30 MB
- Retention: 7 días

## 🎨 Auto-Format Workflow

### Cuándo se ejecuta

```yaml
Trigger: Push a cualquier rama (excepto main)
Paths:
  - backend/**/*.py
  - frontend/**/*.{ts,tsx,js,jsx}
```

### Proceso

1. **Checkout** del código con token especial
2. **Instalar** dependencias de formateo
3. **Formatear** código:
   - Backend: `black .`
   - Frontend: `prettier --write "src/**/*"`
4. **Commit** cambios automáticamente
5. **Push** a la misma rama

### Commit automático

```
🎨 Auto-format code

Co-authored-by: github-actions[bot]
```

### Configuración

- **Permisos:** `contents: write`
- **Token:** `GITHUB_TOKEN` (automático)
- **User:** github-actions[bot]

## 🔬 Integration Tests

### Schedule

```yaml
cron: '0 2 * * *'  # Diario a las 2 AM UTC
workflow_dispatch    # También manual
```

### Servicios levantados

```yaml
Services:
  - postgres:15
  - redis:7-alpine
```

### Proceso completo

1. **Setup** de ambos entornos (Python + Node.js)
2. **Instalar** todas las dependencias
3. **Levantar backend** en background:
   ```bash
   uvicorn app.main:app --host 0.0.0.0 --port 8000 &
   ```
4. **Wait** for backend health check
5. **Ejecutar** tests de integración
6. **Cleanup** y reportes

### Tests de integración

```python
# Ejemplo de test de integración
@pytest.mark.integration
def test_full_user_flow():
    # 1. Registrar usuario
    # 2. Login
    # 3. Crear recurso
    # 4. Verificar en DB
    # 5. Cleanup
    pass
```

## 📊 Reportes y Métricas

### CodeCov

**Reportes generados:**
- 📈 Coverage por archivo
- 📊 Diff coverage (cambios del PR)
- 🎯 Trends históricos
- 🔍 Files sin cobertura

**Umbral recomendado:**
```yaml
Minimum Green: 80%
Minimum Orange: 60%
Below: Red (bloquea PR)
```

**Badge para README:**
```markdown
[![codecov](https://codecov.io/gh/usuario/repo/branch/main/graph/badge.svg)](https://codecov.io/gh/usuario/repo)
```

### GitHub Actions Insights

**Métricas disponibles:**
- ⏱️ Duración de workflows
- 💰 Uso de minutos (Actions)
- 📊 Task de éxito/fallo
- 📈 Trends a lo largo del tiempo

**Acceso:** `Repository` → `Insights` → `Actions`

### Test Results

**Formato JUnit XML:**
```xml
<testsuite tests="50" failures="0" errors="0" time="12.5">
  <testcase name="test_health_check" time="0.05"/>
  ...
</testsuite>
```

**Visualización en GitHub:**
- ✅ Tests pasados
- ❌ Tests fallidos
- ⏱️ Duración por test
- 📝 Logs detallados

## 🔧 Troubleshooting

### ❌ "Black formatting failed"

**Causa:** Código no formateado según Black

**Solución:**
```bash
cd backend
black .
git add .
git commit -m "style: format code with black"
git push
```

### ❌ "ESLint errors found"

**Causa:** Código no cumple reglas de ESLint

**Solución:**
```bash
cd frontend
npm run lint:fix
git add .
git commit -m "style: fix linting errors"
git push
```

### ❌ "Tests failing"

**Causa:** Tests no pasan

**Pasos para debuggear:**
```bash
# 1. Ejecutar tests localmente
cd backend
pytest tests/backend/ -v

# 2. Ver logs detallados
pytest tests/backend/ -v --tb=long

# 3. Ejecutar test específico
pytest tests/backend/test_main.py::test_health_check -v
```

### ❌ "Coverage below threshold"

**Causa:** Cobertura < 80%

**Solución:**
```bash
# 1. Ver reporte de coverage
pytest tests/backend/ --cov=backend/app --cov-report=html

# 2. Abrir htmlcov/index.html en browser

# 3. Identificar archivos con baja cobertura

# 4. Agregar tests para esos archivos
```

### ❌ "Build failing"

**Causa:** Error en build de Next.js

**Solución:**
```bash
# 1. Limpiar cache
cd frontend
rm -rf .next node_modules
npm install

# 2. Intentar build localmente
npm run build

# 3. Revisar errores de TypeScript
npm run type-check

# 4. Fix errors and rebuild
```

### ❌ "Merge conflicts"

**Causa:** Conflictos con branch base

**Solución:**
```bash
# 1. Update tu rama
git fetch origin
git merge origin/develop  # o main

# 2. Resolver conflictos manualmente

# 3. Commit y push
git add .
git commit -m "fix: resolve merge conflicts"
git push
```

### ❌ "Secrets detected"

**Causa:** TruffleHog detectó credenciales

**Solución:**
```bash
# 1. Identificar el archivo
# 2. Eliminar el secret del código
# 3. Usar variables de entorno en su lugar

# MAL ❌
SUPABASE_KEY = "eyJhbGciOiJIUzI1NiIsInR..."

# BIEN ✅
SUPABASE_KEY = os.getenv("SUPABASE_KEY")

# 4. Si ya está en git history, eliminar del historial
git filter-branch --force --index-filter \
  "git rm --cached --ignore-unmatch path/to/file" \
  --prune-empty --tag-name-filter cat -- --all
```

## ✅ Best Practices

### Para Desarrolladores

1. **Antes de crear PR:**
   ```bash
   # Backend
   cd backend
   black .
   ruff check .
   mypy app/
   pytest tests/backend/
   
   # Frontend
   cd frontend
   npm run lint:fix
   npm run format
   npm run type-check
   npm test
   ```

2. **Commits frecuentes y pequeños**
   - Más fácil de revisar
   - Más fácil de revertir
   - CI/CD más rápido

3. **Usar Conventional Commits**
   ```bash
   feat: agregar nueva funcionalidad
   fix: corregir bug
   docs: actualizar documentación
   test: agregar tests
   refactor: refactorizar código
   ```

4. **Mantener PRs pequeños**
   - < 400 líneas de código
   - Un solo propósito
   - Fácil de revisar

5. **Escribir tests para nuevo código**
   - Coverage > 80%
   - Tests unitarios
   - Tests de integración cuando sea necesario

### Para Reviewers

1. **Revisar el reporte de CI/CD**
   - ✅ Todos los checks pasaron
   - 📊 Coverage adecuado
   - 🔒 No security issues

2. **Verificar cambios significativos**
   - Lógica de negocio
   - Cambios en API
   - Migraciones de DB

3. **Aprobar solo si:**
   - ✅ CI/CD pasó
   - ✅ Código revisado
   - ✅ Tests adecuados
   - ✅ Documentación actualizada

### Para el Equipo

1. **Mantener branches actualizados**
   ```bash
   git fetch origin
   git merge origin/develop
   ```

2. **No hacer force push a main/develop**
   ```bash
   # ❌ NUNCA
   git push --force origin main
   ```

3. **Resolver PRs rápidamente**
   - < 24 horas para review
   - Feedback constructivo
   - Merge after approval

4. **Monitorear métricas de CI/CD**
   - Duración de workflows
   - Tasa de éxito
   - Tiempo de resolución

## 📈 Métricas de Éxito

### KPIs del Pipeline

```yaml
Target Metrics:
  • Pipeline Success Rate: >95%
  • Average Duration: <10 min
  • Code Coverage: >80%
  • Mean Time to Review: <24h
  • Mean Time to Merge: <48h
```

### Health Checks

**Semanalmente revisar:**
- 📊 Tasa de éxito de CI/CD
- ⏱️ Duración promedio
- 🔴 Tests fallando frecuentemente
- 🚨 Security issues detectados

## 🔗 Enlaces Útiles

- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [Conventional Commits](https://www.conventionalcommits.org/)
- [Black Code Style](https://black.readthedocs.io/)
- [Ruff Linter](https://docs.astral.sh/ruff/)
- [ESLint Rules](https://eslint.org/docs/rules/)
- [Codecov Documentation](https://docs.codecov.com/)
- [pytest Documentation](https://docs.pytest.org/)
- [Jest Documentation](https://jestjs.io/)

## 📚 Documentos Relacionados

- [GITHUB_CONFIGURATION.md](.github/GITHUB_CONFIGURATION.md) - Configuración del repositorio
- [CONTRIBUTING.md](CONTRIBUTING.md) - Guía de contribución
- [PULL_REQUEST_TEMPLATE.md](.github/PULL_REQUEST_TEMPLATE.md) - Template de PRs

---

**Última actualización:** Febrero 2026
**Mantenido por:** DevOps Team
