# 🗄️ Guía de Configuración de Supabase

Esta guía te llevará paso a paso para configurar Supabase como base de datos PostgreSQL y servicio de autenticación para el Sistema de Gestión de Ferretería.

## Prerrequisitos

- Cuenta en [Supabase](https://supabase.com)
- Acceso a internet

---

## Paso 1: Crear Proyecto en Supabase

1. **Acceder a Supabase**
   - Ve a [https://supabase.com](https://supabase.com)
   - Inicia sesión con tu cuenta (GitHub, Google, etc.)

2. **Crear nuevo proyecto**
   - Haz clic en "New Project"
   - Completa los siguientes campos:
     - **Name**: `sistema-gestion-ferreteria` (o el nombre que prefieras)
     - **Database Password**: Genera una contraseña segura y **guárdala**
     - **Region**: Selecciona la región más cercana (ej: South America - São Paulo)
     - **Pricing Plan**: Free (para desarrollo) o Pro (para producción)
   - Haz clic en "Create new project"
   - Espera 2-3 minutos mientras se provisiona el proyecto

3. **Acceder al Dashboard**
   - Una vez creado, serás redirigido al dashboard del proyecto
   - Aquí verás el estado de tu base de datos y servicios

---

## Paso 2: Obtener Credenciales

### 2.1 Credenciales de Base de Datos

1. En el dashboard, ve a **Settings** (⚙️) en el menú lateral izquierdo
2. Selecciona **Database**
3. Desplázate hasta **Connection String**
4. Copia la cadena de conexión en formato URI:
   ```
   postgresql://postgres:[YOUR-PASSWORD]@db.[PROJECT-REF].supabase.co:5432/postgres
   ```
5. Reemplaza `[YOUR-PASSWORD]` con la contraseña que generaste

### 2.2 Credenciales de API

1. Ve a **Settings** > **API**
2. Anota los siguientes valores:
   - **Project URL**: `https://[PROJECT-REF].supabase.co`
   - **anon/public key**: Empieza con `eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...`
   - **service_role key**: Solo para backend, **nunca expongas en frontend**

---

## Paso 3: Configurar Variables de Entorno

### 3.1 Backend (FastAPI)

Edita el archivo `backend/.env` con las credenciales:

```env
# Base de datos PostgreSQL
DATABASE_URL=postgresql://postgres:[YOUR-PASSWORD]@db.[PROJECT-REF].supabase.co:5432/postgres

# Supabase
SUPABASE_URL=https://[PROJECT-REF].supabase.co
SUPABASE_KEY=[SERVICE-ROLE-KEY]
SUPABASE_ANON_KEY=[ANON-KEY]
```

### 3.2 Frontend (Next.js)

Edita el archivo `frontend/.env.local` con las credenciales:

```env
# API Backend
NEXT_PUBLIC_API_URL=http://localhost:8000

# Supabase
NEXT_PUBLIC_SUPABASE_URL=https://[PROJECT-REF].supabase.co
NEXT_PUBLIC_SUPABASE_ANON_KEY=[ANON-KEY]
```

⚠️ **Importante**: 
- Solo usa variables con `NEXT_PUBLIC_` para el frontend
- NUNCA expongas el `service_role key` en el frontend

---

## Paso 4: Configurar Autenticación

1. En el dashboard de Supabase, ve a **Authentication** > **Providers**
2. Habilita los proveedores que desees:
   - **Email**: Ya viene habilitado por defecto
   - **Google**: Si quieres permitir login con Google
   - **GitHub**: Si quieres permitir login con GitHub

3. Configurar Email Templates (Opcional):
   - Ve a **Authentication** > **Email Templates**
   - Personaliza los correos de confirmación, recuperación de contraseña, etc.

4. Configurar URLs de redirección:
   - Ve a **Authentication** > **URL Configuration**
   - **Site URL**: `http://localhost:3000` (desarrollo)
   - **Redirect URLs**: Agrega:
     - `http://localhost:3000/auth/callback`
     - Tu dominio de producción cuando lo tengas

---

## Paso 5: Configurar Storage (Opcional)

Si necesitas almacenar archivos (imágenes de productos, documentos, etc.):

1. Ve a **Storage** en el menú lateral
2. Crea un nuevo bucket:
   - **Name**: `product-images` (o como desees)
   - **Public**: ✅ (si quieres que las imágenes sean públicas)
   - **File size limit**: Define el límite (ej: 5MB)
   - **Allowed MIME types**: `image/jpeg,image/png,image/webp,application/pdf`

3. Configura las políticas de acceso (RLS) según tus necesidades

---

## Paso 6: Verificar Conexión

### Verificar Backend

1. Asegúrate de tener tu entorno virtual activado:
   ```bash
   cd backend
   source venv/bin/activate  # En Windows: venv\Scripts\activate
   ```

2. Ejecuta el servidor:
   ```bash
   uvicorn app.main:app --reload
   ```

3. Visita `http://localhost:8000/docs` y verifica que cargue correctamente

### Verificar Frontend

1. Inicia el servidor de desarrollo:
   ```bash
   cd frontend
   npm run dev
   ```

2. Visita `http://localhost:3000` y abre la consola del navegador
3. No deberías ver errores relacionados con Supabase

---

## Paso 7: Crear Tablas Iniciales (Próxima Issue)

Las tablas de la base de datos se crearán en las siguientes issues mediante:
- Migraciones de Alembic (backend)
- O directamente desde el SQL Editor de Supabase

Por ahora, solo necesitas tener el proyecto configurado y las credenciales listas.

---

## Resumen de Credenciales Necesarias

| Variable | Ubicación | Descripción |
|----------|-----------|-------------|
| `DATABASE_URL` | Backend `.env` | Cadena de conexión PostgreSQL |
| `SUPABASE_URL` | Backend `.env` + Frontend `.env.local` | URL del proyecto |
| `SUPABASE_KEY` | Backend `.env` | Service role key (privada) |
| `SUPABASE_ANON_KEY` | Backend + Frontend | Anon/public key |

---

## Troubleshooting

### Error: "Connection refused"
- Verifica que la URL sea correcta
- Revisa que la contraseña esté correctamente escapada en la URL

### Error: "Invalid JWT"
- Verifica que las API keys sean correctas
- Asegúrate de no haber copiado espacios adicionales

### Error: "Database not found"
- El nombre de la base de datos debe ser `postgres` (por defecto en Supabase)

---

## Recursos Adicionales

- [Documentación de Supabase](https://supabase.com/docs)
- [Guía de Autenticación](https://supabase.com/docs/guides/auth)
- [Row Level Security (RLS)](https://supabase.com/docs/guides/database/postgres/row-level-security)
- [Supabase Python Client](https://supabase.com/docs/reference/python/introduction)

---

## ✅ Checklist de Verificación

Antes de continuar con la siguiente issue, verifica que:

- [ ] Proyecto creado en Supabase
- [ ] Credenciales obtenidas y guardadas de forma segura
- [ ] Variables de entorno configuradas en backend
- [ ] Variables de entorno configuradas en frontend
- [ ] Autenticación configurada (Email habilitado)
- [ ] Backend inicia sin errores de conexión
- [ ] Frontend inicia sin errores de conexión

¡Configuración completada! 🎉
