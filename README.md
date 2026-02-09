# 📦 Sistema Integral de Gestión para Ferreterías (SaaS)

Sistema completo de gestión para ferreterías, diseñado como producto SaaS escalable, multi-empresa y preparado para integrar facturación electrónica por API.

[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)
[![Contributors](https://img.shields.io/github/contributors/Deibyd07/Proyecto-Ferreteria)](https://github.com/Deibyd07/Proyecto-Ferreteria/graphs/contributors)
[![Issues](https://img.shields.io/github/issues/Deibyd07/Proyecto-Ferreteria)](https://github.com/Deibyd07/Proyecto-Ferreteria/issues)
[![Pull Requests](https://img.shields.io/github/issues-pr/Deibyd07/Proyecto-Ferreteria)](https://github.com/Deibyd07/Proyecto-Ferreteria/pulls)
[![Tests](https://img.shields.io/badge/tests-passing-brightgreen)](https://github.com/CamiloTriana75/sistema-gestion-ferreteria/actions)

> 🌟 **Proyecto Open Source** | Desarrollado con metodología Scrum | ¡Tus contribuciones son bienvenidas!

## 🎯 Características Principales

- Gestión centralizada de operaciones de ferretería
- Control de inventarios en tiempo real
- Gestión de ventas, compras y clientes
- Cumplimiento normativo fiscal (facturación electrónica)
- Soporte multi-tenant (múltiples ferreterías)
- Sistema de roles y permisos (RBAC)

## 🤝 ¿Quieres Contribuir?

Este es un proyecto **open source** y ¡nos encantaría tu ayuda! Ya seas principiante o experimentado, hay muchas formas de contribuir:

- 🐛 **Reportar bugs** - Encuentra algo que no funciona
- ✨ **Proponer features** - Sugiere nuevas funcionalidades
- 📝 **Mejorar documentación** - Ayuda a que sea más clara
- 💻 **Escribir código** - Implementa nuevas features o fixes
- 👀 **Revisar PRs** - Ayuda revisando el código de otros

**Primeros Pasos:**
1. Lee la [Guía de Instalación](INSTALLATION.md)
2. Revisa la [Guía de Contribución](CONTRIBUTING.md)
3. Explora nuestro [Project Board](https://github.com/Deibyd07/Proyecto-Ferreteria/projects)
4. Busca issues etiquetados como [good first issue](https://github.com/Deibyd07/Proyecto-Ferreteria/labels/good%20first%20issue)

**Metodología:**
Usamos **Scrum** para organizar el trabajo. Lee nuestra [Guía de Scrum](docs/project/SCRUM_GUIDE.md) para entender cómo participar en Sprints.

## 📋 Roles del Sistema

1. **Super Administrador (SaaS)** - Gestión global del producto
2. **Administrador de Ferretería** - Gestión de la ferretería
3. **Empleado / Vendedor** - Operaciones de venta
4. **Encargado de Inventario** - Control de inventario y bodega
5. **Contador** - Área financiera
6. **Auditor** - Auditoría y reportes (opcional)

## 🛠️ Stack Tecnológico

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

¿Primera vez con el proyecto? Sigue nuestra **[Guía de Instalación Detallada](INSTALLATION.md)** que incluye:
- Instalación paso a paso
- Configuración de Supabase
- Solución de problemas comunes
- Verificación de la instalación

### Resumen Rápido

**Prerrequisitos:**
- Node.js 18.17+
- Python 3.11+
- PostgreSQL (o cuenta de Supabase)

```bash
# 1. Clonar el repositorio
git clone https://github.com/Deibyd07/sistema-gestion-ferreteria.git
cd sistema-gestion-ferreteria

# 2. Backend Setup
cd backend
python -m venv venv
venv\Scripts\activate  # Windows
pip install -r requirements.txt
copy .env.example .env  # Edita con tus credenciales
uvicorn app.main:app --reload

# 3. Frontend Setup (en otra terminal)
cd frontend
npm install
copy .env.example .env.local  # Edita con tus credenciales
npm run dev
```

**URLs:**
- Backend: http://localhost:8000
- API Docs: http://localhost:8000/api/docs
- Frontend: http://localhost:3000

**📘 Ver la [Guía de Instalación Completa](INSTALLATION.md) para detalles.**

**⚙️ [Guía de Configuración de Supabase](docs/setup/SUPABASE_SETUP.md)** para configurar la base de datos y autenticación.

## 📁 Estructura del Proyecto

```
sistema-gestion-ferreteria/
├── backend/                    # API Backend (FastAPI)
│   ├── app/
│   │   ├── api/               # Endpoints de la API
│   │   ├── core/              # Configuración central
│   │   ├── db/                # Configuración de BD
│   │   ├── models/            # Modelos SQLAlchemy
│   │   ├── schemas/           # Schemas Pydantic
│   │   ├── services/          # Lógica de negocio
│   │   ├── repositories/      # Acceso a datos
│   │   └── main.py            # Punto de entrada
│   ├── tests/                 # Tests unitarios
│   ├── alembic/               # Migraciones de BD
│   ├── requirements.txt       # Dependencias Python
│   └── README.md
│
├── frontend/                   # Aplicación Frontend (Next.js)
│   ├── src/
│   │   ├── app/               # App Router (páginas)
│   │   ├── components/        # Componentes React
│   │   ├── lib/               # Utilidades y configs
│   │   ├── services/          # API clients
│   │   ├── types/             # Tipos TypeScript
│   │   ├── contexts/          # React Contexts
│   │   └── hooks/             # Custom Hooks
│   ├── public/                # Assets estáticos
│   ├── package.json
│   └── README.md
│
├── docs/                       # Documentación
│   ├── project/               # Docs del proyecto
│   ├── database/              # Docs de BD
│   ├── setup/                 # Guías de configuración
│   └── security/              # Docs de seguridad
│
├── .github/                    # GitHub templates
│   ├── ISSUE_TEMPLATE/        # Templates de issues
│   └── PULL_REQUEST_TEMPLATE.md
│
├── INSTALLATION.md             # Guía de instalación
├── CONTRIBUTING.md             # Guía de contribución
├── CODE_OF_CONDUCT.md          # Código de conducta
└── README.md                   # Este archivo
```

## 📝 Documentación

### Para Usuarios y Desarrolladores
- 📖 **[Guía de Instalación](INSTALLATION.md)** - Setup detallado del proyecto
- 🤝 **[Guía de Contribución](CONTRIBUTING.md)** - Cómo contribuir al proyecto
- 📜 **[Código de Conducta](CODE_OF_CONDUCT.md)** - Nuestros estándares comunitarios
- 🎓 **[Guía de Bienvenida](WELCOME.md)** - Bienvenido al proyecto
- 📚 **[Índice de Documentación](docs/DOCUMENTATION_INDEX.md)** - Toda la documentación

### Desarrollo y Arquitectura
- 💻 **[Backend README](backend/README.md)** - Documentación del API
- 🎨 **[Frontend README](frontend/README.md)** - Documentación del Frontend
- 🗄️ **[Diseño de Base de Datos](docs/database/DATABASE_DESIGN.md)** - Schema y relaciones
- 🏗️ **[Documentación Completa](docs/project/sistema_gestion_ferreteria_completo.md)** - Arquitectura completa

### Metodología Scrum
- 🏃 **[Guía de Scrum](docs/project/SCRUM_GUIDE.md)** - Cómo trabajamos con Scrum
- 📋 **[Product Backlog](docs/project/PRODUCT_BACKLOG.md)** - Roadmap y funcionalidades
- ✅ **[Definition of Done](docs/project/DEFINITION_OF_DONE.md)** - Criterios de completitud
- 🎯 **[Sprint Planning Template](docs/project/SPRINT_PLANNING_TEMPLATE.md)** - Template para planificación
- 🎉 **[Sprint Review Template](docs/project/SPRINT_REVIEW_TEMPLATE.md)** - Template para revisión

## 🗓️ Roadmap

Estamos en **Q1 2026**, trabajando en las bases del sistema.

### Q1 2026 (Enero - Marzo)
- ✅ **Epic 1**: Setup inicial del proyecto
- 🔄 **Epic 2**: Base de datos y schemas (60% completo)
- 🔄 **Epic 3**: Autenticación y autorización (40% completo)
- 📅 **Epic 4**: Gestión de productos

### Q2 2026 (Abril - Junio)
- **Epic 5**: Gestión de inventario
- **Epic 6**: Gestión de ventas
- **Epic 7**: Gestión de compras

### Q3 2026 (Julio - Septiembre)
- **Epic 8**: Punto de Venta (POS)
- **Epic 9**: Reportes y análisis
- **Epic 10**: Facturación electrónica

### Q4 2026 (Octubre - Diciembre)
- **Epic 11-13**: Optimizaciones, features adicionales y preparación para producción

Ver el [Product Backlog](docs/project/PRODUCT_BACKLOG.md) completo para más detalles.

## 🎯 Sprint Actual

Revisa nuestro [Project Board](https://github.com/Deibyd07/Proyecto-Ferreteria/projects) para ver:
- 📊 Sprint Goal actual
- 📋 Issues del Sprint
- 🔄 Progreso en tiempo real
- 👥 Quién está trabajando en qué

## 🤝 Cómo Contribuir

Seguimos metodología **Scrum** con Sprints de 2 semanas.

### Proceso Rápido

1. **Elige un issue** del [Sprint Backlog](https://github.com/Deibyd07/Proyecto-Ferreteria/projects)
   - Busca `good first issue` si eres nuevo
   - Comenta que vas a trabajar en él
   
2. **Crea tu rama** desde la épica correspondiente:
   ```bash
   git checkout epic/N-nombre-epica
   git checkout -b feature/issue-123-descripcion
   ```

3. **Desarrolla** siguiendo nuestros estándares:
   - Sigue [estándares de código](CONTRIBUTING.md#estándares-de-código)
   - Escribe tests
   - Actualiza documentación

4. **Crea Pull Request**:
   - Usa la plantilla de PR
   - Solicita revisión
   - Responde a comentarios

5. **Merge**: Una vez aprobado, se hará merge a la épica

**Lee la [Guía Completa de Contribución](CONTRIBUTING.md)** para todos los detalles.

### Eventos de Scrum

Participamos en eventos Scrum (mayormente asíncronos en GitHub):

- 📅 **Sprint Planning** - Inicio de cada Sprint (cada 2 semanas)
- 💬 **Daily Updates** - Actualizar progreso en issues (asíncrono)
- 🎉 **Sprint Review** - Demo de funcionalidades (fin del Sprint)
- 🔄 **Sprint Retrospective** - Mejora continua (después de Review)

Lee la [Guía de Scrum](docs/project/SCRUM_GUIDE.md) para detalles.

## 👥 Comunidad

- 💬 **[Discussions](https://github.com/Deibyd07/Proyecto-Ferreteria/discussions)** - Preguntas, ideas, discusiones
- 🐛 **[Issues](https://github.com/Deibyd07/Proyecto-Ferreteria/issues)** - Bugs y features
- 📋 **[Project Board](https://github.com/Deibyd07/Proyecto-Ferreteria/projects)** - Progreso del Sprint

## 🙏 Agradecimientos

Gracias a todos nuestros contribuyentes que hacen este proyecto posible:

<!-- ALL-CONTRIBUTORS-LIST:START -->
<!-- Lista generada automáticamente -->
<!-- ALL-CONTRIBUTORS-LIST:END -->

## 📄 Licencia

Por definir

---

**¿Listo para contribuir?** 🚀
1. Lee [INSTALLATION.md](INSTALLATION.md)
2. Revisa [CONTRIBUTING.md](CONTRIBUTING.md)
3. Explora el [Project Board](https://github.com/Deibyd07/Proyecto-Ferreteria/projects)
4. ¡Elige tu primer issue!

**¿Preguntas?** Abre un [Discussion](https://github.com/Deibyd07/Proyecto-Ferreteria/discussions) o comenta en un issue.
