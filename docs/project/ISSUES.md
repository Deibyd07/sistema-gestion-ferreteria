# 🎯 Issues del Proyecto - Sistema de Gestión de Ferretería

## Organización de Issues

Las issues están organizadas en **Épicas** que representan los módulos principales del sistema. Cada issue incluye:
- **Título**: Descripción breve
- **Etiquetas sugeridas**: Para clasificación en GitHub
- **Descripción**: Contexto y alcance
- **Criterios de aceptación**: Checklist de completitud

---

## 📋 ÉPICA 1: Configuración Inicial y DevOps

### Issue #1: Configuración inicial del proyecto
**Etiquetas**: `configuración`, `infraestructura`

**Descripción**:
Configurar la estructura base del proyecto con las tecnologías definidas (FastAPI + Next.js).

**Tareas**:
- [ ] Crear estructura de carpetas para backend (FastAPI)
- [ ] Crear estructura de carpetas para frontend (Next.js)
- [ ] Configurar entorno virtual de Python
- [ ] Inicializar proyecto Next.js con TypeScript
- [ ] Configurar variables de entorno (.env.example)
- [ ] Documentar comandos de instalación en README

---

### Issue #2: Configuración de Supabase
**Etiquetas**: `configuración`, `base-de-datos`, `autenticación`

**Descripción**:
Configurar Supabase como servicio de base de datos PostgreSQL y autenticación.

**Tareas**:
- [ ] Crear proyecto en Supabase
- [ ] Configurar conexión PostgreSQL
- [ ] Configurar Supabase Auth
- [ ] Configurar Storage (si es necesario)
- [ ] Documentar credenciales de acceso
- [ ] Crear archivo de configuración de conexión

---

### Issue #3: Configuración de CI/CD
**Etiquetas**: `devops`, `ci-cd`

**Descripción**:
Implementar pipeline de CI/CD con GitHub Actions para automatizar pruebas y despliegues.

**Tareas**:
- [ ] Configurar GitHub Actions para backend
- [ ] Configurar GitHub Actions para frontend
- [ ] Configurar linting y formateo automático
- [ ] Configurar pruebas automáticas
- [ ] Documentar proceso de despliegue

---

### Issue #4: Configuración de Sentry para monitoreo ✅
**Etiquetas**: `Configuración de Sentry para monitoreo`, `infraestructura`

**Descripción**:
Integrar Sentry para monitoreo de errores y performance en producción.

**Tareas**:
- [x] Crear proyecto en Sentry
- [x] Integrar Sentry en backend (FastAPI)
- [x] Integrar Sentry en frontend (Next.js)
- [x] Configurar alertas
- [x] Documentar configuración

**Completado**: 2026-02-08
**Documentación**: Ver [docs/setup/SENTRY_SETUP.md](../setup/SENTRY_SETUP.md)

---

## 📋 ÉPICA 2: Base de Datos y Modelos

### Issue #5: Diseño del modelo de base de datos
**Etiquetas**: `base-de-datos`, `diseño`

**Descripción**:
Diseñar el esquema completo de base de datos para el sistema multi-tenant.

**Tareas**:
- [ ] Crear diagrama ER completo
- [ ] Definir tablas principales (tenants, users, products, etc.)
- [ ] Definir relaciones entre tablas
- [ ] Definir índices para optimización
- [ ] Documentar decisiones de diseño

---

### Issue #6: Implementar modelos SQLAlchemy - Core
**Etiquetas**: `backend`, `base-de-datos`, `modelos`

**Descripción**:
Crear los modelos SQLAlchemy para las tablas principales del sistema.

**Tareas**:
- [ ] Modelo Tenant (ferreterías)
- [ ] Modelo User (usuarios con roles)
- [ ] Modelo Role (roles del sistema)
- [ ] Modelo Permission (permisos)
- [ ] Modelo Plan (planes SaaS)
- [ ] Configurar relaciones y constraints

---

### Issue #7: Implementar modelos SQLAlchemy - Productos e Inventario
**Etiquetas**: `backend`, `base-de-datos`, `modelos`

**Descripción**:
Crear modelos relacionados con productos e inventario.

**Tareas**:
- [ ] Modelo Product (productos)
- [ ] Modelo Category (categorías)
- [ ] Modelo Brand (marcas)
- [ ] Modelo Inventory (inventario)
- [ ] Modelo InventoryMovement (movimientos)
- [ ] Modelo Warehouse (bodegas/sucursales)

---

### Issue #8: Implementar modelos SQLAlchemy - Ventas y Compras
**Etiquetas**: `backend`, `base-de-datos`, `modelos`

**Descripción**:
Crear modelos para gestión de ventas y compras.

**Tareas**:
- [ ] Modelo Sale (ventas)
- [ ] Modelo SaleItem (items de venta)
- [ ] Modelo Purchase (compras)
- [ ] Modelo PurchaseItem (items de compra)
- [ ] Modelo Quote (cotizaciones)
- [ ] Modelo PaymentMethod (métodos de pago)

---

### Issue #9: Implementar modelos SQLAlchemy - Clientes y Proveedores
**Etiquetas**: `backend`, `base-de-datos`, `modelos`

**Descripción**:
Crear modelos para gestión de clientes y proveedores.

**Tareas**:
- [ ] Modelo Customer (clientes)
- [ ] Modelo Supplier (proveedores)
- [ ] Modelo CustomerAddress (direcciones)
- [ ] Modelo Contact (contactos)

