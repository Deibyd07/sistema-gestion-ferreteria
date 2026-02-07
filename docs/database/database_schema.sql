-- =====================================================
-- SISTEMA DE GESTIÓN DE FERRETERÍA - SCHEMA SQL
-- Versión: 2.0.0 (Español)
-- Base de Datos: PostgreSQL 14+
-- Compatible con: Supabase
-- =====================================================

-- =====================================================
-- CONFIGURACIÓN INICIAL
-- =====================================================

-- Habilitar extensiones necesarias
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "pg_trgm"; -- Para búsquedas de texto similares

-- Crear schema si no existe
CREATE SCHEMA IF NOT EXISTS public;

-- =====================================================
-- TABLAS: GESTIÓN DE EMPRESAS (SAAS)
-- =====================================================

-- Tabla: planes (Planes de suscripción)
CREATE TABLE planes (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    nombre VARCHAR(50) NOT NULL UNIQUE,
    nombre_mostrar VARCHAR(100) NOT NULL,
    descripcion TEXT,
    
    -- Límites del plan
    max_usuarios INTEGER NOT NULL DEFAULT 1,
    max_productos INTEGER NOT NULL DEFAULT 100,
    max_facturas_por_mes INTEGER NOT NULL DEFAULT 50,
    max_bodegas INTEGER NOT NULL DEFAULT 1,
    max_almacenamiento_mb INTEGER NOT NULL DEFAULT 100,
    
    -- Características
    caracteristicas JSONB DEFAULT '[]',
    
    -- Precio
    precio_mensual DECIMAL(10, 2) NOT NULL DEFAULT 0.00,
    precio_anual DECIMAL(10, 2) NOT NULL DEFAULT 0.00,
    
    -- Estado
    activo BOOLEAN NOT NULL DEFAULT true,
    
    -- Metadata
    creado_en TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    actualizado_en TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Tabla: empresas (Ferreterías - Clientes del SaaS)
CREATE TABLE empresas (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    
    -- Información básica
    nombre VARCHAR(200) NOT NULL,
    nombre_legal VARCHAR(200),
    slug VARCHAR(100) NOT NULL UNIQUE,
    
    -- Información fiscal
    nit VARCHAR(50) UNIQUE,
    tipo_identificacion VARCHAR(20),
    
    -- Contacto
    email VARCHAR(255) NOT NULL,
    telefono VARCHAR(50),
    sitio_web VARCHAR(255),
    
    -- Dirección
    direccion TEXT,
    ciudad VARCHAR(100),
    departamento VARCHAR(100),
    pais VARCHAR(2) DEFAULT 'CO',
    codigo_postal VARCHAR(20),
    
    -- Configuración
    moneda VARCHAR(3) DEFAULT 'COP',
    zona_horaria VARCHAR(50) DEFAULT 'America/Bogota',
    idioma VARCHAR(10) DEFAULT 'es-CO',
    
    -- Plan y suscripción
    plan_id UUID REFERENCES planes(id),
    
    -- Logo
    logo_url TEXT,
    
    -- Estado
    estado VARCHAR(20) NOT NULL DEFAULT 'activo',
    activo BOOLEAN NOT NULL DEFAULT true,
    
    -- Configuración personalizada
    configuracion JSONB DEFAULT '{}',
    
    -- Facturación electrónica
    factura_electronica_habilitada BOOLEAN DEFAULT false,
    factura_electronica_config JSONB DEFAULT '{}',
    
    -- Metadata
    creado_en TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    actualizado_en TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    eliminado_en TIMESTAMPTZ
);

-- Tabla: suscripciones (Historial de suscripciones)
CREATE TABLE suscripciones (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    empresa_id UUID NOT NULL REFERENCES empresas(id) ON DELETE CASCADE,
    plan_id UUID NOT NULL REFERENCES planes(id),
    
    -- Período
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE,
    
    -- Estado
    estado VARCHAR(20) NOT NULL DEFAULT 'activo',
    
    -- Precio al momento de la suscripción
    precio_pagado DECIMAL(10, 2),
    ciclo_facturacion VARCHAR(20),
    
    -- Metadata
    creado_en TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    actualizado_en TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- =====================================================
-- TABLAS: USUARIOS Y PERMISOS
-- =====================================================

-- Tabla: usuarios (Usuarios del sistema)
CREATE TABLE usuarios (
    id UUID PRIMARY KEY,
    empresa_id UUID REFERENCES empresas(id) ON DELETE CASCADE,
    
    -- Información personal
    email VARCHAR(255) NOT NULL,
    nombre_completo VARCHAR(200) NOT NULL,
    avatar_url TEXT,
    
    -- Información de contacto
    telefono VARCHAR(50),
    
    -- Estado
    activo BOOLEAN NOT NULL DEFAULT true,
    es_super_admin BOOLEAN NOT NULL DEFAULT false,
    
    -- Preferencias
    preferencias JSONB DEFAULT '{}',
    
    -- Último acceso
    ultimo_ingreso_en TIMESTAMPTZ,
    ultima_actividad_en TIMESTAMPTZ,
    
    -- Metadata
    creado_en TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    actualizado_en TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    eliminado_en TIMESTAMPTZ
);

-- Tabla: roles (Roles del sistema)
CREATE TABLE roles (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    empresa_id UUID REFERENCES empresas(id) ON DELETE CASCADE,
    
    -- Información
    nombre VARCHAR(50) NOT NULL,
    nombre_mostrar VARCHAR(100) NOT NULL,
    descripcion TEXT,
    
    -- Tipo
    es_rol_sistema BOOLEAN NOT NULL DEFAULT false,
    es_personalizado BOOLEAN NOT NULL DEFAULT false,
    
    -- Estado
    activo BOOLEAN NOT NULL DEFAULT true,
    
    -- Metadata
    creado_en TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    actualizado_en TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    
    CONSTRAINT roles_nombre_unico_por_empresa UNIQUE (empresa_id, nombre)
);

-- Tabla: permisos (Permisos granulares)
CREATE TABLE permisos (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    
    -- Identificación
    nombre VARCHAR(100) NOT NULL UNIQUE,
    recurso VARCHAR(50) NOT NULL,
    accion VARCHAR(50) NOT NULL,
    
    -- Información
    nombre_mostrar VARCHAR(100) NOT NULL,
    descripcion TEXT,
    
    -- Agrupación
    categoria VARCHAR(50),
    
    -- Metadata
    creado_en TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    
    CONSTRAINT permisos_recurso_accion_unico UNIQUE (recurso, accion)
);

-- Tabla: permisos_rol (Relación roles-permisos)
CREATE TABLE permisos_rol (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    rol_id UUID NOT NULL REFERENCES roles(id) ON DELETE CASCADE,
    permiso_id UUID NOT NULL REFERENCES permisos(id) ON DELETE CASCADE,
    
    -- Metadata
    creado_en TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    
    CONSTRAINT permisos_rol_unico UNIQUE (rol_id, permiso_id)
);

-- Tabla: roles_usuario (Roles asignados a usuarios)
CREATE TABLE roles_usuario (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    usuario_id UUID NOT NULL REFERENCES usuarios(id) ON DELETE CASCADE,
    rol_id UUID NOT NULL REFERENCES roles(id) ON DELETE CASCADE,
    
    -- Vigencia
    valido_desde DATE,
    valido_hasta DATE,
    
    -- Metadata
    asignado_por UUID REFERENCES usuarios(id),
    asignado_en TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    
    CONSTRAINT roles_usuario_unico UNIQUE (usuario_id, rol_id)
);

-- =====================================================
-- TABLAS: PRODUCTOS
-- =====================================================

-- Tabla: categorias (Categorías de productos)
CREATE TABLE categorias (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    empresa_id UUID NOT NULL REFERENCES empresas(id) ON DELETE CASCADE,
    
    -- Jerarquía
    categoria_padre_id UUID REFERENCES categorias(id) ON DELETE SET NULL,
    
    -- Información
    nombre VARCHAR(100) NOT NULL,
    slug VARCHAR(100) NOT NULL,
    descripcion TEXT,
    
    -- Imagen
    imagen_url TEXT,
    
    -- Orden
    orden INTEGER DEFAULT 0,
    
    -- Estado
    activa BOOLEAN NOT NULL DEFAULT true,
    
    -- Metadata
    creado_en TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    actualizado_en TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    eliminado_en TIMESTAMPTZ,
    
    CONSTRAINT categorias_slug_unico UNIQUE (empresa_id, slug)
);

-- Tabla: marcas (Marcas de productos)
CREATE TABLE marcas (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    empresa_id UUID NOT NULL REFERENCES empresas(id) ON DELETE CASCADE,
    
    -- Información
    nombre VARCHAR(100) NOT NULL,
    slug VARCHAR(100) NOT NULL,
    descripcion TEXT,
    
    -- Imagen
    logo_url TEXT,
    
    -- Estado
    activa BOOLEAN NOT NULL DEFAULT true,
    
    -- Metadata
    creado_en TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    actualizado_en TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    eliminado_en TIMESTAMPTZ,
    
    CONSTRAINT marcas_slug_unico UNIQUE (empresa_id, slug)
);

-- Tabla: unidades (Unidades de medida)
CREATE TABLE unidades (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    empresa_id UUID REFERENCES empresas(id) ON DELETE CASCADE,
    
    -- Información
    nombre VARCHAR(50) NOT NULL,
    abreviatura VARCHAR(10) NOT NULL,
    
    -- Tipo
    tipo_unidad VARCHAR(20),
    
    -- Conversión
    unidad_base_id UUID REFERENCES unidades(id),
    factor_conversion DECIMAL(10, 4),
    
    -- Estado
    es_unidad_sistema BOOLEAN NOT NULL DEFAULT false,
    activa BOOLEAN NOT NULL DEFAULT true,
    
    -- Metadata
    creado_en TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    actualizado_en TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    
    CONSTRAINT unidades_abreviatura_unica UNIQUE (empresa_id, abreviatura)
);

-- Tabla: productos (Productos maestros)
CREATE TABLE productos (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    empresa_id UUID NOT NULL REFERENCES empresas(id) ON DELETE CASCADE,
    
    -- Identificación
    sku VARCHAR(100) NOT NULL,
    codigo_barras VARCHAR(100),
    nombre VARCHAR(200) NOT NULL,
    slug VARCHAR(200) NOT NULL,
    descripcion TEXT,
    
    -- Clasificación
    categoria_id UUID REFERENCES categorias(id) ON DELETE SET NULL,
    marca_id UUID REFERENCES marcas(id) ON DELETE SET NULL,
    unidad_id UUID NOT NULL REFERENCES unidades(id),
    
    -- Precios
    precio_costo DECIMAL(12, 2) NOT NULL DEFAULT 0.00,
    precio_venta DECIMAL(12, 2) NOT NULL DEFAULT 0.00,
    precio_minimo DECIMAL(12, 2),
    precio_mayorista DECIMAL(12, 2),
    cantidad_minima_mayorista INTEGER,
    
    -- Impuestos
    tasa_impuesto DECIMAL(5, 2) DEFAULT 19.00,
    impuesto_incluido BOOLEAN DEFAULT false,
    
    -- Inventario
    controlar_inventario BOOLEAN NOT NULL DEFAULT true,
    stock_minimo INTEGER DEFAULT 0,
    stock_maximo INTEGER,
    
    -- Características
    tiene_variantes BOOLEAN NOT NULL DEFAULT false,
    es_servicio BOOLEAN NOT NULL DEFAULT false,
    
    -- Imágenes
    imagen_url TEXT,
    imagenes JSONB DEFAULT '[]',
    
    -- Atributos adicionales
    atributos JSONB DEFAULT '{}',
    
    -- Estado
    activo BOOLEAN NOT NULL DEFAULT true,
    destacado BOOLEAN NOT NULL DEFAULT false,
    
    -- Metadata
    creado_por UUID REFERENCES usuarios(id),
    creado_en TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    actualizado_en TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    eliminado_en TIMESTAMPTZ,
    
    CONSTRAINT productos_sku_unico UNIQUE (empresa_id, sku),
    CONSTRAINT productos_slug_unico UNIQUE (empresa_id, slug)
);

-- Tabla: variantes_producto (Variantes de productos)
CREATE TABLE variantes_producto (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    empresa_id UUID NOT NULL REFERENCES empresas(id) ON DELETE CASCADE,
    producto_id UUID NOT NULL REFERENCES productos(id) ON DELETE CASCADE,
    
    -- Identificación
    sku VARCHAR(100) NOT NULL,
    codigo_barras VARCHAR(100),
    nombre VARCHAR(200) NOT NULL,
    
    -- Atributos de la variante
    atributos JSONB NOT NULL DEFAULT '{}',
    
    -- Precios
    precio_costo DECIMAL(12, 2),
    precio_venta DECIMAL(12, 2),
    
    -- Imagen
    imagen_url TEXT,
    
    -- Estado
    activa BOOLEAN NOT NULL DEFAULT true,
    
    -- Metadata
    creado_en TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    actualizado_en TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    eliminado_en TIMESTAMPTZ,
    
    CONSTRAINT variantes_sku_unico UNIQUE (empresa_id, sku)
);

-- Tabla: historial_precios (Historial de precios)
CREATE TABLE historial_precios (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    empresa_id UUID NOT NULL REFERENCES empresas(id) ON DELETE CASCADE,
    producto_id UUID NOT NULL REFERENCES productos(id) ON DELETE CASCADE,
    variante_id UUID REFERENCES variantes_producto(id) ON DELETE CASCADE,
    
    -- Precios
    precio_costo DECIMAL(12, 2) NOT NULL,
    precio_venta DECIMAL(12, 2) NOT NULL,
    
    -- Vigencia
    vigente_desde TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    vigente_hasta TIMESTAMPTZ,
    
    -- Motivo
    motivo TEXT,
    
    -- Metadata
    cambiado_por UUID REFERENCES usuarios(id),
    creado_en TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- =====================================================
-- TABLAS: INVENTARIO
-- =====================================================

-- Tabla: bodegas (Bodegas/Sucursales)
CREATE TABLE bodegas (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    empresa_id UUID NOT NULL REFERENCES empresas(id) ON DELETE CASCADE,
    
    -- Información
    nombre VARCHAR(100) NOT NULL,
    codigo VARCHAR(20) NOT NULL,
    descripcion TEXT,
    
    -- Ubicación
    direccion TEXT,
    ciudad VARCHAR(100),
    departamento VARCHAR(100),
    pais VARCHAR(2) DEFAULT 'CO',
    codigo_postal VARCHAR(20),
    
    -- Contacto
    telefono VARCHAR(50),
    email VARCHAR(255),
    usuario_encargado_id UUID REFERENCES usuarios(id),
    
    -- Tipo
    tipo_bodega VARCHAR(20) DEFAULT 'tienda',
    
    -- Estado
    activa BOOLEAN NOT NULL DEFAULT true,
    es_principal BOOLEAN NOT NULL DEFAULT false,
    
    -- Metadata
    creado_en TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    actualizado_en TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    eliminado_en TIMESTAMPTZ,
    
    CONSTRAINT bodegas_codigo_unico UNIQUE (empresa_id, codigo)
);

-- Tabla: inventario (Stock actual por producto y bodega)
CREATE TABLE inventario (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    empresa_id UUID NOT NULL REFERENCES empresas(id) ON DELETE CASCADE,
    bodega_id UUID NOT NULL REFERENCES bodegas(id) ON DELETE CASCADE,
    producto_id UUID NOT NULL REFERENCES productos(id) ON DELETE CASCADE,
    variante_id UUID REFERENCES variantes_producto(id) ON DELETE CASCADE,
    
    -- Cantidades
    cantidad DECIMAL(12, 3) NOT NULL DEFAULT 0.000,
    cantidad_reservada DECIMAL(12, 3) NOT NULL DEFAULT 0.000,
    cantidad_disponible DECIMAL(12, 3) GENERATED ALWAYS AS (cantidad - cantidad_reservada) STORED,
    
    -- Ubicación
    ubicacion VARCHAR(50),
    
    -- Última actualización
    ultimo_conteo_en TIMESTAMPTZ,
    
    -- Metadata
    creado_en TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    actualizado_en TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    
    CONSTRAINT inventario_item_unico UNIQUE (empresa_id, bodega_id, producto_id, variante_id)
);

-- Tabla: movimientos_inventario (Kardex)
CREATE TABLE movimientos_inventario (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    empresa_id UUID NOT NULL REFERENCES empresas(id) ON DELETE CASCADE,
    bodega_id UUID NOT NULL REFERENCES bodegas(id) ON DELETE CASCADE,
    producto_id UUID NOT NULL REFERENCES productos(id) ON DELETE CASCADE,
    variante_id UUID REFERENCES variantes_producto(id) ON DELETE CASCADE,
    
    -- Tipo de movimiento
    tipo_movimiento VARCHAR(20) NOT NULL,
    motivo_movimiento VARCHAR(50) NOT NULL,
    
    -- Cantidad
    cantidad DECIMAL(12, 3) NOT NULL,
    
    -- Balance
    saldo_despues DECIMAL(12, 3) NOT NULL,
    
    -- Costo
    costo_unitario DECIMAL(12, 2),
    
    -- Referencia
    tipo_referencia VARCHAR(50),
    referencia_id UUID,
    numero_referencia VARCHAR(100),
    
    -- Bodega destino (transferencias)
    bodega_destino_id UUID REFERENCES bodegas(id),
    
    -- Notas
    notas TEXT,
    
    -- Metadata
    creado_por UUID REFERENCES usuarios(id),
    creado_en TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Tabla: ajustes_inventario (Ajustes de inventario)
CREATE TABLE ajustes_inventario (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    empresa_id UUID NOT NULL REFERENCES empresas(id) ON DELETE CASCADE,
    bodega_id UUID NOT NULL REFERENCES bodegas(id) ON DELETE CASCADE,
    
    -- Identificación
    numero_ajuste VARCHAR(50) NOT NULL,
    
    -- Tipo
    tipo_ajuste VARCHAR(20) NOT NULL,
    
    -- Descripción
    motivo TEXT NOT NULL,
    notas TEXT,
    
    -- Estado
    estado VARCHAR(20) NOT NULL DEFAULT 'borrador',
    
    -- Totales
    total_items INTEGER DEFAULT 0,
    valor_total DECIMAL(15, 2) DEFAULT 0.00,
    
    -- Metadata
    creado_por UUID NOT NULL REFERENCES usuarios(id),
    aprobado_por UUID REFERENCES usuarios(id),
    creado_en TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    aprobado_en TIMESTAMPTZ,
    
    CONSTRAINT ajustes_numero_unico UNIQUE (empresa_id, numero_ajuste)
);

-- Tabla: items_ajuste_inventario (Ítems de ajuste)
CREATE TABLE items_ajuste_inventario (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    empresa_id UUID NOT NULL REFERENCES empresas(id) ON DELETE CASCADE,
    ajuste_id UUID NOT NULL REFERENCES ajustes_inventario(id) ON DELETE CASCADE,
    producto_id UUID NOT NULL REFERENCES productos(id) ON DELETE CASCADE,
    variante_id UUID REFERENCES variantes_producto(id) ON DELETE CASCADE,
    
    -- Cantidades
    cantidad_sistema DECIMAL(12, 3) NOT NULL,
    cantidad_fisica DECIMAL(12, 3) NOT NULL,
    diferencia DECIMAL(12, 3) GENERATED ALWAYS AS (cantidad_fisica - cantidad_sistema) STORED,
    
    -- Costo
    costo_unitario DECIMAL(12, 2),
    valor_total DECIMAL(15, 2) GENERATED ALWAYS AS ((cantidad_fisica - cantidad_sistema) * costo_unitario) STORED,
    
    -- Notas
    notas TEXT,
    
    -- Metadata
    creado_en TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- =====================================================
-- TABLAS: CLIENTES Y PROVEEDORES
-- =====================================================

-- Tabla: clientes (Clientes)
CREATE TABLE clientes (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    empresa_id UUID NOT NULL REFERENCES empresas(id) ON DELETE CASCADE,
    
    -- Identificación
    codigo_cliente VARCHAR(50) NOT NULL,
    
    -- Información
    tipo_cliente VARCHAR(20) NOT NULL DEFAULT 'individual',
    primer_nombre VARCHAR(100),
    apellido VARCHAR(100),
    nombre_negocio VARCHAR(200),
    
    -- Fiscal
    nit VARCHAR(50),
    tipo_identificacion VARCHAR(20),
    
    -- Contacto
    email VARCHAR(255),
    telefono VARCHAR(50),
    movil VARCHAR(50),
    
    -- Dirección
    direccion TEXT,
    ciudad VARCHAR(100),
    departamento VARCHAR(100),
    pais VARCHAR(2) DEFAULT 'CO',
    codigo_postal VARCHAR(20),
    
    -- Crédito
    limite_credito DECIMAL(12, 2) DEFAULT 0.00,
    dias_credito INTEGER DEFAULT 0,
    saldo_actual DECIMAL(12, 2) DEFAULT 0.00,
    
    -- Categorización
    categoria_cliente VARCHAR(50),
    
    -- Descuentos
    descuento_predeterminado DECIMAL(5, 2) DEFAULT 0.00,
    
    -- Estado
    activo BOOLEAN NOT NULL DEFAULT true,
    
    -- Notas
    notas TEXT,
    
    -- Metadata
    creado_por UUID REFERENCES usuarios(id),
    creado_en TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    actualizado_en TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    eliminado_en TIMESTAMPTZ,
    
    CONSTRAINT clientes_codigo_unico UNIQUE (empresa_id, codigo_cliente)
);

-- Tabla: proveedores (Proveedores)
CREATE TABLE proveedores (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    empresa_id UUID NOT NULL REFERENCES empresas(id) ON DELETE CASCADE,
    
    -- Identificación
    codigo_proveedor VARCHAR(50) NOT NULL,
    
    -- Información
    nombre_negocio VARCHAR(200) NOT NULL,
    nombre_legal VARCHAR(200),
    
    -- Fiscal
    nit VARCHAR(50),
    tipo_identificacion VARCHAR(20),
    
    -- Contacto
    nombre_contacto VARCHAR(200),
    email VARCHAR(255),
    telefono VARCHAR(50),
    movil VARCHAR(50),
    sitio_web VARCHAR(255),
    
    -- Dirección
    direccion TEXT,
    ciudad VARCHAR(100),
    departamento VARCHAR(100),
    pais VARCHAR(2) DEFAULT 'CO',
    codigo_postal VARCHAR(20),
    
    -- Términos
    terminos_pago VARCHAR(100),
    dias_terminos_pago INTEGER DEFAULT 30,
    descuento_predeterminado DECIMAL(5, 2) DEFAULT 0.00,
    
    -- Estado
    activo BOOLEAN NOT NULL DEFAULT true,
    
    -- Calificación
    calificacion DECIMAL(3, 2),
    
    -- Notas
    notas TEXT,
    
    -- Metadata
    creado_por UUID REFERENCES usuarios(id),
    creado_en TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    actualizado_en TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    eliminado_en TIMESTAMPTZ,
    
    CONSTRAINT proveedores_codigo_unico UNIQUE (empresa_id, codigo_proveedor)
);

-- =====================================================
-- TABLAS: VENTAS
-- =====================================================

-- Tabla: metodos_pago (Métodos de pago)
CREATE TABLE metodos_pago (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    empresa_id UUID NOT NULL REFERENCES empresas(id) ON DELETE CASCADE,
    
    -- Información
    nombre VARCHAR(50) NOT NULL,
    codigo VARCHAR(20) NOT NULL,
    descripcion TEXT,
    
    -- Configuración
    requiere_referencia BOOLEAN DEFAULT false,
    es_electronico BOOLEAN DEFAULT false,
    
    -- Comisión
    tiene_comision BOOLEAN DEFAULT false,
    tipo_comision VARCHAR(10),
    valor_comision DECIMAL(10, 2),
    
    -- Estado
    activo BOOLEAN NOT NULL DEFAULT true,
    
    -- Metadata
    creado_en TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    actualizado_en TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    
    CONSTRAINT metodos_pago_codigo_unico UNIQUE (empresa_id, codigo)
);

-- Tabla: ventas (Ventas - cabecera)
CREATE TABLE ventas (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    empresa_id UUID NOT NULL REFERENCES empresas(id) ON DELETE CASCADE,
    bodega_id UUID NOT NULL REFERENCES bodegas(id) ON DELETE RESTRICT,
    cliente_id UUID REFERENCES clientes(id) ON DELETE SET NULL,
    
    -- Identificación
    numero_venta VARCHAR(50) NOT NULL,
    
    -- Tipo
    tipo_venta VARCHAR(20) NOT NULL DEFAULT 'minorista',
    
    -- Fechas
    fecha_venta TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    fecha_vencimiento DATE,
    
    -- Totales
    subtotal DECIMAL(15, 2) NOT NULL DEFAULT 0.00,
    monto_descuento DECIMAL(15, 2) NOT NULL DEFAULT 0.00,
    porcentaje_descuento DECIMAL(5, 2) NOT NULL DEFAULT 0.00,
    monto_impuesto DECIMAL(15, 2) NOT NULL DEFAULT 0.00,
    total DECIMAL(15, 2) NOT NULL DEFAULT 0.00,
    
    -- Pagos
    monto_pagado DECIMAL(15, 2) NOT NULL DEFAULT 0.00,
    saldo DECIMAL(15, 2) GENERATED ALWAYS AS (total - monto_pagado) STORED,
    
    -- Estado
    estado VARCHAR(20) NOT NULL DEFAULT 'completada',
    estado_pago VARCHAR(20) NOT NULL DEFAULT 'pendiente',
    
    -- Facturación
    factura_id UUID,
    
    -- Notas
    notas TEXT,
    notas_internas TEXT,
    
    -- Metadata
    creado_por UUID NOT NULL REFERENCES usuarios(id),
    cancelado_por UUID REFERENCES usuarios(id),
    cancelado_en TIMESTAMPTZ,
    motivo_cancelacion TEXT,
    creado_en TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    actualizado_en TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    
    CONSTRAINT ventas_numero_unico UNIQUE (empresa_id, numero_venta)
);

-- Tabla: items_venta (Ítems de venta)
CREATE TABLE items_venta (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    empresa_id UUID NOT NULL REFERENCES empresas(id) ON DELETE CASCADE,
    venta_id UUID NOT NULL REFERENCES ventas(id) ON DELETE CASCADE,
    producto_id UUID NOT NULL REFERENCES productos(id) ON DELETE RESTRICT,
    variante_id UUID REFERENCES variantes_producto(id) ON DELETE RESTRICT,
    
    -- Cantidad
    cantidad DECIMAL(12, 3) NOT NULL,
    unidad_id UUID NOT NULL REFERENCES unidades(id),
    
    -- Precios
    precio_unitario DECIMAL(12, 2) NOT NULL,
    costo_unitario DECIMAL(12, 2),
    
    -- Descuento
    porcentaje_descuento DECIMAL(5, 2) DEFAULT 0.00,
    monto_descuento DECIMAL(12, 2) DEFAULT 0.00,
    
    -- Impuestos
    tasa_impuesto DECIMAL(5, 2) DEFAULT 19.00,
    monto_impuesto DECIMAL(12, 2) NOT NULL,
    
    -- Totales
    subtotal DECIMAL(15, 2) NOT NULL,
    total DECIMAL(15, 2) NOT NULL,
    
    -- Notas
    notas TEXT,
    
    -- Metadata
    creado_en TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Tabla: pagos_venta (Pagos de ventas)
CREATE TABLE pagos_venta (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    empresa_id UUID NOT NULL REFERENCES empresas(id) ON DELETE CASCADE,
    venta_id UUID NOT NULL REFERENCES ventas(id) ON DELETE CASCADE,
    metodo_pago_id UUID NOT NULL REFERENCES metodos_pago(id) ON DELETE RESTRICT,
    
    -- Monto
    monto DECIMAL(12, 2) NOT NULL,
    
    -- Referencia
    numero_referencia VARCHAR(100),
    
    -- Fechas
    fecha_pago TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    
    -- Notas
    notas TEXT,
    
    -- Metadata
    creado_por UUID NOT NULL REFERENCES usuarios(id),
    creado_en TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Tabla: cotizaciones (Cotizaciones)
CREATE TABLE cotizaciones (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    empresa_id UUID NOT NULL REFERENCES empresas(id) ON DELETE CASCADE,
    bodega_id UUID REFERENCES bodegas(id) ON DELETE SET NULL,
    cliente_id UUID REFERENCES clientes(id) ON DELETE SET NULL,
    
    -- Identificación
    numero_cotizacion VARCHAR(50) NOT NULL,
    
    -- Fechas
    fecha_cotizacion DATE NOT NULL DEFAULT CURRENT_DATE,
    valida_hasta DATE NOT NULL,
    
    -- Totales
    subtotal DECIMAL(15, 2) NOT NULL DEFAULT 0.00,
    monto_descuento DECIMAL(15, 2) NOT NULL DEFAULT 0.00,
    monto_impuesto DECIMAL(15, 2) NOT NULL DEFAULT 0.00,
    total DECIMAL(15, 2) NOT NULL DEFAULT 0.00,
    
    -- Estado
    estado VARCHAR(20) NOT NULL DEFAULT 'borrador',
    
    -- Conversión
    convertida_a_venta_id UUID REFERENCES ventas(id),
    convertida_en TIMESTAMPTZ,
    
    -- Notas
    notas TEXT,
    terminos_y_condiciones TEXT,
    
    -- Metadata
    creado_por UUID NOT NULL REFERENCES usuarios(id),
    creado_en TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    actualizado_en TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    
    CONSTRAINT cotizaciones_numero_unico UNIQUE (empresa_id, numero_cotizacion)
);

-- Tabla: items_cotizacion (Ítems de cotización)
CREATE TABLE items_cotizacion (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    empresa_id UUID NOT NULL REFERENCES empresas(id) ON DELETE CASCADE,
    cotizacion_id UUID NOT NULL REFERENCES cotizaciones(id) ON DELETE CASCADE,
    producto_id UUID NOT NULL REFERENCES productos(id) ON DELETE RESTRICT,
    variante_id UUID REFERENCES variantes_producto(id) ON DELETE RESTRICT,
    
    -- Cantidad
    cantidad DECIMAL(12, 3) NOT NULL,
    unidad_id UUID NOT NULL REFERENCES unidades(id),
    
    -- Precios
    precio_unitario DECIMAL(12, 2) NOT NULL,
    porcentaje_descuento DECIMAL(5, 2) DEFAULT 0.00,
    monto_descuento DECIMAL(12, 2) DEFAULT 0.00,
    tasa_impuesto DECIMAL(5, 2) DEFAULT 19.00,
    monto_impuesto DECIMAL(12, 2) NOT NULL,
    
    -- Totales
    subtotal DECIMAL(15, 2) NOT NULL,
    total DECIMAL(15, 2) NOT NULL,
    
    -- Notas
    notas TEXT,
    
    -- Metadata
    creado_en TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- =====================================================
-- TABLAS: COMPRAS
-- =====================================================

-- Tabla: ordenes_compra (Órdenes de compra)
CREATE TABLE ordenes_compra (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    empresa_id UUID NOT NULL REFERENCES empresas(id) ON DELETE CASCADE,
    bodega_id UUID NOT NULL REFERENCES bodegas(id) ON DELETE RESTRICT,
    proveedor_id UUID NOT NULL REFERENCES proveedores(id) ON DELETE RESTRICT,
    
    -- Identificación
    numero_orden VARCHAR(50) NOT NULL,
    
    -- Fechas
    fecha_orden DATE NOT NULL DEFAULT CURRENT_DATE,
    fecha_entrega_esperada DATE,
    
    -- Totales
    subtotal DECIMAL(15, 2) NOT NULL DEFAULT 0.00,
    monto_descuento DECIMAL(15, 2) NOT NULL DEFAULT 0.00,
    monto_impuesto DECIMAL(15, 2) NOT NULL DEFAULT 0.00,
    total DECIMAL(15, 2) NOT NULL DEFAULT 0.00,
    
    -- Estado
    estado VARCHAR(20) NOT NULL DEFAULT 'borrador',
    
    -- Conversión
    convertida_a_compra_id UUID,
    
    -- Notas
    notas TEXT,
    
    -- Metadata
    creado_por UUID NOT NULL REFERENCES usuarios(id),
    aprobado_por UUID REFERENCES usuarios(id),
    creado_en TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    actualizado_en TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    aprobado_en TIMESTAMPTZ,
    
    CONSTRAINT ordenes_compra_numero_unico UNIQUE (empresa_id, numero_orden)
);

-- Tabla: items_orden_compra (Ítems de orden de compra)
CREATE TABLE items_orden_compra (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    empresa_id UUID NOT NULL REFERENCES empresas(id) ON DELETE CASCADE,
    orden_compra_id UUID NOT NULL REFERENCES ordenes_compra(id) ON DELETE CASCADE,
    producto_id UUID NOT NULL REFERENCES productos(id) ON DELETE RESTRICT,
    variante_id UUID REFERENCES variantes_producto(id) ON DELETE RESTRICT,
    
    -- Cantidad
    cantidad DECIMAL(12, 3) NOT NULL,
    cantidad_recibida DECIMAL(12, 3) DEFAULT 0.000,
    unidad_id UUID NOT NULL REFERENCES unidades(id),
    
    -- Precios
    costo_unitario DECIMAL(12, 2) NOT NULL,
    porcentaje_descuento DECIMAL(5, 2) DEFAULT 0.00,
    monto_descuento DECIMAL(12, 2) DEFAULT 0.00,
    tasa_impuesto DECIMAL(5, 2) DEFAULT 19.00,
    monto_impuesto DECIMAL(12, 2) NOT NULL,
    
    -- Totales
    subtotal DECIMAL(15, 2) NOT NULL,
    total DECIMAL(15, 2) NOT NULL,
    
    -- Notas
    notas TEXT,
    
    -- Metadata
    creado_en TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Tabla: compras (Compras realizadas)
CREATE TABLE compras (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    empresa_id UUID NOT NULL REFERENCES empresas(id) ON DELETE CASCADE,
    bodega_id UUID NOT NULL REFERENCES bodegas(id) ON DELETE RESTRICT,
    proveedor_id UUID NOT NULL REFERENCES proveedores(id) ON DELETE RESTRICT,
    orden_compra_id UUID REFERENCES ordenes_compra(id),
    
    -- Identificación
    numero_compra VARCHAR(50) NOT NULL,
    numero_factura_proveedor VARCHAR(100),
    
    -- Fechas
    fecha_compra DATE NOT NULL DEFAULT CURRENT_DATE,
    fecha_recepcion DATE,
    fecha_vencimiento DATE,
    
    -- Totales
    subtotal DECIMAL(15, 2) NOT NULL DEFAULT 0.00,
    monto_descuento DECIMAL(15, 2) NOT NULL DEFAULT 0.00,
    monto_impuesto DECIMAL(15, 2) NOT NULL DEFAULT 0.00,
    total DECIMAL(15, 2) NOT NULL DEFAULT 0.00,
    
    -- Pagos
    monto_pagado DECIMAL(15, 2) NOT NULL DEFAULT 0.00,
    saldo DECIMAL(15, 2) GENERATED ALWAYS AS (total - monto_pagado) STORED,
    
    -- Estado
    estado VARCHAR(20) NOT NULL DEFAULT 'recibida',
    estado_pago VARCHAR(20) NOT NULL DEFAULT 'pendiente',
    
    -- Notas
    notas TEXT,
    
    -- Metadata
    creado_por UUID NOT NULL REFERENCES usuarios(id),
    creado_en TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    actualizado_en TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    
    CONSTRAINT compras_numero_unico UNIQUE (empresa_id, numero_compra)
);

-- Tabla: items_compra (Ítems de compra)
CREATE TABLE items_compra (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    empresa_id UUID NOT NULL REFERENCES empresas(id) ON DELETE CASCADE,
    compra_id UUID NOT NULL REFERENCES compras(id) ON DELETE CASCADE,
    producto_id UUID NOT NULL REFERENCES productos(id) ON DELETE RESTRICT,
    variante_id UUID REFERENCES variantes_producto(id) ON DELETE RESTRICT,
    
    -- Cantidad
    cantidad DECIMAL(12, 3) NOT NULL,
    unidad_id UUID NOT NULL REFERENCES unidades(id),
    
    -- Costos
    costo_unitario DECIMAL(12, 2) NOT NULL,
    porcentaje_descuento DECIMAL(5, 2) DEFAULT 0.00,
    monto_descuento DECIMAL(12, 2) DEFAULT 0.00,
    tasa_impuesto DECIMAL(5, 2) DEFAULT 19.00,
    monto_impuesto DECIMAL(12, 2) NOT NULL,
    
    -- Totales
    subtotal DECIMAL(15, 2) NOT NULL,
    total DECIMAL(15, 2) NOT NULL,
    
    -- Notas
    notas TEXT,
    
    -- Metadata
    creado_en TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- =====================================================
-- TABLAS: FACTURACIÓN ELECTRÓNICA
-- =====================================================

-- Tabla: facturas (Facturas electrónicas)
CREATE TABLE facturas (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    empresa_id UUID NOT NULL REFERENCES empresas(id) ON DELETE CASCADE,
    venta_id UUID REFERENCES ventas(id) ON DELETE SET NULL,
    cliente_id UUID NOT NULL REFERENCES clientes(id) ON DELETE RESTRICT,
    
    -- Identificación
    numero_factura VARCHAR(50) NOT NULL,
    numero_factura_fiscal VARCHAR(100),
    
    -- Tipo
    tipo_factura VARCHAR(20) NOT NULL DEFAULT 'estandar',
    factura_relacionada_id UUID REFERENCES facturas(id),
    
    -- Fechas
    fecha_factura DATE NOT NULL DEFAULT CURRENT_DATE,
    fecha_vencimiento DATE,
    
    -- Totales
    subtotal DECIMAL(15, 2) NOT NULL DEFAULT 0.00,
    monto_descuento DECIMAL(15, 2) NOT NULL DEFAULT 0.00,
    monto_impuesto DECIMAL(15, 2) NOT NULL DEFAULT 0.00,
    total DECIMAL(15, 2) NOT NULL DEFAULT 0.00,
    
    -- Estado fiscal
    estado_fiscal VARCHAR(20) NOT NULL DEFAULT 'pendiente',
    uuid_fiscal VARCHAR(255),
    clave_fiscal TEXT,
    xml_fiscal TEXT,
    pdf_fiscal_url TEXT,
    
    -- Errores
    error_fiscal TEXT,
    intentos_fiscales INTEGER DEFAULT 0,
    ultimo_intento_fiscal_en TIMESTAMPTZ,
    
    -- Notas
    notas TEXT,
    
    -- Metadata
    creado_por UUID NOT NULL REFERENCES usuarios(id),
    creado_en TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    actualizado_en TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    enviado_a_fiscal_en TIMESTAMPTZ,
    
    CONSTRAINT facturas_numero_unico UNIQUE (empresa_id, numero_factura)
);

-- Tabla: items_factura (Ítems de factura)
CREATE TABLE items_factura (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    empresa_id UUID NOT NULL REFERENCES empresas(id) ON DELETE CASCADE,
    factura_id UUID NOT NULL REFERENCES facturas(id) ON DELETE CASCADE,
    producto_id UUID REFERENCES productos(id) ON DELETE SET NULL,
    
    -- Descripción
    descripcion VARCHAR(500) NOT NULL,
    
    -- Cantidad
    cantidad DECIMAL(12, 3) NOT NULL,
    unidad VARCHAR(20),
    
    -- Precios
    precio_unitario DECIMAL(12, 2) NOT NULL,
    porcentaje_descuento DECIMAL(5, 2) DEFAULT 0.00,
    monto_descuento DECIMAL(12, 2) DEFAULT 0.00,
    tasa_impuesto DECIMAL(5, 2) DEFAULT 19.00,
    monto_impuesto DECIMAL(12, 2) NOT NULL,
    
    -- Totales
    subtotal DECIMAL(15, 2) NOT NULL,
    total DECIMAL(15, 2) NOT NULL,
    
    -- Códigos fiscales
    codigo_producto_fiscal VARCHAR(50),
    
    -- Metadata
    creado_en TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Tabla: logs_factura (Logs de envío fiscal)
CREATE TABLE logs_factura (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    empresa_id UUID NOT NULL REFERENCES empresas(id) ON DELETE CASCADE,
    factura_id UUID NOT NULL REFERENCES facturas(id) ON DELETE CASCADE,
    
    -- Intento
    numero_intento INTEGER NOT NULL,
    
    -- Request
    payload_peticion JSONB,
    url_peticion VARCHAR(500),
    
    -- Response
    estado_respuesta INTEGER,
    cuerpo_respuesta JSONB,
    mensaje_respuesta TEXT,
    
    -- Resultado
    exitoso BOOLEAN NOT NULL,
    mensaje_error TEXT,
    
    -- Timing
    duracion_ms INTEGER,
    
    -- Metadata
    creado_en TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- =====================================================
-- TABLAS: AUDITORÍA Y LOGS
-- =====================================================

-- Tabla: logs_auditoria (Auditoría de acciones)
CREATE TABLE logs_auditoria (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    empresa_id UUID REFERENCES empresas(id) ON DELETE CASCADE,
    
    -- Usuario
    usuario_id UUID REFERENCES usuarios(id) ON DELETE SET NULL,
    email_usuario VARCHAR(255),
    ip_usuario VARCHAR(45),
    
    -- Acción
    accion VARCHAR(50) NOT NULL,
    tipo_recurso VARCHAR(50) NOT NULL,
    recurso_id UUID,
    
    -- Detalles
    descripcion TEXT NOT NULL,
    cambios JSONB,
    
    -- Contexto
    metodo_http VARCHAR(10),
    endpoint_api VARCHAR(255),
    agente_usuario TEXT,
    
    -- Metadata
    creado_en TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- =====================================================
-- ÍNDICES PARA PERFORMANCE
-- =====================================================

-- Índices de empresas y planes
CREATE INDEX idx_empresas_plan ON empresas(plan_id);
CREATE INDEX idx_empresas_activas ON empresas(activo) WHERE eliminado_en IS NULL;
CREATE INDEX idx_suscripciones_empresa ON suscripciones(empresa_id);

-- Índices de usuarios
CREATE INDEX idx_usuarios_empresa ON usuarios(empresa_id);
CREATE INDEX idx_usuarios_email ON usuarios(email);
CREATE INDEX idx_usuarios_activos ON usuarios(activo) WHERE eliminado_en IS NULL;

-- Índices de roles y permisos
CREATE INDEX idx_roles_empresa ON roles(empresa_id);
CREATE INDEX idx_roles_usuario_usuario ON roles_usuario(usuario_id);
CREATE INDEX idx_roles_usuario_rol ON roles_usuario(rol_id);
CREATE INDEX idx_permisos_rol_rol ON permisos_rol(rol_id);

-- Índices de productos
CREATE INDEX idx_productos_empresa ON productos(empresa_id);
CREATE INDEX idx_productos_sku ON productos(empresa_id, sku);
CREATE INDEX idx_productos_codigo_barras ON productos(codigo_barras) WHERE codigo_barras IS NOT NULL;
CREATE INDEX idx_productos_categoria ON productos(categoria_id);
CREATE INDEX idx_productos_marca ON productos(marca_id);
CREATE INDEX idx_productos_activos ON productos(activo) WHERE eliminado_en IS NULL;
CREATE INDEX idx_productos_busqueda ON productos USING gin(to_tsvector('spanish', nombre || ' ' || COALESCE(descripcion, '')));

-- Índices de categorías y marcas
CREATE INDEX idx_categorias_empresa ON categorias(empresa_id);
CREATE INDEX idx_categorias_padre ON categorias(categoria_padre_id);
CREATE INDEX idx_marcas_empresa ON marcas(empresa_id);

-- Índices de inventario
CREATE INDEX idx_inventario_empresa_bodega ON inventario(empresa_id, bodega_id);
CREATE INDEX idx_inventario_producto ON inventario(producto_id);
CREATE INDEX idx_inventario_stock_bajo ON inventario(bodega_id, producto_id) WHERE cantidad_disponible <= 10;

-- Índices de movimientos
CREATE INDEX idx_movimientos_empresa_bodega ON movimientos_inventario(empresa_id, bodega_id);
CREATE INDEX idx_movimientos_producto ON movimientos_inventario(producto_id);
CREATE INDEX idx_movimientos_fecha ON movimientos_inventario(creado_en DESC);
CREATE INDEX idx_movimientos_referencia ON movimientos_inventario(tipo_referencia, referencia_id);

-- Índices de clientes y proveedores
CREATE INDEX idx_clientes_empresa ON clientes(empresa_id);
CREATE INDEX idx_clientes_codigo ON clientes(empresa_id, codigo_cliente);
CREATE INDEX idx_clientes_busqueda ON clientes USING gin(to_tsvector('spanish', 
    COALESCE(primer_nombre, '') || ' ' || COALESCE(apellido, '') || ' ' || COALESCE(nombre_negocio, '')));
CREATE INDEX idx_proveedores_empresa ON proveedores(empresa_id);
CREATE INDEX idx_proveedores_codigo ON proveedores(empresa_id, codigo_proveedor);

-- Índices de ventas
CREATE INDEX idx_ventas_empresa ON ventas(empresa_id);
CREATE INDEX idx_ventas_numero ON ventas(empresa_id, numero_venta);
CREATE INDEX idx_ventas_cliente ON ventas(cliente_id);
CREATE INDEX idx_ventas_bodega ON ventas(bodega_id);
CREATE INDEX idx_ventas_fecha ON ventas(fecha_venta DESC);
CREATE INDEX idx_ventas_estado ON ventas(estado);
CREATE INDEX idx_items_venta_venta ON items_venta(venta_id);
CREATE INDEX idx_items_venta_producto ON items_venta(producto_id);
CREATE INDEX idx_pagos_venta_venta ON pagos_venta(venta_id);

-- Índices de cotizaciones
CREATE INDEX idx_cotizaciones_empresa ON cotizaciones(empresa_id);
CREATE INDEX idx_cotizaciones_cliente ON cotizaciones(cliente_id);
CREATE INDEX idx_cotizaciones_fecha ON cotizaciones(fecha_cotizacion DESC);
CREATE INDEX idx_items_cotizacion_cotizacion ON items_cotizacion(cotizacion_id);

-- Índices de compras
CREATE INDEX idx_compras_empresa ON compras(empresa_id);
CREATE INDEX idx_compras_proveedor ON compras(proveedor_id);
CREATE INDEX idx_compras_fecha ON compras(fecha_compra DESC);
CREATE INDEX idx_items_compra_compra ON items_compra(compra_id);
CREATE INDEX idx_ordenes_compra_empresa ON ordenes_compra(empresa_id);
CREATE INDEX idx_items_orden_compra_orden ON items_orden_compra(orden_compra_id);

-- Índices de facturas
CREATE INDEX idx_facturas_empresa ON facturas(empresa_id);
CREATE INDEX idx_facturas_numero ON facturas(empresa_id, numero_factura);
CREATE INDEX idx_facturas_venta ON facturas(venta_id);
CREATE INDEX idx_facturas_cliente ON facturas(cliente_id);
CREATE INDEX idx_facturas_estado_fiscal ON facturas(estado_fiscal);
CREATE INDEX idx_facturas_fecha ON facturas(fecha_factura DESC);
CREATE INDEX idx_items_factura_factura ON items_factura(factura_id);
CREATE INDEX idx_logs_factura_factura ON logs_factura(factura_id);

-- Índices de auditoría
CREATE INDEX idx_auditoria_empresa ON logs_auditoria(empresa_id);
CREATE INDEX idx_auditoria_usuario ON logs_auditoria(usuario_id);
CREATE INDEX idx_auditoria_recurso ON logs_auditoria(tipo_recurso, recurso_id);
CREATE INDEX idx_auditoria_fecha ON logs_auditoria(creado_en DESC);

-- =====================================================
-- TRIGGERS PARA ACTUALIZADO_EN
-- =====================================================

-- Función para actualizar actualizado_en
CREATE OR REPLACE FUNCTION actualizar_columna_actualizado_en()
RETURNS TRIGGER AS $$
BEGIN
    NEW.actualizado_en = NOW();
    RETURN NEW;
END;
$$ language 'plpgsql';

-- Aplicar trigger a todas las tablas con actualizado_en
CREATE TRIGGER actualizar_planes_actualizado_en BEFORE UPDATE ON planes FOR EACH ROW EXECUTE FUNCTION actualizar_columna_actualizado_en();
CREATE TRIGGER actualizar_empresas_actualizado_en BEFORE UPDATE ON empresas FOR EACH ROW EXECUTE FUNCTION actualizar_columna_actualizado_en();
CREATE TRIGGER actualizar_suscripciones_actualizado_en BEFORE UPDATE ON suscripciones FOR EACH ROW EXECUTE FUNCTION actualizar_columna_actualizado_en();
CREATE TRIGGER actualizar_usuarios_actualizado_en BEFORE UPDATE ON usuarios FOR EACH ROW EXECUTE FUNCTION actualizar_columna_actualizado_en();
CREATE TRIGGER actualizar_roles_actualizado_en BEFORE UPDATE ON roles FOR EACH ROW EXECUTE FUNCTION actualizar_columna_actualizado_en();
CREATE TRIGGER actualizar_categorias_actualizado_en BEFORE UPDATE ON categorias FOR EACH ROW EXECUTE FUNCTION actualizar_columna_actualizado_en();
CREATE TRIGGER actualizar_marcas_actualizado_en BEFORE UPDATE ON marcas FOR EACH ROW EXECUTE FUNCTION actualizar_columna_actualizado_en();
CREATE TRIGGER actualizar_unidades_actualizado_en BEFORE UPDATE ON unidades FOR EACH ROW EXECUTE FUNCTION actualizar_columna_actualizado_en();
CREATE TRIGGER actualizar_productos_actualizado_en BEFORE UPDATE ON productos FOR EACH ROW EXECUTE FUNCTION actualizar_columna_actualizado_en();
CREATE TRIGGER actualizar_variantes_producto_actualizado_en BEFORE UPDATE ON variantes_producto FOR EACH ROW EXECUTE FUNCTION actualizar_columna_actualizado_en();
CREATE TRIGGER actualizar_bodegas_actualizado_en BEFORE UPDATE ON bodegas FOR EACH ROW EXECUTE FUNCTION actualizar_columna_actualizado_en();
CREATE TRIGGER actualizar_inventario_actualizado_en BEFORE UPDATE ON inventario FOR EACH ROW EXECUTE FUNCTION actualizar_columna_actualizado_en();
CREATE TRIGGER actualizar_clientes_actualizado_en BEFORE UPDATE ON clientes FOR EACH ROW EXECUTE FUNCTION actualizar_columna_actualizado_en();
CREATE TRIGGER actualizar_proveedores_actualizado_en BEFORE UPDATE ON proveedores FOR EACH ROW EXECUTE FUNCTION actualizar_columna_actualizado_en();
CREATE TRIGGER actualizar_metodos_pago_actualizado_en BEFORE UPDATE ON metodos_pago FOR EACH ROW EXECUTE FUNCTION actualizar_columna_actualizado_en();
CREATE TRIGGER actualizar_ventas_actualizado_en BEFORE UPDATE ON ventas FOR EACH ROW EXECUTE FUNCTION actualizar_columna_actualizado_en();
CREATE TRIGGER actualizar_cotizaciones_actualizado_en BEFORE UPDATE ON cotizaciones FOR EACH ROW EXECUTE FUNCTION actualizar_columna_actualizado_en();
CREATE TRIGGER actualizar_ordenes_compra_actualizado_en BEFORE UPDATE ON ordenes_compra FOR EACH ROW EXECUTE FUNCTION actualizar_columna_actualizado_en();
CREATE TRIGGER actualizar_compras_actualizado_en BEFORE UPDATE ON compras FOR EACH ROW EXECUTE FUNCTION actualizar_columna_actualizado_en();
CREATE TRIGGER actualizar_facturas_actualizado_en BEFORE UPDATE ON facturas FOR EACH ROW EXECUTE FUNCTION actualizar_columna_actualizado_en();

-- =====================================================
-- COMENTARIOS EN TABLAS
-- =====================================================

COMMENT ON TABLE planes IS 'Planes de suscripción del SaaS';
COMMENT ON TABLE empresas IS 'Ferreterías (clientes del SaaS)';
COMMENT ON TABLE usuarios IS 'Usuarios del sistema integrados con Supabase Auth';
COMMENT ON TABLE roles IS 'Roles del sistema (RBAC)';
COMMENT ON TABLE permisos IS 'Permisos granulares del sistema';
COMMENT ON TABLE productos IS 'Catálogo de productos maestros';
COMMENT ON TABLE inventario IS 'Stock actual por producto y bodega';
COMMENT ON TABLE movimientos_inventario IS 'Kardex - Historial de movimientos';
COMMENT ON TABLE ventas IS 'Ventas realizadas (cabecera)';
COMMENT ON TABLE items_venta IS 'Ítems detallados de cada venta';
COMMENT ON TABLE compras IS 'Compras a proveedores';
COMMENT ON TABLE facturas IS 'Facturas electrónicas';
COMMENT ON TABLE logs_auditoria IS 'Registro de auditoría de acciones importantes';

-- =====================================================
-- FIN DEL SCRIPT
-- =====================================================

-- Script generado para Sistema de Gestión de Ferretería
-- Total de tablas: 42
-- Versión: 2.0.0 (Español)
-- Fecha: 2026-02-05
