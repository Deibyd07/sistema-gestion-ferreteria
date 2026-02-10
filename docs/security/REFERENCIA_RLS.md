# 🔒 Referencia Rápida de Row Level Security (RLS)

## 📋 Resumen

Este documento explica cómo funcionan las políticas de Row Level Security (RLS) implementadas en el sistema de gestión de ferretería.

---

## 🎯 Concepto Principal: Multi-Tenancy

### ¿Qué es Multi-Tenancy?

Nuestro sistema es **SaaS multi-tenant**, lo que significa:
- Una sola base de datos aloja datos de múltiples ferreterías (empresas)
- Cada empresa (tenant) está completamente aislada de las demás
- Los datos se filtran automáticamente por `empresa_id`

### Ejemplo Visual

```
┌─────────────────────────────────┐
│     Base de Datos (PostgreSQL)   │
├─────────────────────────────────┤
│  Empresa A (empresa_id: aaa-111) │
│  - 50 productos                  │
│  - 20 usuarios                   │
│  - 100 ventas                    │
├─────────────────────────────────┤
│  Empresa B (empresa_id: bbb-222) │
│  - 100 productos                 │
│  - 10 usuarios                   │
│  - 200 ventas                    │
├─────────────────────────────────┤
│  Empresa C (empresa_id: ccc-333) │
│  - 30 productos                  │
│  - 5 usuarios                    │
│  - 50 ventas                     │
└─────────────────────────────────┘

Usuario de Empresa A solo ve:
✅ Productos de Empresa A
❌ Productos de Empresa B o C
```

---

## 🔑 Funciones Auxiliares

### 1. `public.obtener_empresa_id()`

Obtiene el ID de la empresa del usuario autenticado desde el JWT token.

```sql
-- El JWT token incluye:
{
  "user_id": "uuid-usuario",
  "email": "usuario@ejemplo.com",
  "empresa_id": "uuid-empresa",  ⬅️ Este valor
  "role": "vendedor"
}

-- La función retorna: "uuid-empresa"
```

**Uso en políticas:**
```sql
CREATE POLICY "Usuarios ven productos de su empresa"
ON productos FOR SELECT
USING (empresa_id = public.obtener_empresa_id());
```

---

### 2. `public.es_super_admin()`

Verifica si el usuario es Super Administrador (puede ver todas las empresas).

```sql
-- Retorna true si el JWT incluye:
{ "role": "super_admin" }

-- Retorna false para cualquier otro rol
```

**Uso en políticas:**
```sql
CREATE POLICY "Usuarios ven productos"
ON productos FOR SELECT
USING (
  empresa_id = public.obtener_empresa_id() OR  -- Su empresa
  public.es_super_admin()              -- O es super admin
);
```

---

### 3. `public.obtener_rol_usuario()`

Obtiene el rol del usuario actual (admin, gerente, vendedor, etc.).

```sql
-- Posibles valores:
'super_admin'
'admin'
'gerente'
'vendedor'
'inventario'
'contador'
'invitado'
```

**Uso en políticas:**
```sql
CREATE POLICY "Solo gerentes pueden eliminar productos"
ON productos FOR DELETE
USING (
  empresa_id = public.obtener_empresa_id() AND
  public.obtener_rol_usuario() IN ('super_admin', 'admin', 'gerente')
);
```

---

### 4. `public.obtener_user_id()`

Obtiene el ID del usuario autenticado (desde Supabase Auth).

```sql
-- Retorna el UUID del usuario de auth.users
```

**Uso en políticas:**
```sql
CREATE POLICY "Usuarios ven sus propias notificaciones"
ON notificaciones FOR SELECT
USING (usuario_id = public.obtener_user_id());
```

---

## 👥 Roles y Permisos

### Matriz de Permisos por Rol

| Entidad | Super Admin | Admin | Gerente | Vendedor | Inventario | Contador |
|---------|-------------|-------|---------|----------|------------|----------|
| **Empresas** | ✅ CRUD | ❌ | ❌ | ❌ | ❌ | ❌ |
| **Usuarios** | ✅ CRUD | ✅ CRUD | ❌ | ❌ | ❌ | ❌ |
| **Productos** | ✅ CRUD | ✅ CRUD | ✅ CRUD | 👁️ Ver | ✅ CRU | 👁️ Ver |
| **Inventario** | ✅ CRUD | ✅ CRUD | ✅ CRUD | 👁️ Ver | ✅ CRUD | 👁️ Ver |
| **Ventas** | ✅ CRUD | ✅ CRUD | ✅ CRUD | ✅ CRUD | 👁️ Ver | 👁️ Ver |
| **Compras** | ✅ CRUD | ✅ CRUD | ✅ CRUD | ❌ | 👁️ Ver | 👁️ Ver |
| **Clientes** | ✅ CRUD | ✅ CRUD | ✅ CRUD | ✅ CRUD | ❌ | 👁️ Ver |
| **Proveedores** | ✅ CRUD | ✅ CRUD | ✅ CRUD | ❌ | ❌ | 👁️ Ver |
| **Facturas** | ✅ CRUD | ✅ CRUD | ✅ CRUD | ❌ | ❌ | ✅ CRUD |
| **Reportes** | ✅ Ver | ✅ Ver | ✅ Ver | 👁️ Ver | 👁️ Ver | ✅ Ver |
| **Auditoría** | ✅ Ver | ✅ Ver | 👁️ Ver | ❌ | ❌ | ❌ |