---

### Issue #10: Migraciones de base de datos con Alembic
**Etiquetas**: `backend`, `base-de-datos`, `migraciones`

**Descripción**:
Configurar Alembic e implementar las migraciones iniciales de base de datos.

**Tareas**:
- [ ] Configurar Alembic
- [ ] Crear migración inicial con todos los modelos
- [ ] Crear script de seeds para datos de prueba
- [ ] Documentar comandos de migración
- [ ] Probar migraciones en entorno local

---

## 📋 ÉPICA 3: Autenticación y Autorización

### Issue #11: Integración con Supabase Auth
**Etiquetas**: `backend`, `autenticación`, `seguridad`

**Descripción**:
Integrar autenticación JWT con Supabase Auth en FastAPI.

**Tareas**:
- [ ] Configurar cliente de Supabase en backend
- [ ] Implementar middleware de autenticación JWT
- [ ] Crear decorador para rutas protegidas
- [ ] Implementar validación de tokens
- [ ] Manejar renovación de tokens

---

### Issue #12: Sistema RBAC (Control de Acceso Basado en Roles)
**Etiquetas**: `backend`, `autenticación`, `seguridad`

**Descripción**:
Implementar sistema completo de roles y permisos.

**Tareas**:
- [ ] Definir roles del sistema (6 roles base)
- [ ] Crear tabla de permisos
- [ ] Implementar decorador @require_permission
- [ ] Implementar decorador @require_role
- [ ] Crear endpoints de gestión de permisos
- [ ] Documentar matriz de permisos por rol

---

### Issue #13: Registro y Login - Backend
**Etiquetas**: `backend`, `autenticación`

**Descripción**:
Implementar endpoints de registro y autenticación de usuarios.

**Tareas**:
- [ ] Endpoint POST /auth/register
- [ ] Endpoint POST /auth/login
- [ ] Endpoint POST /auth/logout
- [ ] Endpoint POST /auth/refresh-token
- [ ] Endpoint POST /auth/forgot-password
- [ ] Endpoint POST /auth/reset-password
- [ ] Validaciones de datos con Pydantic

---

### Issue #14: Autenticación - Frontend
**Etiquetas**: `frontend`, `autenticación`

**Descripción**:
Implementar pantallas y lógica de autenticación en Next.js.

**Tareas**:
- [ ] Página de login
- [ ] Página de registro
- [ ] Página de recuperación de contraseña
- [ ] Context de autenticación (AuthProvider)
- [ ] Persistencia de sesión
- [ ] Protección de rutas privadas
- [ ] Redirección automática según rol

---

### Issue #15: Middleware Multi-Tenant
**Etiquetas**: `backend`, `seguridad`, `multi-tenant`

**Descripción**:
Implementar middleware para aislamiento de datos por tenant.

**Tareas**:
- [ ] Crear middleware de tenant_id
- [ ] Filtrar automáticamente queries por tenant
- [ ] Validar acceso cross-tenant
- [ ] Implementar contexto de tenant actual
- [ ] Documentar estrategia multi-tenant

---

## 📋 ÉPICA 4: Gestión de Tenants (Super Admin)

### Issue #16: CRUD de Ferreterías (Tenants)
**Etiquetas**: `backend`, `super-admin`, `inquilino`

**Descripción**:
Implementar gestión completa de ferreterías para Super Administrador.

**Tareas**:
- [ ] Endpoint GET /admin/tenants (listar)
- [ ] Endpoint POST /admin/tenants (crear)
- [ ] Endpoint GET /admin/tenants/{id}
- [ ] Endpoint PUT /admin/tenants/{id}
- [ ] Endpoint DELETE /admin/tenants/{id}
- [ ] Endpoint PATCH /admin/tenants/{id}/suspend
- [ ] Validaciones y permisos

---

### Issue #17: Gestión de Planes SaaS
**Etiquetas**: `backend`, `super-admin`, `saas`

**Descripción**:
Implementar sistema de planes (Free, Pro, Premium) con límites.

**Tareas**:
- [ ] Endpoint GET /admin/plans
- [ ] Endpoint POST /admin/plans
- [ ] Endpoint PUT /admin/plans/{id}
- [ ] Configuración de límites por plan
- [ ] Endpoint para asignar plan a tenant
- [ ] Validación de límites en operaciones

---

### Issue #18: Dashboard Super Admin
**Etiquetas**: `frontend`, `super-admin`, `dashboard`

**Descripción**:
Crear dashboard para Super Administrador con métricas globales.

**Tareas**:
- [ ] Pantalla de dashboard con KPIs
- [ ] Lista de tenants activos/suspendidos
- [ ] Gráficos de uso del sistema
- [ ] Tabla de tenants con filtros
- [ ] Acciones rápidas (suspender, reactivar)

---

### Issue #19: Gestión de Tenants - Frontend
**Etiquetas**: `frontend`, `super-admin`

**Descripción**:
Crear interfaces para gestión de ferreterías.

**Tareas**:
- [ ] Formulario de creación de tenant
- [ ] Formulario de edición de tenant
- [ ] Modal de confirmación para eliminar
- [ ] Asignación de planes
- [ ] Configuración de límites

---

## 📋 ÉPICA 5: Gestión de Usuarios y Roles

### Issue #20: CRUD de Usuarios - Backend
**Etiquetas**: `backend`, `usuarios`, `admin`

