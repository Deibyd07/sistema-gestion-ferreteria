-- =====================================================
-- ROW LEVEL SECURITY (RLS) - MULTI-TENANT
-- Sistema de Gestión de Ferretería
-- =====================================================
-- Este script configura Row Level Security para aislar
-- datos entre diferentes empresas (multi-tenant)
-- =====================================================

-- =====================================================
-- FUNCIONES AUXILIARES: Obtener datos del JWT
-- =====================================================
-- NOTA: Las creamos en el schema PUBLIC porque 
-- no tenemos permisos para modificar el schema AUTH

-- Esta función extrae el empresa_id del JWT token de Supabase
CREATE OR REPLACE FUNCTION public.obtener_empresa_id()
RETURNS UUID
LANGUAGE sql STABLE
SECURITY DEFINER
AS $$
  SELECT COALESCE(
    NULLIF(current_setting('request.jwt.claims', true)::json->>'empresa_id', '')::uuid,
    NULL
  );
$$;

-- Esta función verifica si el usuario es Super Admin
CREATE OR REPLACE FUNCTION public.es_super_admin()
RETURNS BOOLEAN
LANGUAGE sql STABLE
SECURITY DEFINER
AS $$
  SELECT COALESCE(
    (current_setting('request.jwt.claims', true)::json->>'role') = 'super_admin',
    false
  );
$$;

-- Esta función obtiene el rol del usuario actual
CREATE OR REPLACE FUNCTION public.obtener_rol_usuario()
RETURNS TEXT
LANGUAGE sql STABLE
SECURITY DEFINER
AS $$
  SELECT COALESCE(
    current_setting('request.jwt.claims', true)::json->>'role',
    'invitado'
  );
$$;

-- Esta función obtiene el user_id de Supabase Auth (usa la función nativa)
CREATE OR REPLACE FUNCTION public.obtener_user_id()
RETURNS UUID
LANGUAGE sql STABLE
SECURITY DEFINER
AS $$
  SELECT auth.uid();
$$;


-- =====================================================
-- HABILITAR RLS EN TODAS LAS TABLAS
-- =====================================================

-- Tablas de gestión SaaS
ALTER TABLE planes ENABLE ROW LEVEL SECURITY;
ALTER TABLE empresas ENABLE ROW LEVEL SECURITY;
ALTER TABLE suscripciones ENABLE ROW LEVEL SECURITY;

-- Tablas de usuarios y permisos
ALTER TABLE usuarios ENABLE ROW LEVEL SECURITY;
ALTER TABLE roles ENABLE ROW LEVEL SECURITY;
ALTER TABLE permisos ENABLE ROW LEVEL SECURITY;
ALTER TABLE permisos_rol ENABLE ROW LEVEL SECURITY;
ALTER TABLE roles_usuario ENABLE ROW LEVEL SECURITY;

-- Tablas de productos
ALTER TABLE categorias ENABLE ROW LEVEL SECURITY;
ALTER TABLE marcas ENABLE ROW LEVEL SECURITY;
ALTER TABLE unidades ENABLE ROW LEVEL SECURITY;
ALTER TABLE productos ENABLE ROW LEVEL SECURITY;
ALTER TABLE variantes_producto ENABLE ROW LEVEL SECURITY;
ALTER TABLE historial_precios ENABLE ROW LEVEL SECURITY;

-- Tablas de inventario
ALTER TABLE bodegas ENABLE ROW LEVEL SECURITY;
ALTER TABLE inventario ENABLE ROW LEVEL SECURITY;
ALTER TABLE movimientos_inventario ENABLE ROW LEVEL SECURITY;
ALTER TABLE ajustes_inventario ENABLE ROW LEVEL SECURITY;
ALTER TABLE items_ajuste_inventario ENABLE ROW LEVEL SECURITY;

