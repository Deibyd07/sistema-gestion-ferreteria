# 📁 Índice de Documentación del Proyecto

Este documento proporciona un índice completo de toda la documentación del proyecto.

## 🎯 Por Dónde Empezar

Si eres nuevo en el proyecto, **lee estos documentos en este orden**:

1. [README.md](../README.md) - Visión general 
2. [WELCOME.md](../WELCOME.md) - Guía de bienvenida 
3. [INSTALLATION.md](../INSTALLATION.md) - Instalación 
5. [SCRUM_GUIDE.md](project/SCRUM_GUIDE.md) - Metodología 

---

## 📚 Documentación Principal

### Archivos en la Raíz

| Archivo | Descripción | Audiencia |
|---------|-------------|-----------|
| [README.md](../README.md) | Visión general del proyecto | Todos |
| [WELCOME.md](../WELCOME.md) | Guía de bienvenida para nuevos contribuyentes | Nuevos contribuyentes |
| [INSTALLATION.md](../INSTALLATION.md) | Guía completa de instalación | Desarrolladores |
| [CONTRIBUTING.md](../CONTRIBUTING.md) | Guía de contribución | Contribuyentes |
| [CODE_OF_CONDUCT.md](../CODE_OF_CONDUCT.md) | Código de conducta | Todos |

---

## 🏗️ Documentación del Proyecto (`docs/project/`)

### Metodología y Procesos

| Archivo | Descripción | Cuándo Leer |
|---------|-------------|-------------|
| [SCRUM_GUIDE.md](project/SCRUM_GUIDE.md) | Guía completa de Scrum | Antes de tu primer Sprint |
| [PRODUCT_BACKLOG.md](project/PRODUCT_BACKLOG.md) | Backlog y roadmap del producto | Al elegir issues |
| [DEFINITION_OF_DONE.md](project/DEFINITION_OF_DONE.md) | Criterios de completitud | Antes de crear un PR |
| [BRANCHING_STRATEGY.md](project/BRANCHING_STRATEGY.md) | Estrategia de branching Git | Antes de crear tu primera rama |
| [SPRINT_PLANNING_TEMPLATE.md](project/SPRINT_PLANNING_TEMPLATE.md) | Template para Sprint Planning | Al facilitar Sprint Planning |
| [SPRINT_REVIEW_TEMPLATE.md](project/SPRINT_REVIEW_TEMPLATE.md) | Template para Sprint Review | Al facilitar Sprint Review |
| [ISSUES.md](project/ISSUES.md) | Lista histórica de issues | Referencia |
| [sistema_gestion_ferreteria_completo.md](project/sistema_gestion_ferreteria_completo.md) | Documentación arquitectónica completa | Para entender la arquitectura |

---

## 🗄️ Documentación de Base de Datos (`docs/database/`)

| Archivo | Descripción | Cuándo Usar |
|---------|-------------|-------------|
| [DATABASE_DESIGN.md](database/DATABASE_DESIGN.md) | Diseño y schema de BD | Al trabajar con modelos |
| [database_schema.sql](database/database_schema.sql) | Script SQL del schema | Al crear la BD |
| [rls_policies.sql](database/rls_policies.sql) | Políticas Row Level Security | Al configurar seguridad |
| [storage_policies.sql](database/storage_policies.sql) | Políticas de Storage | Al configurar storage |
| [verify_rls.sql](database/verify_rls.sql) | Verificación de RLS | Para validar seguridad |
| [SUPABASE_SETUP.md](database/SUPABASE_SETUP.md) | Setup de Supabase | Al configurar Supabase |

---

## ⚙️ Documentación de Setup (`docs/setup/`)

| Archivo | Descripción | Cuándo Usar |
|---------|-------------|-------------|
| [SUPABASE_SETUP.md](setup/SUPABASE_SETUP.md) | Configuración de Supabase | Setup inicial |
| [DATABASE_EXECUTION_GUIDE.md](setup/DATABASE_EXECUTION_GUIDE.md) | Guía para ejecutar scripts SQL | Al crear la BD |
| [SENTRY_SETUP.md](setup/SENTRY_SETUP.md) | Configuración de Sentry | Para monitoreo de errores |
| [examples_supabase_usage.py](setup/examples_supabase_usage.py) | Ejemplos de uso de Supabase | Referencia de código |

---