**Descripción**:
Implementar endpoints para gestión de usuarios por tenant.

**Tareas**:
- [ ] Endpoint GET /users (listar por tenant)
- [ ] Endpoint POST /users (crear usuario)
- [ ] Endpoint GET /users/{id}
- [ ] Endpoint PUT /users/{id}
- [ ] Endpoint DELETE /users/{id}
- [ ] Endpoint PATCH /users/{id}/activate
- [ ] Endpoint PATCH /users/{id}/deactivate

---

### Issue #21: Asignación de Roles
**Etiquetas**: `backend`, `usuarios`, `rbac`

**Descripción**:
Implementar sistema de asignación de roles a usuarios.

**Tareas**:
- [ ] Endpoint POST /users/{id}/roles (asignar rol)
- [ ] Endpoint DELETE /users/{id}/roles/{role_id} (quitar rol)
- [ ] Endpoint GET /users/{id}/roles (ver roles)
- [ ] Validar permisos para asignar roles
- [ ] Prevenir escalamiento de privilegios

---

### Issue #22: Gestión de Usuarios - Frontend
**Etiquetas**: `frontend`, `usuarios`, `admin`

**Descripción**:
Crear interfaces de gestión de usuarios para administrador de ferretería.

**Tareas**:
- [ ] Tabla de usuarios con filtros
- [ ] Formulario de creación de usuario
- [ ] Formulario de edición de usuario
- [ ] Selector de roles
- [ ] Indicadores de estado (activo/inactivo)
- [ ] Acciones en tabla (editar, eliminar, desactivar)

---

## 📋 ÉPICA 6: Gestión de Productos

### Issue #23: CRUD de Productos - Backend
**Etiquetas**: `backend`, `productos`

**Descripción**:
Implementar endpoints completos para gestión de productos.

**Tareas**:
- [ ] Endpoint GET /products (con paginación y filtros)
- [ ] Endpoint POST /products
- [ ] Endpoint GET /products/{id}
- [ ] Endpoint PUT /products/{id}
- [ ] Endpoint DELETE /products/{id}
- [ ] Búsqueda por código de barras
- [ ] Búsqueda por nombre/descripción

---

### Issue #24: Categorías y Subcategorías
**Etiquetas**: `backend`, `productos`

**Descripción**:
Implementar sistema de categorización de productos.

**Tareas**:
- [ ] Endpoint GET /categories
- [ ] Endpoint POST /categories
- [ ] Endpoint PUT /categories/{id}
- [ ] Endpoint DELETE /categories/{id}
- [ ] Soporte para subcategorías (árbol)
- [ ] Validar que categoría no tenga productos antes de eliminar

---

### Issue #25: Gestión de Precios
**Etiquetas**: `backend`, `productos`, `precios`

**Descripción**:
Implementar sistema de precios con historial y precios por volumen.

**Tareas**:
- [ ] Tabla de historial de precios
- [ ] Endpoint para actualizar precio (guarda historial)
- [ ] Endpoint GET /products/{id}/price-history
- [ ] Precios por volumen (descuentos por cantidad)
- [ ] Cálculo automático de precio con descuento

---

### Issue #26: Variantes de Productos
**Etiquetas**: `backend`, `productos`, `mejora`

**Descripción**:
Implementar soporte para variantes de productos (tallas, colores, etc.).

**Tareas**:
- [ ] Modelo ProductVariant
- [ ] Endpoint GET /products/{id}/variants
- [ ] Endpoint POST /products/{id}/variants
- [ ] Endpoint PUT /variants/{id}
- [ ] Endpoint DELETE /variants/{id}
- [ ] SKU automático para variantes

---

### Issue #27: Gestión de Productos - Frontend
**Etiquetas**: `frontend`, `productos`

**Descripción**:
Crear interfaces de gestión de productos.

**Tareas**:
- [ ] Tabla de productos con TanStack Table
- [ ] Filtros avanzados (categoría, stock, precio)
- [ ] Formulario de creación de producto
- [ ] Formulario de edición con tabs
- [ ] Vista de detalle de producto
- [ ] Generador de código de barras
- [ ] Búsqueda rápida tipo-ahead

---

### Issue #28: Catálogo de Productos - Frontend
**Etiquetas**: `frontend`, `productos`, `catálogo`

**Descripción**:
Crear vista de catálogo para visualización rápida de productos.

**Tareas**:
- [ ] Vista en grid/lista de productos
- [ ] Filtros por categoría
- [ ] Búsqueda instantánea
- [ ] Indicador de stock
- [ ] Vista rápida de detalles

---

## 📋 ÉPICA 7: Gestión de Inventario

### Issue #29: Sistema de Inventario - Backend
**Etiquetas**: `backend`, `inventario`

**Descripción**:
Implementar sistema de control de inventario por sucursal.

**Tareas**:
- [ ] Endpoint GET /inventory (stock por sucursal)
- [ ] Endpoint GET /inventory/product/{id}
- [ ] Endpoint POST /inventory/adjustment (ajuste manual)
- [ ] Alertas de stock mínimo
- [ ] Cálculo de stock disponible vs reservado

---

### Issue #30: Kardex y Movimientos
**Etiquetas**: `backend`, `inventario`, `auditoría`

**Descripción**:
Implementar kardex completo con registro de todos los movimientos.

