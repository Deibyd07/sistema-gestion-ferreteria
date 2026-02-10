# 📋 Product Backlog

Este documento mantiene el Product Backlog del proyecto - una lista priorizada de todas las funcionalidades, mejoras y fixes necesarios.

---

## 🎯 Product Vision

**Sistema Integral de Gestión para Ferreterías (SaaS)**

Un sistema completo, moderno y escalable para la gestión de ferreterías que permite:
- Control completo de inventarios en tiempo real
- Gestión eficiente de ventas y compras
- Cumplimiento normativo fiscal (facturación electrónica)
- Soporte multi-tenant para múltiples ferreterías
- Análisis y reportes para toma de decisiones

---

## 📊 Product Roadmap

### Q1 2026 (Enero - Marzo)
- ✅ Epic 1: Setup inicial del proyecto
- 🔄 Epic 2: Base de datos y schemas
- 🔄 Epic 3: Autenticación y autorización
- 📅 Epic 4: Gestión de productos

### Q2 2026 (Abril - Junio)
- Epic 5: Gestión de inventario
- Epic 6: Gestión de ventas
- Epic 7: Gestión de compras

### Q3 2026 (Julio - Septiembre)
- Epic 8: Punto de Venta (POS)
- Epic 9: Reportes y análisis
- Epic 10: Facturación electrónica

### Q4 2026 (Octubre - Diciembre)
- Epic 11: Optimizaciones y mejoras
- Epic 12: Feature adicionales
- Epic 13: Preparación para producción

---

## 📂 Épicas

### Epic 1: Setup Inicial ✅
**Status**: Completed  
**Priority**: Critical  
**Effort**: 40 Story Points

**Description**: Configuración inicial del proyecto, estructura de carpetas, CI/CD, y herramientas de desarrollo.

**Issues**:
- [ ] #001 - Setup repositorio y estructura de carpetas
- [ ] #002 - Configurar CI/CD pipeline
- [ ] #003 - Setup Docker y docker-compose
- [ ] #004 - Configurar linting y formatters
- [ ] #005 - Setup Sentry para monitoreo

---

### Epic 2: Base de Datos y Schemas 🔄
**Status**: In Progress (60%)  
**Priority**: Critical  
**Effort**: 80 Story Points  
**Target**: Sprint 2-3

**Description**: Diseño e implementación del schema de base de datos, migraciones, y políticas RLS en Supabase.

**Issues**:
- [X] #010 - Diseñar schema de base de datos
- [X] #011 - Crear script SQL inicial
- [X] #012 - Implementar políticas RLS
- [ ] #013 - Configurar Storage buckets
- [ ] #014 - Crear migraciones Alembic
- [ ] #015 - Seeds de datos de prueba
- [ ] #016 - Documentar estructura de BD

**Dependencies**: Epic 1 debe estar completo

---

### Epic 3: Autenticación y Autorización 🔄
**Status**: In Progress (40%)  
**Priority**: Critical  
**Effort**: 60 Story Points  
**Target**: Sprint 3-4

**Description**: Sistema completo de autenticación con Supabase, gestión de usuarios, roles y permisos (RBAC).

**Issues**:
- [ ] #020 - Implementar auth con Supabase
- [ ] #021 - Crear modelos de User y Role
- [ ] #022 - Implementar RBAC (Role-Based Access Control)
- [ ] #023 - Endpoints de login/logout/register
- [ ] #024 - Middleware de autenticación
- [ ] #025 - Password reset flow
- [ ] #026 - Email verification
- [ ] #027 - Frontend: Login/Register pages
- [ ] #028 - Frontend: Protected routes
- [ ] #029 - Tests de autenticación

**Dependencies**: Epic 2 debe estar completo

---

### Epic 4: Gestión de Productos 📅
**Status**: Not Started  
**Priority**: High  
**Effort**: 100 Story Points  
**Target**: Sprint 5-7

**Description**: CRUD completo de productos, categorías, marcas, unidades de medida, y gestión de imágenes.

**Issues**:
- [ ] #030 - Modelo de Producto
- [ ] #031 - Modelo de Categoría
- [ ] #032 - Modelo de Marca
- [ ] #033 - Modelo de Unidad de Medida
- [ ] #034 - API: CRUD de productos
- [ ] #035 - API: CRUD de categorías
- [ ] #036 - API: Búsqueda y filtros avanzados
- [ ] #037 - Upload de imágenes de productos
- [ ] #038 - Frontend: Lista de productos
- [ ] #039 - Frontend: Formulario de producto
- [ ] #040 - Frontend: Búsqueda y filtros
- [ ] #041 - Tests de productos

