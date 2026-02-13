# 🎨 Gúia de Diseño Profesional - FerreCloud

El frontend ha sido completamente rediseñado a nivel empresarial con componentes profesionales reutilizables y una experiencia de usuario moderna.

## 📦 Componentes Profesionales Creados

### 1. **BaseCard** (`BaseCard.vue`)
Card reutilizable con slots para header, content y footer.

```vue
<BaseCard>
  <template #header>
    <h3>Título</h3>
  </template>
  <p>Contenido</p>
  <template #footer>
    <button>Acción</button>
  </template>
</BaseCard>
```

### 2. **BaseButton** (`BaseButton.vue`)
Botón versátil con múltiples variantes y tamaños.

```vue
<BaseButton variant="primary" size="md" :loading="isLoading">
  Click me
</BaseButton>
```

**Variantes:** `primary`, `secondary`, `outline`, `ghost`, `danger`
**Tamaños:** `sm`, `md`, `lg`, `xl`

### 3. **BaseInput** (`BaseInput.vue`)
Input profesional con validación y soporte de errores.

```vue
<BaseInput 
  v-model="email"
  type="email"
  label="Correo"
  placeholder="tu@ejemplo.com"
  :error="errors.email"
  hint="Usaremos esto para tu cuenta"
  required
/>
```

### 4. **StatCard** (`StatCard.vue`)
Tarjeta de estadística con icono, valor y cambio porcentual.

```vue
<StatCard
  title="Ventas Hoy"
  value="$45,231"
  color="green"
  :change="12.5"
  period="vs ayer"
>
  <template #icon>
    <!-- SVG icon -->
  </template>
</StatCard>
```

### 5. **TopNavbar** (`TopNavbar.vue`)
Barra de navegación profesional con:
- Logo y branding
- Búsqueda integrada
- Notificaciones
- Menú de usuario desplegable

### 6. **Sidebar** (`Sidebar.vue`)
Navegación lateral con:
- Enlaces organizados por secciones
- Estados activos visuales
- Iconos descriptivos
- Separadores de secciones

## 🎯 Mejoras en Vistas

### Dashboard (Completamente Rediseñado)
✅ Navbar profesional con notificaciones y menú de usuario
✅ Sidebar de navegación elegante
✅ 4 stat cards con métricas clave
✅ Gráficos de ventas con placeholder
✅ Tabla de órdenes recientes
✅ Productos más vendidos

### Login & Register
✅ Diseño moderno con gradientes
✅ Validación inline
✅ Animaciones suaves
✅ Responsivo en móvil
✅ Opciones de login social

## 🎨 Paleta de Colores

```javascript
Primary: Blue (#3b82f6)
Secondary: Purple (#a855f7)
Success: Green (#10b981)
Warning: Orange (#f97316)
Error: Red (#ef4444)
Neutral: Escala de grises completa
```

## 📐 Espacios y Tipografía

- **Font:** Inter (sistema pre-configurado)
- **Border Radius:** 12px (rounded-xl) estándar
- **Sombras:** Sombras consistentes y sutiles
- **Transiciones:** 200-300ms cubic-bezier(0.16, 1, 0.3, 1)

## 🚀 Cómo Usar los Componentes

### En cualquier Vista:

```vue
<template>
  <div>
    <TopNavbar />
    
    <div class="flex">
      <Sidebar />
      
      <main class="flex-1">
        <div class="grid grid-cols-1 lg:grid-cols-4 gap-6">
          <StatCard 
            title="Métrica"
            value="123"
            color="blue"
            :change="5.2"
          />
        </div>

        <BaseCard>
          <template #header>
            <h3>Título</h3>
          </template>
          Contenido
        </BaseCard>

        <div class="flex gap-3">
          <BaseButton variant="primary">Guardar</BaseButton>
          <BaseButton variant="outline">Cancelar</BaseButton>
        </div>
      </main>
    </div>
  </div>
</template>

<script setup lang="ts">
import TopNavbar from '@/components/TopNavbar.vue'
import Sidebar from '@/components/Sidebar.vue'
import StatCard from '@/components/StatCard.vue'
import BaseCard from '@/components/BaseCard.vue'
import BaseButton from '@/components/BaseButton.vue'
</script>
```

## 📱 Responsive Design

Todos los componentes son totalmente responsivos:

- **Mobile:** Versión colapsada, touch-friendly
- **Tablet:** 2 columnas adaptadas
- **Desktop:** 4 columnas y layouts complejos

## ✨ Características Profesionales

### Animaciones
- Fade-in en entrada: `animate-fade-in`
- Slide-up en cards: `animate-slide-up`
- Hover effects suaves
- Transiciones de color

### Interactividad
- Botones con estados de carga
- Dropdowns funcionales
- Hover effects intuitivos
- Focus states accesibles

### Accesibilidad
- Contraste adecuado (WCAG AA)
- Focus rings visibles
- Labels asociados a inputs
- ARIA attributes donde aplica

## 🎁 Próximas Mejoras

- [ ] Modales profesionales
- [ ] Tablas avanzadas con sorting
- [ ] Paginación elegante
- [ ] Toasts/Notificaciones
- [ ] Skeletons de carga
- [ ] Temas oscuro/claro
- [ ] Gráficos interactivos (Chart.js/Recharts)

## 📚 Estructura de Archivos

```
src/
├── components/
│   ├── BaseButton.vue        # Botón reutilizable
│   ├── BaseCard.vue          # Card reutilizable
│   ├── BaseInput.vue         # Input reutilizable
│   ├── StatCard.vue          # Stat card
│   ├── TopNavbar.vue         # Navbar superior
│   └── Sidebar.vue           # Sidebar de navegación
├── views/
│   ├── DashboardView.vue     # Dashboard profesional
│   ├── auth/
│   │   ├── LoginView.vue
│   │   └── RegisterView.vue
│   └── ...
└── assets/
    └── main.css              # Estilos globales
```

## 🔧 Utilidades Tailwind Personalizadas

```javascript
// tailwind.config.js
extend: {
  colors: { /* Colores personalizados */ },
  fontFamily: { sans: ['Inter', '...'] },
  animation: {
    'fade-in': '...',
    'slide-up': '...',
    'pulse-glow': '...'
  }
}
```

---

**Última actualización:** Febrero 12, 2026
**Versión:** 1.0.0 (Professional Design Release)