**Tareas**:
- [ ] Modelo InventoryMovement con tipos
- [ ] Registro automático en ventas
- [ ] Registro automático en compras
- [ ] Endpoint GET /inventory/movements
- [ ] Endpoint GET /products/{id}/kardex
- [ ] Filtros por fecha, tipo, usuario

---

### Issue #31: Transferencias entre Sucursales
**Etiquetas**: `backend`, `inventario`, `multi-bodega`

**Descripción**:
Implementar sistema de transferencias de productos entre sucursales.

**Tareas**:
- [ ] Modelo Transfer
- [ ] Endpoint POST /transfers (crear)
- [ ] Endpoint GET /transfers (listar)
- [ ] Endpoint PATCH /transfers/{id}/approve
- [ ] Endpoint PATCH /transfers/{id}/receive
- [ ] Estados: pendiente, en tránsito, recibido
- [ ] Actualización automática de inventario

---

### Issue #32: Gestión de Bodegas/Sucursales
**Etiquetas**: `backend`, `inventario`

**Descripción**:
Implementar CRUD de bodegas y sucursales.

**Tareas**:
- [ ] Endpoint GET /warehouses
- [ ] Endpoint POST /warehouses
- [ ] Endpoint PUT /warehouses/{id}
- [ ] Endpoint DELETE /warehouses/{id}
- [ ] Asociar usuarios a sucursales

---

### Issue #33: Dashboard de Inventario - Frontend
**Etiquetas**: `frontend`, `inventario`, `dashboard`

**Descripción**:
Crear dashboard de inventario con métricas y alertas.

**Tareas**:
- [ ] Resumen de stock total
- [ ] Alertas de productos bajo mínimo
- [ ] Productos sin stock
- [ ] Movimientos recientes
- [ ] Gráficos de rotación

---

### Issue #34: Gestión de Inventario - Frontend
**Etiquetas**: `frontend`, `inventario`

**Descripción**:
Crear interfaces para gestión de inventario.

**Tareas**:
- [ ] Tabla de inventario por sucursal
- [ ] Formulario de ajuste de inventario
- [ ] Historial de movimientos (kardex)
- [ ] Alertas visuales de stock bajo
- [ ] Vista de transferencias entre sucursales

---

## 📋 ÉPICA 8: Punto de Venta (POS)

### Issue #35: API de Ventas - Backend
**Etiquetas**: `backend`, `ventas`, `pos`

**Descripción**:
Implementar endpoints para registrar ventas.

**Tareas**:
- [ ] Endpoint POST /sales (crear venta)
- [ ] Endpoint GET /sales (listar)
- [ ] Endpoint GET /sales/{id}
- [ ] Cálculo automático de totales
- [ ] Aplicación de impuestos (IVA)
- [ ] Soporte para múltiples métodos de pago
- [ ] Descuentos por item y global

---

### Issue #36: Integración con Inventario en Ventas
**Etiquetas**: `backend`, `ventas`, `inventario`

**Descripción**:
Descontar inventario automáticamente al registrar venta.

**Tareas**:
- [ ] Validar disponibilidad de stock
- [ ] Descontar stock al confirmar venta
- [ ] Registrar movimiento en kardex
- [ ] Manejar ventas fallidas (rollback)
- [ ] Soporte para productos sin control de stock

---

### Issue #37: Interfaz POS - Frontend
**Etiquetas**: `frontend`, `pos`, `prioridad-alta`

**Descripción**:
Crear interfaz de punto de venta optimizada para velocidad.

**Tareas**:
- [ ] Layout tipo POS (productos + carrito)
- [ ] Búsqueda rápida de productos
- [ ] Soporte para lector de código de barras
- [ ] Carrito de compras con acciones rápidas
- [ ] Selector de cliente
- [ ] Calculadora de pago
- [ ] Métodos de pago (efectivo, tarjeta, mixto)
- [ ] Aplicar descuentos

---

### Issue #38: Impresión de Recibos/Facturas
**Etiquetas**: `frontend`, `pos`, `impresión`

**Descripción**:
Implementar sistema de impresión de comprobantes.

**Tareas**:
- [ ] Template de recibo/factura
- [ ] Impresión térmica (POS printer)
- [ ] Vista previa antes de imprimir
- [ ] Opción de envío por email
- [ ] Descarga en PDF

---

### Issue #39: Ventas a Crédito
**Etiquetas**: `backend`, `ventas`, `crédito`

**Descripción**:
Implementar sistema de ventas a crédito con pagos parciales.

**Tareas**:
- [ ] Modelo CreditSale
- [ ] Modelo Payment (pagos parciales)
- [ ] Endpoint POST /sales/credit
- [ ] Endpoint POST /sales/{id}/payments
- [ ] Endpoint GET /sales/credit/pending
- [ ] Cálculo de saldo pendiente
- [ ] Alertas de pagos vencidos

---

### Issue #40: Gestión de Ventas a Crédito - Frontend
**Etiquetas**: `frontend`, `ventas`, `crédito`

**Descripción**:
Crear interfaces para gestión de créditos.

**Tareas**:
- [ ] Lista de ventas a crédito
- [ ] Detalle de venta con historial de pagos
- [ ] Formulario de registro de pago
- [ ] Indicadores de estado (al día, vencido)
- [ ] Filtros y búsqueda

---

## 📋 ÉPICA 9: Cotizaciones

### Issue #41: Sistema de Cotizaciones - Backend
**Etiquetas**: `backend`, `cotizaciones`