-- Tablas de clientes y proveedores
ALTER TABLE clientes ENABLE ROW LEVEL SECURITY;
ALTER TABLE proveedores ENABLE ROW LEVEL SECURITY;

-- Tablas de ventas y compras
ALTER TABLE metodos_pago ENABLE ROW LEVEL SECURITY;
ALTER TABLE ventas ENABLE ROW LEVEL SECURITY;
ALTER TABLE items_venta ENABLE ROW LEVEL SECURITY;
ALTER TABLE pagos_venta ENABLE ROW LEVEL SECURITY;
ALTER TABLE cotizaciones ENABLE ROW LEVEL SECURITY;
ALTER TABLE items_cotizacion ENABLE ROW LEVEL SECURITY;
ALTER TABLE ordenes_compra ENABLE ROW LEVEL SECURITY;
ALTER TABLE items_orden_compra ENABLE ROW LEVEL SECURITY;
ALTER TABLE compras ENABLE ROW LEVEL SECURITY;
ALTER TABLE items_compra ENABLE ROW LEVEL SECURITY;

-- Tablas de facturación
ALTER TABLE facturas ENABLE ROW LEVEL SECURITY;
ALTER TABLE items_factura ENABLE ROW LEVEL SECURITY;
ALTER TABLE logs_factura ENABLE ROW LEVEL SECURITY;

-- Tablas de auditoría
ALTER TABLE logs_auditoria ENABLE ROW LEVEL SECURITY;


-- =====================================================
-- POLÍTICAS: PLANES (Públicas para todos)
-- =====================================================

-- Los planes son públicos para lectura (para mostrar opciones)
CREATE POLICY "Cualquiera puede ver planes activos"
ON planes FOR SELECT
TO authenticated
USING (activo = true);

-- Solo Super Admin puede crear/modificar planes
CREATE POLICY "Solo Super Admin puede crear planes"
ON planes FOR INSERT
TO authenticated
WITH CHECK (public.es_super_admin());

CREATE POLICY "Solo Super Admin puede actualizar planes"
ON planes FOR UPDATE
TO authenticated
USING (public.es_super_admin());

CREATE POLICY "Solo Super Admin puede eliminar planes"
ON planes FOR DELETE
TO authenticated
USING (public.es_super_admin());


-- =====================================================
-- POLÍTICAS: EMPRESAS (Tenants)
-- =====================================================

-- Los usuarios solo pueden ver su propia empresa
CREATE POLICY "Usuarios ven su propia empresa"
ON empresas FOR SELECT
TO authenticated
USING (
  id = public.obtener_empresa_id() OR
  public.es_super_admin()
);

-- Solo Super Admin puede crear empresas
CREATE POLICY "Solo Super Admin puede crear empresas"
ON empresas FOR INSERT
TO authenticated
WITH CHECK (public.es_super_admin());

-- Solo Super Admin puede actualizar empresas
CREATE POLICY "Solo Super Admin puede actualizar empresas"
ON empresas FOR UPDATE
TO authenticated
USING (public.es_super_admin());

-- Solo Super Admin puede eliminar empresas
CREATE POLICY "Solo Super Admin puede eliminar empresas"
ON empresas FOR DELETE
TO authenticated
USING (public.es_super_admin());


-- =====================================================
-- POLÍTICAS: USUARIOS
-- =====================================================

-- Los usuarios pueden ver otros usuarios de su empresa
CREATE POLICY "Usuarios ven usuarios de su empresa"
ON usuarios FOR SELECT
TO authenticated
USING (
  empresa_id = public.obtener_empresa_id() OR
  public.es_super_admin()
);

-- Administradores pueden crear usuarios en su empresa
CREATE POLICY "Admins pueden crear usuarios"
ON usuarios FOR INSERT
TO authenticated
WITH CHECK (
  empresa_id = public.obtener_empresa_id() AND
  public.obtener_rol_usuario() IN ('super_admin', 'admin')
);

