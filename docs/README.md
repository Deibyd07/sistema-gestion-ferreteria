# 📚 Documentación del Sistema de Gestión de Ferretería

Esta carpeta contiene toda la documentación técnica y organizacional del proyecto.

## 📁 Estructura de Documentación

### 📦 [setup/](./setup/)
Guías de configuración e instalación del sistema.

- **[SUPABASE_SETUP.md](./setup/SUPABASE_SETUP.md)**: Guía completa de configuración de Supabase (PostgreSQL, Auth, Storage, RLS)
- **[DATABASE_EXECUTION_GUIDE.md](./setup/DATABASE_EXECUTION_GUIDE.md)**: Instrucciones paso a paso para ejecutar el schema de base de datos
- **[examples_supabase_usage.py](./setup/examples_supabase_usage.py)**: Ejemplos de uso de los módulos de Supabase (Auth, Storage, Client)

### 🗄️ [database/](./database/)
Scripts SQL y diseño de base de datos.

- **[DATABASE_DESIGN.md](./database/DATABASE_DESIGN.md)**: Diseño conceptual y lógico de la base de datos (35+ tablas)
- **[database_schema.sql](./database/database_schema.sql)**: Script SQL completo con el schema de base de datos
- **[rls_policies.sql](./database/rls_policies.sql)**: Políticas de Row Level Security para aislamiento multi-tenant
- **[storage_policies.sql](./database/storage_policies.sql)**: Políticas de acceso para buckets de Supabase Storage
- **[verify_rls.sql](./database/verify_rls.sql)**: Script de verificación de políticas RLS

### 🔒 [security/](./security/)
Documentación de seguridad y Row Level Security (RLS).

- **[RLS_REFERENCE.md](./security/RLS_REFERENCE.md)**: Referencia completa de RLS (conceptos, funciones auxiliares, políticas)
- **[RLS_FIX_EXPLANATION.md](./security/RLS_FIX_EXPLANATION.md)**: Explicación técnica de la corrección del schema `auth` a `public`

### 📋 [project/](./project/)
Documentación de gestión de proyecto.

- **[sistema_gestion_ferreteria_completo.md](./project/sistema_gestion_ferreteria_completo.md)**: Especificación completa del sistema (requerimientos, arquitectura, módulos)
- **[ISSUES.md](./project/ISSUES.md)**: Lista de issues del proyecto con descripción, criterios de aceptación y prioridades
- **[BRANCHING_STRATEGY.md](./project/BRANCHING_STRATEGY.md)**: Estrategia de branches de Git y workflow de desarrollo

---

## 🚀 Guías de Inicio Rápido

### Para desarrolladores nuevos:
1. Lee [sistema_gestion_ferreteria_completo.md](./project/sistema_gestion_ferreteria_completo.md) para entender el sistema
2. Revisa [DATABASE_DESIGN.md](./database/DATABASE_DESIGN.md) para conocer el modelo de datos
3. Sigue [SUPABASE_SETUP.md](./setup/SUPABASE_SETUP.md) para configurar tu entorno local

### Para deployment:
1. Ejecuta [database_schema.sql](./database/database_schema.sql) en tu instancia de Supabase
2. Ejecuta [rls_policies.sql](./database/rls_policies.sql) para configurar seguridad
3. Ejecuta [storage_policies.sql](./database/storage_policies.sql) para buckets
4. Verifica con [verify_rls.sql](./database/verify_rls.sql)

### Para contribuir al proyecto:
1. Lee [BRANCHING_STRATEGY.md](./project/BRANCHING_STRATEGY.md) para workflow de Git
2. Consulta [ISSUES.md](./project/ISSUES.md) para tareas pendientes
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
- [ISSUES.md](./project/ISSUES.md) para reportar problemas
- [sistema_gestion_ferreteria_completo.md](./project/sistema_gestion_ferreteria_completo.md) para especificaciones técnicas