**Descripción**:
Implementar sistema completo de cotizaciones.

**Tareas**:
- [ ] Modelo Quote y QuoteItem
- [ ] Endpoint POST /quotes
- [ ] Endpoint GET /quotes
- [ ] Endpoint GET /quotes/{id}
- [ ] Endpoint PUT /quotes/{id}
- [ ] Endpoint POST /quotes/{id}/convert-to-sale
- [ ] Estados: borrador, enviada, aprobada, rechazada
- [ ] Vigencia de cotización

---

### Issue #42: Gestión de Cotizaciones - Frontend
**Etiquetas**: `frontend`, `cotizaciones`

**Descripción**:
Crear interfaces para crear y gestionar cotizaciones.

**Tareas**:
- [ ] Formulario de cotización (similar a POS)
- [ ] Lista de cotizaciones con filtros
- [ ] Vista de detalle de cotización
- [ ] Convertir cotización a venta
- [ ] Enviar cotización por email
- [ ] Imprimir cotización
- [ ] Indicadores de vigencia

---

## 📋 ÉPICA 10: Gestión de Compras

### Issue #43: Gestión de Proveedores - Backend
**Etiquetas**: `backend`, `proveedores`

**Descripción**:
Implementar CRUD de proveedores.

**Tareas**:
- [ ] Endpoint GET /suppliers
- [ ] Endpoint POST /suppliers
- [ ] Endpoint GET /suppliers/{id}
- [ ] Endpoint PUT /suppliers/{id}
- [ ] Endpoint DELETE /suppliers/{id}
- [ ] Información de contacto
- [ ] Términos de pago

---

### Issue #44: Órdenes de Compra - Backend
**Etiquetas**: `backend`, `compras`

**Descripción**:
Implementar sistema de órdenes de compra.

**Tareas**:
- [ ] Modelo PurchaseOrder y PurchaseOrderItem
- [ ] Endpoint POST /purchases/orders
- [ ] Endpoint GET /purchases/orders
- [ ] Endpoint GET /purchases/orders/{id}
- [ ] Endpoint PUT /purchases/orders/{id}
- [ ] Estados: borrador, enviada, recibida, cancelada

---

### Issue #45: Recepción de Compras
**Etiquetas**: `backend`, `compras`, `inventario`

**Descripción**:
Implementar recepción de compras con actualización de inventario.

**Tareas**:
- [ ] Endpoint PATCH /purchases/orders/{id}/receive
- [ ] Incrementar inventario automáticamente
- [ ] Registrar movimiento en kardex
- [ ] Permitir recepción parcial
- [ ] Actualizar costo del producto

---

### Issue #46: Gestión de Compras - Frontend
**Etiquetas**: `frontend`, `compras`
fr
**Descripción**:
Crear interfaces para gestión de compras.

**Tareas**:
- [ ] Lista de proveedores
- [ ] Formulario de orden de compra
- [ ] Lista de órdenes de compra
- [ ] Detalle de orden
- [ ] Formulario de recepción de mercancía
- [ ] Indicadores de estado

---

## 📋 ÉPICA 11: Clientes

### Issue #47: Gestión de Clientes - Backend
**Etiquetas**: `backend`, `clientes`

**Descripción**:
Implementar CRUD completo de clientes.

**Tareas**:
- [ ] Endpoint GET /customers
- [ ] Endpoint POST /customers
- [ ] Endpoint GET /customers/{id}
- [ ] Endpoint PUT /customers/{id}
- [ ] Endpoint DELETE /customers/{id}
- [ ] Búsqueda por documento
- [ ] Historial de compras del cliente

---

### Issue #48: Gestión de Clientes - Frontend
**Etiquetas**: `frontend`, `clientes`

**Descripción**:
Crear interfaces de gestión de clientes.

**Tareas**:
- [ ] Tabla de clientes con filtros
- [ ] Formulario de creación/edición
- [ ] Vista de detalle del cliente
- [ ] Historial de compras
- [ ] Estado de cuenta (si tiene crédito)
- [ ] Búsqueda rápida en POS

---

## 📋 ÉPICA 12: Facturación Electrónica

### Issue #49: Integración con API de Facturación - Backend
**Etiquetas**: `backend`, `facturación`, `integración-api`

**Descripción**:
Integrar API externa de facturación electrónica.

**Tareas**:
- [ ] Seleccionar proveedor de API fiscal
- [ ] Crear cliente HTTP para la API
- [ ] Endpoint POST /invoices/electronic
- [ ] Manejo de errores de la API
- [ ] Sistema de reintentos
- [ ] Guardar respuesta XML/JSON de DIAN
- [ ] Estados: borrador, enviada, aprobada, rechazada

---

### Issue #50: Configuración Fiscal - Backend
**Etiquetas**: `backend`, `facturación`, `configuración`

**Descripción**:
Implementar configuración fiscal por tenant.

**Tareas**:
- [ ] Modelo TenantConfig (datos fiscales)
- [ ] Endpoint PUT /settings/fiscal
- [ ] Resoluciones de facturación
- [ ] Rangos de numeración
- [ ] Tipos de impuestos (IVA, retenciones)
- [ ] Configuración de API fiscal

---

### Issue #51: Notas Crédito y Débito
**Etiquetas**: `backend`, `facturación`

**Descripción**:
Implementar emisión de notas crédito y débito.