-- Usuarios pueden actualizar su propio perfil
-- Administradores pueden actualizar usuarios de su empresa
CREATE POLICY "Usuarios pueden actualizar su perfil"
ON usuarios FOR UPDATE
TO authenticated
USING (
  id = public.obtener_user_id() OR
  (empresa_id = public.obtener_empresa_id() AND public.obtener_rol_usuario() IN ('super_admin', 'admin')) OR
  public.es_super_admin()
);

-- Solo administradores pueden eliminar usuarios
CREATE POLICY "Admins pueden eliminar usuarios"
ON usuarios FOR DELETE
TO authenticated
USING (
  empresa_id = public.obtener_empresa_id() AND
  public.obtener_rol_usuario() IN ('super_admin', 'admin')
);


-- =====================================================
-- POLÍTICAS: ROLES Y PERMISOS
-- =====================================================

-- Todos pueden ver roles (necesario para UI)
CREATE POLICY "Usuarios ven roles de su empresa"
ON roles FOR SELECT
TO authenticated
USING (
  empresa_id IS NULL OR  -- Roles globales
  empresa_id = public.obtener_empresa_id() OR
  public.es_super_admin()
);

-- Solo admins pueden gestionar roles
CREATE POLICY "Admins gestionan roles"
ON roles FOR ALL
TO authenticated
USING (
  public.obtener_rol_usuario() IN ('super_admin', 'admin')
);

-- Todos pueden ver permisos
CREATE POLICY "Usuarios ven permisos"
ON permisos FOR SELECT
TO authenticated
USING (true);

-- Solo Super Admin gestiona permisos
CREATE POLICY "Super Admin gestiona permisos"
ON permisos FOR ALL
TO authenticated
USING (public.es_super_admin());


-- =====================================================
-- POLÍTICAS: PRODUCTOS
-- =====================================================

-- Usuarios ven productos de su empresa
CREATE POLICY "Usuarios ven productos de su empresa"
ON productos FOR SELECT
TO authenticated
USING (
  empresa_id = public.obtener_empresa_id() OR
  public.es_super_admin()
);

-- Usuarios con permisos pueden crear productos
CREATE POLICY "Usuarios pueden crear productos"
ON productos FOR INSERT
TO authenticated
WITH CHECK (
  empresa_id = public.obtener_empresa_id() AND
  public.obtener_rol_usuario() IN ('super_admin', 'admin', 'gerente', 'inventario')
);

-- Usuarios con permisos pueden actualizar productos
CREATE POLICY "Usuarios pueden actualizar productos"
ON productos FOR UPDATE
TO authenticated
USING (
  empresa_id = public.obtener_empresa_id() AND
  public.obtener_rol_usuario() IN ('super_admin', 'admin', 'gerente', 'inventario')
);

-- Solo admins pueden eliminar productos
CREATE POLICY "Admins pueden eliminar productos"
ON productos FOR DELETE
TO authenticated
USING (
  empresa_id = public.obtener_empresa_id() AND
  public.obtener_rol_usuario() IN ('super_admin', 'admin', 'gerente')
);


-- =====================================================
-- POLÍTICAS: CATEGORÍAS, MARCAS, UNIDADES
-- =====================================================

-- Política para categorías
CREATE POLICY "Usuarios ven categorías de su empresa"
ON categorias FOR SELECT
TO authenticated
USING (empresa_id = public.obtener_empresa_id() OR public.es_super_admin());

CREATE POLICY "Usuarios gestionan categorías de su empresa"
ON categorias FOR ALL
TO authenticated
USING (
  empresa_id = public.obtener_empresa_id() AND
  public.obtener_rol_usuario() IN ('super_admin', 'admin', 'gerente')
);

-- Política para marcas
CREATE POLICY "Usuarios ven marcas de su empresa"
ON marcas FOR SELECT
TO authenticated
USING (empresa_id = public.obtener_empresa_id() OR public.es_super_admin());

