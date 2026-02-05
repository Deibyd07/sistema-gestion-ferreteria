
# 📦 Sistema Integral de Gestión para Ferreterías (SaaS)

## 1. Visión General del Proyecto

El proyecto consiste en un **sistema completo de gestión para ferreterías**, diseñado desde el inicio como un **producto vendible (SaaS)**, escalable, multi-empresa y preparado para integrar **facturación electrónica por API**.

### Objetivos clave

- Centralizar operaciones de la ferretería
- Controlar inventarios en tiempo real
- Gestionar ventas, compras y clientes
- Cumplir normativa fiscal (facturación electrónica)
- Soportar múltiples ferreterías (multi-tenant)
- Escalar a múltiples roles, sucursales y planes

---

## 2. Tipos de Usuarios y Roles

### Roles base del sistema

1. **Super Administrador (SaaS)**
2. **Administrador de Ferretería**
3. **Empleado / Vendedor**
4. **Encargado de Inventario / Bodega**
5. **Contador / Área financiera**
6. **Auditor (opcional / futuro)**

Cada rol tiene permisos estrictamente definidos (RBAC).

---

## 3. Requerimientos Funcionales por Rol

---

## 3.1 Super Administrador (SaaS Owner)

### Objetivo

Gestionar el **producto**, clientes (ferreterías) y la operación global del SaaS.

### Funcionalidades

- Gestión de ferreterías (tenants)
  - Crear / suspender / eliminar ferreterías
  - Asignar planes (Free, Pro, Premium)
- Gestión de usuarios globales
- Configuración de planes y límites
  - Usuarios máximos
  - Facturas mensuales
  - Sucursales
- Monitoreo del sistema
  - Uso de recursos
  - Logs globales
- Acceso a métricas
  - Ferreterías activas
  - Facturación total del SaaS

---

## 3.2 Administrador de Ferretería

### Objetivo

Control total de la operación de una ferretería específica.

### Gestión General

- Configuración de datos de la empresa
  - Razón social
  - NIT / RUT
  - Dirección
  - Resoluciones de facturación
- Configuración fiscal
  - Impuestos (IVA, retenciones)
  - Integración API facturación electrónica

### Usuarios y Roles

- Crear / editar / desactivar usuarios
- Asignar roles
- Definir permisos personalizados

### Productos

- Crear / editar / eliminar productos
- Códigos internos y códigos de barras
- Categorías y subcategorías
- Precios:
  - Precio base
  - Precio por volumen
  - Historial de precios

### Inventario

- Control de stock
- Mínimos y alertas
- Inventario por sucursal
- Kardex / movimientos

### Ventas

- Ventas POS
- Ventas a crédito
- Cotizaciones
- Conversión cotización → factura

### Compras

- Registro de proveedores
- Órdenes de compra
- Ingreso de mercancía

### Reportes

- Ventas por período
- Productos más vendidos
- Rentabilidad
- Stock crítico

---

## 3.3 Empleado / Vendedor

### Objetivo

Registrar ventas de forma rápida y segura.

### Funcionalidades

- Acceso al módulo POS
- Búsqueda rápida de productos
- Venta con lector de código de barras
- Aplicación de descuentos (limitados)
- Selección de cliente
- Emisión de factura / recibo

### Restricciones

- No puede eliminar ventas
- No puede modificar precios base
- No accede a reportes financieros globales

---

## 3.4 Encargado de Inventario / Bodega

### Objetivo

Garantizar la disponibilidad correcta de productos.

### Funcionalidades

- Ver stock actual
- Registrar entradas y salidas
- Ajustes de inventario (con motivo)
- Gestión de ubicaciones
- Transferencias entre sucursales
- Alertas de stock bajo

### Restricciones

- No gestiona ventas
- No accede a datos financieros

---

## 3.5 Contador / Área Financiera

### Objetivo

Control fiscal, contable y legal.

### Funcionalidades