**Tareas**:
- [ ] Modelo CreditNote y DebitNote
- [ ] Endpoint POST /invoices/{id}/credit-note
- [ ] Endpoint POST /invoices/{id}/debit-note
- [ ] Validar factura original
- [ ] Ajustar inventario en nota crédito
- [ ] Enviar a DIAN

---

### Issue #52: Gestión de Facturación - Frontend
**Etiquetas**: `frontend`, `facturación`

**Descripción**:
Crear interfaces de gestión de facturación electrónica.

**Tareas**:
- [ ] Lista de facturas electrónicas
- [ ] Detalle de factura con estado DIAN
- [ ] Descargar PDF y XML
- [ ] Reenviar factura
- [ ] Crear nota crédito/débito
- [ ] Configuración fiscal en settings

---

## 📋 ÉPICA 13: Reportes y Analytics

### Issue #53: Reportes de Ventas - Backend
**Etiquetas**: `backend`, `reportes`, `ventas`

**Descripción**:
Implementar endpoints de reportes de ventas.

**Tareas**:
- [ ] Endpoint GET /reports/sales (por período)
- [ ] Endpoint GET /reports/sales/by-product
- [ ] Endpoint GET /reports/sales/by-category
- [ ] Endpoint GET /reports/sales/by-employee
- [ ] Endpoint GET /reports/best-sellers
- [ ] Filtros: fecha, sucursal, usuario
- [ ] Exportación a Excel/CSV

---

### Issue #54: Reportes de Inventario - Backend
**Etiquetas**: `backend`, `reportes`, `inventario`

**Descripción**:
Implementar reportes de inventario.

**Tareas**:
- [ ] Endpoint GET /reports/inventory/stock-levels
- [ ] Endpoint GET /reports/inventory/low-stock
- [ ] Endpoint GET /reports/inventory/movements
- [ ] Endpoint GET /reports/inventory/valuation
- [ ] Endpoint GET /reports/inventory/turnover

---

### Issue #55: Reportes Financieros - Backend
**Etiquetas**: `backend`, `reportes`, `financiero`

**Descripción**:
Implementar reportes financieros y fiscales.

**Tareas**:
- [ ] Endpoint GET /reports/financial/profit-loss
- [ ] Endpoint GET /reports/financial/taxes (IVA)
- [ ] Endpoint GET /reports/financial/payments
- [ ] Endpoint GET /reports/financial/outstanding-credits
- [ ] Exportación contable

---

### Issue #56: Dashboard Principal - Frontend
**Etiquetas**: `frontend`, `dashboard`, `analíticas`

**Descripción**:
Crear dashboard principal con métricas clave.

**Tareas**:
- [ ] KPIs principales (ventas, inventario, clientes)
- [ ] Gráfico de ventas por período
- [ ] Top productos vendidos
- [ ] Alertas importantes
- [ ] Resumen de caja
- [ ] Filtros por fecha y sucursal

---

### Issue #57: Módulo de Reportes - Frontend
**Etiquetas**: `frontend`, `reportes`

**Descripción**:
Crear módulo de reportes con visualizaciones.

**Tareas**:
- [ ] Navegación de reportes
- [ ] Reporte de ventas con gráficos
- [ ] Reporte de inventario
- [ ] Reporte financiero
- [ ] Filtros avanzados
- [ ] Exportar a Excel/PDF
- [ ] Gráficos con Recharts

---

## 📋 ÉPICA 14: Configuración de Empresa

### Issue #58: Configuración General - Backend
**Etiquetas**: `backend`, `configuración`

**Descripción**:
Implementar endpoints de configuración de la ferretería.

**Tareas**:
- [ ] Endpoint GET /settings
- [ ] Endpoint PUT /settings/company
- [ ] Endpoint PUT /settings/billing
- [ ] Endpoint PUT /settings/notifications
- [ ] Endpoint PUT /settings/pos
- [ ] Logo de empresa (Storage)

---

### Issue #59: Configuración General - Frontend
**Etiquetas**: `frontend`, `configuración`

**Descripción**:
Crear pantallas de configuración.

**Tareas**:
- [ ] Datos de la empresa
- [ ] Configuración fiscal
- [ ] Configuración de POS
- [ ] Configuración de notificaciones
- [ ] Upload de logo
- [ ] Gestión de sucursales

---

## 📋 ÉPICA 15: Auditoría y Logs

### Issue #60: Sistema de Auditoría - Backend
**Etiquetas**: `backend`, `auditoría`, `seguridad`

**Descripción**:
Implementar sistema completo de auditoría.

**Tareas**:
- [ ] Modelo AuditLog
- [ ] Middleware de logging automático
- [ ] Registrar: usuario, acción, tabla, cambios
- [ ] Endpoint GET /audit/logs
- [ ] Filtros por usuario, tabla, fecha
- [ ] Retención de logs según plan

---

### Issue #61: Visualización de Logs - Frontend
**Etiquetas**: `frontend`, `auditoría`

**Descripción**:
Crear interfaz de consulta de logs de auditoría.

**Tareas**:
- [ ] Tabla de logs con filtros avanzados
- [ ] Detalle de cambios (antes/después)
- [ ] Filtros por usuario, acción, fecha
- [ ] Exportación de logs

---

## 📋 ÉPICA 16: Notificaciones

### Issue #62: Sistema de Notificaciones - Backend
**Etiquetas**: `backend`, `notificaciones`