CREATE POLICY "Usuarios gestionan marcas de su empresa"
ON marcas FOR ALL
TO authenticated
USING (
  empresa_id = public.obtener_empresa_id() AND
  public.obtener_rol_usuario() IN ('super_admin', 'admin', 'gerente')
);

-- Política para unidades
CREATE POLICY "Usuarios ven unidades de su empresa"
ON unidades FOR SELECT
TO authenticated
USING (empresa_id = public.obtener_empresa_id() OR public.es_super_admin());

CREATE POLICY "Usuarios gestionan unidades de su empresa"
ON unidades FOR ALL
TO authenticated
USING (
  empresa_id = public.obtener_empresa_id() AND
  public.obtener_rol_usuario() IN ('super_admin', 'admin', 'gerente')
);


-- =====================================================
-- POLÍTICAS: INVENTARIO
-- =====================================================

-- Política para bodegas
CREATE POLICY "Usuarios ven bodegas de su empresa"
ON bodegas FOR SELECT
TO authenticated
USING (empresa_id = public.obtener_empresa_id() OR public.es_super_admin());

CREATE POLICY "Admins gestionan bodegas"
ON bodegas FOR ALL
TO authenticated
USING (
  empresa_id = public.obtener_empresa_id() AND
  public.obtener_rol_usuario() IN ('super_admin', 'admin', 'gerente')
);

-- Política para inventario
CREATE POLICY "Usuarios ven inventario de su empresa"
ON inventario FOR SELECT
TO authenticated
USING (empresa_id = public.obtener_empresa_id() OR public.es_super_admin());

CREATE POLICY "Usuarios gestionan inventario"
ON inventario FOR ALL
TO authenticated
USING (
  empresa_id = public.obtener_empresa_id() AND
  public.obtener_rol_usuario() IN ('super_admin', 'admin', 'gerente', 'inventario')
);

-- Política para movimientos de inventario
CREATE POLICY "Usuarios ven movimientos de su empresa"
ON movimientos_inventario FOR SELECT
TO authenticated
USING (empresa_id = public.obtener_empresa_id() OR public.es_super_admin());

CREATE POLICY "Sistema registra movimientos"
ON movimientos_inventario FOR INSERT
TO authenticated
WITH CHECK (empresa_id = public.obtener_empresa_id());


-- =====================================================
-- POLÍTICAS: CLIENTES Y PROVEEDORES
-- =====================================================

-- Política para clientes
CREATE POLICY "Usuarios ven clientes de su empresa"
ON clientes FOR SELECT
TO authenticated
USING (empresa_id = public.obtener_empresa_id() OR public.es_super_admin());

CREATE POLICY "Usuarios gestionan clientes"
ON clientes FOR ALL
TO authenticated
USING (
  empresa_id = public.obtener_empresa_id() AND
  public.obtener_rol_usuario() IN ('super_admin', 'admin', 'gerente', 'vendedor')
);

-- Política para proveedores
CREATE POLICY "Usuarios ven proveedores de su empresa"
ON proveedores FOR SELECT
TO authenticated
USING (empresa_id = public.obtener_empresa_id() OR public.es_super_admin());

CREATE POLICY "Usuarios gestionan proveedores"
ON proveedores FOR ALL
TO authenticated
USING (
  empresa_id = public.obtener_empresa_id() AND
  public.obtener_rol_usuario() IN ('super_admin', 'admin', 'gerente', 'compras')
);


-- =====================================================
-- POLÍTICAS: VENTAS
-- =====================================================

-- Política para ventas
CREATE POLICY "Usuarios ven ventas de su empresa"
ON ventas FOR SELECT
TO authenticated
USING (empresa_id = public.obtener_empresa_id() OR public.es_super_admin());

CREATE POLICY "Vendedores pueden crear ventas"
ON ventas FOR INSERT
TO authenticated
WITH CHECK (
  empresa_id = public.obtener_empresa_id() AND
  public.obtener_rol_usuario() IN ('super_admin', 'admin', 'gerente', 'vendedor')
);

