# 🔧 Guía de Configuración de Supabase

Esta guía te ayudará a configurar completamente Supabase para el Sistema de Gestión de Ferretería, incluyendo PostgreSQL, Auth y Storage.

## 📋 Tabla de Contenidos

1. [Crear Proyecto en Supabase](#1-crear-proyecto-en-supabase)
2. [Configurar Base de Datos PostgreSQL](#2-configurar-base-de-datos-postgresql)
3. [Configurar Supabase Auth](#3-configurar-supabase-auth)
4. [Configurar Supabase Storage](#4-configurar-supabase-storage)
5. [Obtener Credenciales](#5-obtener-credenciales)
6. [Configurar Variables de Entorno](#6-configurar-variables-de-entorno)
7. [Verificar Configuración](#7-verificar-configuración)

---

## 1. Crear Proyecto en Supabase

### Paso 1.1: Crear cuenta y proyecto

1. Ve a [https://supabase.com](https://supabase.com)
2. Haz clic en "Start your project"
3. Inicia sesión con GitHub o Email
4. Crea una nueva organización (si no tienes una)
5. Haz clic en "New Project"
6. Completa los datos:
   - **Name**: `ferreteria-system` (o el nombre que prefieras)
   - **Database Password**: Genera una contraseña segura y guárdala
   - **Region**: Selecciona la más cercana a tus usuarios (ej: South America - São Paulo)
   - **Pricing Plan**: Free (para desarrollo) o Pro (para producción)

7. Haz clic en "Create new project"
8. Espera 2-3 minutos mientras se aprovisiona el proyecto

---

## 2. Configurar Base de Datos PostgreSQL

### Paso 2.1: Ejecutar el schema

1. En el panel de Supabase, ve a **SQL Editor** (icono de base de datos con SQL)
2. Haz clic en "New query"
3. Copia y pega el contenido del archivo `database_schema.sql`
4. Haz clic en "Run" o presiona `Ctrl + Enter`
5. Verifica que todas las tablas se crearon correctamente en **Database > Tables**

### Paso 2.2: Configurar Row Level Security (RLS)

Supabase utiliza RLS para seguridad a nivel de fila. Este sistema implementa **aislamiento multi-tenant** completo.

#### ¿Qué es RLS?
Row Level Security permite filtrar automáticamente los datos según el usuario autenticado. En nuestro sistema:
- Cada empresa (tenant) solo ve sus propios datos
- El Super Admin puede ver todo
- Los usuarios tienen acceso según su rol

#### Ejecutar Script de RLS

1. En el panel de Supabase, ve a **SQL Editor**
2. Haz clic en "New query"
3. Abre el archivo **`rls_policies_fixed.sql`** del proyecto (versión corregida)
4. Copia y pega TODO el contenido del archivo
5. Haz clic en "Run" o presiona `Ctrl + Enter`
6. Espera a que se ejecute (puede tomar 10-20 segundos)

> **Nota:** Usa `rls_policies_fixed.sql` (no `rls_policies.sql`) porque este crea las funciones en el schema `public` en lugar de `auth`, evitando errores de permisos.

#### ¿Qué incluye el script?

El script `rls_policies.sql` configura:

✅ **Funciones auxiliares** para obtener el empresa_id del JWT  
✅ **Habilita RLS** en todas las tablas (50+ tablas)  
✅ **Políticas de acceso** multi-tenant por tabla:
   - Usuarios solo ven datos de su empresa
   - Super Admin ve todo
   - Filtros por rol (admin, gerente, vendedor, etc.)
   
✅ **Políticas específicas** por entidad:
   - Productos, Inventario, Ventas, Compras
   - Clientes, Proveedores, Cotizaciones
   - Facturas, Auditoría, Notificaciones
   
✅ **Índices de performance** en empresa_id

#### Verificar que RLS está funcionando

Después de ejecutar el script, verifica la configuración:

1. En **SQL Editor**, abre una nueva query
2. Copia y pega el contenido de `verify_rls.sql`
3. Ejecuta el script
4. Revisa los resultados:

**Debe mostrar:**
- ✅ Todas las tablas con "RLS Habilitado"
- ✅ 80+ políticas creadas
- ✅ 4 funciones auxiliares (empresa_id, es_super_admin, rol_usuario, user_id)
- ✅ 10+ índices de performance

#### Ejemplo de cómo funciona RLS

```sql
-- Cuando un usuario se autentica, Supabase establece automáticamente:
-- request.jwt.claims = {"empresa_id": "uuid-123", "role": "vendedor"}

-- Esta query:
SELECT * FROM productos;

-- Se convierte automáticamente en:
SELECT * FROM productos 
WHERE empresa_id = 'uuid-123';  -- Filtro automático por RLS

-- El usuario NUNCA ve productos de otras empresas
```

#### Solución de problemas

**Error: "permission denied for schema auth"**
- ✅ **Solución:** Usa el archivo `rls_policies_fixed.sql` en lugar de `rls_policies.sql`
- Este error ocurre porque Supabase no permite crear funciones en el schema `auth`
- El script corregido crea las funciones en el schema `public`
- Lee [RLS_FIX_EXPLANATION.md](RLS_FIX_EXPLANATION.md) para más detalles

**Error: "function auth.empresa_id() does not exist"**
- Asegúrate de ejecutar TODAS las funciones auxiliares al inicio del script
- Verifica que las funciones se crearon con `SELECT * FROM information_schema.routines WHERE routine_schema = 'public'`

**Error: "permission denied for table"**
- Verifica que las políticas se crearon correctamente
- Ejecuta `verify_rls.sql` para ver el estado

**Los usuarios ven datos de otras empresas**
- Verifica que el JWT incluya el campo `empresa_id`
- Revisa que las políticas estén habilitadas con `verify_rls.sql`

---

## 3. Configurar Supabase Auth

### Paso 3.1: Configurar proveedores de autenticación

1. Ve a **Authentication > Providers**
2. Configura **Email** (habilitado por defecto):
   - ✅ Enable Email provider
   - ✅ Confirm email (recomendado para producción)
   - Opcional: Personaliza templates de email

### Paso 3.2: Configurar URLs de redirección

1. Ve a **Authentication > URL Configuration**
2. Configura las siguientes URLs:

   **Site URL**: `http://localhost:3000`
   
   **Redirect URLs** (añade las siguientes):
   ```
   http://localhost:3000/auth/callback
   http://localhost:3000/auth/reset-password
   https://tu-dominio.com/auth/callback
   https://tu-dominio.com/auth/reset-password
   ```

### Paso 3.3: Configurar JWT Settings

1. Ve a **Authentication > Settings**
2. Configura:
   - **JWT Expiry**: 3600 (1 hora recomendado)
   - **Refresh Token Expiry**: 604800 (7 días)
   - **Min Password Length**: 8 caracteres

### Paso 3.4: Personalizar Email Templates (Opcional)

1. Ve a **Authentication > Email Templates**
2. Personaliza los templates:
   - Confirm signup
   - Invite user
   - Magic link
   - Reset password

---

## 4. Configurar Supabase Storage

### Paso 4.1: Crear Buckets

1. Ve a **Storage** en el panel lateral
2. Haz clic en "Create bucket"
3. Crea los siguientes buckets:

#### Bucket 1: company-logos
- **Name**: `company-logos`
- **Public**: ✅ Sí (para mostrar logos públicamente)
- **Allowed MIME types**: `image/png, image/jpeg, image/jpg, image/webp`
- **Max file size**: 5 MB

#### Bucket 2: product-images
- **Name**: `product-images`
- **Public**: ✅ Sí
- **Allowed MIME types**: `image/png, image/jpeg, image/jpg, image/webp`
- **Max file size**: 5 MB

#### Bucket 3: documents
- **Name**: `documents`
- **Public**: ❌ No (documentos privados)
- **Allowed MIME types**: `application/pdf, application/vnd.openxmlformats-officedocument.wordprocessingml.document, application/vnd.openxmlformats-officedocument.spreadsheetml.sheet, text/csv`
- **Max file size**: 10 MB

### Paso 4.2: Configurar Políticas de Storage

Para cada bucket, configura políticas de acceso:

#### Políticas para company-logos y product-images (públicos):

```sql
-- Permitir subida solo a usuarios autenticados
CREATE POLICY "Authenticated users can upload"
ON storage.objects FOR INSERT
TO authenticated
WITH CHECK (bucket_id = 'company-logos');

-- Permitir lectura pública
CREATE POLICY "Public can view"
ON storage.objects FOR SELECT
TO public
USING (bucket_id = 'company-logos');

-- Permitir borrado solo al dueño o admin
CREATE POLICY "Users can delete own files"
ON storage.objects FOR DELETE
TO authenticated
USING (bucket_id = 'company-logos' AND auth.uid() = owner);
```

#### Políticas para documents (privado):

```sql
-- Solo usuarios del mismo tenant pueden acceder
CREATE POLICY "Users can access tenant documents"
ON storage.objects FOR SELECT
TO authenticated
USING (
  bucket_id = 'documents' AND
  (storage.foldername(name))[1] = auth.jwt() ->> 'tenant_id'
);
```

---

## 5. Obtener Credenciales

### Paso 5.1: Obtener API Keys

1. Ve a **Settings > API**
2. Encontrarás las siguientes credenciales:

#### Project URL
```
https://xxxxxxxxxxxxx.supabase.co
```
Copia este valor para `SUPABASE_URL`

#### API Keys

**anon public** (anon key):
```
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
```
Copia este valor para `SUPABASE_KEY`

**service_role** (service role key):
```
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
```
⚠️ **IMPORTANTE**: Esta key tiene acceso completo. NO la expongas en el frontend.
Copia este valor para `SUPABASE_SERVICE_ROLE_KEY`

### Paso 5.2: Obtener JWT Secret

1. Sigue en **Settings > API**
2. Busca la sección "JWT Settings"
3. Copia el valor de **JWT Secret**:
```
tu-jwt-secret-super-secreto
```
Copia este valor para `SUPABASE_JWT_SECRET`

### Paso 5.3: Obtener Connection String

1. Ve a **Settings > Database**
2. Busca la sección "Connection string"
3. Selecciona "URI" y copia:
```
postgresql://postgres:[YOUR-PASSWORD]@db.xxxxxxxxxxxxx.supabase.co:5432/postgres
```
Reemplaza `[YOUR-PASSWORD]` con la contraseña que creaste en el Paso 1.1
Copia este valor para `DATABASE_URL`

---

## 6. Configurar Variables de Entorno

### Paso 6.1: Crear archivo .env (Backend)

1. En la carpeta `backend/`, copia `.env.example` a `.env`:
   ```bash
   cp .env.example .env
   ```

2. Edita el archivo `.env` con tus credenciales:

```env
# Información del Proyecto
PROJECT_NAME="Sistema de Gestión de Ferretería"
VERSION="0.1.0"
ENVIRONMENT="development"
DEBUG=true

# Seguridad
SECRET_KEY="genera-una-clave-secreta-aqui"  # Genera con: openssl rand -hex 32
ALGORITHM="HS256"
ACCESS_TOKEN_EXPIRE_MINUTES=30

# CORS
ALLOWED_ORIGINS="http://localhost:3000,http://localhost:5173"

# Base de Datos - Supabase PostgreSQL
DATABASE_URL="postgresql://postgres:TU_PASSWORD@db.xxxxxxxxxxxxx.supabase.co:5432/postgres"

# Supabase
SUPABASE_URL="https://xxxxxxxxxxxxx.supabase.co"
SUPABASE_KEY="tu-anon-key-aqui"
SUPABASE_JWT_SECRET="tu-jwt-secret-aqui"
SUPABASE_SERVICE_ROLE_KEY="tu-service-role-key-aqui"

# Supabase Storage
SUPABASE_STORAGE_BUCKET_LOGOS="company-logos"
SUPABASE_STORAGE_BUCKET_DOCUMENTS="documents"
SUPABASE_STORAGE_BUCKET_PRODUCTS="product-images"
SUPABASE_STORAGE_MAX_FILE_SIZE=5242880

# Supabase Auth
SUPABASE_AUTH_REDIRECT_URL="http://localhost:3000/auth/callback"
SUPABASE_AUTH_PASSWORD_MIN_LENGTH=8

# Logging
LOG_LEVEL="INFO"
```

### Paso 6.2: Generar SECRET_KEY

Ejecuta en terminal:
```bash
openssl rand -hex 32
```
Copia el resultado en `SECRET_KEY`

### Paso 6.3: Configurar variables en Frontend

1. En la carpeta `frontend/`, crea `.env.local`:

```env
NEXT_PUBLIC_SUPABASE_URL=https://xxxxxxxxxxxxx.supabase.co
NEXT_PUBLIC_SUPABASE_ANON_KEY=tu-anon-key-aqui
NEXT_PUBLIC_API_URL=http://localhost:8000
```

---

## 7. Verificar Configuración

### Paso 7.1: Instalar dependencias de Supabase

```bash
# En la carpeta backend/
pip install supabase
```

O si usas poetry:
```bash
poetry add supabase
```

### Paso 7.2: Probar conexión (Backend)

Crea un script de prueba `backend/test_supabase.py`:

```python
from app.core.supabase_client import supabase_client
from app.core.config import settings

def test_connection():
    """Prueba la conexión con Supabase"""
    try:
        client = supabase_client()
        print("✅ Conexión exitosa a Supabase")
        print(f"📍 URL: {settings.SUPABASE_URL}")
        
        # Probar query simple
        response = client.table('tenants').select("*").limit(1).execute()
        print(f"✅ Query a base de datos exitosa")
        print(f"📊 Tenants encontrados: {len(response.data)}")
        
    except Exception as e:
        print(f"❌ Error: {str(e)}")

if __name__ == "__main__":
    test_connection()
```

Ejecuta:
```bash
cd backend
python test_supabase.py
```

### Paso 7.3: Probar Auth

```python
from app.core.supabase_auth import SupabaseAuth
import asyncio

async def test_auth():
    """Prueba autenticación"""
    try:
        # Registrar usuario de prueba
        result = await SupabaseAuth.sign_up(
            email="test@example.com",
            password="test123456",
            metadata={"name": "Usuario de Prueba"}
        )
        print("✅ Registro exitoso")
        print(f"👤 Usuario: {result['user'].email}")
        
    except Exception as e:
        print(f"❌ Error: {str(e)}")

if __name__ == "__main__":
    asyncio.run(test_auth())
```

### Paso 7.4: Probar Storage

```python
from app.core.supabase_storage import SupabaseStorage
from fastapi import UploadFile
import asyncio

async def test_storage():
    """Prueba subida de archivos"""
    try:
        # Listar archivos en bucket
        files = await SupabaseStorage.list_files("company-logos")
        print(f"✅ Storage funcionando")
        print(f"📁 Archivos en company-logos: {len(files)}")
        
    except Exception as e:
        print(f"❌ Error: {str(e)}")

if __name__ == "__main__":
    asyncio.run(test_storage())
```

---

## ✅ Checklist Final

Marca cuando completes cada paso:

- [ ] ✅ Proyecto creado en Supabase
- [ ] ✅ Base de datos PostgreSQL configurada (schema ejecutado)
- [ ] ✅ Row Level Security (RLS) configurado
- [ ] ✅ Supabase Auth configurado (proveedores, URLs)
- [ ] ✅ JWT Settings configurados
- [ ] ✅ Buckets de Storage creados (company-logos, product-images, documents)
- [ ] ✅ Políticas de Storage configuradas
- [ ] ✅ Credenciales obtenidas (URL, anon key, service role key, JWT secret)
- [ ] ✅ Variables de entorno configuradas en `.env` (backend)
- [ ] ✅ Variables de entorno configuradas en `.env.local` (frontend)
- [ ] ✅ Dependencia `supabase` instalada
- [ ] ✅ Prueba de conexión exitosa
- [ ] ✅ Prueba de Auth exitosa
- [ ] ✅ Prueba de Storage exitosa

---

## 🔒 Seguridad: Buenas Prácticas

### ⚠️ NUNCA expongas estas credenciales:
- ❌ `SUPABASE_SERVICE_ROLE_KEY` en el frontend
- ❌ `SUPABASE_JWT_SECRET` en el frontend
- ❌ `DATABASE_URL` en el frontend

### ✅ SOLO usa en el frontend:
- ✅ `NEXT_PUBLIC_SUPABASE_URL`
- ✅ `NEXT_PUBLIC_SUPABASE_ANON_KEY`

### 🔐 Archivo .gitignore

Asegúrate de que tu `.gitignore` incluya:
```
.env
.env.local
.env.production
```

---

## 📚 Referencias

- [Documentación de Supabase](https://supabase.com/docs)
- [Supabase Auth](https://supabase.com/docs/guides/auth)
- [Supabase Storage](https://supabase.com/docs/guides/storage)
- [Row Level Security](https://supabase.com/docs/guides/auth/row-level-security)

---

## 🆘 Troubleshooting

### Error: "Invalid API key"
- Verifica que copiaste correctamente el `SUPABASE_KEY`
- Asegúrate de usar el anon key, no el service role key

### Error: "Connection refused"
- Verifica que el `SUPABASE_URL` sea correcto
- Asegúrate de que el proyecto en Supabase esté activo

### Error: "JWT expired"
- El token de acceso expira después de 1 hora
- Implementa refresh token para renovar automáticamente

### Error: "Permission denied" en Storage
- Verifica las políticas de RLS en el bucket
- Asegúrate de estar autenticado al subir archivos

---

**Issue #2 - Completada** ✅

Ahora puedes continuar con la **Issue #3: Configuración de CI/CD**.
