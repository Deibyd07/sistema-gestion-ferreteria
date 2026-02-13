# Frontend - Vue 3 + TypeScript + Vite

Sistema de gestión de ferretería - Frontend desarrollado con Vue 3, TypeScript, Pinia y Tailwind CSS.

## 🚀 Tecnologías

- **Vue 3** - Framework progresivo de JavaScript
- **TypeScript** - Tipado estático para JavaScript
- **Vite** - Build tool moderno y rápido
- **Pinia** - Store de estado oficial para Vue
- **Vue Router** - Router oficial de Vue
- **Tailwind CSS** - Framework de CSS utility-first
- **Axios** - Cliente HTTP
- **Sentry** - Monitoreo de errores (opcional)

## 📋 Requisitos Previos

- Node.js >= 20.19.0 o >= 22.12.0
- npm o yarn

## 🛠️ Instalación

1. **Instalar dependencias:**
```bash
npm install
```

2. **Configurar variables de entorno:**
```bash
cp .env.example .env
```

Editar el archivo `.env` con tus configuraciones:
```env
VITE_API_URL=http://localhost:8000/api/v1
VITE_SUPABASE_URL=your_supabase_url
VITE_SUPABASE_ANON_KEY=your_supabase_anon_key
VITE_SENTRY_DSN=your_sentry_dsn  # Opcional
VITE_ENVIRONMENT=development
```

## 🏃 Ejecución

### Desarrollo
```bash
npm run dev
```
La aplicación estará disponible en `http://localhost:5173`

### Build para Producción
```bash
npm run build
```

### Preview del Build
```bash
npm run preview
```

### Linting
```bash
npm run lint
```

### Type Checking
```bash
npm run type-check
```

## 📁 Estructura del Proyecto

```
frontend/
├── public/              # Archivos estáticos
├── src/
│   ├── assets/         # Recursos (CSS, imágenes)
│   │   └── main.css   # Estilos globales con Tailwind
│   ├── components/     # Componentes reutilizables
│   ├── router/         # Configuración de rutas
│   │   └── index.ts   # Router con navigation guards
│   ├── services/       # Servicios de API
│   │   ├── api-client.ts      # Cliente Axios configurado
│   │   └── auth.service.ts    # Servicio de autenticación
│   ├── stores/         # Stores de Pinia
│   │   └── auth.ts    # Store de autenticación
│   ├── views/          # Vistas/Páginas
│   │   ├── auth/
│   │   │   ├── LoginView.vue
│   │   │   ├── RegisterView.vue
│   │   │   └── ForgotPasswordView.vue
│   │   └── DashboardView.vue
│   ├── App.vue         # Componente raíz
│   └── main.ts         # Punto de entrada
├── .env                # Variables de entorno (no commiteado)
├── .env.example        # Ejemplo de variables de entorno
├── index.html          # HTML principal
├── package.json        # Dependencias y scripts
├── tailwind.config.js  # Configuración de Tailwind
├── tsconfig.json       # Configuración de TypeScript
└── vite.config.ts      # Configuración de Vite
```

## 🔐 Autenticación

El sistema utiliza **Pinia** para el manejo de estado de autenticación:

### Store de Autenticación (`stores/auth.ts`)
- `user` - Usuario actual
- `accessToken` - Token de acceso JWT
- `isLoading` - Estado de carga
- `isAuthenticated` - Estado de autenticación

### Acciones disponibles:
- `initializeAuth()` - Inicializar desde localStorage
- `login(email, password)` - Iniciar sesión
- `register(data)` - Registrar usuario
- `logout()` - Cerrar sesión
- `refreshSession()` - Refrescar token

### Navigation Guards

Las rutas están protegidas con navigation guards:

```typescript
// Ruta protegida (requiere autenticación)
{
  path: '/dashboard',
  meta: { requiresAuth: true }
}

// Ruta para invitados (solo sin autenticación)
{
  path: '/auth/login',
  meta: { requiresGuest: true }
}
```

## 🎨 Tailwind CSS

El proyecto usa Tailwind CSS v4 con configuración personalizada:

### Colores de marca
- `brand-{50-900}` - Colores azules corporativos
- `neutral-{0-950}` - Escala de grises

### Utilidades personalizadas
- `.gradient-primary` - Gradiente azul-morado
- `.gradient-accent` - Gradiente rosa-rojo
- `.gradient-success` - Gradiente verde-cyan
- `.glass-effect` - Efecto glassmorphism
- `.hover-lift` - Elevación al hover

### Animaciones
- `animate-fade-in` - Fade in suave
- `animate-slide-up` - Deslizamiento hacia arriba
- `animate-pulse-glow` - Pulso con brillo
- `animate-float` - Flotación continua

## 🔌 API Client

El cliente HTTP está configurado con interceptors:

### Request Interceptor
- Agrega automáticamente el token de autenticación a las peticiones

### Response Interceptor
- Maneja errores 401 automáticamente
- Refresca el token si es necesario
- Redirige al login si falla el refresh

## 📝 Migraciones desde Next.js

Este proyecto fue migrado de Next.js a Vue 3. Principales cambios:

| Next.js | Vue 3 |
|---------|-------|
| Context API | Pinia Store |
| useRouter (Next) | useRouter (Vue Router) |
| pages/ | views/ |
| Link | router-link |
| useEffect | onMounted |
| useState | ref |

## 🐛 Debugging

### Errores comunes

1. **CORS Error**: Verifica que el backend tenga configurado el CORS correctamente
2. **401 Unauthorized**: Verifica que el token esté presente en localStorage
3. **Network Error**: Verifica que la API esté corriendo en el puerto correcto

### Vue DevTools

Instala [Vue.js devtools](https://devtools.vuejs.org/) para debugging avanzado:
- Inspección de componentes
- Estado de Pinia
- Router
- Timeline de eventos

## 📦 Build y Deployment

### Variables de entorno para producción

Asegúrate de configurar en tu servidor:
```env
VITE_API_URL=https://api.tudominio.com/api/v1
VITE_SUPABASE_URL=https://tu-proyecto.supabase.co
VITE_SUPABASE_ANON_KEY=tu_anon_key
VITE_SENTRY_DSN=tu_sentry_dsn
VITE_ENVIRONMENT=production
```

### Build optimizado
```bash
npm run build
```

Los archivos se generarán en `dist/`

## 🤝 Contribución

1. Fork el proyecto
2. Crea una rama (`git checkout -b feature/AmazingFeature`)
3. Commit tus cambios (`git commit -m 'Add some AmazingFeature'`)
4. Push a la rama (`git push origin feature/AmazingFeature`)
5. Abre un Pull Request

## 📄 Licencia

Este proyecto es privado y confidencial.

---

Para más información, consulta la [documentación principal](../README.md) del proyecto.