CREATE POLICY "Usuarios pueden actualizar ventas"
ON ventas FOR UPDATE
TO authenticated
USING (
  empresa_id = public.obtener_empresa_id() AND
  public.obtener_rol_usuario() IN ('super_admin', 'admin', 'gerente', 'vendedor')
);

-- Los items de venta heredan las políticas de ventas
CREATE POLICY "Usuarios ven items de venta"
ON items_venta FOR SELECT
TO authenticated
USING (
  EXISTS (
    SELECT 1 FROM ventas v
    WHERE v.id = items_venta.venta_id
    AND (v.empresa_id = public.obtener_empresa_id() OR public.es_super_admin())
  )
);

CREATE POLICY "Usuarios gestionan items de venta"
ON items_venta FOR ALL
TO authenticated
USING (
  EXISTS (
    SELECT 1 FROM ventas v
    WHERE v.id = items_venta.venta_id
    AND v.empresa_id = public.obtener_empresa_id()
    AND public.obtener_rol_usuario() IN ('super_admin', 'admin', 'gerente', 'vendedor')
  )
);


-- =====================================================
-- POLÍTICAS: COMPRAS
-- =====================================================

CREATE POLICY "Usuarios ven compras de su empresa"
ON compras FOR SELECT
TO authenticated
USING (empresa_id = public.obtener_empresa_id() OR public.es_super_admin());

CREATE POLICY "Usuarios gestionan compras"
ON compras FOR ALL
TO authenticated
USING (
  empresa_id = public.obtener_empresa_id() AND
  public.obtener_rol_usuario() IN ('super_admin', 'admin', 'gerente', 'compras')
);

-- Órdenes de compra
CREATE POLICY "Usuarios ven ordenes de compra de su empresa"
ON ordenes_compra FOR SELECT
TO authenticated
USING (empresa_id = public.obtener_empresa_id() OR public.es_super_admin());

CREATE POLICY "Usuarios gestionan ordenes de compra"
ON ordenes_compra FOR ALL
TO authenticated
USING (
  empresa_id = public.obtener_empresa_id() AND
  public.obtener_rol_usuario() IN ('super_admin', 'admin', 'gerente', 'compras')
);


-- =====================================================
-- POLÍTICAS: COTIZACIONES
-- =====================================================

CREATE POLICY "Usuarios ven cotizaciones de su empresa"
ON cotizaciones FOR SELECT
TO authenticated
USING (empresa_id = public.obtener_empresa_id() OR public.es_super_admin());

CREATE POLICY "Usuarios gestionan cotizaciones"
ON cotizaciones FOR ALL
TO authenticated
USING (
  empresa_id = public.obtener_empresa_id() AND
  public.obtener_rol_usuario() IN ('super_admin', 'admin', 'gerente', 'vendedor')
);


-- =====================================================
-- POLÍTICAS: FACTURACIÓN
-- =====================================================

CREATE POLICY "Usuarios ven facturas de su empresa"
ON facturas FOR SELECT
TO authenticated
USING (empresa_id = public.obtener_empresa_id() OR public.es_super_admin());

CREATE POLICY "Usuarios gestionan facturas"
ON facturas FOR ALL
TO authenticated
USING (
  empresa_id = public.obtener_empresa_id() AND
  public.obtener_rol_usuario() IN ('super_admin', 'admin', 'gerente', 'contador')
);


-- =====================================================
-- POLÍTICAS: AUDITORÍA
-- =====================================================

-- Los logs de auditoría solo se pueden crear y leer, no actualizar/eliminar
CREATE POLICY "Sistema registra auditoría"
ON logs_auditoria FOR INSERT
TO authenticated
WITH CHECK (empresa_id = public.obtener_empresa_id() OR public.es_super_admin());

