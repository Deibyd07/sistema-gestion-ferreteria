# Frontend - Sistema de Gestión de Ferretería

Aplicación web moderna construida con Next.js 14 para el sistema de gestión de ferreterías (SaaS Multi-tenant).

## 🚀 Tecnologías

- **Next.js** 14+ - Framework React con App Router
- **TypeScript** - Tipado estático
- **Tailwind CSS** - Framework de estilos
- **Supabase** - Cliente para autenticación y base de datos
- **React** 19+ - Biblioteca de UI

## 📁 Estructura del Proyecto

```
frontend/
├── src/
│   ├── app/                    # App Router de Next.js
│   │   ├── layout.tsx         # Layout principal
│   │   └── page.tsx           # Página de inicio
│   ├── components/             # Componentes React reutilizables
│   ├── lib/                    # Utilidades y configuraciones
│   │   ├── config.ts          # Configuración centralizada
│   │   ├── utils.ts           # Funciones auxiliares
│   │   └── supabase.ts        # Cliente de Supabase
│   ├── services/               # Servicios API
│   │   └── api-client.ts      # Cliente HTTP
│   ├── types/                  # Definiciones de tipos TypeScript
│   │   └── index.ts           # Tipos exportados
│   └── styles/                 # Estilos globales
├── public/                     # Archivos estáticos
├── .env.example               # Variables de entorno ejemplo
├── .env.local                 # Variables de entorno (no commitear)
└── README.md                  # Este archivo
```

## 🛠️ Instalación y Configuración

### 1. Requisitos Previos

- Node.js 18+
- npm, yarn, pnpm o bun
- Cuenta de Supabase configurada

### 2. Instalar Dependencias

```bash
npm install
# o
yarn install
# o
pnpm install
```

### 3. Configurar Variables de Entorno

```bash
# Copiar archivo de ejemplo
cp .env.example .env.local

# Editar .env.local con tus credenciales
# - NEXT_PUBLIC_API_URL (URL del backend)
# - NEXT_PUBLIC_SUPABASE_URL
# - NEXT_PUBLIC_SUPABASE_ANON_KEY
# - NEXT_PUBLIC_SENTRY_DSN (opcional, monitoreo)
```

> 📘 **Configurar Supabase**: Consulta la guía [SUPABASE_SETUP.md](../SUPABASE_SETUP.md) en la raíz del proyecto para instrucciones detalladas sobre cómo crear y configurar tu proyecto de Supabase.

## 🚀 Ejecutar la Aplicación

### Modo Desarrollo

```bash
npm run dev
# o
yarn dev
# o
pnpm dev
```

La aplicación estará disponible en [http://localhost:3000](http://localhost:3000)

## 🛡️ Sentry (Opcional)

Para habilitar monitoreo en produccion:

1. Crea un proyecto en Sentry.
2. Configura `NEXT_PUBLIC_SENTRY_DSN` en `.env.local`.
3. Si quieres subir sourcemaps en build, agrega `SENTRY_ORG`, `SENTRY_PROJECT` y `SENTRY_AUTH_TOKEN`.

### Modo Producción

```bash
# Construir la aplicación
npm run build

# Ejecutar en producción
npm run start
```

## 🧪 Linting

```bash
# Ejecutar ESLint
npm run lint
```

## 📦 Bibliotecas Principales

- **@supabase/supabase-js**: Cliente oficial de Supabase para JavaScript
- **Tailwind CSS**: Framework de utilidades CSS
- **TypeScript**: Superset de JavaScript con tipado estático

## 🎨 Arquitectura

Este proyecto sigue las mejores prácticas de Next.js 14 con App Router:

- **App Router**: Sistema de enrutamiento basado en el sistema de archivos
- **Server Components**: Renderizado del lado del servidor por defecto
- **Client Components**: Componentes interactivos marcados con `'use client'`
- **API Integration**: Servicios centralizados para llamadas al backend
- **Type Safety**: TypeScript en todo el proyecto

### Estructura de Capas

- **Presentation Layer**: Componentes de UI (React)
- **Service Layer**: Lógica de comunicación con APIs
- **Type Layer**: Definiciones de tipos compartidos
- **Configuration**: Gestión centralizada de configuración

## 🔐 Integración con Supabase

El cliente de Supabase está configurado en `src/lib/supabase.ts` y proporciona:

- **Autenticación**: Login, registro, recuperación de contraseña
- **Consultas a BD**: Acceso directo a tablas mediante PostgREST
- **Storage**: Subida y gestión de archivos
- **Realtime**: Subscripciones a cambios en tiempo real

### Ejemplo de Uso

```typescript
import { supabase } from '@/lib/supabase';

// Autenticación
const { data, error } = await supabase.auth.signInWithPassword({
  email: 'user@example.com',
  password: 'password123'
});

// Consulta
const { data: products } = await supabase
  .from('products')
  .select('*')
  .limit(10);
```

## 📝 Convenciones de Código

- Usar **camelCase** para variables y funciones
- Usar **PascalCase** para componentes y clases
- Usar **kebab-case** para nombres de archivos
- Organizar imports: React → Next.js → Externos → Internos
- Documentar componentes complejos con JSDoc
- Prefijar componentes cliente con `'use client'`

## 🔗 Enlaces Útiles

- [Documentación de Next.js](https://nextjs.org/docs)
- [Documentación de Supabase](https://supabase.com/docs)
- [Documentación de Tailwind CSS](https://tailwindcss.com/docs)
- [TypeScript Handbook](https://www.typescriptlang.org/docs/)

## 🤝 Contribución

1. Crear rama feature: `git checkout -b feature/nueva-funcionalidad`
2. Commit cambios: `git commit -m 'Add: nueva funcionalidad'`
3. Push a la rama: `git push origin feature/nueva-funcionalidad`
4. Crear Pull Request

## 📄 Licencia

Por definir