**Dependencies**: Epic 3 debe estar completo

---

### Epic 5: Gestión de Inventario 📅
**Status**: Not Started  
**Priority**: High  
**Effort**: 120 Story Points  
**Target**: Sprint 8-10

**Description**: Control de stock, movimientos de inventario, bodegas, alertas de stock bajo, ajustes de inventario.

**Issues**:
- [ ] #050 - Modelo de Bodega/Almacén
- [ ] #051 - Modelo de Movimiento de Inventario
- [ ] #052 - Sistema de tracking de stock
- [ ] #053 - Alertas de stock bajo
- [ ] #054 - Ajustes de inventario
- [ ] #055 - Transferencias entre bodegas
- [ ] #056 - Historial de movimientos
- [ ] #057 - API: Endpoints de inventario
- [ ] #058 - Frontend: Dashboard de inventario
- [ ] #059 - Frontend: Movimientos y ajustes
- [ ] #060 - Reportes de inventario
- [ ] #061 - Tests de inventario

**Dependencies**: Epic 4 debe estar completo

---

### Epic 6: Gestión de Ventas 📅
**Status**: Not Started  
**Priority**: High  
**Effort**: 130 Story Points  
**Target**: Sprint 11-14

**Description**: Órdenes de venta, cotizaciones, facturación, pagos, clientes.

**Issues**:
- [ ] #070 - Modelo de Cliente
- [ ] #071 - Modelo de Orden de Venta
- [ ] #072 - Modelo de Cotización
- [ ] #073 - Modelo de Factura
- [ ] #074 - Cálculo de impuestos
- [ ] #075 - Descuentos y promociones
- [ ] #076 - Multiple métodos de pago
- [ ] #077 - API: CRUD de ventas
- [ ] #078 - Frontend: Crear orden de venta
- [ ] #079 - Frontend: Gestión de clientes
- [ ] #080 - Frontend: Historial de ventas
- [ ] #081 - Imprimir facturas/cotizaciones
- [ ] #082 - Tests de ventas

**Dependencies**: Epic 5 debe estar completo

---

### Epic 7: Gestión de Compras 📅
**Status**: Not Started  
**Priority**: High  
**Effort**: 110 Story Points  
**Target**: Sprint 15-17

**Description**: Órdenes de compra, proveedores, recepción de mercancía, pagos a proveedores.

**Issues**:
- [ ] #090 - Modelo de Proveedor
- [ ] #091 - Modelo de Orden de Compra
- [ ] #092 - Modelo de Recepción de Mercancía
- [ ] #093 - Gestión de pagos a proveedores
- [ ] #094 - API: CRUD de compras
- [ ] #095 - Frontend: Crear orden de compra
- [ ] #096 - Frontend: Gestión de proveedores
- [ ] #097 - Frontend: Recepción de mercancía
- [ ] #098 - Frontend: Pagos a proveedores
- [ ] #099 - Reportes de compras
- [ ] #100 - Tests de compras

**Dependencies**: Epic 5 debe estar completo

---

### Epic 8: Punto de Venta (POS) 📅
**Status**: Not Started  
**Priority**: Critical  
**Effort**: 150 Story Points  
**Target**: Sprint 18-22

**Description**: Interfaz de punto de venta optimizada, ventas rápidas, impresión de tickets, caja.

**Issues**:
- [ ] #110 - Diseño UI/UX del POS
- [ ] #111 - Búsqueda rápida de productos
- [ ] #112 - Carrito de compra
- [ ] #113 - Cálculo automático de totales
- [ ] #114 - Múltiples métodos de pago
- [ ] #115 - Impresión de tickets
- [ ] #116 - Apertura/cierre de caja
- [ ] #117 - Arqueo de caja
- [ ] #118 - Modo offline
- [ ] #119 - Sincronización cuando vuelve online
- [ ] #120 - Atajos de teclado
- [ ] #121 - Tests del POS

**Dependencies**: Epic 6 debe estar completo

---

### Epic 9: Reportes y Análisis 📅
**Status**: Not Started  
**Priority**: Medium  
**Effort**: 90 Story Points  
**Target**: Sprint 23-25

**Description**: Dashboards, reportes de ventas, inventario, financieros, exportación de datos.

