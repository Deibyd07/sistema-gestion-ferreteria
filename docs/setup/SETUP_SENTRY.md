# 🛡️ Guía Completa de Configuración de Sentry

Guía paso a paso para integrar Sentry en el Sistema de Gestión de Ferretería (backend FastAPI + frontend Next.js).

## 📋 ¿Qué es Sentry?

Sentry es una plataforma de monitoreo de errores y performance que te ayuda a:
- **Detectar errores** en tiempo real en producción
- **Monitorear performance** (tiempos de respuesta, consultas lentas)
- **Recibir alertas** cuando algo falla
- **Ver stacktraces completos** con contexto del error
- **Entender el impacto** (cuántos usuarios afectados)

---

## 🎯 Paso 1: Crear Cuenta en Sentry

### 1.1. Registrarse

1. Ve a [https://sentry.io](https://sentry.io)
2. Haz clic en **"Get Started"** o **"Sign Up"**
3. Opciones de registro:
   - Email y contraseña
   - GitHub (recomendado si tu proyecto está en GitHub)
   - Google
   - Azure DevOps

4. Completa el formulario:
   - Nombre completo
   - Email
   - Contraseña (si usas email)

5. Verifica tu email si es necesario

### 1.2. Crear Organización

Después del registro, Sentry te pedirá crear una **Organización**:
- **Nombre**: Ej: "Ferretería SaaS" o el nombre de tu empresa
- **Slug**: URL amigable (ej: `ferreteria-saas`)
- Esto será tu namespace en Sentry

> 💡 **Nota**: Puedes usar el plan **gratuito** que incluye:
> - 5,000 errores por mes
> - 10,000 transacciones de performance
> - Retención de 90 días
> - 1 usuario

---

## 🎯 Paso 2: Crear Proyectos en Sentry

Crearemos **dos proyectos**: uno para backend y otro para frontend.

### 2.1. Crear Proyecto Backend (FastAPI)

1. En el dashboard de Sentry, haz clic en **"Create Project"**
2. Selecciona la plataforma: **Python** o busca **FastAPI**
3. Configura:
   - **Alert frequency**: "Alert me on every new issue" (al inicio)
   - **Project name**: `ferreteria-backend` o `backend-api`
   - **Team**: Default es suficiente
4. Haz clic en **"Create Project"**

### 2.2. Obtener DSN del Backend

Después de crear el proyecto:

1. Serás redirigido a la página de configuración
2. Verás el **DSN** (Data Source Name) - se ve así:
   ```
   https://abc123def456@o1234567.ingest.sentry.io/7654321
   ```
3. **Copia este DSN** - lo necesitarás más adelante
4. También verás código de ejemplo - puedes ignorarlo por ahora

> 💡 **¿Qué es el DSN?**: Es la URL que identifica tu proyecto. Es seguro compartirlo en el código cliente.

### 2.3. Crear Proyecto Frontend (Next.js)

1. Regresa al dashboard principal (logo de Sentry arriba a la izquierda)
2. Haz clic en **"Create Project"** nuevamente
3. Selecciona la plataforma: **Next.js**
4. Configura:
   - **Project name**: `ferreteria-frontend` o `frontend-web`
   - **Team**: Default
5. Haz clic en **"Create Project"**
6. **Copia el DSN** de este proyecto también

### 2.4. Ubicar tus Proyectos

Los proyectos aparecerán en:
- **Dashboard principal**: Lista de proyectos
- **URL**: `https://sentry.io/organizations/TU-ORG/projects/`

---

## 🎯 Paso 3: Obtener Credenciales para Source Maps (Frontend)

Para que Sentry muestre código fuente legible en errores de producción:

### 3.1. Crear Auth Token

1. Haz clic en tu avatar (esquina superior derecha)
2. Selecciona **"User Settings"** o tu nombre de usuario
3. En el menú lateral, bajo la sección **"Developer Settings"**, haz clic en **"Personal Tokens"**
4. Haz clic en **"Create New Token"**
5. Configura el token:
   - **Name**: "Next.js Source Maps"
   - **Scopes** (permisos necesarios):
     - ✅ `project:read`
     - ✅ `project:releases`
     - ✅ `org:read`
   - **Organization**: Selecciona tu organización
6. Haz clic en **"Create Token"**
7. **Copia el token inmediatamente** - no podrás verlo después
   - Se ve así: `sntrys_abc123def456...` (muy largo)

### 3.2. Obtener Organization Slug

1. Ve a **Organization Settings** (ícono de engranaje)
2. En **General Settings**, verás:
   - **Organization Slug**: Ej: `ferreteria-saas`
3. Cópialo, lo necesitarás

### 3.3. Obtener Project Slug

1. Ve a tu proyecto de frontend
2. Haz clic en **Settings** (engranaje del proyecto)
3. En **General Settings**, verás:
   - **Project Slug**: Ej: `ferreteria-frontend`
4. Cópialo

---

## 🎯 Paso 4: Configurar Backend (FastAPI)

### 4.1. Instalar Dependencias

El proyecto ya incluye Sentry en `requirements.txt`, instálalo:

```bash
cd backend
pip install -r requirements.txt
```

### 4.2. Configurar Variables de Entorno

Edita `backend/.env` y agrega:

```bash
# Sentry - Monitoreo y Performance
SENTRY_DSN="https://TU-DSN-BACKEND@o1234567.ingest.sentry.io/7654321"
SENTRY_TRACES_SAMPLE_RATE=0.1
SENTRY_PROFILES_SAMPLE_RATE=0.0
ENVIRONMENT=development
```

**Explicación de las variables:**

- **SENTRY_DSN**: El DSN que copiaste del proyecto backend
- **SENTRY_TRACES_SAMPLE_RATE**: 
  - `0.1` = 10% de requests envían tracing de performance
  - `1.0` = 100% (úsalo si pagas plan Pro y quieres todo)
  - `0.0` = deshabilitado
- **SENTRY_PROFILES_SAMPLE_RATE**: 
  - Profiling avanzado (generalmente déjalo en `0.0` al inicio)
- **ENVIRONMENT**: `development`, `staging` o `production`

### 4.3. Verificar Integración

El código ya está integrado en `app/main.py`. Verifica que se ve así:

```python
if settings.SENTRY_DSN:
    sentry_sdk.init(
        dsn=settings.SENTRY_DSN,
        environment=settings.ENVIRONMENT,
        release=f"{settings.PROJECT_NAME}@{settings.VERSION}",
        traces_sample_rate=settings.SENTRY_TRACES_SAMPLE_RATE,
        profiles_sample_rate=settings.SENTRY_PROFILES_SAMPLE_RATE,
        integrations=[FastApiIntegration()],
    )
```

### 4.4. Probar Backend

1. Inicia el servidor:
   ```bash
   uvicorn app.main:app --reload
   ```

2. Abre tu navegador y ve a: `http://localhost:8000`

3. Sentry debería capturar el inicio automáticamente

4. **Provocar un error de prueba**:
   - Agrega temporalmente esta ruta en `main.py`:
   ```python
   @app.get("/sentry-test")
   def trigger_error():
       division_by_zero = 1 / 0
       return {"message": "This won't work"}
   ```
   
5. Visita: `http://localhost:8000/sentry-test`

6. Ve a Sentry → Issues → Deberías ver el error `ZeroDivisionError`

7. **Elimina la ruta de prueba después**

---

## 🎯 Paso 5: Configurar Frontend (Next.js)

### 5.1. Instalar Dependencias

```bash
cd frontend
npm install
```

### 5.2. Configurar Variables de Entorno

Edita `frontend/.env.local` y agrega:

```bash
# Sentry - Monitoreo (Cliente)
NEXT_PUBLIC_SENTRY_DSN=https://TU-DSN-FRONTEND@o1234567.ingest.sentry.io/9876543
NEXT_PUBLIC_SENTRY_ENVIRONMENT=development
NEXT_PUBLIC_SENTRY_TRACES_SAMPLE_RATE=0.1

# Sentry - Monitoreo (Servidor Next.js)
SENTRY_DSN=https://TU-DSN-FRONTEND@o1234567.ingest.sentry.io/9876543
SENTRY_ENVIRONMENT=development
SENTRY_TRACES_SAMPLE_RATE=0.1
SENTRY_PROFILES_SAMPLE_RATE=0.0

# Sentry - Source Maps (Opcional, para producción)
SENTRY_ORG=ferreteria-saas
SENTRY_PROJECT=ferreteria-frontend
SENTRY_AUTH_TOKEN=sntrys_abc123def456...
```

**Variables Frontend vs Backend:**

- **NEXT_PUBLIC_**: Variables visibles en el navegador (cliente)
- Sin prefijo: Variables solo en el servidor Next.js

### 5.3. Verificar Configuración

Los archivos de configuración ya fueron creados:
- `sentry.client.config.ts` - Errores del navegador
- `sentry.server.config.ts` - Errores del servidor Next.js
- `sentry.edge.config.ts` - Errores en Edge Runtime
- `next.config.ts` - Integración con Webpack

### 5.4. Probar Frontend

1. Inicia el servidor:
   ```bash
   npm run dev
   ```

2. Abre: `http://localhost:3000`

3. **Provocar error de prueba en cliente**:
   - Crea una página temporal `src/app/test-sentry/page.tsx`:
   ```tsx
   "use client";
   
   export default function TestSentry() {
     const triggerError = () => {
       throw new Error("Este es un error de prueba en el cliente");
     };
     
     return (
       <div className="p-8">
         <button 
           onClick={triggerError}
           className="bg-red-500 text-white px-4 py-2 rounded"
         >
           Provocar Error de Prueba
         </button>
       </div>
     );
   }
   ```

4. Ve a: `http://localhost:3000/test-sentry`

5. Haz clic en el botón

6. Ve a Sentry → Proyecto Frontend → Issues → Verás el error

7. **Elimina la página de prueba después**

---

## 🎯 Paso 6: Configurar Alertas

### 6.1. Alertas de Email (Por Defecto)

Por defecto, Sentry envía emails cuando:
- Aparece un error nuevo
- Un error resuelto vuelve a ocurrir
- Aumenta la frecuencia de un error

### 6.2. Configurar Alertas Personalizadas

1. Ve a **Alerts** en el menú lateral
2. Haz clic en **"Create Alert"**
3. Plantillas recomendadas:

**Alert 1: Errores Críticos**
- **When**: An issue is first seen
- **If**: issue.level equals error or fatal
- **Then**: Send notification via Email

**Alert 2: Muchos Errores**
- **When**: An event is captured
- **If**: Event count in 1 hour is above 100
- **Then**: Send notification

**Alert 3: Performance Degradado**
- **When**: A metric value is above/below threshold
- **If**: p95 response time > 1000ms
- **Then**: Send notification

### 6.3. Integraciones (Opcional)

Puedes integrar Sentry con:
- **Slack**: Notificaciones en canal
- **Discord**: Webhook
- **PagerDuty**: Para on-call
- **Jira**: Crear tickets automáticos

---

## 🎯 Paso 7: Mejores Prácticas

### 7.1. Configuración por Entorno

**Desarrollo (local):**
```bash
ENVIRONMENT=development
SENTRY_TRACES_SAMPLE_RATE=1.0  # 100% para detectar todo
```

**Staging:**
```bash
ENVIRONMENT=staging
SENTRY_TRACES_SAMPLE_RATE=0.5  # 50%
```

**Producción:**
```bash
ENVIRONMENT=production
SENTRY_TRACES_SAMPLE_RATE=0.1  # 10% (suficiente para millones de requests)
```

### 7.2. Source Maps en Producción

Los **Source Maps** permiten ver el código fuente original en Sentry cuando ocurren errores en producción, en lugar de código JavaScript minificado e ilegible.

#### ¿Qué son los Source Maps?

Cuando haces build de tu app Next.js para producción:
- El código se **minifica** (reduce tamaño)
- Las variables se **renombran** (`userName` → `a`)
- El código se **comprime** en archivos pequeños

Sin Source Maps, los errores en Sentry mostrarían:
```javascript
TypeError: Cannot read property 'a' of undefined at b.c (main-abc123.js:1:2345)
```

Con Source Maps configurados, verás:
```javascript
TypeError: Cannot read property 'userData' of undefined
  at UserProfile.render (components/UserProfile.tsx:45:12)
```

#### Configuración (Ya incluida en el proyecto)

El archivo `next.config.ts` ya tiene la configuración necesaria:

```typescript
const sentryWebpackPluginOptions = {
  authToken: process.env.SENTRY_AUTH_TOKEN,    // Token de autenticación
  org: process.env.SENTRY_ORG,                 // Tu organización en Sentry
  project: process.env.SENTRY_PROJECT,         // Nombre del proyecto
  silent: true,                                // No mostrar logs en build
  dryRun: !process.env.SENTRY_AUTH_TOKEN,     // Solo subir si hay token
};

export default withSentryConfig(nextConfig, sentryWebpackPluginOptions, {
  hideSourceMaps: true,      // ✅ Ocultar source maps del público
  disableLogger: true,       // ✅ Reducir logs en producción
});
```

**Opciones importantes:**
- **`hideSourceMaps: true`**: Los source maps se suben a Sentry pero NO se exponen públicamente (seguridad)
- **`dryRun`**: Si no hay `SENTRY_AUTH_TOKEN`, hace un "dry run" (no sube nada)

#### Pasos para habilitar Source Maps

1. **Copia `.env.local.example` a `.env.local`**:
   ```bash
   cp .env.local.example .env.local
   ```

2. **Configura las variables en `.env.local`**:
   ```bash
   # Estas 3 variables son necesarias para Source Maps
   SENTRY_ORG=tu-organization-slug          # Ej: ferreteria-saas
   SENTRY_PROJECT=tu-project-slug           # Ej: ferreteria-frontend
   SENTRY_AUTH_TOKEN=sntrys_tu-token-aqui   # Token con permisos
   ```

   > 💡 **Cómo obtener el Auth Token**: Ver [Paso 3.1](#31-crear-auth-token) de esta guía

3. **Hacer build de producción**:
   ```bash
   npm run build
   ```

4. **Verificar que se subieron**:
   - Durante el build verías (si no está en `silent: true`):
     ```
     ✓ Source maps uploaded to Sentry
     ```
   - En Sentry: Proyecto → Settings → Source Maps → Verás los archivos subidos

#### Cómo funciona en producción

1. **Sin Source Maps**:
   - Build: `npm run build` → genera archivos minificados
   - Deploy: Usuarios descargan código comprimido
   - Error: Sentry muestra código minificado 😞

2. **Con Source Maps** (configurado en este proyecto):
   - Build: `npm run build` 
     - Genera archivos minificados para usuarios
     - **Sube source maps a Sentry** (en privado)
     - **NO incluye source maps en el bundle público** (`hideSourceMaps: true`)
   - Deploy: Usuarios solo descargan código comprimido (rápido)
   - Error: Sentry usa los source maps almacenados para mostrar código legible ✅

#### Seguridad

- ✅ **Source maps NO se exponen al público** (`hideSourceMaps: true`)
- ✅ Solo Sentry puede acceder a ellos (en su servidor)
- ✅ Los usuarios descargan código minificado normal
- ✅ Tu código fuente NO es visible en DevTools del navegador

#### Testing en desarrollo

Para probar source maps en desarrollo (opcional):

```bash
# 1. Hacer build local
npm run build

# 2. Iniciar en modo producción
npm start

# 3. Provocar error y verificar en Sentry que aparece código fuente legible
```

### 7.3. Filtrar Errores de Bots

En `sentry.client.config.ts`, puedes agregar:

```typescript
Sentry.init({
  dsn: process.env.NEXT_PUBLIC_SENTRY_DSN,
  beforeSend(event, hint) {
    // Ignorar errores de extensiones de navegador
    if (event.exception?.values?.[0]?.value?.includes('chrome-extension://')) {
      return null;
    }
    return event;
  },
});
```

### 7.4. Contexto Adicional

Agregar información del usuario:

**Backend:**
```python
from sentry_sdk import set_user

set_user({
    "id": user.id,
    "email": user.email,
    "username": user.username,
    "tenant_id": user.tenant_id
})
```

**Frontend:**
```typescript
import * as Sentry from "@sentry/nextjs";

Sentry.setUser({
  id: user.id,
  email: user.email,
  username: user.username,
});
```

---

## ✅ Verificación Final

### Checklist Backend ✓
- [ ] `SENTRY_DSN` configurado en `.env`
- [ ] Servidor inicia sin errores
- [ ] Ruta de prueba genera error visible en Sentry
- [ ] Error muestra información del entorno correcto

### Checklist Frontend ✓
- [ ] `NEXT_PUBLIC_SENTRY_DSN` configurado en `.env.local`
- [ ] `SENTRY_ORG`, `SENTRY_PROJECT` y `SENTRY_AUTH_TOKEN` configurados en `.env.local`
- [ ] Archivo `.env.local.example` como referencia disponible
- [ ] App inicia sin errores
- [ ] Error de prueba aparece en Sentry
- [ ] `npm run build` se ejecuta sin errores
- [ ] Source maps se suben correctamente (verificar en Sentry → Settings → Source Maps)
- [ ] Errores en Sentry muestran código fuente real, no minificado

### Checklist Alertas ✓
- [ ] Recibes email cuando ocurre un error nuevo
- [ ] Alertas configuradas según necesidad
- [ ] Integración con Slack/Discord (opcional)

---

## 🆘 Solución de Problemas

### Error: "Sentry not initialized"

**Causa**: DSN no configurado o inválido

**Solución**:
- Verifica que el DSN esté en `.env` (backend) y `.env.local` (frontend)
- Verifica que no tenga espacios extra
- Reinicia el servidor

### Error: "Authentication required"

**Causa**: `SENTRY_AUTH_TOKEN` inválido o sin permisos

**Solución**:
- Genera nuevo token con los scopes correctos
- Verifica que no haya espacios extra
- El token debe tener permisos `project:releases`

### Los Source Maps no suben

**Causa**: Variables de build no configuradas o token sin permisos

**Solución**:

1. **Verifica las variables en `.env.local`**:
   ```bash
   # Deben estar las 3 variables:
   SENTRY_ORG=tu-org-slug
   SENTRY_PROJECT=tu-project-slug
   SENTRY_AUTH_TOKEN=sntrys_abc123...
   ```

2. **Verifica que no haya espacios extra o comillas incorrectas**:
   ```bash
   # ❌ Incorrecto
   SENTRY_ORG="mi-org"
   SENTRY_AUTH_TOKEN= sntrys_abc...
   
   # ✅ Correcto
   SENTRY_ORG=mi-org
   SENTRY_AUTH_TOKEN=sntrys_abc...
   ```

3. **Verifica permisos del token** (debe tener):
   - `project:read`
   - `project:releases`
   - `org:read`

4. **Regenera el token si es necesario**:
   - Sentry → Settings → Auth Tokens → Create New Token
   - Selecciona los 3 permisos mencionados

5. **Ejecuta build nuevamente**:
   ```bash
   npm run build
   ```

6. **Verifica en Sentry**:
   - Proyecto → Settings → Source Maps
   - Deberías ver los archivos `.map` subidos con el release correspondiente

**Si sigue sin funcionar**:
```bash
# Verificar que next.config.ts tiene la configuración
cat next.config.ts | grep withSentryConfig

# Limpiar cache y rebuilder
rm -rf .next
npm run build
```

### Demasiados errores en Sentry

**Causa**: Errores repetitivos o bots

**Solución**:
- Usa filtros `beforeSend` en la configuración
- Reduce `SENTRY_TRACES_SAMPLE_RATE` en producción
- Marca errores conocidos como "Resolved" o "Ignored"

---

## 🧪 Pruebas de Integración de Sentry

Para verificar que Sentry funciona correctamente en ambos entornos (frontend y backend), hemos creado una página de pruebas interactiva.

### Ubicación de las Pruebas

- **Frontend**: `http://localhost:3000/test-sentry`
- **Endpoints Backend**:
  - `/sentry-test` - Genera error intencional
  - `/sentry-test-message` - Envía mensaje de prueba

### Cómo Ejecutar las Pruebas

#### Paso 1: Iniciar los Servidores

**Backend:**
```bash
cd backend
uvicorn app.main:app --reload
# Debe estar corriendo en http://localhost:8000
```

**Frontend:**
```bash
cd frontend
npm run dev
# Debe estar corriendo en http://localhost:3000
```

#### Paso 2: Abrir la Página de Pruebas

1. Ve a: `http://localhost:3000/test-sentry`
2. Abre las herramientas de desarrollo (F12) para ver los logs

#### Paso 3: Ejecutar Pruebas de Frontend

**Prueba 1: Error de Cliente**
1. Haz clic en el botón **"💥 Generar Error de Cliente"**
2. Verás una alerta con el Event ID
3. El error será capturado por Sentry

**Prueba 2: Mensaje de Info**
1. Haz clic en el botón **"💬 Enviar Mensaje de Info"**
2. Verás una alerta confirmando el envío
3. El mensaje aparecerá en Sentry

#### Paso 4: Ejecutar Pruebas de Backend

**Prueba 3: Error en Backend**
1. Haz clic en el botón **"🔥 Generar Error en Backend"**
2. El frontend llamará al endpoint `/sentry-test`
3. El backend generará un error de división por cero
4. Verás el estado en pantalla

**Prueba 4: Mensaje desde Backend**
1. Haz clic en el botón **"📨 Enviar Mensaje desde Backend"**
2. El frontend llamará al endpoint `/sentry-test-message`
3. El backend enviará un mensaje a Sentry
4. Verás confirmación en pantalla

### Verificar Resultados en Sentry

#### Para Frontend (Next.js)

1. Ve a: `https://sentry.io`
2. Selecciona tu organización
3. Haz clic en el proyecto **"ferreteria-frontend"**
4. Ve a **Issues**
5. Deberías ver:
   - Error: "🔴 Error de prueba - Frontend (cliente)"
   - Mensaje: "💬 Mensaje de prueba - Frontend"

#### Para Backend (FastAPI)

1. En el mismo dashboard de Sentry
2. Cambia al proyecto **"ferreteria-backend"** (selector arriba)
3. Ve a **Issues**
4. Deberías ver:
   - Error: "ZeroDivisionError: division by zero"
   - Mensaje: "Mensaje de prueba desde FastAPI Backend"

### Información en los Issues

Cada issue en Sentry mostrará:
- **Stack trace completo**: Líneas exactas donde ocurrió el error
- **Contexto**: Variables, estado de la aplicación
- **Breadcrumbs**: Eventos previos al error
- **User info**: IP, navegador, sistema operativo
- **Release**: Versión de la aplicación
- **Environment**: development, staging, production
- **Timestamp**: Cuándo ocurrió

### Solución de Problemas en Pruebas

#### Frontend: No aparecen errores en Sentry

**Verificar:**
```bash
# En frontend/.env.local
NEXT_PUBLIC_SENTRY_DSN="tu-dsn-aquí"
```

**Reiniciar el servidor:**
```bash
# Ctrl+C para detener
npm run dev
```

#### Backend: No aparecen errores en Sentry

**Verificar:**
```bash
# En backend/.env
SENTRY_DSN="tu-dsn-aquí"
```

**Revisar logs del servidor:**
```bash
# Deberías ver en la consola:
# "Sentry inicializado correctamente"
```

#### Error: Cannot connect to backend

**Verificar:**
1. Backend está corriendo en `http://localhost:8000`
2. Visita: `http://localhost:8000/docs` (debe abrir FastAPI docs)
3. CORS está configurado correctamente en `main.py`

**Verificar variable de entorno:**
```bash
# En frontend/.env.local
NEXT_PUBLIC_API_URL=http://localhost:8000
```

### Pruebas en Producción

Cuando despliegues a producción:

1. **Actualiza las variables de entorno** con los valores de producción
2. **Cambia ENVIRONMENT** a `production`
3. **Reduce sample rates** para evitar límites:
   ```bash
   SENTRY_TRACES_SAMPLE_RATE=0.1  # Solo 10% de requests
   ```
4. **Ejecuta las pruebas** llamando a tu dominio real
5. **Verifica** que los errores aparecen con `environment: production`

### Limpiar Issues de Prueba

Después de probar:

1. Ve a Sentry → Issues
2. Selecciona los issues de prueba
3. Haz clic en **"Resolve"** o **"Delete"**
4. O simplemente ignóralos - se resolverán automáticamente si no vuelven a ocurrir

---

## 📚 Recursos Adicionales

- **Documentación Sentry**: https://docs.sentry.io
- **Sentry Python (FastAPI)**: https://docs.sentry.io/platforms/python/guides/fastapi/
- **Sentry Next.js**: https://docs.sentry.io/platforms/javascript/guides/nextjs/
- **Best Practices**: https://docs.sentry.io/product/best-practices/

---

## 🎉 ¡Listo!

Ahora tienes Sentry completamente configurado para monitorear errores y performance en producción. 

**Próximos pasos:**
1. Despliega a producción con las variables configuradas
2. Monitorea el dashboard de Sentry regularmente
3. Resuelve errores a medida que aparecen
4. Ajusta alertas según tus necesidades