**Descripción**:
Implementar sistema de notificaciones internas.

**Tareas**:
- [ ] Modelo Notification
- [ ] Endpoint GET /notifications
- [ ] Endpoint PATCH /notifications/{id}/read
- [ ] Notificaciones de stock bajo
- [ ] Notificaciones de pagos vencidos
- [ ] Notificaciones de límites del plan

---

### Issue #63: Notificaciones - Frontend
**Etiquetas**: `frontend`, `notificaciones`

**Descripción**:
Implementar UI de notificaciones.

**Tareas**:
- [ ] Campana de notificaciones en navbar
- [ ] Lista de notificaciones
- [ ] Marcar como leída
- [ ] Badge con contador
- [ ] Actualización en tiempo real (polling)

---

## 📋 ÉPICA 17: Testing

### Issue #64: Tests Unitarios - Backend
**Etiquetas**: `backend`, `pruebas`

**Descripción**:
Implementar suite de tests unitarios con pytest.

**Tareas**:
- [ ] Configurar pytest
- [ ] Tests de modelos
- [ ] Tests de servicios
- [ ] Tests de endpoints críticos
- [ ] Cobertura mínima 70%

---

### Issue #65: Tests de Integración - Backend
**Etiquetas**: `backend`, `pruebas`, `integración`

**Descripción**:
Implementar tests de integración.

**Tareas**:
- [ ] Tests de flujo completo de venta
- [ ] Tests de flujo de compra
- [ ] Tests de autenticación
- [ ] Tests de multi-tenant
- [ ] Tests de facturación

---

### Issue #66: Tests E2E - Frontend
**Etiquetas**: `frontend`, `pruebas`, `e2e`

**Descripción**:
Implementar tests end-to-end con Playwright o Cypress.

**Tareas**:
- [ ] Configurar herramienta de E2E
- [ ] Tests de flujo de login
- [ ] Tests de flujo POS completo
- [ ] Tests de gestión de productos
- [ ] Tests de reportes

---

## 📋 ÉPICA 18: Optimización y Performance

### Issue #67: Optimización de Queries
**Etiquetas**: `backend`, `rendimiento`, `base-de-datos`

**Descripción**:
Optimizar queries de base de datos para mejor performance.

**Tareas**:
- [ ] Identificar queries lentas
- [ ] Crear índices necesarios
- [ ] Implementar eager loading
- [ ] Optimizar endpoints de reportes
- [ ] Documentar mejoras de performance

---

### Issue #68: Implementar Caché con Redis
**Etiquetas**: `backend`, `rendimiento`, `caché`

**Descripción**:
Implementar sistema de caché para datos frecuentes.

**Tareas**:
- [ ] Configurar Redis
- [ ] Caché de productos
- [ ] Caché de configuración
- [ ] Caché de sesiones
- [ ] Estrategias de invalidación

---

### Issue #69: Optimización Frontend
**Etiquetas**: `frontend`, `rendimiento`

**Descripción**:
Optimizar carga y performance del frontend.

**Tareas**:
- [ ] Code splitting
- [ ] Lazy loading de rutas
- [ ] Optimización de imágenes
- [ ] Implementar service worker (PWA)
- [ ] Medir y mejorar Lighthouse score

---

## 📋 ÉPICA 19: Despliegue y Producción

### Issue #70: Despliegue de Backend
**Etiquetas**: `devops`, `despliegue`, `backend`

**Descripción**:
Configurar despliegue de backend en Railway/Fly.io.

**Tareas**:
- [ ] Seleccionar plataforma
- [ ] Configurar pipeline de deployment
- [ ] Configurar variables de entorno
- [ ] Configurar dominio
- [ ] Configurar SSL
- [ ] Documentar proceso

---

### Issue #71: Despliegue de Frontend
**Etiquetas**: `devops`, `despliegue`, `frontend`

**Descripción**:
Configurar despliegue de frontend en Vercel.

**Tareas**:
- [ ] Conectar repositorio con Vercel
- [ ] Configurar variables de entorno
- [ ] Configurar dominio personalizado
- [ ] Configurar preview deployments
- [ ] Configurar analytics

---

### Issue #72: Backups Automáticos
**Etiquetas**: `devops`, `base-de-datos`, `respaldo`

**Descripción**:
Configurar sistema de backups automáticos de base de datos.

**Tareas**:
- [ ] Configurar backups diarios en Supabase
- [ ] Configurar retención de backups
- [ ] Documentar proceso de restauración
- [ ] Probar restauración de backup

---

### Issue #73: Monitoring y Alertas
**Etiquetas**: `devops`, `monitoreo`

**Descripción**:
Configurar monitoreo y sistema de alertas.

**Tareas**:
- [ ] Configurar Sentry para errores
- [ ] Configurar alertas de uptime
- [ ] Configurar alertas de performance
- [ ] Dashboard de métricas
- [ ] Documentar runbooks

---

## 📋 ÉPICA 20: Documentación

### Issue #74: Documentación de API
**Etiquetas**: `documentación`, `backend`

**Descripción**:
Crear documentación completa de la API.

**Tareas**:
- [ ] Configurar OpenAPI/Swagger
- [ ] Documentar todos los endpoints
- [ ] Ejemplos de uso
- [ ] Códigos de error
- [ ] Guía de autenticación

---

### Issue #75: Documentación de Usuario
**Etiquetas**: `documentación`, `guía-usuario`