CREATE POLICY "Usuarios ven auditoría de su empresa"
ON logs_auditoria FOR SELECT
TO authenticated
USING (
  empresa_id = public.obtener_empresa_id() OR
  public.es_super_admin()
);


-- =====================================================
-- POLÍTICAS: PAGOS
-- =====================================================

CREATE POLICY "Usuarios ven pagos de su empresa"
ON pagos_venta FOR SELECT
TO authenticated
USING (
  EXISTS (
    SELECT 1 FROM ventas v
    WHERE v.id = pagos_venta.venta_id
    AND (v.empresa_id = public.obtener_empresa_id() OR public.es_super_admin())
  )
);

CREATE POLICY "Usuarios registran pagos"
ON pagos_venta FOR INSERT
TO authenticated
WITH CHECK (
  EXISTS (
    SELECT 1 FROM ventas v
    WHERE v.id = pagos_venta.venta_id
    AND v.empresa_id = public.obtener_empresa_id()
  )
);


-- =====================================================
-- ÍNDICES PARA MEJORAR PERFORMANCE DE RLS
-- =====================================================

-- Índices en empresa_id para todas las tablas multi-tenant
CREATE INDEX IF NOT EXISTS idx_usuarios_empresa_id ON usuarios(empresa_id);
CREATE INDEX IF NOT EXISTS idx_productos_empresa_id ON productos(empresa_id);
CREATE INDEX IF NOT EXISTS idx_categorias_empresa_id ON categorias(empresa_id);
CREATE INDEX IF NOT EXISTS idx_bodegas_empresa_id ON bodegas(empresa_id);
CREATE INDEX IF NOT EXISTS idx_inventario_empresa_id ON inventario(empresa_id);
CREATE INDEX IF NOT EXISTS idx_clientes_empresa_id ON clientes(empresa_id);
CREATE INDEX IF NOT EXISTS idx_proveedores_empresa_id ON proveedores(empresa_id);
CREATE INDEX IF NOT EXISTS idx_ventas_empresa_id ON ventas(empresa_id);
CREATE INDEX IF NOT EXISTS idx_compras_empresa_id ON compras(empresa_id);
CREATE INDEX IF NOT EXISTS idx_cotizaciones_empresa_id ON cotizaciones(empresa_id);
CREATE INDEX IF NOT EXISTS idx_facturas_empresa_id ON facturas(empresa_id);

-- Índices compuestos para queries frecuentes
CREATE INDEX IF NOT EXISTS idx_productos_empresa_activo ON productos(empresa_id, activo);
CREATE INDEX IF NOT EXISTS idx_ventas_empresa_fecha ON ventas(empresa_id, fecha_venta);
CREATE INDEX IF NOT EXISTS idx_inventario_empresa_producto ON inventario(empresa_id, producto_id);


-- =====================================================
-- COMENTARIOS Y DOCUMENTACIÓN
-- =====================================================

COMMENT ON FUNCTION public.obtener_empresa_id() IS 'Obtiene el empresa_id del JWT token del usuario autenticado';
COMMENT ON FUNCTION public.es_super_admin() IS 'Verifica si el usuario actual es Super Admin';
COMMENT ON FUNCTION public.obtener_rol_usuario() IS 'Obtiene el rol del usuario actual desde el JWT';
COMMENT ON FUNCTION public.obtener_user_id() IS 'Obtiene el user_id de Supabase Auth';

-- =====================================================
-- FIN DEL SCRIPT RLS
-- =====================================================

-- Para verificar que RLS está habilitado:
-- SELECT tablename, rowsecurity 
-- FROM pg_tables 
-- WHERE schemaname = 'public' AND rowsecurity = true;

-- Para ver todas las políticas:
-- SELECT schemaname, tablename, policyname, permissive, roles, cmd, qual
-- FROM pg_policies
-- WHERE schemaname = 'public'
-- ORDER BY tablename, policyname;