**Issues**:
- [ ] #130 - Dashboard principal
- [ ] #131 - Reporte de ventas por período
- [ ] #132 - Reporte de productos más vendidos
- [ ] #133 - Reporte de inventario valorizado
- [ ] #134 - Reporte de clientes top
- [ ] #135 - Reporte financiero
- [ ] #136 - Gráficos y visualizaciones
- [ ] #137 - Exportar reportes a PDF
- [ ] #138 - Exportar reportes a Excel
- [ ] #139 - Reportes personalizados
- [ ] #140 - Tests de reportes

**Dependencies**: Epic 6, 7, 8 deben estar completos

---

## 🔥 High Priority Backlog Items

Estos son los items más importantes del Product Backlog actual, ordenados por prioridad:

### 🔴 Critical

1. **#013 - Configurar Storage buckets en Supabase** (Epic 2)
   - Story Points: 3
   - Description: Crear buckets para product-images, company-logos, invoices, reports
   - Acceptance Criteria: ...
   
2. **#020 - Implementar auth con Supabase** (Epic 3)
   - Story Points: 8
   - Description: Integrar Supabase Auth con el backend
   - Acceptance Criteria: ...

3. **#021 - Crear modelos de User y Role** (Epic 3)
   - Story Points: 5
   - Description: Modelos SQLAlchemy para usuarios y roles
   - Acceptance Criteria: ...

### 🟠 High

4. **#022 - Implementar RBAC** (Epic 3)
   - Story Points: 13
   - Description: Sistema completo de permisos basado en roles
   - Acceptance Criteria: ...

5. **#023 - Endpoints de login/logout/register** (Epic 3)
   - Story Points: 5
   - Description: APIs de autenticación
   - Acceptance Criteria: ...

---

## 📝 Backlog Grooming Notes

### Últimas Actualizaciones
**Fecha**: [Fecha actual]

**Nuevos Items Agregados**:
- #XXX - [Descripción]

**Items Re-priorizados**:
- #YYY - Movido de Medium a High porque...

**Items Removidos/Descartados**:
- #ZZZ - Removido porque...

### Próximo Grooming Session
**Fecha**: [Fecha]  
**Agenda**: 
- Refinar Epic 4
- Estimar nuevos issues
- Priorizar backlog based on user feedback

---

## 🎯 Definition of Ready

Para que un item esté listo para ser seleccionado en Sprint Planning:

- [ ] Tiene una descripción clara de user story
- [ ] Tiene criterios de aceptación definidos
- [ ] Está estimado (Story Points)
- [ ] No tiene dependencias bloqueantes
- [ ] El equipo entiende qué hacer
- [ ] Tiene valor de negocio claro
- [ ] Es lo suficientemente pequeño (< 13 SP ideal)

---

## 📊 Backlog Statistics

**Total Épicas**: 13  
**Épicas Completadas**: 1 (8%)  
**Épicas En Progreso**: 2 (15%)  
**Épicas Planificadas**: 10 (77%)

**Total Story Points Estimados**: ~1,000 SP  
**Story Points Completados**: ~40 SP (4%)  
**Velocity Promedio**: ~20 SP por Sprint

**Estimated Project Completion**: Q4 2026

---

## 🗂️ Backlog Labels

Usamos estos labels para categorizar el backlog:

- `epic/*` - Épica específica
- `priority: critical` - Debe hacerse ASAP
- `priority: high` - Alta prioridad
- `priority: medium` - Media prioridad
- `priority: low` - Baja prioridad
- `type: feature` - Nueva funcionalidad
- `type: bug` - Corrección de error
- `type: enhancement` - Mejora a funcionalidad existente
- `type: documentation` - Documentación
- `type: technical` - Tarea técnica
- `size: xs` - Muy pequeño (1-2 SP)
- `size: s` - Pequeño (3-5 SP)
- `size: m` - Mediano (8 SP)
- `size: l` - Grande (13 SP)
- `size: xl` - Muy grande (20+ SP - debe dividirse)
- `good first issue` - Bueno para nuevos contribuyentes
- `help wanted` - Se necesita ayuda

---

## 📞 Product Backlog Owner

**Product Owner**: [@Deibyd07](https://github.com/Deibyd07)

Para proponer nuevas funcionalidades o sugerir cambios al backlog:
1. Crea un [Feature Request](https://github.com/Deibyd07/Proyecto-Ferreteria/issues/new/choose)
2. Participa en [Discussions](https://github.com/Deibyd07/Proyecto-Ferreteria/discussions)
3. Comenta en issues existentes

---

**Última Actualización**: Febrero 2026  
**Versión**: 1.0