## 🔒 Documentación de Seguridad (`docs/security/`)

| Archivo | Descripción | Cuándo Usar |
|---------|-------------|-------------|
| [RLS_REFERENCE.md](security/RLS_REFERENCE.md) | Referencia de Row Level Security | Al implementar seguridad |
| [RLS_FIX_EXPLANATION.md](security/RLS_FIX_EXPLANATION.md) | Explicación de fixes de RLS | Troubleshooting de seguridad |

---

## 💻 Documentación del Backend (`backend/`)

| Archivo | Descripción | Cuándo Leer |
|---------|-------------|-------------|
| [backend/README.md](../backend/README.md) | Documentación del backend | Al trabajar en el backend |
| [backend/pyproject.toml](../backend/pyproject.toml) | Configuración del proyecto Python | Setup de herramientas |
| [backend/requirements.txt](../backend/requirements.txt) | Dependencias Python | Instalación |

### Subdirectorios del Backend

- **app/api/** - Endpoints de la API
- **app/core/** - Configuración central (config, security, supabase)
- **app/db/** - Configuración de base de datos
- **app/models/** - Modelos SQLAlchemy
- **app/schemas/** - Schemas Pydantic (DTOs)
- **app/services/** - Lógica de negocio
- **app/repositories/** - Acceso a datos
- **app/middleware/** - Middlewares personalizados
- **app/utils/** - Utilidades
- **tests/** - Tests unitarios e integración
- **alembic/** - Migraciones de BD

---

## 🎨 Documentación del Frontend (`frontend/`)

| Archivo | Descripción | Cuándo Leer |
|---------|-------------|-------------|
| [frontend/README.md](../frontend/README.md) | Documentación del frontend | Al trabajar en el frontend |
| [frontend/package.json](../frontend/package.json) | Dependencias y scripts | Setup y comandos |
| [frontend/tsconfig.json](../frontend/tsconfig.json) | Configuración de TypeScript | Configuración |
| [frontend/next.config.ts](../frontend/next.config.ts) | Configuración de Next.js | Configuración |

### Subdirectorios del Frontend

- **src/app/** - Páginas (App Router de Next.js)
- **src/components/** - Componentes React reutilizables
- **src/lib/** - Utilidades (supabase client, config)
- **src/services/** - Clientes de API
- **src/types/** - Tipos TypeScript
- **src/contexts/** - React Contexts
- **src/hooks/** - Custom Hooks
- **public/** - Assets estáticos

---

## 🎫 Templates de GitHub (`.github/`)

### Issue Templates (`.github/ISSUE_TEMPLATE/`)

| Template | Cuándo Usar |
|----------|-------------|
| [bug_report.yml](.github/ISSUE_TEMPLATE/bug_report.yml) | Reportar un bug |
| [feature_request.yml](.github/ISSUE_TEMPLATE/feature_request.yml) | Proponer nueva funcionalidad |
| [user_story.yml](.github/ISSUE_TEMPLATE/user_story.yml) | Crear una User Story |
| [technical_task.yml](.github/ISSUE_TEMPLATE/technical_task.yml) | Tarea técnica (refactoring, deuda técnica) |
| [documentation.yml](.github/ISSUE_TEMPLATE/documentation.yml) | Mejorar documentación |
| [config.yml](.github/ISSUE_TEMPLATE/config.yml) | Configuración de templates |

### Pull Request Template

| Template | Cuándo Usar |
|----------|-------------|
| [PULL_REQUEST_TEMPLATE.md](.github/PULL_REQUEST_TEMPLATE.md) | Al crear cualquier PR |

---

## 📊 Flujo de Lectura por Rol

### 🆕 Nuevo Contribuyente (Primera Vez)

**Lectura esencial** (~1.5 horas):
1. README.md
2. WELCOME.md
3. INSTALLATION.md
4. CONTRIBUTING.md
5. SCRUM_GUIDE.md
6. CODE_OF_CONDUCT.md

**Referencia cuando necesites**:
- BRANCHING_STRATEGY.md
- DEFINITION_OF_DONE.md
- Backend/Frontend README según tu área

### 👨‍💻 Desarrollador Backend

**Lectura inicial**:
1. README.md
2. INSTALLATION.md
3. CONTRIBUTING.md
4. backend/README.md
5. DATABASE_DESIGN.md

**Referencia frecuente**:
- DEFINITION_OF_DONE.md
- database/database_schema.sql
- RLS_REFERENCE.md
- SUPABASE_SETUP.md

### 👩‍💻 Desarrollador Frontend

**Lectura inicial**:
1. README.md
2. INSTALLATION.md
3. CONTRIBUTING.md
4. frontend/README.md

**Referencia frecuente**:
- DEFINITION_OF_DONE.md
- API documentation en backend

### 📋 Scrum Master

**Lectura inicial**:
1. README.md
2. SCRUM_GUIDE.md
3. PRODUCT_BACKLOG.md
4. CONTRIBUTING.md

**Para facilitar eventos**:
- SPRINT_PLANNING_TEMPLATE.md
- SPRINT_REVIEW_TEMPLATE.md
- DEFINITION_OF_DONE.md

### 🎯 Product Owner

**Lectura inicial**:
1. README.md
2. PRODUCT_BACKLOG.md
3. SCRUM_GUIDE.md
4. sistema_gestion_ferreteria_completo.md

**Gestión del backlog**:
- PRODUCT_BACKLOG.md (actualizar regularmente)
- Issue templates para crear issues
- DEFINITION_OF_DONE.md para aceptar trabajo

### 📝 Revisor de Código

**Lectura inicial**:
1. CONTRIBUTING.md
2. DEFINITION_OF_DONE.md
3. Backend/Frontend README según área

**Durante revisiones**:
- DEFINITION_OF_DONE.md como checklist
- Estándares de código en CONTRIBUTING.md

---

## 🔍 Buscar Información por Tema

### Instalación y Setup
- INSTALLATION.md
- SUPABASE_SETUP.md
- DATABASE_EXECUTION_GUIDE.md
- SENTRY_SETUP.md

### Contribución y Desarrollo
- CONTRIBUTING.md
- BRANCHING_STRATEGY.md
- DEFINITION_OF_DONE.md
- Backend/Frontend README

### Metodología y Procesos
- SCRUM_GUIDE.md
- PRODUCT_BACKLOG.md
- SPRINT_PLANNING_TEMPLATE.md
- SPRINT_REVIEW_TEMPLATE.md

### Base de Datos
- DATABASE_DESIGN.md
- database_schema.sql
- rls_policies.sql
- RLS_REFERENCE.md

### Arquitectura
- sistema_gestion_ferreteria_completo.md
- Backend README
- Frontend README
- DATABASE_DESIGN.md

### Seguridad
- RLS_REFERENCE.md
- RLS_FIX_EXPLANATION.md
- rls_policies.sql
- CONTRIBUTING.md (sección de seguridad)

---

## 🔄 Documentos que se Actualizan Frecuentemente

| Documento | Frecuencia | Responsable |
|-----------|-----------|-------------|
| PRODUCT_BACKLOG.md | Semanal | Product Owner |
| README.md | Mensual | Mantenedores |
| Sprint Planning/Review | Cada Sprint | Scrum Master |
| ISSUES.md | Cuando hay nuevas épicas | Product Owner |

---

## 📞 Mantener la Documentación

### ¿Encontraste Documentación Desactualizada?

1. Crea un issue con template **Documentation**
2. O directamente haz un PR con las correcciones
3. Etiqueta con `documentation`

### Agregar Nueva Documentación

1. Crea el documento en el directorio apropiado
2. Actualiza este índice (DOCUMENTATION_INDEX.md)
3. Referencia desde README.md si es importante
4. Crea PR con descripción clara

---

## 🎓 Recursos Externos

### Aprender Tecnologías
- [FastAPI Docs](https://fastapi.tiangolo.com/)
- [Next.js Docs](https://nextjs.org/docs)
- [Supabase Docs](https://supabase.com/docs)
- [Scrum Guide](https://scrumguides.org/)

### Mejores Prácticas
- [Conventional Commits](https://www.conventionalcommits.org/)
- [GitHub Flow](https://guides.github.com/introduction/flow/)
- [Clean Code](https://github.com/ryanmcdermott/clean-code-javascript)

---

**Última Actualización**: Febrero 2026  
**Mantenido por**: Mantenedores del proyecto

¿Falta algo? [Sugerir mejora →](https://github.com/Deibyd07/Proyecto-Ferreteria/issues/new?template=documentation.yml)
