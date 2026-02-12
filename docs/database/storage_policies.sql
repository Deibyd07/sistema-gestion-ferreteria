-- =====================================================
-- POLÍTICAS DE STORAGE - SUPABASE
-- Sistema de Gestión de Ferretería
-- =====================================================
-- Ejecutar después de crear los buckets en Supabase Storage
-- =====================================================

-- =====================================================
-- BUCKET: company-logos (Público)
-- =====================================================

-- Permitir que usuarios autenticados suban logos
CREATE POLICY "Usuarios autenticados pueden subir logos"
ON storage.objects FOR INSERT
TO authenticated
WITH CHECK (
  bucket_id = 'company-logos' AND
  (storage.foldername(name))[1] = (auth.jwt() ->> 'empresa_id')
);

-- Permitir lectura pública de todos los logos
CREATE POLICY "Todos pueden ver logos de empresas"
ON storage.objects FOR SELECT
TO public
USING (bucket_id = 'company-logos');

-- Permitir actualización solo a la misma empresa
CREATE POLICY "Empresas pueden actualizar su propio logo"
ON storage.objects FOR UPDATE
TO authenticated
USING (
  bucket_id = 'company-logos' AND
  (storage.foldername(name))[1] = (auth.jwt() ->> 'empresa_id')
);

-- Permitir eliminación solo a admins de la empresa
CREATE POLICY "Admins pueden eliminar logos de su empresa"
ON storage.objects FOR DELETE
TO authenticated
USING (
  bucket_id = 'company-logos' AND
  (storage.foldername(name))[1] = (auth.jwt() ->> 'empresa_id') AND
  (auth.jwt() ->> 'role') IN ('super_admin', 'admin', 'gerente')
);


-- =====================================================
-- BUCKET: product-images (Público)
-- =====================================================

-- Permitir que usuarios autenticados suban imágenes de productos
CREATE POLICY "Usuarios pueden subir imágenes de productos"
ON storage.objects FOR INSERT
TO authenticated
WITH CHECK (
  bucket_id = 'product-images' AND
  (storage.foldername(name))[1] = (auth.jwt() ->> 'empresa_id')
);

-- Permitir lectura pública (para mostrar productos en catálogo)
CREATE POLICY "Todos pueden ver imágenes de productos"
ON storage.objects FOR SELECT
TO public
USING (bucket_id = 'product-images');

-- Permitir actualización solo a usuarios de la empresa
CREATE POLICY "Usuarios pueden actualizar imágenes de su empresa"
ON storage.objects FOR UPDATE
TO authenticated
USING (
  bucket_id = 'product-images' AND
  (storage.foldername(name))[1] = (auth.jwt() ->> 'empresa_id') AND
  (auth.jwt() ->> 'role') IN ('super_admin', 'admin', 'gerente', 'inventario')
);

-- Permitir eliminación solo a usuarios con permisos
CREATE POLICY "Usuarios pueden eliminar imágenes de productos"
ON storage.objects FOR DELETE
TO authenticated
USING (
  bucket_id = 'product-images' AND
  (storage.foldername(name))[1] = (auth.jwt() ->> 'empresa_id') AND
  (auth.jwt() ->> 'role') IN ('super_admin', 'admin', 'gerente', 'inventario')
);


-- =====================================================
-- BUCKET: documents (Privado)
-- =====================================================

-- Permitir que usuarios autenticados suban documentos
CREATE POLICY "Usuarios pueden subir documentos"
ON storage.objects FOR INSERT
TO authenticated
WITH CHECK (
  bucket_id = 'documents' AND
  (storage.foldername(name))[1] = (auth.jwt() ->> 'empresa_id')
);

-- Permitir lectura solo a usuarios de la misma empresa
CREATE POLICY "Usuarios ven documentos de su empresa"
ON storage.objects FOR SELECT
TO authenticated
USING (
  bucket_id = 'documents' AND
  (storage.foldername(name))[1] = (auth.jwt() ->> 'empresa_id')
);

-- Permitir actualización solo a usuarios de la empresa
CREATE POLICY "Usuarios pueden actualizar documentos de su empresa"
ON storage.objects FOR UPDATE
TO authenticated
USING (
  bucket_id = 'documents' AND
  (storage.foldername(name))[1] = (auth.jwt() ->> 'empresa_id') AND
  (auth.jwt() ->> 'role') IN ('super_admin', 'admin', 'gerente', 'contador')
);

-- Permitir eliminación solo a admins
CREATE POLICY "Admins pueden eliminar documentos"
ON storage.objects FOR DELETE
TO authenticated
USING (
  bucket_id = 'documents' AND
  (storage.foldername(name))[1] = (auth.jwt() ->> 'empresa_id') AND
  (auth.jwt() ->> 'role') IN ('super_admin', 'admin', 'gerente')
);


-- =====================================================
-- VERIFICACIÓN DE POLÍTICAS DE STORAGE
-- =====================================================

-- Ver todas las políticas de storage
SELECT 
    schemaname,
    tablename,
    policyname,
    permissive,
    roles,
    cmd,
    qual
FROM pg_policies 
WHERE schemaname = 'storage'
ORDER BY tablename, policyname;


-- =====================================================
-- ESTRUCTURA DE CARPETAS RECOMENDADA
-- =====================================================

/*
BUCKET: company-logos
  └── {empresa_id}/
      └── logo.png

BUCKET: product-images
  └── {empresa_id}/
      └── {producto_id}/
          ├── imagen1.jpg
          ├── imagen2.jpg
          └── thumbnail.jpg

BUCKET: documents
  └── {empresa_id}/
      ├── facturas/
      │   └── factura-{id}.pdf
      ├── compras/
      │   └── orden-{id}.pdf
      └── reportes/
          └── reporte-mensual.xlsx
*/

-- =====================================================
-- NOTAS IMPORTANTES
-- =====================================================

-- 1. El JWT de Supabase debe incluir:
--    - empresa_id: UUID de la empresa
--    - role: Rol del usuario (admin, gerente, vendedor, etc.)

-- 2. La estructura de carpetas usa empresa_id como primer nivel
--    para aislar archivos entre tenants (multi-tenant)

-- 3. Los buckets públicos (logos, imágenes) permiten lectura sin auth
--    pero requieren autenticación para subir/modificar/eliminar

-- 4. El bucket documents es completamente privado
--    solo usuarios autenticados de la misma empresa pueden acceder

-- 5. Las políticas verifican el campo empresa_id del JWT
--    para garantizar aislamiento multi-tenant

-- =====================================================
-- FIN DEL SCRIPT DE POLÍTICAS DE STORAGE
-- =====================================================
