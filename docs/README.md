# 📚 Documentación del Sistema de Gestión de Ferretería

Esta carpeta contiene toda la documentación técnica y organizacional del proyecto.

> **⭐ IMPORTANTE:** Ve a [INDICE_DOCUMENTACION.md](INDICE_DOCUMENTACION.md) para navegar toda la documentación de forma organizada y por rol.

## 📁 Estructura de Documentación

### Documentación Reorganizada en Español

Todos los archivos MD han sido renombrados al español para mejor accesibilidad del equipo. Consulta [INDICE_DOCUMENTACION.md](INDICE_DOCUMENTACION.md) para:

- 🚀 Ruta de lectura por rol (Nuevo Dev, Backend, Frontend, Scrum Master, etc.)
- 📋 Búsqueda por tema
- 🎯 Orden de lectura recomendado
- 📚 Tabla completa de todos los archivos

### Antes de continuar leyendo aquí

Por favor, revisa primero:
1. [INDICE_DOCUMENTACION.md](INDICE_DOCUMENTACION.md) - Índice completo
2. Tu rol específico en la sección "Por Rol" del índice

---

## 📁 Referencia de Carpetas (estructura física)

### 🚀 CI/CD y DevOps

Documentación completa del pipeline de integración y despliegue continuo.

- **[CI_CD_PIPELINE.md](./CI_CD_PIPELINE.md)**: 📖 Guía completa del pipeline CI/CD con GitHub Actions
- **[DEPLOYMENT.md](./DEPLOYMENT.md)**: 📦 Guía de despliegue a producción (Azure, AWS, Vercel)
- **[../CI_CD_SETUP_SUMMARY.md](../CI_CD_SETUP_SUMMARY.md)**: 📊 Resumen de configuración del CI/CD
- **[../QUICK_START_CI_CD.md](../QUICK_START_CI_CD.md)**: ⚡ Quick start de CI/CD en 5 minutos

### 💾 Database

Scripts SQL y diseño de base de datos.

- **[DISEÑO_BASE_DATOS.md](./database/DISEÑO_BASE_DATOS.md)**: Diseño conceptual y lógico de la base de datos (35+ tablas)
- **[database_schema.sql](./database/database_schema.sql)**: Script SQL completo con el schema de base de datos
- **[rls_policies.sql](./database/rls_policies.sql)**: Políticas de Row Level Security para aislamiento multi-tenant
- **[storage_policies.sql](./database/storage_policies.sql)**: Políticas de acceso para buckets de Supabase Storage
- **[verify_rls.sql](./database/verify_rls.sql)**: Scripts de verificación de RLS

### 📦 Setup

Guías de configuración e instalación del sistema.

- **[SETUP_SUPABASE.md](./setup/SETUP_SUPABASE.md)**: Guía completa de configuración de Supabase (PostgreSQL, Auth, Storage, RLS)
- **[GUIA_EJECUCION_BD.md](./setup/GUIA_EJECUCION_BD.md)**: Instrucciones paso a paso para ejecutar el schema de base de datos
- **[examples_supabase_usage.py](./setup/examples_supabase_usage.py)**: Ejemplos de uso de los módulos de Supabase (Auth, Storage, Client)
- **[verify_rls.sql](./database/verify_rls.sql)**: Script de verificación de políticas RLS

### 🔒 [security/](./security/)
Documentación de seguridad y Row Level Security (RLS).

- **[REFERENCIA_RLS.md](./security/REFERENCIA_RLS.md)**: Referencia completa de RLS (conceptos, funciones auxiliares, políticas)
- **[EXPLICACION_ARREGLO_RLS.md](./security/EXPLICACION_ARREGLO_RLS.md)**: Explicación técnica de la corrección del schema `auth` a `public`

### 📋 [project/](./project/)
Documentación de gestión de proyecto.

- **[sistema_gestion_ferreteria_completo.md](./project/sistema_gestion_ferreteria_completo.md)**: Especificación completa del sistema (requerimientos, arquitectura, módulos)
- **[REPORTES_ISSUES.md](./project/REPORTES_ISSUES.md)**: Lista de issues del proyecto con descripción, criterios de aceptación y prioridades
- **[ESTRATEGIA_RAMAS.md](./project/ESTRATEGIA_RAMAS.md)**: Estrategia de branches de Git y workflow de desarrollo

---

## 🚀 Guías de Inicio Rápido

### Para desarrolladores nuevos:
1. Lee [sistema_gestion_ferreteria_completo.md](./project/sistema_gestion_ferreteria_completo.md) para entender el sistema
2. Revisa [DISEÑO_BASE_DATOS.md](./database/DISEÑO_BASE_DATOS.md) para conocer el modelo de datos
3. Sigue [SETUP_SUPABASE.md](./setup/SETUP_SUPABASE.md) para configurar tu entorno local

### Para deployment:
1. Ejecuta [database_schema.sql](./database/database_schema.sql) en tu instancia de Supabase
2. Ejecuta [rls_policies.sql](./database/rls_policies.sql) para configurar seguridad
3. Ejecuta [storage_policies.sql](./database/storage_policies.sql) para buckets
4. Verifica con [verify_rls.sql](./database/verify_rls.sql)

### Para contribuir al proyecto:
1. Lee [ESTRATEGIA_RAMAS.md](./project/ESTRATEGIA_RAMAS.md) para workflow de Git
2. Consulta [REPORTES_ISSUES.md](./project/REPORTES_ISSUES.md) para tareas pendientes
3. Sigue los ejemplos en [examples_supabase_usage.py](./setup/examples_supabase_usage.py)

---

## 📖 Convenciones de Documentación

- **Archivos SQL**: Scripts ejecutables en Supabase SQL Editor
- **Archivos MD**: Documentación en formato Markdown
- **Archivos PY**: Scripts de ejemplo o verificación

---

## 🔄 Última Actualización

**Fecha**: Febrero 2026  
**Versión**: 0.1.0  
**Estado**: Issue #2 (Configuración de Supabase) completada ✅

---

## 📞 Contacto y Soporte

Para preguntas sobre la documentación o el proyecto, consulta:
- [REPORTES_ISSUES.md](./project/REPORTES_ISSUES.md) para reportar problemas
- [sistema_gestion_ferreteria_completo.md](./project/sistema_gestion_ferreteria_completo.md) para especificaciones técnicas