**Descripción**:
Crear guías de usuario para cada rol.

**Tareas**:
- [ ] Guía de Super Admin
- [ ] Guía de Administrador
- [ ] Guía de Vendedor (POS)
- [ ] Guía de Inventario
- [ ] Guía de Contador
- [ ] Videos tutoriales (opcional)

---

### Issue #76: Documentación Técnica
**Etiquetas**: `documentación`, `técnico`

**Descripción**:
Crear documentación técnica para desarrolladores.

**Tareas**:
- [ ] Arquitectura del sistema
- [ ] Guía de contribución
- [ ] Convenciones de código
- [ ] Guía de deployment
- [ ] Troubleshooting común

---

## 📋 ÉPICA 21: Features Premium (Futuro)

### Issue #77: Multi-Sucursal Avanzado
**Etiquetas**: `mejora`, `premium`, `multi-bodega`

**Descripción**:
Implementar features avanzados para múltiples sucursales.

**Tareas**:
- [ ] Dashboard consolidado multi-sucursal
- [ ] Transferencias automáticas sugeridas
- [ ] Sincronización de precios
- [ ] Reportes consolidados

---

### Issue #78: Integración Contable
**Etiquetas**: `mejora`, `premium`, `integración`

**Descripción**:
Integrar con software contable (Siigo, Alegra, etc.).

**Tareas**:
- [ ] Seleccionar plataformas a integrar
- [ ] Mapeo de cuentas contables
- [ ] Sincronización automática
- [ ] Logs de integración

---

### Issue #79: App Móvil (React Native)
**Etiquetas**: `mejora`, `móvil`, `futuro`

**Descripción**:
Desarrollar aplicación móvil para iOS y Android.

**Tareas**:
- [ ] Setup de React Native
- [ ] Autenticación
- [ ] POS móvil
- [ ] Consulta de inventario
- [ ] Escaneo de códigos de barras

---

### Issue #80: IA para Predicción de Stock
**Etiquetas**: `mejora`, `ia`, `futuro`

**Descripción**:
Implementar IA para predicción de demanda y sugerencias de compra.

**Tareas**:
- [ ] Análisis de datos históricos
- [ ] Modelo de predicción
- [ ] Alertas de reabastecimiento
- [ ] Sugerencias automáticas de compra

---

## 🏷️ Sistema de Etiquetas Sugerido

```
Prioridad:
- crítico
- prioridad-alta
- prioridad-media
- prioridad-baja

Tipo:
- funcionalidad
- bug
- mejora
- documentación
- pruebas
- refactorización

Módulo:
- autenticación
- productos
- inventario
- ventas
- pos
- compras
- clientes
- proveedores
- facturación
- reportes
- configuración
- auditoría

Área:
- backend
- frontend
- base-de-datos
- devops
- diseño
- integración-api

Estado:
- por-hacer
- en-progreso
- en-revisión
- probando
- hecho
- bloqueado
```

---

## 📊 Resumen de Issues por Épica

| Épica | Cantidad | Prioridad |
|-------|----------|-----------|
| 1. Configuración Inicial | 4 | 🔴 Critical |
| 2. Base de Datos | 6 | 🔴 Critical |
| 3. Autenticación | 5 | 🔴 Critical |
| 4. Gestión Tenants | 4 | 🟡 High |
| 5. Usuarios y Roles | 3 | 🟡 High |
| 6. Productos | 6 | 🟡 High |
| 7. Inventario | 6 | 🟡 High |
| 8. POS | 6 | 🔴 Critical |
| 9. Cotizaciones | 2 | 🟢 Medium |
| 10. Compras | 4 | 🟢 Medium |
| 11. Clientes | 2 | 🟡 High |
| 12. Facturación | 4 | 🟡 High |
| 13. Reportes | 5 | 🟢 Medium |
| 14. Configuración | 2 | 🟢 Medium |
| 15. Auditoría | 2 | 🟢 Medium |
| 16. Notificaciones | 2 | 🔵 Low |
| 17. Testing | 3 | 🟡 High |
| 18. Performance | 3 | 🟢 Medium |
| 19. Despliegue | 4 | 🟡 High |
| 20. Documentación | 3 | 🟢 Medium |
| 21. Features Premium | 4 | 🔵 Future |

**Total: 80 Issues**

---

## 🎯 Roadmap Sugerido por Fases

### Fase 1: MVP Core (Issues críticas)
- Setup inicial (#1-5)
- Modelos de BD (#6-10)
- Autenticación básica (#11-15)
- Productos básicos (#23, #27)
- POS básico (#35-38)
- Inventario básico (#29-30)

### Fase 2: Gestión Completa
- Multi-tenant (#16-19)
- Usuarios completo (#20-22)
- Productos avanzado (#24-28)
- Inventario avanzado (#31-34)
- Clientes (#47-48)

### Fase 3: Ventas y Compras
- Ventas a crédito (#39-40)
- Cotizaciones (#41-42)
- Compras (#43-46)

### Fase 4: Facturación y Reportes
- Facturación electrónica (#49-52)
- Reportes (#53-57)
- Dashboard (#56)

### Fase 5: Calidad y Producción
- Testing (#64-66)
- Optimización (#67-69)
- Despliegue (#70-73)
- Documentación (#74-76)

### Fase 6: Features Premium
- Multi-sucursal avanzado (#77)
- Integraciones (#78)
- App móvil (#79)
- IA (#80)
