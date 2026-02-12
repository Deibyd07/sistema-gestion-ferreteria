-- =====================================================
-- SCRIPT DE VERIFICACIÓN DE RLS
-- Ejecutar después de aplicar rls_policies.sql
-- =====================================================

-- =====================================================
-- 1. VERIFICAR QUE RLS ESTÁ HABILITADO
-- =====================================================

SELECT 
    schemaname,
    tablename,
    CASE 
        WHEN rowsecurity THEN '✅ RLS Habilitado'
        ELSE '❌ RLS NO Habilitado'
    END as estado_rls
FROM pg_tables 
WHERE schemaname = 'public'
ORDER BY tablename;


-- =====================================================
-- 2. CONTAR POLÍTICAS POR TABLA
-- =====================================================

SELECT 
    tablename,
    COUNT(*) as num_politicas,
    STRING_AGG(DISTINCT cmd::text, ', ') as operaciones
FROM pg_policies
WHERE schemaname = 'public'
GROUP BY tablename
ORDER BY tablename;


-- =====================================================
-- 3. VER TODAS LAS POLÍTICAS DETALLADAS
-- =====================================================

SELECT 
    tablename as tabla,
    policyname as politica,
    cmd as operacion,
    CASE 
        WHEN permissive = 'PERMISSIVE' THEN 'Permisiva'
        ELSE 'Restrictiva'
    END as tipo,
    roles as roles_aplicados
FROM pg_policies
WHERE schemaname = 'public'
ORDER BY tablename, policyname;


-- =====================================================
-- 4. VERIFICAR FUNCIONES AUXILIARES
-- =====================================================

SELECT 
    routine_name as funcion,
    routine_type as tipo,
    data_type as retorna,
    CASE 
        WHEN routine_name = 'obtener_empresa_id' THEN '✅ Función existe'
        WHEN routine_name = 'es_super_admin' THEN '✅ Función existe'
        WHEN routine_name = 'obtener_rol_usuario' THEN '✅ Función existe'
        WHEN routine_name = 'obtener_user_id' THEN '✅ Función existe'
        ELSE 'Función auxiliar'
    END as estado
FROM information_schema.routines
WHERE routine_schema = 'public'
AND routine_name IN ('obtener_empresa_id', 'es_super_admin', 'obtener_rol_usuario', 'obtener_user_id')
ORDER BY routine_name;


-- =====================================================
-- 5. VERIFICAR ÍNDICES PARA PERFORMANCE
-- =====================================================

SELECT 
    tablename as tabla,
    indexname as indice,
    indexdef as definicion
FROM pg_indexes
WHERE schemaname = 'public'
AND indexname LIKE 'idx_%empresa_id%'
ORDER BY tablename, indexname;


-- =====================================================
-- 6. TABLAS SIN POLÍTICAS (Posibles Problemas)
-- =====================================================

SELECT DISTINCT
    t.tablename as tabla_sin_politicas
FROM pg_tables t
LEFT JOIN pg_policies p ON t.tablename = p.tablename AND p.schemaname = 'public'
WHERE t.schemaname = 'public'
AND t.rowsecurity = true
AND p.policyname IS NULL
ORDER BY t.tablename;


-- =====================================================
-- 7. RESUMEN GENERAL
-- =====================================================

SELECT 
    'Total de tablas con RLS' as metrica,
    COUNT(*) as valor
FROM pg_tables 
WHERE schemaname = 'public' AND rowsecurity = true

UNION ALL

SELECT 
    'Total de políticas creadas' as metrica,
    COUNT(*) as valor
FROM pg_policies
WHERE schemaname = 'public'

UNION ALL

SELECT 
    'Funciones auxiliares' as metrica,
    COUNT(*) as valor
FROM information_schema.routines
WHERE routine_schema = 'public'
AND routine_name IN ('obtener_empresa_id', 'es_super_admin', 'obtener_rol_usuario', 'obtener_user_id')

UNION ALL

SELECT 
    'Índices de performance' as metrica,
    COUNT(*) as valor
FROM pg_indexes
WHERE schemaname = 'public'
AND indexname LIKE 'idx_%empresa_id%';


-- =====================================================
-- 8. PRUEBA DE POLÍTICAS (Simulación)
-- =====================================================

-- NOTA: Estas queries solo funcionarán con datos de prueba
-- Comenta/descomenta según necesites

/*
-- Ejemplo: Verificar que un usuario solo vea productos de su empresa
-- (Requiere tener usuarios y productos de prueba)

SET request.jwt.claims = '{"empresa_id": "tu-empresa-id-aqui", "role": "admin"}';

SELECT COUNT(*) as productos_visibles 
FROM productos;

-- Debería mostrar solo productos de esa empresa

RESET request.jwt.claims;
*/


-- =====================================================
-- COMANDOS ÚTILES PARA DEBUGGING
-- =====================================================

-- Ver definición de una política específica
-- SELECT pg_get_expr(polqual, polrelid) FROM pg_policy WHERE polname = 'nombre_de_politica';

-- Ver todas las columnas de pg_policies
-- SELECT * FROM pg_policies WHERE tablename = 'productos';

-- Desactivar RLS temporalmente (SOLO PARA DEBUG)
-- ALTER TABLE nombre_tabla DISABLE ROW LEVEL SECURITY;

-- Reactivar RLS
-- ALTER TABLE nombre_tabla ENABLE ROW LEVEL SECURITY;

-- Eliminar una política
-- DROP POLICY "nombre_politica" ON nombre_tabla;

-- =====================================================
-- FIN DEL SCRIPT DE VERIFICACIÓN
-- =====================================================

-- 🎯 SIGUIENTE PASO: Si todo está ✅, continúa con:
-- - Configurar Supabase Auth (URLs de redirección)
-- - Configurar Supabase Storage (crear buckets)
-- - Probar autenticación y permisos