**Leyenda:**
- ✅ CRUD = Create, Read, Update, Delete
- ✅ CRU = Create, Read, Update (sin Delete)
- 👁️ Ver = Solo lectura
- ❌ = Sin acceso

---

## 📊 Ejemplos de Políticas

### Ejemplo 1: Productos (Multi-Tenant básico)

```sql
-- SELECT: Usuarios ven productos de su empresa
CREATE POLICY "Usuarios ven productos de su empresa"
ON productos FOR SELECT
USING (
  empresa_id = public.obtener_empresa_id() OR
  public.es_super_admin()
);

-- INSERT: Solo roles autorizados pueden crear
CREATE POLICY "Usuarios pueden crear productos"
ON productos FOR INSERT
WITH CHECK (
  empresa_id = public.obtener_empresa_id() AND
  public.obtener_rol_usuario() IN ('super_admin', 'admin', 'gerente', 'inventario')
);

-- UPDATE: Solo roles autorizados pueden actualizar
CREATE POLICY "Usuarios pueden actualizar productos"
ON productos FOR UPDATE
USING (
  empresa_id = public.obtener_empresa_id() AND
  public.obtener_rol_usuario() IN ('super_admin', 'admin', 'gerente', 'inventario')
);

-- DELETE: Solo admins y gerentes
CREATE POLICY "Admins pueden eliminar productos"
ON productos FOR DELETE
USING (
  empresa_id = public.obtener_empresa_id() AND
  public.obtener_rol_usuario() IN ('super_admin', 'admin', 'gerente')
);
```

---

### Ejemplo 2: Ventas (Con relaciones)

```sql
-- Los items de venta dependen de la venta
CREATE POLICY "Usuarios ven items de venta"
ON items_venta FOR SELECT
USING (
  EXISTS (
    SELECT 1 FROM ventas v
    WHERE v.id = items_venta.venta_id
    AND (v.empresa_id = public.obtener_empresa_id() OR public.es_super_admin())
  )
);
```

**Explicación:**
- Un `item_venta` no tiene `empresa_id` directamente
- Debe buscar el `empresa_id` en la tabla `ventas` relacionada
- Solo muestra items si la venta pertenece a la empresa del usuario

---

### Ejemplo 3: Notificaciones (Por usuario)

```sql
-- Cada usuario solo ve sus propias notificaciones
CREATE POLICY "Usuarios ven sus notificaciones"
ON notificaciones FOR SELECT
USING (
  usuario_id = public.obtener_user_id() OR
  public.es_super_admin()
);

-- Pueden marcarlas como leídas
CREATE POLICY "Usuarios actualizan sus notificaciones"
ON notificaciones FOR UPDATE
USING (usuario_id = public.obtener_user_id());
```

---

### Ejemplo 4: Auditoría (Solo lectura)

```sql
-- La auditoría solo se puede crear y leer (nunca actualizar/eliminar)
CREATE POLICY "Sistema registra auditoría"
ON auditoria FOR INSERT
WITH CHECK (empresa_id = public.obtener_empresa_id());

CREATE POLICY "Usuarios ven auditoría de su empresa"
ON auditoria FOR SELECT
USING (
  empresa_id = public.obtener_empresa_id() OR
  public.es_super_admin()
);

-- NO hay políticas UPDATE/DELETE - los logs son inmutables
```

---

## 🔍 Tipos de Políticas

### USING vs WITH CHECK

```sql
-- USING: Determina QUÉ registros son visibles/modificables
CREATE POLICY "politica"
ON tabla
USING (condicion);  ⬅️ Filtra registros existentes

-- WITH CHECK: Valida NUEVOS registros que se insertan
CREATE POLICY "politica"
ON tabla
WITH CHECK (condicion);  ⬅️ Valida antes de insertar

-- Ejemplo completo:
CREATE POLICY "Usuarios pueden crear productos en su empresa"
ON productos FOR INSERT
WITH CHECK (
  empresa_id = public.obtener_empresa_id()  -- El nuevo producto debe ser de su empresa
);
```

---

### Operaciones de Política

```sql
-- Aplicar a todas las operaciones
FOR ALL

-- Solo para consultas SELECT
FOR SELECT

-- Solo para INSERT
FOR INSERT

-- Solo para UPDATE
FOR UPDATE

-- Solo para DELETE
FOR DELETE
```

---

## 🚀 Performance de RLS

### Índices Importantes

Las políticas RLS necesitan índices para ser rápidas:

```sql
-- Índice en empresa_id (MUY IMPORTANTE)
CREATE INDEX idx_productos_empresa_id ON productos(empresa_id);

-- Índices compuestos para queries frecuentes
CREATE INDEX idx_productos_empresa_activo 
ON productos(empresa_id, activo);

CREATE INDEX idx_ventas_empresa_fecha 
ON ventas(empresa_id, fecha_venta);
```

**Sin índices:**
- Una query puede tardar 500ms+ 🐌

**Con índices adecuados:**
- La misma query tarda ~10ms ⚡

---

## 🧪 Probar Políticas

### En SQL Editor (Supabase)

```sql
-- Simular un usuario autenticado
SET request.jwt.claims = '{
  "user_id": "uuid-usuario",
  "empresa_id": "uuid-empresa-A",
  "role": "vendedor"
}';

-- Ahora todas las queries respetan RLS
SELECT * FROM productos;
-- Solo retorna productos de empresa-A

-- Resetear
RESET request.jwt.claims;
```

---

### Desde el Backend (FastAPI)

```python
from app.core.supabase_auth import SupabaseAuth

# Obtener usuario autenticado
user = await SupabaseAuth.get_user_from_token(access_token)

# El JWT ya incluye empresa_id:
user.user_metadata["empresa_id"]  # uuid de su empresa

# Cuando haces una query, RLS filtra automáticamente:
result = supabase_client().table('productos').select('*').execute()
# Solo retorna productos de su empresa (automático)
```

---

## 🛠️ Comandos Útiles

### Ver políticas de una tabla

```sql
SELECT * FROM pg_policies 
WHERE tablename = 'productos';
```

### Ver estado de RLS

```sql
SELECT tablename, rowsecurity 
FROM pg_tables 
WHERE schemaname = 'public' 
AND rowsecurity = true;
```

### Desactivar RLS temporalmente (DEBUG)

```sql
-- ⚠️ SOLO PARA DESARROLLO
ALTER TABLE productos DISABLE ROW LEVEL SECURITY;

-- Reactivar
ALTER TABLE productos ENABLE ROW LEVEL SECURITY;
```

### Eliminar una política

```sql
DROP POLICY "nombre_politica" ON nombre_tabla;
```

---

## ❓ Preguntas Frecuentes

### ¿Qué pasa si no configuramos RLS?

❌ **Peligro:** Sin RLS, todos los usuarios verían datos de todas las empresas.

```sql
-- Sin RLS:
SELECT * FROM productos;
-- Retorna: 10,000 productos de 100 empresas diferentes ❌

-- Con RLS:
SELECT * FROM productos;
-- Retorna: 50 productos solo de MI empresa ✅
```

---

### ¿Cómo se establece el empresa_id en el JWT?

Al registrar/autenticar un usuario, guardamos `empresa_id` en los metadatos:

```python
# Backend: Al registrar usuario
result = await SupabaseAuth.sign_up(
    email="usuario@ejemplo.com",
    password="password123",
    metadata={
        "empresa_id": "uuid-de-su-empresa",
        "name": "Juan Pérez",
        "role": "vendedor"
    }
)

# Supabase incluye esto automáticamente en el JWT
```

---

### ¿Puedo tener políticas más complejas?

✅ Sí, puedes combinar condiciones:

```sql
CREATE POLICY "Vendedores solo ven ventas propias"
ON ventas FOR SELECT
USING (
  empresa_id = public.obtener_empresa_id() AND
  (
    public.obtener_rol_usuario() IN ('admin', 'gerente') OR  -- Admins ven todo
    usuario_id = public.obtener_user_id()                    -- Vendedores solo las suyas
  )
);
```

---

### ¿Qué NO protege RLS?

RLS protege datos a nivel de fila, pero NO:
- ❌ Estructura de la base de datos
- ❌ Funciones y triggers
- ❌ Acceso directo con service_role_key (bypass completo)

**NUNCA expongas `service_role_key` en el frontend.**

---

## 📚 Referencias

- [Documentación oficial de RLS en PostgreSQL](https://www.postgresql.org/docs/current/ddl-rowsecurity.html)
- [Guía de RLS en Supabase](https://supabase.com/docs/guides/auth/row-level-security)
- [Políticas de Storage en Supabase](https://supabase.com/docs/guides/storage/security/access-control)

---

## ✅ Checklist de Seguridad RLS

- [ ] ✅ RLS habilitado en TODAS las tablas con datos sensibles
- [ ] ✅ Funciones auxiliares creadas (empresa_id, es_super_admin, etc.)
- [ ] ✅ Políticas definidas para SELECT, INSERT, UPDATE, DELETE
- [ ] ✅ Índices creados en empresa_id para performance
- [ ] ✅ Políticas probadas con diferentes roles
- [ ] ✅ JWT incluye empresa_id en metadata
- [ ] ✅ service_role_key NO está en el frontend
- [ ] ✅ Auditoría configurada (logs inmutables)

---

**Última actualización:** Febrero 2026