- Acceso a facturación electrónica
- Descarga de:
  - Facturas
  - Notas crédito / débito
- Reportes fiscales
  - IVA
  - Ventas por período
- Exportación contable
  - Excel
  - CSV
- Integración con software contable (futuro)

### Restricciones

- No modifica ventas
- No gestiona inventario

---

## 4. Módulos Funcionales del Sistema

### 4.1 Autenticación y Seguridad

- Login con Supabase Auth
- JWT
- Recuperación de contraseña
- 2FA (futuro)
- Control de sesiones

### 4.2 Gestión de Productos

- CRUD completo
- Variantes
- Unidades de medida

### 4.3 Inventario

- Kardex
- Movimientos automáticos por venta/compra
- Auditoría

### 4.4 Ventas y POS

- Interfaz rápida
- Impresión
- Métodos de pago
- Ventas mixtas

### 4.5 Facturación Electrónica

- Integración API externa
- Manejo de errores fiscales
- Reintentos
- Estados fiscales

### 4.6 Reportes

- Dashboard
- Gráficos
- Exportación

---

## 5. Requerimientos No Funcionales

### Escalabilidad

- Multi-tenant
- Separación por tenant_id

### Seguridad

- RBAC
- Logs
- Auditoría

### Performance

- Caché
- Indexación DB

### Usabilidad

- UX tipo POS
- Responsive

### Disponibilidad

- Backups automáticos
- Alta disponibilidad

---

## 6. Preparación para Venta Comercial

### Features Premium

- Multi-sucursal
- Usuarios ilimitados
- Reportes avanzados
- Integración contable

### Diferenciadores

- Simpleza
- Rapidez POS
- Cumplimiento legal

---

## 7. Evolución Futura

- App móvil
- IA para predicción de stock
- Recomendaciones de compra
- Integraciones ERP

---

## 8. Análisis de Tecnologías a Implementar

Este apartado define de manera **profesional y justificada** las tecnologías seleccionadas para el desarrollo del sistema, teniendo en cuenta escalabilidad, costos, mantenibilidad y enfoque SaaS.

---

## 8.1 Arquitectura General

**Arquitectura desacoplada tipo SaaS (Frontend + Backend + Servicios externos)**

- Frontend: Aplicación web moderna (SPA + SSR)
- Backend: API REST
- Base de datos: PostgreSQL gestionado
- Autenticación y storage: Servicio externo (Supabase)
- Integraciones: APIs fiscales y contables

---

## 8.2 Tecnologías de Backend

### Lenguaje y Framework

- **Python 3.11+**
- **FastAPI**

### ORM y Base de Datos

- **PostgreSQL (Supabase)**
- **SQLAlchemy 2.0**
- **Alembic**

### Autenticación y Seguridad

- Supabase Auth (JWT)
- Validación de tokens en FastAPI
- RBAC
- Middlewares de seguridad

### Facturación Electrónica

- Integración vía API REST
- Manejo de colas y reintentos
- Estados fiscales

---

## 8.3 Tecnologías de Frontend

- **Next.js 14**
- **React 18**
- **TypeScript**
- **Tailwind CSS**
- **Shadcn/ui**
- **TanStack Query**
- **TanStack Table**
- **React Hook Form + Zod**

---

## 8.4 Infraestructura y DevOps

- Vercel (frontend)
- Railway / Fly.io / AWS (backend)
- Supabase Cloud
- GitHub Actions
- Sentry

---

## 8.5 Seguridad

- HTTPS
- CORS
- Rate limiting
- Auditoría
- Backups

---

## 8.6 Escalabilidad y Performance

- Redis (futuro)
- Indexación PostgreSQL
- Paginación API
- Optimización POS

---

## 8.7 Integraciones Futuras

- API contable
- Pasarelas de pago
- React Native
- PWA

---

## 9. Conclusión Técnica

La selección tecnológica propuesta garantiza escalabilidad, costos controlados, mantenibilidad y atractivo comercial.
