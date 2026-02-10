# 🗄️ Diseño Detallado de Base de Datos - Sistema de Gestión de Ferretería

## 📋 Tabla de Contenidos

1. [Análisis de Entidades](#1-análisis-de-entidades)
2. [Decisiones de Diseño](#2-decisiones-de-diseño)
3. [Esquema de Tablas Detallado](#3-esquema-de-tablas-detallado)
4. [Relaciones y Cardinalidad](#4-relaciones-y-cardinalidad)
5. [Índices y Optimización](#5-índices-y-optimización)
6. [Políticas de Seguridad (RLS)](#6-políticas-de-seguridad-rls)
7. [Diagrama ER](#7-diagrama-er)

---

## 1. Análisis de Entidades

### 1.1 Entidades Principales Identificadas

Basado en los requerimientos funcionales, se identificaron las siguientes entidades:

#### **Gestión de Tenants (Multi-tenant SaaS)**
- `tenants` - Ferreterías (clientes del SaaS)
- `plans` - Planes de suscripción (Free, Pro, Premium)
- `tenant_subscriptions` - Suscripciones activas de tenants

#### **Gestión de Usuarios y Permisos**
- `users` - Usuarios del sistema (todos los roles)
- `roles` - Roles predefinidos (Admin, Vendedor, etc.)
- `permissions` - Permisos granulares del sistema
- `role_permissions` - Relación roles-permisos (muchos a muchos)
- `user_roles` - Roles asignados a usuarios

#### **Gestión de Productos**
- `categories` - Categorías de productos
- `brands` - Marcas de productos
- `units` - Unidades de medida (kg, unidad, metro, etc.)
- `products` - Productos maestros
- `product_variants` - Variantes de productos (color, tamaño, etc.)
- `product_prices` - Historial de precios

#### **Gestión de Inventario**
- `warehouses` - Bodegas/Sucursales
- `inventory` - Stock actual por producto y bodega
- `inventory_movements` - Kardex (movimientos de inventario)
- `inventory_adjustments` - Ajustes manuales de inventario

#### **Gestión de Ventas**
- `customers` - Clientes de la ferretería
- `payment_methods` - Métodos de pago (efectivo, tarjeta, etc.)
- `sales` - Ventas (cabecera)
- `sale_items` - Ítems de venta (detalle)
- `sale_payments` - Pagos de una venta (mixtos)
- `quotes` - Cotizaciones
- `quote_items` - Ítems de cotización

#### **Gestión de Compras**
- `suppliers` - Proveedores
- `purchase_orders` - Órdenes de compra
- `purchase_order_items` - Ítems de orden de compra
- `purchases` - Compras realizadas
- `purchase_items` - Ítems de compra

#### **Facturación Electrónica**
- `invoices` - Facturas electrónicas
- `invoice_items` - Ítems de factura
- `invoice_logs` - Logs de intentos de envío a DIAN/SAT

#### **Auditoría y Logs**
- `audit_logs` - Registro de todas las acciones importantes
- `system_logs` - Logs de sistema y errores

---

## 2. Decisiones de Diseño

### 2.1 Multi-tenancy

**Estrategia**: Row-Level Security con columna `tenant_id`

- Cada tabla tiene `tenant_id UUID` referenciando a `tenants`
- Se usarán políticas RLS de Supabase para aislar datos
- Índices compuestos con `tenant_id` para performance

### 2.2 Claves Primarias

**Estrategia**: UUID v4

- Más seguras que INT AUTO_INCREMENT
- Permiten generación distribuida
- No exponen cantidad de registros
- Compatibles con Supabase

### 2.3 Timestamps

**Campos estándar en todas las tablas**:
- `created_at TIMESTAMPTZ` - Fecha de creación
- `updated_at TIMESTAMPTZ` - Última actualización
- `deleted_at TIMESTAMPTZ` - Soft delete (opcional en algunas tablas)

### 2.4 Soft Delete

**Implementado en tablas críticas**:
- Productos, clientes, proveedores
- Usuarios (para historial)
- Ventas, compras (para auditoría)

### 2.5 Precios y Moneda

**Estrategia**: DECIMAL(12, 2)

- `DECIMAL(12, 2)` para precios (hasta 999,999,999.99)
- `DECIMAL(15, 2)` para totales acumulados
- Siempre en la moneda local del tenant

### 2.6 Códigos de Referencia

**Estrategia**: Códigos legibles + UUIDs

- Facturas: `INV-2024-00001`
- Compras: `PUR-2024-00001`
- Cotizaciones: `QUO-2024-00001`
- Generación automática por tenant

### 2.7 Normalización

**Nivel**: 3NF (Tercera Forma Normal)

- Elimina redundancia
- Facilita actualizaciones
- Algunas desnormalizaciones controladas para performance (ej: totales en ventas)

---

## 3. Esquema de Tablas Detallado

### 3.1 Módulo: Gestión de Tenants

#### Tabla: `plans`

Planes de suscripción del SaaS.

```sql
CREATE TABLE plans (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(50) NOT NULL UNIQUE, -- 'Free', 'Pro', 'Premium'
    display_name VARCHAR(100) NOT NULL, -- 'Plan Gratuito', 'Plan Profesional'
    description TEXT,
    
    -- Límites del plan
    max_users INTEGER NOT NULL DEFAULT 1,
    max_products INTEGER NOT NULL DEFAULT 100,
    max_invoices_per_month INTEGER NOT NULL DEFAULT 50,
    max_warehouses INTEGER NOT NULL DEFAULT 1,
    max_storage_mb INTEGER NOT NULL DEFAULT 100, -- Almacenamiento en MB
    
    -- Características
    features JSONB DEFAULT '[]', -- ['multi_warehouse', 'advanced_reports', 'api_access']
    
    -- Precio
    price_monthly DECIMAL(10, 2) NOT NULL DEFAULT 0.00,
    price_yearly DECIMAL(10, 2) NOT NULL DEFAULT 0.00,
    
    -- Estado
    is_active BOOLEAN NOT NULL DEFAULT true,
    
    -- Metadata
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
```

#### Tabla: `tenants`

Ferreterías (clientes del SaaS).

```sql
CREATE TABLE tenants (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    
    -- Información básica
    name VARCHAR(200) NOT NULL, -- Nombre comercial
    legal_name VARCHAR(200), -- Razón social
    slug VARCHAR(100) NOT NULL UNIQUE, -- ferreteria-ejemplo
    
    -- Información fiscal
    tax_id VARCHAR(50) UNIQUE, -- NIT, RUT, RFC
    tax_id_type VARCHAR(20), -- 'NIT', 'RUT', 'RFC'
    
    -- Contacto
    email VARCHAR(255) NOT NULL,
    phone VARCHAR(50),
    website VARCHAR(255),
    
    -- Dirección
    address TEXT,
    city VARCHAR(100),
    state VARCHAR(100),
    country VARCHAR(2) DEFAULT 'CO', -- ISO 3166-1 alpha-2
    postal_code VARCHAR(20),
    
    -- Configuración
    currency VARCHAR(3) DEFAULT 'COP', -- ISO 4217
    timezone VARCHAR(50) DEFAULT 'America/Bogota',
    locale VARCHAR(10) DEFAULT 'es-CO',
    
    -- Plan y suscripción
    plan_id UUID REFERENCES plans(id),
    
    -- Logo
    logo_url TEXT,
    
    -- Estado
    status VARCHAR(20) NOT NULL DEFAULT 'active', -- 'active', 'suspended', 'cancelled'
    is_active BOOLEAN NOT NULL DEFAULT true,
    
    -- Configuración personalizada
    settings JSONB DEFAULT '{}', -- Configuraciones específicas del tenant
    
    -- Facturación electrónica
    electronic_invoice_enabled BOOLEAN DEFAULT false,
    electronic_invoice_config JSONB DEFAULT '{}', -- Credenciales API, certificados, etc.
    
    -- Metadata
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    deleted_at TIMESTAMPTZ
);
```

#### Tabla: `tenant_subscriptions`

Historial de suscripciones de tenants.

```sql
CREATE TABLE tenant_subscriptions (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    tenant_id UUID NOT NULL REFERENCES tenants(id) ON DELETE CASCADE,
    plan_id UUID NOT NULL REFERENCES plans(id),
    
    -- Período
    start_date DATE NOT NULL,
    end_date DATE,
    
    -- Estado
    status VARCHAR(20) NOT NULL DEFAULT 'active', -- 'active', 'cancelled', 'expired'
    
    -- Precio al momento de la suscripción
    price_paid DECIMAL(10, 2),
    billing_cycle VARCHAR(20), -- 'monthly', 'yearly'
    
    -- Metadata
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
```

---

### 3.2 Módulo: Usuarios y Permisos

#### Tabla: `users`

Usuarios del sistema (integración con Supabase Auth).

```sql
CREATE TABLE users (
    id UUID PRIMARY KEY, -- Mismo UUID de Supabase Auth
    tenant_id UUID REFERENCES tenants(id) ON DELETE CASCADE,
    
    -- Información personal
    email VARCHAR(255) NOT NULL,
    full_name VARCHAR(200) NOT NULL,
    avatar_url TEXT,
    
    -- Información de contacto
    phone VARCHAR(50),
    
    -- Estado
    is_active BOOLEAN NOT NULL DEFAULT true,
    is_super_admin BOOLEAN NOT NULL DEFAULT false, -- Super admin del SaaS
    
    -- Preferencias
    preferences JSONB DEFAULT '{}', -- Tema, idioma, notificaciones, etc.
    
    -- Último acceso
    last_login_at TIMESTAMPTZ,
    last_activity_at TIMESTAMPTZ,
    
    -- Metadata
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    deleted_at TIMESTAMPTZ
);
```

#### Tabla: `roles`

Roles del sistema (predefinidos y personalizados).

```sql
CREATE TABLE roles (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    tenant_id UUID REFERENCES tenants(id) ON DELETE CASCADE, -- NULL para roles globales
    
    -- Información
    name VARCHAR(50) NOT NULL, -- 'admin', 'seller', 'warehouse_manager'
    display_name VARCHAR(100) NOT NULL, -- 'Administrador', 'Vendedor'
    description TEXT,
    
    -- Tipo
    is_system_role BOOLEAN NOT NULL DEFAULT false, -- Roles predefinidos del sistema
    is_custom BOOLEAN NOT NULL DEFAULT false, -- Roles personalizados por tenant
    
    -- Estado
    is_active BOOLEAN NOT NULL DEFAULT true,
    
    -- Metadata
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    
    CONSTRAINT unique_role_per_tenant UNIQUE (tenant_id, name)
);
```

#### Tabla: `permissions`

Permisos granulares del sistema.

```sql
CREATE TABLE permissions (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    
    -- Identificación
    name VARCHAR(100) NOT NULL UNIQUE, -- 'products.create', 'sales.delete'
    resource VARCHAR(50) NOT NULL, -- 'products', 'sales', 'users'
    action VARCHAR(50) NOT NULL, -- 'create', 'read', 'update', 'delete', 'list'
    
    -- Información
    display_name VARCHAR(100) NOT NULL,
    description TEXT,
    
    -- Agrupación
    category VARCHAR(50), -- 'inventory', 'sales', 'admin'
    
    -- Metadata
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    
    CONSTRAINT unique_permission UNIQUE (resource, action)
);
```

#### Tabla: `role_permissions`

Relación muchos a muchos entre roles y permisos.

```sql
CREATE TABLE role_permissions (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    role_id UUID NOT NULL REFERENCES roles(id) ON DELETE CASCADE,
    permission_id UUID NOT NULL REFERENCES permissions(id) ON DELETE CASCADE,
    
    -- Metadata
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    
    CONSTRAINT unique_role_permission UNIQUE (role_id, permission_id)
);
```

#### Tabla: `user_roles`

Roles asignados a usuarios.

```sql
CREATE TABLE user_roles (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    role_id UUID NOT NULL REFERENCES roles(id) ON DELETE CASCADE,
    
    -- Vigencia (opcional)
    valid_from DATE,
    valid_until DATE,
    
    -- Metadata
    assigned_by UUID REFERENCES users(id),
    assigned_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    
    CONSTRAINT unique_user_role UNIQUE (user_id, role_id)
);
```

---

### 3.3 Módulo: Productos

#### Tabla: `categories`

Categorías de productos (jerárquicas).

```sql
CREATE TABLE categories (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    tenant_id UUID NOT NULL REFERENCES tenants(id) ON DELETE CASCADE,
    
    -- Jerarquía
    parent_id UUID REFERENCES categories(id) ON DELETE SET NULL,
    
    -- Información
    name VARCHAR(100) NOT NULL,
    slug VARCHAR(100) NOT NULL,
    description TEXT,
    
    -- Imagen
    image_url TEXT,
    
    -- Orden
    sort_order INTEGER DEFAULT 0,
    
    -- Estado
    is_active BOOLEAN NOT NULL DEFAULT true,
    
    -- Metadata
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    deleted_at TIMESTAMPTZ,
    
    CONSTRAINT unique_category_slug UNIQUE (tenant_id, slug)
);
```

#### Tabla: `brands`

Marcas de productos.

```sql
CREATE TABLE brands (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    tenant_id UUID NOT NULL REFERENCES tenants(id) ON DELETE CASCADE,
    
    -- Información
    name VARCHAR(100) NOT NULL,
    slug VARCHAR(100) NOT NULL,
    description TEXT,
    
    -- Imagen
    logo_url TEXT,
    
    -- Estado
    is_active BOOLEAN NOT NULL DEFAULT true,
    
    -- Metadata
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    deleted_at TIMESTAMPTZ,
    
    CONSTRAINT unique_brand_slug UNIQUE (tenant_id, slug)
);
```

#### Tabla: `units`

Unidades de medida.

```sql
CREATE TABLE units (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    tenant_id UUID REFERENCES tenants(id) ON DELETE CASCADE, -- NULL para unidades globales
    
    -- Información
    name VARCHAR(50) NOT NULL, -- 'Kilogramo', 'Unidad', 'Metro'
    abbreviation VARCHAR(10) NOT NULL, -- 'kg', 'un', 'm'
    
    -- Tipo
    unit_type VARCHAR(20), -- 'weight', 'length', 'volume', 'unit'
    
    -- Conversión
    base_unit_id UUID REFERENCES units(id), -- Para conversiones
    conversion_factor DECIMAL(10, 4), -- Factor de conversión a la unidad base
    
    -- Estado
    is_system_unit BOOLEAN NOT NULL DEFAULT false,
    is_active BOOLEAN NOT NULL DEFAULT true,
    
    -- Metadata
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    
    CONSTRAINT unique_unit_abbr UNIQUE (tenant_id, abbreviation)
);
```

#### Tabla: `products`

Productos maestros.

```sql
CREATE TABLE products (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    tenant_id UUID NOT NULL REFERENCES tenants(id) ON DELETE CASCADE,
    
    -- Identificación
    sku VARCHAR(100) NOT NULL, -- Código interno
    barcode VARCHAR(100), -- Código de barras
    name VARCHAR(200) NOT NULL,
    slug VARCHAR(200) NOT NULL,
    description TEXT,
    
    -- Clasificación
    category_id UUID REFERENCES categories(id) ON DELETE SET NULL,
    brand_id UUID REFERENCES brands(id) ON DELETE SET NULL,
    unit_id UUID NOT NULL REFERENCES units(id),
    
    -- Precios
    cost_price DECIMAL(12, 2) NOT NULL DEFAULT 0.00, -- Precio de costo
    sale_price DECIMAL(12, 2) NOT NULL DEFAULT 0.00, -- Precio de venta
    min_price DECIMAL(12, 2), -- Precio mínimo permitido
    wholesale_price DECIMAL(12, 2), -- Precio por mayor
    wholesale_min_qty INTEGER, -- Cantidad mínima para precio por mayor
    
    -- Impuestos
    tax_rate DECIMAL(5, 2) DEFAULT 19.00, -- IVA por defecto en Colombia
    tax_included BOOLEAN DEFAULT false, -- Si el precio incluye impuestos
    
    -- Inventario
    track_inventory BOOLEAN NOT NULL DEFAULT true,
    min_stock INTEGER DEFAULT 0, -- Stock mínimo (alerta)
    max_stock INTEGER, -- Stock máximo
    
    -- Características
    has_variants BOOLEAN NOT NULL DEFAULT false,
    is_service BOOLEAN NOT NULL DEFAULT false, -- Si es servicio (no se controla stock)
    
    -- Imágenes
    image_url TEXT,
    images JSONB DEFAULT '[]', -- Array de URLs de imágenes adicionales
    
    -- Atributos adicionales
    attributes JSONB DEFAULT '{}', -- Peso, dimensiones, color, etc.
    
    -- Estado
    is_active BOOLEAN NOT NULL DEFAULT true,
    is_featured BOOLEAN NOT NULL DEFAULT false,
    
    -- Metadata
    created_by UUID REFERENCES users(id),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    deleted_at TIMESTAMPTZ,
    
    CONSTRAINT unique_product_sku UNIQUE (tenant_id, sku),
    CONSTRAINT unique_product_slug UNIQUE (tenant_id, slug)
);
```

#### Tabla: `product_variants`

Variantes de productos (ej: talla, color).

```sql
CREATE TABLE product_variants (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    tenant_id UUID NOT NULL REFERENCES tenants(id) ON DELETE CASCADE,
    product_id UUID NOT NULL REFERENCES products(id) ON DELETE CASCADE,
    
    -- Identificación
    sku VARCHAR(100) NOT NULL,
    barcode VARCHAR(100),
    name VARCHAR(200) NOT NULL, -- 'Tornillo 1/2" - Dorado'
    
    -- Atributos de la variante
    attributes JSONB NOT NULL DEFAULT '{}', -- {"size": "1/2", "finish": "gold"}
    
    -- Precios (override del producto padre)
    cost_price DECIMAL(12, 2),
    sale_price DECIMAL(12, 2),
    
    -- Imagen específica
    image_url TEXT,
    
    -- Estado
    is_active BOOLEAN NOT NULL DEFAULT true,
    
    -- Metadata
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    deleted_at TIMESTAMPTZ,
    
    CONSTRAINT unique_variant_sku UNIQUE (tenant_id, sku)
);
```

#### Tabla: `product_prices`

Historial de cambios de precios.

```sql
CREATE TABLE product_prices (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    tenant_id UUID NOT NULL REFERENCES tenants(id) ON DELETE CASCADE,
    product_id UUID NOT NULL REFERENCES products(id) ON DELETE CASCADE,
    variant_id UUID REFERENCES product_variants(id) ON DELETE CASCADE,
    
    -- Precios
    cost_price DECIMAL(12, 2) NOT NULL,
    sale_price DECIMAL(12, 2) NOT NULL,
    
    -- Vigencia
    effective_from TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    effective_until TIMESTAMPTZ,
    
    -- Motivo
    reason TEXT,
    
    -- Metadata
    changed_by UUID REFERENCES users(id),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
```

---

### 3.4 Módulo: Inventario

#### Tabla: `warehouses`

Bodegas/Sucursales.

```sql
CREATE TABLE warehouses (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    tenant_id UUID NOT NULL REFERENCES tenants(id) ON DELETE CASCADE,
    
    -- Información
    name VARCHAR(100) NOT NULL,
    code VARCHAR(20) NOT NULL, -- Código corto: 'BOG-01', 'MED-01'
    description TEXT,
    
    -- Ubicación
    address TEXT,
    city VARCHAR(100),
 state VARCHAR(100),
    country VARCHAR(2) DEFAULT 'CO',
    postal_code VARCHAR(20),
    
    -- Contacto
    phone VARCHAR(50),
    email VARCHAR(255),
    manager_user_id UUID REFERENCES users(id),
    
    -- Tipo
    warehouse_type VARCHAR(20) DEFAULT 'store', -- 'store', 'warehouse', 'transit'
    
    -- Estado
    is_active BOOLEAN NOT NULL DEFAULT true,
    is_main BOOLEAN NOT NULL DEFAULT false, -- Bodega principal
    
    -- Metadata
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    deleted_at TIMESTAMPTZ,
    
    CONSTRAINT unique_warehouse_code UNIQUE (tenant_id, code)
);
```

#### Tabla: `inventory`

Stock actual por producto y bodega.

```sql
CREATE TABLE inventory (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    tenant_id UUID NOT NULL REFERENCES tenants(id) ON DELETE CASCADE,
    warehouse_id UUID NOT NULL REFERENCES warehouses(id) ON DELETE CASCADE,
    product_id UUID NOT NULL REFERENCES products(id) ON DELETE CASCADE,
    variant_id UUID REFERENCES product_variants(id) ON DELETE CASCADE,
    
    -- Cantidades
    quantity DECIMAL(12, 3) NOT NULL DEFAULT 0.000, -- Permite decimales para kg, litros, etc.
    reserved_quantity DECIMAL(12, 3) NOT NULL DEFAULT 0.000, -- Cantidad reservada en pedidos
    available_quantity DECIMAL(12, 3) GENERATED ALWAYS AS (quantity - reserved_quantity) STORED,
    
    -- Ubicación en bodega
    location VARCHAR(50), -- Ej: 'A-12-3' (Pasillo-Estante-Nivel)
    
    -- Última actualización
    last_counted_at TIMESTAMPTZ, -- Último conteo físico
    
    -- Metadata
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    
    CONSTRAINT unique_inventory_item UNIQUE (tenant_id, warehouse_id, product_id, variant_id)
);
```

#### Tabla: `inventory_movements`

Kardex - Historial de movimientos de inventario.

```sql
CREATE TABLE inventory_movements (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    tenant_id UUID NOT NULL REFERENCES tenants(id) ON DELETE CASCADE,
    warehouse_id UUID NOT NULL REFERENCES warehouses(id) ON DELETE CASCADE,
    product_id UUID NOT NULL REFERENCES products(id) ON DELETE CASCADE,
    variant_id UUID REFERENCES product_variants(id) ON DELETE CASCADE,
    
    -- Tipo de movimiento
    movement_type VARCHAR(20) NOT NULL, -- 'in', 'out', 'transfer', 'adjustment'
    movement_reason VARCHAR(50) NOT NULL, -- 'sale', 'purchase', 'return', 'damage', 'transfer'
    
    -- Cantidad
    quantity DECIMAL(12, 3) NOT NULL, -- Positivo para entradas, negativo para salidas
    
    -- Balance después del movimiento
    balance_after DECIMAL(12, 3) NOT NULL,
    
    -- Costo unitario al momento del movimiento
    unit_cost DECIMAL(12, 2),
    
    -- Referencia al documento origen
    reference_type VARCHAR(50), -- 'sale', 'purchase', 'transfer', 'adjustment'
    reference_id UUID, -- ID del documento (venta, compra, etc.)
    reference_number VARCHAR(100), -- Número del documento para referencia
    
    -- Bodega destino (para transferencias)
    destination_warehouse_id UUID REFERENCES warehouses(id),
    
    -- Notas
    notes TEXT,
    
    -- Metadata
    created_by UUID REFERENCES users(id),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
```

#### Tabla: `inventory_adjustments`

Ajustes manuales de inventario (conteos físicos, correcciones).

```sql
CREATE TABLE inventory_adjustments (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    tenant_id UUID NOT NULL REFERENCES tenants(id) ON DELETE CASCADE,
    warehouse_id UUID NOT NULL REFERENCES warehouses(id) ON DELETE CASCADE,
    
    -- Identificación
    adjustment_number VARCHAR(50) NOT NULL,
    
    -- Tipo
    adjustment_type VARCHAR(20) NOT NULL, -- 'count', 'damage', 'loss', 'found', 'correction'
    
    -- Descripción
    reason TEXT NOT NULL,
    notes TEXT,
    
    -- Estado
    status VARCHAR(20) NOT NULL DEFAULT 'draft', -- 'draft', 'confirmed', 'cancelled'
    
    -- Totales
    total_items INTEGER DEFAULT 0,
    total_value DECIMAL(15, 2) DEFAULT 0.00,
    
    -- Metadata
    created_by UUID NOT NULL REFERENCES users(id),
    approved_by UUID REFERENCES users(id),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    approved_at TIMESTAMPTZ,
    
    CONSTRAINT unique_adjustment_number UNIQUE (tenant_id, adjustment_number)
);
```

#### Tabla: `inventory_adjustment_items`

Ítems de ajuste de inventario.

```sql
CREATE TABLE inventory_adjustment_items (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    tenant_id UUID NOT NULL REFERENCES tenants(id) ON DELETE CASCADE,
    adjustment_id UUID NOT NULL REFERENCES inventory_adjustments(id) ON DELETE CASCADE,
    product_id UUID NOT NULL REFERENCES products(id) ON DELETE CASCADE,
    variant_id UUID REFERENCES product_variants(id) ON DELETE CASCADE,
    
    -- Cantidades
    system_quantity DECIMAL(12, 3) NOT NULL, -- Cantidad en sistema
    physical_quantity DECIMAL(12, 3) NOT NULL, -- Cantidad contada físicamente
    difference DECIMAL(12, 3) GENERATED ALWAYS AS (physical_quantity - system_quantity) STORED,
    
    -- Costo
    unit_cost DECIMAL(12, 2),
    total_value DECIMAL(15, 2) GENERATED ALWAYS AS ((physical_quantity - system_quantity) * unit_cost) STORED,
    
    -- Notas
    notes TEXT,
    
    -- Metadata
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
```

---

### 3.5 Módulo: Clientes y Proveedores

#### Tabla: `customers`

Clientes de la ferretería.

```sql
CREATE TABLE customers (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    tenant_id UUID NOT NULL REFERENCES tenants(id) ON DELETE CASCADE,
    
    -- Identificación
    customer_code VARCHAR(50) NOT NULL,
    
    -- Información personal/empresarial
    customer_type VARCHAR(20) NOT NULL DEFAULT 'individual', -- 'individual', 'business'
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    business_name VARCHAR(200),
    
    -- Información fiscal
    tax_id VARCHAR(50), -- NIT, Cédula, etc.
    tax_id_type VARCHAR(20),
    
    -- Contacto
    email VARCHAR(255),
    phone VARCHAR(50),
    mobile VARCHAR(50),
    
    -- Dirección
    address TEXT,
    city VARCHAR(100),
    state VARCHAR(100),
    country VARCHAR(2) DEFAULT 'CO',
    postal_code VARCHAR(20),
    
    -- Crédito
    credit_limit DECIMAL(12, 2) DEFAULT 0.00,
    credit_days INTEGER DEFAULT 0, -- Días de crédito
    current_balance DECIMAL(12, 2) DEFAULT 0.00, -- Saldo actual
    
    -- Categorización
    customer_category VARCHAR(50), -- 'retail', 'wholesale', 'vip'
    
    -- Descuentos
    default_discount DECIMAL(5, 2) DEFAULT 0.00, -- Descuento por defecto
    
    -- Estado
    is_active BOOLEAN NOT NULL DEFAULT true,
    
    -- Notas
    notes TEXT,
    
    -- Metadata
    created_by UUID REFERENCES users(id),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    deleted_at TIMESTAMPTZ,
    
    CONSTRAINT unique_customer_code UNIQUE (tenant_id, customer_code)
);
```

#### Tabla: `suppliers`

Proveedores.

```sql
CREATE TABLE suppliers (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    tenant_id UUID NOT NULL REFERENCES tenants(id) ON DELETE CASCADE,
    
    -- Identificación
    supplier_code VARCHAR(50) NOT NULL,
    
    -- Información empresarial
    business_name VARCHAR(200) NOT NULL,
    legal_name VARCHAR(200),
    
    -- Información fiscal
    tax_id VARCHAR(50),
    tax_id_type VARCHAR(20),
    
    -- Contacto principal
    contact_name VARCHAR(200),
    email VARCHAR(255),
    phone VARCHAR(50),
    mobile VARCHAR(50),
    website VARCHAR(255),
    
    -- Dirección
    address TEXT,
    city VARCHAR(100),
    state VARCHAR(100),
    country VARCHAR(2) DEFAULT 'CO',
    postal_code VARCHAR(20),
    
    -- Términos comerciales
    payment_terms VARCHAR(100), -- 'Net 30', 'Net 60'
    payment_terms_days INTEGER DEFAULT 30,
    default_discount DECIMAL(5, 2) DEFAULT 0.00,
    
    -- Estado
    is_active BOOLEAN NOT NULL DEFAULT true,
    
    -- Calificación
    rating DECIMAL(3, 2), -- 0.00 a 5.00
    
    -- Notas
    notes TEXT,
    
    -- Metadata
    created_by UUID REFERENCES users(id),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    deleted_at TIMESTAMPTZ,
    
    CONSTRAINT unique_supplier_code UNIQUE (tenant_id, supplier_code)
);
```

---

### 3.6 Módulo: Ventas

#### Tabla: `payment_methods`

Métodos de pago configurables.

```sql
CREATE TABLE payment_methods (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    tenant_id UUID NOT NULL REFERENCES tenants(id) ON DELETE CASCADE,
    
    -- Información
    name VARCHAR(50) NOT NULL,
    code VARCHAR(20) NOT NULL, -- 'cash', 'card', 'transfer', 'credit'
    description TEXT,
    
    -- Configuración
    requires_reference BOOLEAN DEFAULT false, -- Si requiere número de referencia
    is_electronic BOOLEAN DEFAULT false, -- Si es método electrónico
    
    -- Comisión
    has_fee BOOLEAN DEFAULT false,
    fee_type VARCHAR(10), -- 'percentage', 'fixed'
    fee_value DECIMAL(10, 2),
    
    -- Estado
    is_active BOOLEAN NOT NULL DEFAULT true,
    
    -- Metadata
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    
    CONSTRAINT unique_payment_method_code UNIQUE (tenant_id, code)
);
```

#### Tabla: `sales`

Ventas (cabecera).

```sql
CREATE TABLE sales (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    tenant_id UUID NOT NULL REFERENCES tenants(id) ON DELETE CASCADE,
    warehouse_id UUID NOT NULL REFERENCES warehouses(id) ON DELETE RESTRICT,
    customer_id UUID REFERENCES customers(id) ON DELETE SET NULL,
    
    -- Identificación
    sale_number VARCHAR(50) NOT NULL, -- SAL-2024-00001
    
    -- Tipo
    sale_type VARCHAR(20) NOT NULL DEFAULT 'retail', -- 'retail', 'wholesale', 'credit'
    
    -- Fechas
    sale_date TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    due_date DATE, -- Para ventas a crédito
    
    -- Totales
    subtotal DECIMAL(15, 2) NOT NULL DEFAULT 0.00,
    discount_amount DECIMAL(15, 2) NOT NULL DEFAULT 0.00,
    discount_percentage DECIMAL(5, 2) NOT NULL DEFAULT 0.00,
    tax_amount DECIMAL(15, 2) NOT NULL DEFAULT 0.00,
    total DECIMAL(15, 2) NOT NULL DEFAULT 0.00,
    
    -- Pagos
    paid_amount DECIMAL(15, 2) NOT NULL DEFAULT 0.00,
    balance DECIMAL(15, 2) GENERATED ALWAYS AS (total - paid_amount) STORED,
    
    -- Estado
    status VARCHAR(20) NOT NULL DEFAULT 'completed', -- 'draft', 'completed', 'cancelled', 'refunded'
    payment_status VARCHAR(20) NOT NULL DEFAULT 'pending', -- 'pending', 'partial', 'paid'
    
    -- Facturación
    invoice_id UUID, -- Referencia a factura electrónica
    
    -- Notas
    notes TEXT,
    internal_notes TEXT,
    
    -- Metadata
    created_by UUID NOT NULL REFERENCES users(id),
    cancelled_by UUID REFERENCES users(id),
    cancelled_at TIMESTAMPTZ,
    cancellation_reason TEXT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    
    CONSTRAINT unique_sale_number UNIQUE (tenant_id, sale_number)
);
```

#### Tabla: `sale_items`

Ítems de venta (detalle).

```sql
CREATE TABLE sale_items (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    tenant_id UUID NOT NULL REFERENCES tenants(id) ON DELETE CASCADE,
    sale_id UUID NOT NULL REFERENCES sales(id) ON DELETE CASCADE,
    product_id UUID NOT NULL REFERENCES products(id) ON DELETE RESTRICT,
    variant_id UUID REFERENCES product_variants(id) ON DELETE RESTRICT,
    
    -- Cantidad
    quantity DECIMAL(12, 3) NOT NULL,
    unit_id UUID NOT NULL REFERENCES units(id),
    
    -- Precios
    unit_price DECIMAL(12, 2) NOT NULL, -- Precio unitario al momento de la venta
    unit_cost DECIMAL(12, 2), -- Costo unitario (para calcular utilidad)
    
    -- Descuento
    discount_percentage DECIMAL(5, 2) DEFAULT 0.00,
    discount_amount DECIMAL(12, 2) DEFAULT 0.00,
    
    -- Impuestos
    tax_rate DECIMAL(5, 2) DEFAULT 19.00,
    tax_amount DECIMAL(12, 2) NOT NULL,
    
    -- Totales
    subtotal DECIMAL(15, 2) NOT NULL, -- quantity * unit_price
    total DECIMAL(15, 2) NOT NULL, -- subtotal - discount + tax
    
    -- Notas
    notes TEXT,
    
    -- Metadata
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
```

#### Tabla: `sale_payments`

Pagos de ventas (permite pagos mixtos).

```sql
CREATE TABLE sale_payments (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    tenant_id UUID NOT NULL REFERENCES tenants(id) ON DELETE CASCADE,
    sale_id UUID NOT NULL REFERENCES sales(id) ON DELETE CASCADE,
    payment_method_id UUID NOT NULL REFERENCES payment_methods(id) ON DELETE RESTRICT,
    
    -- Monto
    amount DECIMAL(12, 2) NOT NULL,
    
    -- Referencia
    reference_number VARCHAR(100), -- Número de transacción, cheque, etc.
    
    -- Fechas
    payment_date TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    
    -- Notas
    notes TEXT,
    
    -- Metadata
    created_by UUID NOT NULL REFERENCES users(id),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
```

#### Tabla: `quotes`

Cotizaciones.

```sql
CREATE TABLE quotes (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    tenant_id UUID NOT NULL REFERENCES tenants(id) ON DELETE CASCADE,
    warehouse_id UUID REFERENCES warehouses(id) ON DELETE SET NULL,
    customer_id UUID REFERENCES customers(id) ON DELETE SET NULL,
    
    -- Identificación
    quote_number VARCHAR(50) NOT NULL,
    
    -- Fechas
    quote_date DATE NOT NULL DEFAULT CURRENT_DATE,
    valid_until DATE NOT NULL, -- Fecha de validez
    
    -- Totales
    subtotal DECIMAL(15, 2) NOT NULL DEFAULT 0.00,
    discount_amount DECIMAL(15, 2) NOT NULL DEFAULT 0.00,
    tax_amount DECIMAL(15, 2) NOT NULL DEFAULT 0.00,
    total DECIMAL(15, 2) NOT NULL DEFAULT 0.00,
    
    -- Estado
    status VARCHAR(20) NOT NULL DEFAULT 'draft', -- 'draft', 'sent', 'accepted', 'rejected', 'expired', 'converted'
    
    -- Conversión a venta
    converted_to_sale_id UUID REFERENCES sales(id),
    converted_at TIMESTAMPTZ,
    
    -- Notas
    notes TEXT,
    terms_and_conditions TEXT,
    
    -- Metadata
    created_by UUID NOT NULL REFERENCES users(id),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    
    CONSTRAINT unique_quote_number UNIQUE (tenant_id, quote_number)
);
```

#### Tabla: `quote_items`

Ítems de cotización.

```sql
CREATE TABLE quote_items (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    tenant_id UUID NOT NULL REFERENCES tenants(id) ON DELETE CASCADE,
    quote_id UUID NOT NULL REFERENCES quotes(id) ON DELETE CASCADE,
    product_id UUID NOT NULL REFERENCES products(id) ON DELETE RESTRICT,
    variant_id UUID REFERENCES product_variants(id) ON DELETE RESTRICT,
    
    -- Cantidad
    quantity DECIMAL(12, 3) NOT NULL,
    unit_id UUID NOT NULL REFERENCES units(id),
    
    -- Precios
    unit_price DECIMAL(12, 2) NOT NULL,
    discount_percentage DECIMAL(5, 2) DEFAULT 0.00,
    discount_amount DECIMAL(12, 2) DEFAULT 0.00,
    tax_rate DECIMAL(5, 2) DEFAULT 19.00,
    tax_amount DECIMAL(12, 2) NOT NULL,
    
    -- Totales
    subtotal DECIMAL(15, 2) NOT NULL,
    total DECIMAL(15, 2) NOT NULL,
    
    -- Notas
    notes TEXT,
    
    -- Metadata
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
```

---

### 3.7 Módulo: Compras

#### Tabla: `purchase_orders`

Órdenes de compra.

```sql
CREATE TABLE purchase_orders (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    tenant_id UUID NOT NULL REFERENCES tenants(id) ON DELETE CASCADE,
    warehouse_id UUID NOT NULL REFERENCES warehouses(id) ON DELETE RESTRICT,
    supplier_id UUID NOT NULL REFERENCES suppliers(id) ON DELETE RESTRICT,
    
    -- Identificación
    po_number VARCHAR(50) NOT NULL, -- PO-2024-00001
    
    -- Fechas
    order_date DATE NOT NULL DEFAULT CURRENT_DATE,
    expected_delivery_date DATE,
    
    -- Totales
    subtotal DECIMAL(15, 2) NOT NULL DEFAULT 0.00,
    discount_amount DECIMAL(15, 2) NOT NULL DEFAULT 0.00,
    tax_amount DECIMAL(15, 2) NOT NULL DEFAULT 0.00,
    total DECIMAL(15, 2) NOT NULL DEFAULT 0.00,
    
    -- Estado
    status VARCHAR(20) NOT NULL DEFAULT 'draft', -- 'draft', 'sent', 'confirmed', 'received', 'cancelled'
    
    -- Conversión a compra
    converted_to_purchase_id UUID,
    
    -- Notas
    notes TEXT,
    
    -- Metadata
    created_by UUID NOT NULL REFERENCES users(id),
    approved_by UUID REFERENCES users(id),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    approved_at TIMESTAMPTZ,
    
    CONSTRAINT unique_po_number UNIQUE (tenant_id, po_number)
);
```

#### Tabla: `purchase_order_items`

Ítems de orden de compra.

```sql
CREATE TABLE purchase_order_items (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    tenant_id UUID NOT NULL REFERENCES tenants(id) ON DELETE CASCADE,
    po_id UUID NOT NULL REFERENCES purchase_orders(id) ON DELETE CASCADE,
    product_id UUID NOT NULL REFERENCES products(id) ON DELETE RESTRICT,
    variant_id UUID REFERENCES product_variants(id) ON DELETE RESTRICT,
    
    -- Cantidad
    quantity DECIMAL(12, 3) NOT NULL,
    received_quantity DECIMAL(12, 3) DEFAULT 0.000, -- Cantidad recibida
    unit_id UUID NOT NULL REFERENCES units(id),
    
    -- Precios
    unit_cost DECIMAL(12, 2) NOT NULL,
    discount_percentage DECIMAL(5, 2) DEFAULT 0.00,
    discount_amount DECIMAL(12, 2) DEFAULT 0.00,
    tax_rate DECIMAL(5, 2) DEFAULT 19.00,
    tax_amount DECIMAL(12, 2) NOT NULL,
    
    -- Totales
    subtotal DECIMAL(15, 2) NOT NULL,
    total DECIMAL(15, 2) NOT NULL,
    
    -- Notas
    notes TEXT,
    
    -- Metadata
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
```

#### Tabla: `purchases`

Compras realizadas (ingreso de mercancía).

```sql
CREATE TABLE purchases (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    tenant_id UUID NOT NULL REFERENCES tenants(id) ON DELETE CASCADE,
    warehouse_id UUID NOT NULL REFERENCES warehouses(id) ON DELETE RESTRICT,
    supplier_id UUID NOT NULL REFERENCES suppliers(id) ON DELETE RESTRICT,
    po_id UUID REFERENCES purchase_orders(id), -- Puede ser NULL si es compra directa
    
    -- Identificación
    purchase_number VARCHAR(50) NOT NULL, -- PUR-2024-00001
    supplier_invoice_number VARCHAR(100), -- Número de factura del proveedor
    
    -- Fechas
    purchase_date DATE NOT NULL DEFAULT CURRENT_DATE,
    received_date DATE,
    due_date DATE,
    
    -- Totales
    subtotal DECIMAL(15, 2) NOT NULL DEFAULT 0.00,
    discount_amount DECIMAL(15, 2) NOT NULL DEFAULT 0.00,
    tax_amount DECIMAL(15, 2) NOT NULL DEFAULT 0.00,
    total DECIMAL(15, 2) NOT NULL DEFAULT 0.00,
    
    -- Pagos
    paid_amount DECIMAL(15, 2) NOT NULL DEFAULT 0.00,
    balance DECIMAL(15, 2) GENERATED ALWAYS AS (total - paid_amount) STORED,
    
    -- Estado
    status VARCHAR(20) NOT NULL DEFAULT 'received', -- 'received', 'cancelled'
    payment_status VARCHAR(20) NOT NULL DEFAULT 'pending', -- 'pending', 'partial', 'paid'
    
    -- Notas
    notes TEXT,
    
    -- Metadata
    created_by UUID NOT NULL REFERENCES users(id),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    
    CONSTRAINT unique_purchase_number UNIQUE (tenant_id, purchase_number)
);
```

#### Tabla: `purchase_items`

Ítems de compra.

```sql
CREATE TABLE purchase_items (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    tenant_id UUID NOT NULL REFERENCES tenants(id) ON DELETE CASCADE,
    purchase_id UUID NOT NULL REFERENCES purchases(id) ON DELETE CASCADE,
    product_id UUID NOT NULL REFERENCES products(id) ON DELETE RESTRICT,
    variant_id UUID REFERENCES product_variants(id) ON DELETE RESTRICT,
    
    -- Cantidad
    quantity DECIMAL(12, 3) NOT NULL,
    unit_id UUID NOT NULL REFERENCES units(id),
    
    -- Costos
    unit_cost DECIMAL(12, 2) NOT NULL,
    discount_percentage DECIMAL(5, 2) DEFAULT 0.00,
    discount_amount DECIMAL(12, 2) DEFAULT 0.00,
    tax_rate DECIMAL(5, 2) DEFAULT 19.00,
    tax_amount DECIMAL(12, 2) NOT NULL,
    
    -- Totales
    subtotal DECIMAL(15, 2) NOT NULL,
    total DECIMAL(15, 2) NOT NULL,
    
    -- Notas
    notes TEXT,
    
    -- Metadata
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
```

---

### 3.8 Módulo: Facturación Electrónica

#### Tabla: `invoices`

Facturas electrónicas.

```sql
CREATE TABLE invoices (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    tenant_id UUID NOT NULL REFERENCES tenants(id) ON DELETE CASCADE,
    sale_id UUID REFERENCES sales(id) ON DELETE SET NULL,
    customer_id UUID NOT NULL REFERENCES customers(id) ON DELETE RESTRICT,
    
    -- Identificación
    invoice_number VARCHAR(50) NOT NULL, -- INV-2024-00001
    fiscal_invoice_number VARCHAR(100), -- Número asignado por la DIAN/SAT
    
    -- Tipo
    invoice_type VARCHAR(20) NOT NULL DEFAULT 'standard', -- 'standard', 'credit_note', 'debit_note'
    related_invoice_id UUID REFERENCES invoices(id), -- Para notas crédito/débito
    
    -- Fechas
    invoice_date DATE NOT NULL DEFAULT CURRENT_DATE,
    due_date DATE,
    
    -- Totales
    subtotal DECIMAL(15, 2) NOT NULL DEFAULT 0.00,
    discount_amount DECIMAL(15, 2) NOT NULL DEFAULT 0.00,
    tax_amount DECIMAL(15, 2) NOT NULL DEFAULT 0.00,
    total DECIMAL(15, 2) NOT NULL DEFAULT 0.00,
    
    -- Estado fiscal
    fiscal_status VARCHAR(20) NOT NULL DEFAULT 'pending', -- 'pending', 'sent', 'accepted', 'rejected', 'cancelled'
    fiscal_uuid VARCHAR(255), -- UUID de la factura electrónica (DIAN/SAT)
    fiscal_key TEXT, -- Cadena de sello o clave fiscal
    fiscal_xml TEXT, -- XML de la factura (comprimido o URL)
    fiscal_pdf_url TEXT,
    
    -- Errores
    fiscal_error TEXT,
    fiscal_attempts INTEGER DEFAULT 0,
    last_fiscal_attempt_at TIMESTAMPTZ,
    
    -- Notas
    notes TEXT,
    
    -- Metadata
    created_by UUID NOT NULL REFERENCES users(id),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    sent_to_fiscal_at TIMESTAMPTZ,
    
    CONSTRAINT unique_invoice_number UNIQUE (tenant_id, invoice_number)
);
```

#### Tabla: `invoice_items`

Ítems de factura electrónica.

```sql
CREATE TABLE invoice_items (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    tenant_id UUID NOT NULL REFERENCES tenants(id) ON DELETE CASCADE,
    invoice_id UUID NOT NULL REFERENCES invoices(id) ON DELETE CASCADE,
    product_id UUID REFERENCES products(id) ON DELETE SET NULL,
    
    -- Descripción (puede no estar ligado a un producto)
    description VARCHAR(500) NOT NULL,
    
    -- Cantidad
    quantity DECIMAL(12, 3) NOT NULL,
    unit VARCHAR(20),
    
    -- Precios
    unit_price DECIMAL(12, 2) NOT NULL,
    discount_percentage DECIMAL(5, 2) DEFAULT 0.00,
    discount_amount DECIMAL(12, 2) DEFAULT 0.00,
    tax_rate DECIMAL(5, 2) DEFAULT 19.00,
    tax_amount DECIMAL(12, 2) NOT NULL,
    
    -- Totales
    subtotal DECIMAL(15, 2) NOT NULL,
    total DECIMAL(15, 2) NOT NULL,
    
    -- Códigos fiscales
    fiscal_product_code VARCHAR(50), -- Código de producto según la autoridad fiscal
    
    -- Metadata
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
```

#### Tabla: `invoice_logs`

Logs de intentos de envío a autoridad fiscal.

```sql
CREATE TABLE invoice_logs (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    tenant_id UUID NOT NULL REFERENCES tenants(id) ON DELETE CASCADE,
    invoice_id UUID NOT NULL REFERENCES invoices(id) ON DELETE CASCADE,
    
    -- Intento
    attempt_number INTEGER NOT NULL,
    
    -- Request
    request_payload JSONB,
    request_url VARCHAR(500),
    
    -- Response
    response_status INTEGER, -- HTTP status code
    response_body JSONB,
    response_message TEXT,
    
    -- Resultado
    success BOOLEAN NOT NULL,
    error_message TEXT,
    
    -- Timing
    duration_ms	 INTEGER, -- Duración en milisegundos
    
    -- Metadata
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
```

---

### 3.9 Módulo: Auditoría

#### Tabla: `audit_logs`

Registro de auditoría de acciones importantes.

```sql
CREATE TABLE audit_logs (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    tenant_id UUID REFERENCES tenants(id) ON DELETE CASCADE,
    
    -- Usuario
    user_id UUID REFERENCES users(id) ON DELETE SET NULL,
    user_email VARCHAR(255),
    user_ip VARCHAR(45), -- IPv4 o IPv6
    
    -- Acción
    action VARCHAR(50) NOT NULL, -- 'create', 'update', 'delete', 'login', 'logout'
    resource_type VARCHAR(50) NOT NULL, -- 'product', 'sale', 'user', etc.
    resource_id UUID,
    
    -- Detalles
    description TEXT NOT NULL,
    changes JSONB, -- Antes y después: {"before": {...}, "after": {...}}
    
    -- Contexto
    http_method VARCHAR(10), -- 'GET', 'POST', 'PUT', 'DELETE'
    api_endpoint VARCHAR(255),
    user_agent TEXT,
    
    -- Metadata
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
```

---

## 4. Relaciones y Cardinalidad

### Resumen de Relaciones Principales

```
tenants (1) ----< (*) users
tenants (1) ----< (*) products
tenants (1) ----< (*) sales
tenants (1) ----< (*) purchases

plans (1) ----< (*) tenants

users (*) >----< (*) roles (through user_roles)
roles (*) >----< (*) permissions (through role_permissions)

categories (1) ----< (*) products
categories (1) ----< (*) categories (self-referencing, jerarquía)

products (1) ----< (*) product_variants
products (1) ----< (*) inventory
products (1) ----< (*) sale_items
products (1) ----< (*) purchase_items

sales (1) ----< (*) sale_items
sales (1) ----< (*) sale_payments
sales (1) ----< (0..1) invoices

customers (1) ----< (*) sales
suppliers (1) ----< (*) purchases

warehouses (1) ----< (*) inventory
warehouses (1) ----< (*) inventory_movements
warehouses (1) ----< (*) sales

purchase_orders (1) ----< (0..1) purchases
quotes (1) ----< (0..1) sales

invoices (1) ----< (*) invoice_logs
```

---

## 5. Índices y Optimización

### 5.1 Índices Principales

```sql
-- Índices para multi-tenancy y performance

-- users
CREATE INDEX idx_users_tenant ON users(tenant_id);
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_users_active ON users(is_active) WHERE deleted_at IS NULL;

-- products
CREATE INDEX idx_products_tenant ON products(tenant_id);
CREATE INDEX idx_products_sku ON products(tenant_id, sku);
CREATE INDEX idx_products_barcode ON products(barcode) WHERE barcode IS NOT NULL;
CREATE INDEX idx_products_category ON products(category_id);
CREATE INDEX idx_products_brand ON products(brand_id);
CREATE INDEX idx_products_active ON products(is_active) WHERE deleted_at IS NULL;

-- inventory
CREATE INDEX idx_inventory_tenant_warehouse ON inventory(tenant_id, warehouse_id);
CREATE INDEX idx_inventory_product ON inventory(product_id);
CREATE INDEX idx_inventory_low_stock ON inventory(warehouse_id, product_id) WHERE available_quantity <= 10;

-- inventory_movements
CREATE INDEX idx_movements_tenant_warehouse ON inventory_movements(tenant_id, warehouse_id);
CREATE INDEX idx_movements_product ON inventory_movements(product_id);
CREATE INDEX idx_movements_date ON inventory_movements(created_at DESC);
CREATE INDEX idx_movements_reference ON inventory_movements(reference_type, reference_id);

-- sales
CREATE INDEX idx_sales_tenant ON sales(tenant_id);
CREATE INDEX idx_sales_number ON sales(tenant_id, sale_number);
CREATE INDEX idx_sales_customer ON sales(customer_id);
CREATE INDEX idx_sales_warehouse ON sales(warehouse_id);
CREATE INDEX idx_sales_date ON sales(sale_date DESC);
CREATE INDEX idx_sales_status ON sales(status);

-- sale_items
CREATE INDEX idx_sale_items_sale ON sale_items(sale_id);
CREATE INDEX idx_sale_items_product ON sale_items(product_id);

-- purchases
CREATE INDEX idx_purchases_tenant ON purchases(tenant_id);
CREATE INDEX idx_purchases_supplier ON purchases(supplier_id);
CREATE INDEX idx_purchases_date ON purchases(purchase_date DESC);

-- invoices
CREATE INDEX idx_invoices_tenant ON invoices(tenant_id);
CREATE INDEX idx_invoices_number ON invoices(tenant_id, invoice_number);
CREATE INDEX idx_invoices_fiscal_status ON invoices(fiscal_status);
CREATE INDEX idx_invoices_date ON invoices(invoice_date DESC);

-- audit_logs
CREATE INDEX idx_audit_tenant ON audit_logs(tenant_id);
CREATE INDEX idx_audit_user ON audit_logs(user_id);
CREATE INDEX idx_audit_resource ON audit_logs(resource_type, resource_id);
CREATE INDEX idx_audit_date ON audit_logs(created_at DESC);
```

### 5.2 Índices Full-Text Search

```sql
-- Búsqueda de productos
CREATE INDEX idx_products_search ON products 
USING gin(to_tsvector('spanish', name || ' ' || COALESCE(description, '')));

-- Búsqueda de clientes
CREATE INDEX idx_customers_search ON customers 
USING gin(to_tsvector('spanish', 
    COALESCE(first_name, '') || ' ' || 
    COALESCE(last_name, '') || ' ' || 
    COALESCE(business_name, '')
));
```

---

## 6. Políticas de Seguridad (RLS)

### 6.1 Habilitación de RLS

Todas las tablas multi-tenant deben tener RLS habilitado:

```sql
-- Ejemplo: Habilitar RLS en tabla products
ALTER TABLE products ENABLE ROW LEVEL SECURITY;

-- Política para lectura (usuarios del mismo tenant)
CREATE POLICY tenant_isolation_select_products ON products
    FOR SELECT
    USING (tenant_id = current_setting('app.current_tenant_id')::UUID);

-- Política para insert
CREATE POLICY tenant_isolation_insert_products ON products
    FOR INSERT
    WITH CHECK (tenant_id = current_setting('app.current_tenant_id')::UUID);

-- Política para update
CREATE POLICY tenant_isolation_update_products ON products
    FOR UPDATE
    USING (tenant_id = current_setting('app.current_tenant_id')::UUID);

-- Política para delete
CREATE POLICY tenant_isolation_delete_products ON products
    FOR DELETE
    USING (tenant_id = current_setting('app.current_tenant_id')::UUID);
```

### 6.2 Super Admin Bypass

Los super admins pueden acceder a todos los tenants:

```sql
-- Política adicional para super admins
CREATE POLICY super_admin_all_access_products ON products
    USING (
        EXISTS (
            SELECT 1 FROM users
            WHERE id = auth.uid()
            AND is_super_admin = true
        )
    );
```

### 6.3 Context Setting

El backend debe configurar el tenant actual antes de cada query:

```sql
-- En cada request, establecer el tenant del usuario
SET LOCAL app.current_tenant_id = '<tenant-uuid>';
```

---

## 7. Diagrama ER

El diagrama ER completo se encuentra en el archivo `DATABASE_DIAGRAM.md` y se puede visualizar usando Mermaid.

### Principales Áreas del Diagrama

1. **Gestión de Tenants**: plans → tenants → tenant_subscriptions
2. **Usuarios**: users ← user_roles → roles ← role_permissions → permissions
3. **Productos**: categories → products → product_variants, brands, units
4. **Inventario**: warehouses → inventory → inventory_movements
5. **Ventas**: customers → sales → sale_items, sale_payments, quotes
6. **Compras**: suppliers → purchase_orders → purchases → purchase_items
7. **Facturación**: invoices → invoice_items, invoice_logs
8. **Auditoría**: audit_logs

---

## 📊 Estadísticas del Diseño

- **Total de tablas**: 42
- **Tablas multi-tenant**: 35
- **Tablas globales**: 7 (plans, permissions, roles del sistema, units globales)
- **Relaciones 1:N**: 58
- **Relaciones N:M**: 2 (user_roles, role_permissions)
- **Índices principales**: 35+
- **Campos de auditoría**: created_at, updated_at en todas las tablas

---

## 🎯 Próximos Pasos

1. Revisar y validar el diseño
2. Crear script SQL de generación (`database_schema.sql`)
3. Crear migraciones de Alembic
4. Configurar políticas RLS en Supabase
5. Implementar modelos SQLAlchemy
6. Crear seeds de datos iniciales (planes, roles, permisos, unidades)
