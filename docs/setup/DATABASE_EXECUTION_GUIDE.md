# 🚀 Guía de Ejecución del Schema de Base de Datos

## 📋 Índice

1. [Requisitos Previos](#requisitos-previos)
2. [Opción 1: Ejecutar en Supabase (Recomendado)](#opción-1-ejecutar-en-supabase-recomendado)
3. [Opción 2: Ejecutar en PostgreSQL Local](#opción-2-ejecutar-en-postgresql-local)
4. [Verificación Post-Instalación](#verificación-post-instalación)
5. [Seeds de Datos Iniciales](#seeds-de-datos-iniciales)
6. [Troubleshooting](#troubleshooting)

---

## Requisitos Previos

### Para Supabase
- ✅ Proyecto de Supabase creado y configurado ([ver SUPABASE_SETUP.md](SUPABASE_SETUP.md))
- ✅ Acceso al SQL Editor de Supabase
- ✅ Credenciales de conexión guardadas

### Para PostgreSQL Local
- ✅ PostgreSQL 14+ instalado
- ✅ Cliente psql o pgAdmin
- ✅ Usuario con permisos de CREATE TABLE

---

## Opción 1: Ejecutar en Supabase (Recomendado)

### Paso 1: Acceder al SQL Editor

1. Accede a tu proyecto en [https://supabase.com/dashboard](https://supabase.com/dashboard)
2. En el menú lateral izquierdo, haz clic en **SQL Editor**
3. Haz clic en **New Query**

### Paso 2: Ejecutar el Script

1. Abre el archivo `database_schema.sql` desde tu editor de código
2. **Copia TODO el contenido** del archivo
3. Pégalo en el SQL Editor de Supabase
4. Haz clic en **Run** (o presiona Ctrl/Cmd + Enter)

### Paso 3: Monitorear la Ejecución

- El script tomará aproximadamente **30-60 segundos** en ejecutarse
- Verás mensajes de confirmación para cada tabla creada
- Si hay errores, se mostrarán en la parte inferior del editor

### Paso 4: Verificar Tablas Creadas

1. En el menú lateral, ve a **Table Editor**
2. Deberías ver **42 tablas** creadas:
   - `plans`, `tenants`, `users`, `roles`, `permissions`, etc.
3. Verifica que cada tabla tenga sus columnas correctas

---

## Opción 2: Ejecutar en PostgreSQL Local

### Paso 1: Conectar a la Base de Datos

```bash
# Conectar como usuario postgres
psql -U postgres

# Crear base de datos (si no existe)
CREATE DATABASE ferreteria_db;

# Conectar a la base de datos
\c ferreteria_db
```

### Paso 2: Ejecutar el Script

```bash
# Opción A: Desde psql
\i /ruta/completa/al/database_schema.sql

# Opción B: Desde la terminal
psql -U postgres -d ferreteria_db -f database_schema.sql
```

### Paso 3: Verificar la Ejecución

```sql
-- Listar todas las tablas
\dt

-- Deberías ver 42 tablas creadas
```

---

## Verificación Post-Instalación

### 1. Verificar Cantidad de Tablas

```sql
-- Contar tablas creadas (debe ser 42)
SELECT COUNT(*) 
FROM information_schema.tables 
WHERE table_schema = 'public' 
AND table_type = 'BASE TABLE';
```

**Resultado esperado**: 42 tablas

### 2. Verificar Extensiones

```sql
-- Verificar extensiones instaladas
SELECT * FROM pg_extension WHERE extname IN ('uuid-ossp', 'pg_trgm');
```

**Resultado esperado**: 2 filas (ambas extensiones)

### 3. Verificar Índices

```sql
-- Contar índices creados
SELECT COUNT(*) 
FROM pg_indexes 
WHERE schemaname = 'public';
```

**Resultado esperado**: 60+ índices

### 4. Verificar Triggers

```sql
-- Listar triggers de updated_at
SELECT 
    trigger_name,
    event_object_table 
FROM information_schema.triggers 
WHERE trigger_schema = 'public' 
AND trigger_name LIKE '%updated_at%'
ORDER BY event_object_table;
```

**Resultado esperado**: 19 triggers (uno por cada tabla con `updated_at`)

### 5. Verificar Foreign Keys

```sql
-- Contar foreign keys
SELECT COUNT(*) 
FROM information_schema.table_constraints 
WHERE constraint_type = 'FOREIGN KEY' 
AND constraint_schema = 'public';
```

**Resultado esperado**: 80+ foreign keys

---

## Seeds de Datos Iniciales

Después de crear el schema, es recomendable insertar datos iniciales:

### 1. Crear Planes de Suscripción

```sql
-- Plan Free
INSERT INTO plans (name, display_name, description, max_users, max_products, max_invoices_per_month, max_warehouses, price_monthly, price_yearly) 
VALUES (
    'free',
    'Plan Gratuito',
    'Plan básico gratuito para empezar',
    2,
    100,
    50,
    1,
    0.00,
    0.00
);

-- Plan Pro
INSERT INTO plans (name, display_name, description, max_users, max_products, max_invoices_per_month, max_warehouses, price_monthly, price_yearly, features) 
VALUES (
    'pro',
    'Plan Profesional',
    'Plan profesional con características avanzadas',
    10,
    1000,
    500,
    3,
    49.99,
    499.99,
    '["multi_warehouse", "advanced_reports", "email_support"]'::jsonb
);

-- Plan Premium
INSERT INTO plans (name, display_name, description, max_users, max_products, max_invoices_per_month, max_warehouses, price_monthly, price_yearly, features) 
VALUES (
    'premium',
    'Plan Premium',
    'Plan completo con todas las funcionalidades',
    9999,
    9999,
    9999,
    9999,
    99.99,
    999.99,
    '["multi_warehouse", "advanced_reports", "api_access", "priority_support", "custom_integrations"]'::jsonb
);
```

### 2. Crear Permisos del Sistema

```sql
-- Permisos de productos
INSERT INTO permissions (name, resource, action, display_name, description, category) VALUES
('products.create', 'products', 'create', 'Crear productos', 'Permite crear nuevos productos', 'products'),
('products.read', 'products', 'read', 'Ver productos', 'Permite ver detalles de productos', 'products'),
('products.update', 'products', 'update', 'Editar productos', 'Permite editar productos existentes', 'products'),
('products.delete', 'products', 'delete', 'Eliminar productos', 'Permite eliminar productos', 'products'),
('products.list', 'products', 'list', 'Listar productos', 'Permite ver listado de productos', 'products');

-- Permisos de ventas
INSERT INTO permissions (name, resource, action, display_name, description, category) VALUES
('sales.create', 'sales', 'create', 'Realizar ventas', 'Permite crear nuevas ventas', 'sales'),
('sales.read', 'sales', 'read', 'Ver ventas', 'Permite ver detalles de ventas', 'sales'),
('sales.update', 'sales', 'update', 'Editar ventas', 'Permite editar ventas', 'sales'),
('sales.delete', 'sales', 'delete', 'Eliminar ventas', 'Permite eliminar ventas', 'sales'),
('sales.cancel', 'sales', 'cancel', 'Cancelar ventas', 'Permite cancelar ventas completadas', 'sales');

-- Permisos de inventario
INSERT INTO permissions (name, resource, action, display_name, description, category) VALUES
('inventory.read', 'inventory', 'read', 'Ver inventario', 'Permite ver stock e inventario', 'inventory'),
('inventory.update', 'inventory', 'update', 'Ajustar inventario', 'Permite realizar ajustes de inventario', 'inventory'),
('inventory.transfer', 'inventory', 'transfer', 'Transferir inventario', 'Permite transferencias entre bodegas', 'inventory');

-- Permisos de usuarios
INSERT INTO permissions (name, resource, action, display_name, description, category) VALUES
('users.create', 'users', 'create', 'Crear usuarios', 'Permite crear nuevos usuarios', 'admin'),
('users.read', 'users', 'read', 'Ver usuarios', 'Permite ver usuarios del sistema', 'admin'),
('users.update', 'users', 'update', 'Editar usuarios', 'Permite editar usuarios existentes', 'admin'),
('users.delete', 'users', 'delete', 'Eliminar usuarios', 'Permite eliminar usuarios', 'admin');

-- Agregar más permisos según sea necesario...
```

### 3. Crear Roles del Sistema

```sql
-- Rol: Super Admin (global, sin tenant)
INSERT INTO roles (name, display_name, description, is_system_role) 
VALUES (
    'super_admin',
    'Super Administrador',
    'Administrador global del SaaS con acceso total',
    true
);

-- Nota: Los demás roles se crean por tenant después de crear la ferretería
```

### 4. Crear Unidades de Medida Globales

```sql
-- Unidades básicas
INSERT INTO units (name, abbreviation, unit_type, is_system_unit) VALUES
('Unidad', 'un', 'unit', true),
('Kilogramo', 'kg', 'weight', true),
('Gramo', 'g', 'weight', true),
('Metro', 'm', 'length', true),
('Centímetro', 'cm', 'length', true),
('Litro', 'L', 'volume', true),
('Mililitro', 'mL', 'volume', true),
('Caja', 'caja', 'unit', true),
('Paquete', 'paq', 'unit', true),
('Docena', 'doc', 'unit', true),
('Metro cuadrado', 'm²', 'area', true),
('Galón', 'gal', 'volume', true),
('Libra', 'lb', 'weight', true),
('Onza', 'oz', 'weight', true);
```

---

## Troubleshooting

### Error: "extension uuid-ossp does not exist"

**Solución**: Ejecutar manualmente:
```sql
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
```

### Error: "relation already exists"

**Causa**: El schema ya fue ejecutado previamente.

**Solución**: Eliminar todas las tablas y volver a ejecutar:
```sql
-- ⚠️ CUIDADO: Esto eliminará TODAS las tablas
DROP SCHEMA public CASCADE;
CREATE SCHEMA public;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO public;

-- Luego ejecutar el database_schema.sql nuevamente
```

### Error: "permission denied"

**Causa**: Usuario sin permisos suficientes.

**Solución**: Ejecutar como superusuario o un usuario con permisos CREATE:
```sql
-- Otorgar permisos al usuario
GRANT ALL PRIVILEGES ON DATABASE ferreteria_db TO tu_usuario;
```

### Error: "syntax error at or near"

**Causa**: Versión de PostgreSQL muy antigua o incompatibilidad.

**Solución**: 
1. Verificar versión de PostgreSQL: `SELECT version();`
2. Asegurar que sea PostgreSQL 14+
3. Si es menor, actualizar o modificar el script

### Performance Lenta al Crear Índices

**Causa**: Normal en bases de datos grandes o con pocos recursos.

**Solución**: Los índices se crean al final, esperar a que termine. Puede tomar varios minutos en bases de datos grandes.

---

## 📊 Resumen del Schema Creado

| Categoría | Tablas | Descripción |
|-----------|--------|-------------|
| **Tenants & Plans** | 3 | Gestión multi-tenant |
| **Usuarios** | 5 | Usuarios, roles y permisos |
| **Productos** | 6 | Catálogo de productos |
| **Inventario** | 6 | Stock y movimientos |
| **Clientes/Proveedores** | 2 | Gestión de terceros |
| **Ventas** | 6 | POS y ventas |
| **Compras** | 4 | Órdenes y compras |
| **Facturación** | 3 | Facturación electrónica |
| **Auditoría** | 1 | Logs de auditoría |
| **TOTAL** | **42** | |

---

## 🎯 Próximos Pasos

Después de ejecutar el schema exitosamente:

1. ✅ **Insertar seeds de datos iniciales** (planes, permisos, unidades)
2. ✅ **Configurar Row Level Security (RLS)** en Supabase
3. ✅ **Crear primer tenant de prueba**
4. ✅ **Implementar modelos SQLAlchemy** en el backend
5. ✅ **Crear migraciones de Alembic** para versionado

---

## 📚 Referencias

- [DATABASE_DESIGN.md](DATABASE_DESIGN.md) - Diseño detallado
- [SUPABASE_SETUP.md](SUPABASE_SETUP.md) - Configuración de Supabase
- [PostgreSQL Documentation](https://www.postgresql.org/docs/)
- [Supabase Docs - Database](https://supabase.com/docs/guides/database)

---

**¿Necesitas ayuda?**

Si encuentras algún problema durante la ejecución del schema, verifica:
1. Que Supabase esté correctamente configurado
2. Que tengas permisos suficientes
3. Que la versión de PostgreSQL sea 14+
4. Los logs de error completos

**¡El schema está listo para producción y soporta todas las funcionalidades del sistema! 🎉**
