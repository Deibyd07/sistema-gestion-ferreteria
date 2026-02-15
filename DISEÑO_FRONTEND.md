# 🚀 FerreCloud Design System
### Sistema de Diseño Empresarial de Clase Mundial

> **Filosofía:** Crear experiencias digitales que combinen sofisticación tecnológica, confianza empresarial y usabilidad excepcional. Diseñado para escalar a nivel enterprise con estándares de las mejores compañías tech del mundo.

---

## 📋 Tabla de Contenidos

1. [Principios de Diseño](#-principios-de-diseño)
2. [Sistema de Colores](#-sistema-de-colores)
3. [Tipografía y Jerarquía](#-tipografía-y-jerarquía)
4. [Espaciado y Grid System](#-espaciado-y-grid-system)
5. [Componentes Enterprise](#-componentes-enterprise)
6. [Patrones de Interacción](#-patrones-de-interacción)
7. [Animaciones y Microinteracciones](#-animaciones-y-microinteracciones)
8. [Data Visualization](#-data-visualization)
9. [Estados y Feedback](#-estados-y-feedback)
10. [Accesibilidad y Performance](#-accesibilidad-y-performance)

---

## 🎯 Principios de Diseño

### 1. **Claridad Ante Todo**
Cada elemento debe tener un propósito claro y comunicar su función instantáneamente. Sin ambigüedades.

### 2. **Confianza a Través del Diseño**
- Consistencia visual absoluta
- Transiciones suaves y predecibles
- Feedback inmediato en cada interacción
- Manejo elegante de errores

### 3. **Eficiencia Profesional**
- Diseño dirigido a tareas
- Flujos optimizados (reducir clics)
- Información densa pero digerible
- Keyboard shortcuts y accesibilidad

### 4. **Belleza Funcional**
- Estética moderna y tecnológica
- Glassmorphism y effects sutiles
- Uso estratégico de color y espacios en blanco
- Jerarquía visual clara

### 5. **Escalabilidad Enterprise**
- Componentes atómicos reutilizables
- Design tokens para consistencia
- Theming y personalización
- Performance optimizada

---

## 🎨 Sistema de Colores

### Paleta Principal (Dark Theme First)

```javascript
// Surface Colors - Backgrounds oscuros sofisticados
surface: {
  base: '#0b1120',      // Background principal
  elevated: '#141b2d',  // Cards y modales
  hover: '#1a2332',     // Hover states
  border: '#1e293b',    // Bordes sutiles
}

// Brand Colors - Teal/Cyan (Confianza + Innovación)
primary: {
  50: '#ecfdf5',
  400: '#2dd4bf',       // Accent principal
  500: '#14b8a6',       // Primary standard
  600: '#0d9488',       // Hover state
  glow: 'rgba(45, 212, 191, 0.15)', // Efecto glow
}

// Semantic Colors
success: '#10b981',     // Green - Confirmaciones
warning: '#f59e0b',     // Amber - Advertencias
danger: '#f43f5e',      // Rose - Errores críticos
info: '#3b82f6',        // Blue - Información

// Text Hierarchy
text: {
  primary: '#f1f5f9',   // Títulos principales
  secondary: '#cbd5e1', // Texto regular
  tertiary: '#94a3b8',  // Texto secundario
  disabled: '#64748b',  // Deshabilitado
}
```

### Gradientes Profesionales

```css
/* Hero Gradient */
bg-gradient-to-br from-accent-500 via-cyan-500 to-violet-600

/* Subtle Card Gradient */
bg-gradient-to-b from-surface-elevated to-surface-base

/* Glow Effect */
shadow-[0_0_20px_rgba(45,212,191,0.2)]
```

---

## ✍️ Tipografía y Jerarquía

### Familia Tipográfica

```javascript
fontFamily: {
  sans: ['Inter', 'system-ui', 'sans-serif'],        // UI general
  display: ['Plus Jakarta Sans', 'Inter'],            // Títulos
  mono: ['JetBrains Mono', 'monospace'],             // Código
}
```

### Escala Tipográfica Empresarial

| Uso | Clase | Tamaño | Weight | Line Height |
|-----|-------|--------|--------|-------------|
| **Display XL** | `text-6xl` | 60px | 700 | 1.1 |
| **Display L** | `text-5xl` | 48px | 700 | 1.15 |
| **Heading 1** | `text-4xl` | 36px | 600 | 1.2 |
| **Heading 2** | `text-3xl` | 30px | 600 | 1.3 |
| **Heading 3** | `text-2xl` | 24px | 600 | 1.35 |
| **Heading 4** | `text-xl` | 20px | 600 | 1.4 |
| **Body Large** | `text-lg` | 18px | 400 | 1.6 |
| **Body** | `text-base` | 16px | 400 | 1.5 |
| **Body Small** | `text-sm` | 14px | 400 | 1.5 |
| **Caption** | `text-xs` | 12px | 500 | 1.4 |

### Reglas de Uso

- **Títulos de página:** Display L + font-display + Gradient text
- **Section headers:** Heading 2-3 + semi-bold
- **Card titles:** Heading 4 + medium weight
- **Body text:** Body regular, máximo 65-75 caracteres por línea
- **Captions:** Small + text-tertiary para metadatos

---

## 📐 Espaciado y Grid System

### Escala de Espaciado (8px base)

```
2px  → space-0.5   (Bordes, separadores finos)
4px  → space-1     (Spacing interno muy apretado)
8px  → space-2     (Spacing interno componentes)
12px → space-3     (Padding botones, inputs)
16px → space-4     (Espaciado interno cards)
24px → space-6     (Separación entre secciones)
32px → space-8     (Márgenes grandes)
48px → space-12    (Separación entre módulos)
64px → space-16    (Espaciado hero sections)
```

### Grid Layouts Enterprise

#### Dashboard Grid (12 columnas)
```vue
<!-- 4 columnas responsivas para stats -->
<div class="grid grid-cols-1 md:grid-cols-2 xl:grid-cols-4 gap-6">
  <StatCard />
</div>

<!-- 2/3 + 1/3 layout para contenido principal + sidebar -->
<div class="grid grid-cols-1 xl:grid-cols-3 gap-8">
  <div class="xl:col-span-2"><!-- Contenido principal --></div>
  <div class="xl:col-span-1"><!-- Sidebar --></div>
</div>
```

#### Content Container
```css
/* Max-width para legibilidad óptima */
.container-sm { max-width: 640px; }   /* Formularios */
.container-md { max-width: 896px; }   /* Artículos */
.container-lg { max-width: 1280px; }  /* Dashboard */
.container-xl { max-width: 1536px; }  /* Full width sections */
```

---

## 🧩 Componentes Enterprise

### Nivel 1: Componentes Atómicos

#### 1.1 **BaseButton** - Sistema de Botones Completo

```vue
<!-- Variantes y tamaños -->
<BaseButton variant="primary" size="lg">Primary Action</BaseButton>
<BaseButton variant="secondary" size="md">Secondary</BaseButton>
<BaseButton variant="outline" size="sm">Outline</BaseButton>
<BaseButton variant="ghost">Ghost</BaseButton>
<BaseButton variant="danger" :loading="true">Loading</BaseButton>
<BaseButton variant="success" :icon-left="CheckIcon">With Icon</BaseButton>

<!-- Props -->
variant: 'primary' | 'secondary' | 'outline' | 'ghost' | 'danger' | 'success'
size: 'xs' | 'sm' | 'md' | 'lg' | 'xl'
loading: boolean
disabled: boolean
iconLeft: Component
iconRight: Component
fullWidth: boolean
```

**Especificaciones Visuales:**
- Primary: Gradient teal → cyan, shadow glow
- Hover: Scale(1.02) + brightness increase
- Active: Scale(0.98)
- Loading: Spinner animado + disabled state
- Focus: Ring accent-400 con blur

#### 1.2 **BaseInput** - Input System Profesional

```vue
<BaseInput
  v-model="form.email"
  type="email"
  label="Email Address"
  placeholder="you@company.com"
  :error="errors.email"
  hint="We'll never share your email"
  :icon="EnvelopeIcon"
  required
  autocomplete="email"
/>

<!-- Variaciones -->
<BaseInput variant="default" />    <!-- Fondo subtle -->
<BaseInput variant="filled" />     <!-- Fondo más visible -->
<BaseInput variant="modern" />     <!-- Glassmorphism -->

<!-- Estados -->
- Default: Border subtle
- Focus: Border accent + ring glow
- Error: Border danger + icon + mensaje
- Success: Border success + checkmark
- Disabled: Opacity 50% + cursor-not-allowed
```

#### 1.3 **BaseCard** - Card System Avanzado

```vue
<BaseCard variant="elevated" hover="lift">
  <template #header>
    <div class="flex items-center justify-between">
      <h3>Card Title</h3>
      <BaseButton variant="ghost" size="sm">Action</BaseButton>
    </div>
  </template>
  
  <p>Card content with proper spacing and typography.</p>
  
  <template #footer>
    <div class="flex gap-3">
      <BaseButton>Primary</BaseButton>
      <BaseButton variant="outline">Cancel</BaseButton>
    </div>
  </template>
</BaseCard>

<!-- Variantes -->
variant: 'default' | 'elevated' | 'outlined' | 'glass'
hover: 'none' | 'lift' | 'glow' | 'border'
```

**Especificaciones:**
- Elevated: `bg-surface-elevated shadow-xl border border-surface-border`
- Glass: `backdrop-blur-xl bg-surface-elevated/50`
- Lift hover: `translate-y-[-4px] shadow-2xl transition-all`
- Padding: `p-6` (header/footer), `p-6` (content)

### Nivel 2: Componentes Compuestos

#### 2.1 **StatCard** - KPI Cards Profesionales

```vue
<StatCard
  title="Revenue Today"
  :value="45231"
  format="currency"
  :change="12.5"
  trend="up"
  period="vs yesterday"
  :chart-data="[...]"
  color="accent"
>
  <template #icon>
    <CurrencyDollarIcon />
  </template>
</StatCard>

<!-- Features -->
- Animated counters para valores
- Sparkline charts inline (opcional)
- Trend indicators con colores
- Tooltips con data histórica
- Loading skeleton states
```

**Especificaciones Visuales:**
```css
/* Layout */
- Icon: Gradient circle 48x48, glow effect
- Title: text-sm text-tertiary uppercase tracking-wide
- Value: text-3xl font-bold animate-count-up
- Change: Pill badge con icon (▲/▼)
- Chart: Área sombreada 60px altura

/* Animaciones */
- Mount: Stagger fade-in + slide-up
- Value change: Number transition smooth
- Hover: Lift + border glow
```

#### 2.2 **DataTable** - Tablas Enterprise

```vue
<DataTable
  :columns="columns"
  :data="products"
  :loading="isLoading"
  sortable
  searchable
  :filters="['category', 'status']"
  :actions="rowActions"
  pagination
  :page-size="25"
  selectable
  @row-click="handleRowClick"
  @selection-change="handleSelection"
>
  <!-- Custom cells -->
  <template #cell-status="{ value }">
    <BaseBadge :variant="getStatusVariant(value)">
      {{ value }}
    </BaseBadge>
  </template>
</DataTable>
```

**Features Empresariales:**
- ✅ Sort multi-columna
- ✅ Búsqueda global + filtros por columna
- ✅ Paginación con size selector
- ✅ Bulk actions (selección múltiple)
- ✅ Row actions dropdown
- ✅ Column visibility toggle
- ✅ Export (CSV, Excel, PDF)
- ✅ Loading skeletons
- ✅ Empty states ilustrados
- ✅ Responsive (colapsa a cards en móvil)

#### 2.3 **Modal** - Sistema de Modales

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

```vue
<BaseModal
  v-model="showModal"
  title="Confirm Action"
  size="md"
  :persistent="false"
  @confirm="handleConfirm"
  @cancel="handleCancel"
>
  <template #icon>
    <ExclamationTriangleIcon class="text-warning-500" />
  </template>
  
  <p>Are you sure you want to proceed with this action?</p>
  
  <template #footer>
    <BaseButton variant="danger" @click="handleConfirm">Confirm</BaseButton>
    <BaseButton variant="ghost" @click="handleCancel">Cancel</BaseButton>
  </template>
</BaseModal>

<!-- Sizes -->
size: 'sm' (400px) | 'md' (600px) | 'lg' (800px) | 'xl' (1000px) | 'full'

<!-- Variantes especializadas -->
<ConfirmDialog />   <!-- Confirmación simple -->
<AlertDialog />     <!-- Alertas críticas -->
<FormDialog />      <!-- Formularios complejos -->
<SlideOver />       <!-- Panel lateral (detalles) -->
```

**Especificaciones:**
- Backdrop: `bg-black/60 backdrop-blur-sm`
- Animación entrada: Scale(0.95) → 1 + fade
- Close gestures: ESC key, click outside (si no persistent)
- Focus trap para accesibilidad
- Z-index: 50 (modal), 60 (nested modals)

#### 2.4 **Toast/Notification System**

```javascript
// Composable para usar en cualquier componente
import { useToast } from '@/composables/useToast'

const toast = useToast()

toast.success('Product created successfully!')
toast.error('Failed to save changes', { duration: 5000 })
toast.warning('Your session will expire soon')
toast.info('New update available')

// Con actions
toast.success('Changes saved', {
  action: { label: 'Undo', onClick: handleUndo }
})
```

**Features:**
- Auto-dismiss configurable
- Stack múltiples toasts
- Progress bar animado
- Icons contextuales
- Position: top-right (default), top-center, bottom-right
- Swipe to dismiss en móvil

#### 2.5 **Sidebar Navigation** - Sistema de Navegación

```vue
<Sidebar
  :collapsed="isSidebarCollapsed"
  :items="navigationItems"
  @toggle="handleToggle"
>
  <template #header>
    <div class="flex items-center gap-3">
      <Logo :size="isSidebarCollapsed ? 'sm' : 'md'" />
      <span v-if="!isSidebarCollapsed">FerreCloud</span>
    </div>
  </template>
  
  <template #footer>
    <UserProfile :collapsed="isSidebarCollapsed" />
  </template>
</Sidebar>
```

**Estructura de Items:**
```typescript
interface NavItem {
  id: string
  label: string
  icon: Component
  to?: string
  badge?: { text: string, variant: 'accent' | 'danger' }
  children?: NavItem[]  // Sub-items
  separator?: boolean   // Separador visual
}
```

**Especificaciones:**
- Width: 280px (expandido), 72px (colapsado)
- Transition: 300ms ease-in-out
- Active state: Border left accent + bg subtle
- Hover: bg-surface-hover
- Nested items: Indentado + chevron animado

#### 2.6 **CommandPalette** - Búsqueda Global (CMD+K)

```vue
<CommandPalette
  v-model:open="showCommandPalette"
  :items="searchableItems"
  placeholder="Search or jump to..."
  @select="handleCommandSelect"
/>

<!-- Shortcut: CMD+K / CTRL+K -->
```

**Features:**
- Fuzzy search algorithm
- Recent searches
- Categorías (Actions, Navigation, Help)
- Keyboard navigation completa
- Icons y shortcuts visuales
- Quick actions (Create Product, New Order)

### Nivel 3: Componentes de Layout

#### 3.1 **AppShell** - Layout Principal

```vue
<template>
  <AppShell>
    <template #navbar>
      <TopNavbar />
    </template>
    
    <template #sidebar>
      <Sidebar />
    </template>
    
    <template #main>
      <RouterView />
    </template>
  </AppShell>
</template>
```

#### 3.2 **PageHeader** - Encabezados de Página

```vue
<PageHeader
  title="Products"
  subtitle="Manage your inventory and catalog"
  :breadcrumbs="breadcrumbs"
>
  <template #actions>
    <BaseButton variant="outline" :icon-left="FilterIcon">Filter</BaseButton>
    <BaseButton variant="primary" :icon-left="PlusIcon">Add Product</BaseButton>
  </template>
</PageHeader>
```

#### 3.3 **ContentContainer** - Wrapper de Contenido

```vue
<!-- Con sidebar -->
<ContentContainer layout="with-sidebar">
  <template #main>
    <!-- Contenido principal -->
  </template>
  <template #sidebar>
    <!-- Filtros, acciones secundarias -->
  </template>
</ContentContainer>

<!-- Grid de cards -->
<ContentContainer layout="grid" :cols="3">
  <ProductCard v-for="product in products" />
</ContentContainer>
```

---

## 🎭 Patrones de Interacción

### Hover Effects Empresariales

```css
/* Lift Effect - Cards, buttons */
.hover-lift {
  transition: all 200ms cubic-bezier(0.16, 1, 0.3, 1);
}
.hover-lift:hover {
  transform: translateY(-4px);
  box-shadow: 0 20px 25px -5px rgb(0 0 0 / 0.15);
}

/* Glow Effect - Primary actions */
.hover-glow:hover {
  box-shadow: 0 0 0 4px rgba(45, 212, 191, 0.15);
}

/* Press Effect - Botones */
.active-press:active {
  transform: scale(0.97);
}

/* Shine Effect - Testimonials, highlights */
.shine-effect {
  position: relative;
  overflow: hidden;
}
.shine-effect::after {
  content: '';
  position: absolute;
  top: -50%;
  left: -100%;
  width: 100%;
  height: 200%;
  background: linear-gradient(
    90deg, 
    transparent, 
    rgba(255, 255, 255, 0.05), 
    transparent
  );
  animation: shine 3s infinite;
}
```

### Loading States

```vue
<!-- Skeleton Loader -->
<div class="animate-pulse">
  <div class="h-4 bg-surface-2 rounded w-3/4 mb-4"></div>
  <div class="h-4 bg-surface-2 rounded w-1/2"></div>
</div>

<!-- Spinner en botón -->
<BaseButton :loading="isLoading">
  <Spinner class="mr-2" /> Processing...
</BaseButton>

<!-- Shimmer effect -->
<div class="shimmer-loading">
  <!-- Content skeleton -->
</div>
```

### Empty States

```vue
<EmptyState
  :icon="InboxIcon"
  title="No products yet"
  description="Get started by creating your first product"
>
  <template #action>
    <BaseButton variant="primary">Create Product</BaseButton>
  </template>
</EmptyState>
```

**Principios:**
- Ilustraciones claras y amigables
- Call-to-action obvio
- Mensajes útiles (no solo "No data")
- Sugerencias de qué hacer

### Error States

```vue
<ErrorState
  :error="error"
  title="Failed to load products"
  retry-label="Try Again"
  @retry="refetch"
>
  <template #details v-if="isDev">
    <pre>{{ error.stack }}</pre>
  </template>
</ErrorState>
```

---

## ✨ Animaciones y Microinteracciones

### Sistema de Animaciones

```javascript
// tailwind.config.js
animation: {
  // Enter/Exit
  'fade-in': 'fadeIn 300ms ease-out',
  'slide-up': 'slideUp 400ms cubic-bezier(0.16, 1, 0.3, 1)',
  'slide-down': 'slideDown 400ms cubic-bezier(0.16, 1, 0.3, 1)',
  'scale-in': 'scaleIn 200ms ease-out',
  
  // Continuous
  'spin-slow': 'spin 3s linear infinite',
  'pulse-glow': 'pulseGlow 2s ease-in-out infinite',
  'float': 'float 3s ease-in-out infinite',
  
  // Numbers
  'count-up': 'countUp 800ms ease-out',
  
  // Attention
  'shake': 'shake 400ms ease-in-out',
  'bounce-subtle': 'bounceSubtle 600ms ease-out',
}

keyframes: {
  fadeIn: {
    '0%': { opacity: '0' },
    '100%': { opacity: '1' },
  },
  slideUp: {
    '0%': { transform: 'translateY(20px)', opacity: '0' },
    '100%': { transform: 'translateY(0)', opacity: '1' },
  },
  pulseGlow: {
    '0%, 100%': { boxShadow: '0 0 20px rgba(45, 212, 191, 0.2)' },
    '50%': { boxShadow: '0 0 40px rgba(45, 212, 191, 0.4)' },
  },
  float: {
    '0%, 100%': { transform: 'translateY(0)' },
    '50%': { transform: 'translateY(-10px)' },
  },
  shake: {
    '0%, 100%': { transform: 'translateX(0)' },
    '10%, 30%, 50%, 70%, 90%': { transform: 'translateX(-4px)' },
    '20%, 40%, 60%, 80%': { transform: 'translateX(4px)' },
  },
}
```

### Stagger Animations (Cascada)

```vue
<!-- En listas de items -->
<TransitionGroup
  name="list"
  tag="div"
  class="grid grid-cols-3 gap-6"
>
  <ProductCard
    v-for="(product, index) in products"
    :key="product.id"
    :style="{ animationDelay: `${index * 50}ms` }"
    class="animate-slide-up"
  />
</TransitionGroup>
```

### Microinteracciones Clave

```vue
<!-- Success Checkmark animado -->
<transition name="success-check">
  <CheckCircleIcon v-if="isSuccess" class="animate-scale-in" />
</transition>

<!-- Progress Circle -->
<CircularProgress :value="uploadProgress" :animated="true" />

<!-- Ripple Effect en botones -->
<button @click="createRipple" class="relative overflow-hidden">
  <span class="ripple"></span>
  Button Text
</button>

<!-- Confetti en acciones exitosas críticas -->
<Confetti v-if="showConfetti" :duration="3000" />
```

### Page Transitions

```vue
<RouterView v-slot="{ Component }">
  <Transition name="page" mode="out-in">
    <component :is="Component" />
  </Transition>
</RouterView>

<style>
.page-enter-active {
  animation: slideUp 400ms cubic-bezier(0.16, 1, 0.3, 1);
}
.page-leave-active {
  animation: fadeOut 200ms ease-out;
}
</style>
```

---

## 📊 Data Visualization

### Charts & Graphs

**Librería Recomendada:** Chart.js + vue-chartjs (livianos) o Recharts (React-like)

```vue
<LineChart
  :data="revenueData"
  :options="chartOptions"
  class="h-80"
  smooth
  gradient
/>

<BarChart
  :data="salesByCategory"
  :colors="['#2dd4bf', '#3b82f6', '#a855f7']"
  stacked
/>

<DonutChart
  :data="marketShare"
  :total="totalRevenue"
  show-legend
  interactive
/>
```

**Especificaciones Visuales:**
- Background: Transparent o surface-elevated
- Grid lines: rgb(148, 163, 184, 0.1) (sutiles)
- Tooltips: Glassmorphism con blur
- Colors: Usar paleta brand + gradientes
- Animations: Smooth entry (800ms ease-out)

### KPI Displays

```vue
<!-- Big Number Display -->
<KPIDisplay
  label="Total Revenue"
  :value="284503"
  format="currency"
  :comparison="{ value: 18.2, period: 'vs last month' }"
  :sparkline="last30DaysData"
/>

<!-- Mini stat inline -->
<InlineStat label="Avg Order" value="$142" :change="5.3" />
```

### Progress Indicators

```vue
<!-- Linear Progress -->
<ProgressBar
  :value="75"
  :max="100"
  variant="accent"
  show-label
  animated
/>

<!-- Radial Progress -->
<CircularProgress
  :value="completionPercentage"
  :size="120"
  :stroke-width="10"
  show-percentage
>
  <template #center>
    <CheckIcon class="w-8 h-8" />
  </template>
</CircularProgress>

<!-- Step Progress -->
<StepProgress
  :steps="orderSteps"
  :current="2"
  variant="vertical"
/>
```

---

## 🎯 Estados y Feedback

### Toast Notifications (Expandido)

```typescript
// Tipos de notificaciones
interface ToastOptions {
  title: string
  description?: string
  variant: 'success' | 'error' | 'warning' | 'info'
  duration?: number  // ms, 0 = permanent
  action?: {
    label: string
    onClick: () => void
  }
  icon?: Component
  position?: 'top-right' | 'top-center' | 'bottom-right'
}

// Uso avanzado
toast.promise(
  saveProduct(),
  {
    loading: 'Saving product...',
    success: 'Product saved!',
    error: (err) => `Error: ${err.message}`
  }
)
```

### Confirmation Dialogs

```vue
<!-- Patrón seguro para acciones destructivas -->
<ConfirmDialog
  v-model="showDeleteConfirm"
  title="Delete Product"
  variant="danger"
  confirm-text="Delete"
  :require-confirmation="true"
  confirmation-phrase="DELETE"
>
  <p>This action cannot be undone. Type <strong>DELETE</strong> to confirm.</p>
</ConfirmDialog>
```

### Form Validation Visual

```vue
<BaseInput
  v-model="form.email"
  :error="v$.email.$error"
  :success="!v$.email.$error && v$.email.$dirty"
>
  <!-- Icon feedback -->
  <template #suffix>
    <CheckCircleIcon v-if="!v$.email.$error" class="text-success" />
    <XCircleIcon v-else class="text-danger" />
  </template>
</BaseInput>

<!-- Validation summary -->
<ValidationSummary :errors="errors" />
```

---

## ♿ Accesibilidad y Performance

### WCAG 2.1 AA Compliance

#### Contraste de Color
```
- Text-primary on surface-base: 15:1 ✅
- Text-secondary on surface-base: 8:1 ✅
- Accent-400 on surface-base: 4.5:1 ✅
- All interactive elements: Minimum 4.5:1
```

#### Keyboard Navigation
```vue
<!-- Todos los elementos interactivos -->
- Tab index lógico
- Focus visible (ring-2 ring-accent-400)
- Enter/Space para activar
- Escape para cerrar modales
- Arrow keys en listas/menús
```

#### Screen Readers
```vue
<!-- ARIA Labels donde sea necesario -->
<button aria-label="Close notification">
  <XIcon aria-hidden="true" />
</button>

<!-- Estados dinámicos -->
<div role="status" aria-live="polite" aria-atomic="true">
  {{ statusMessage }}
</div>

<!-- Headings jerárquicos -->
<h1>Page Title</h1>
<h2>Main Section</h2>
<h3>Subsection</h3>
```

### Performance Optimizations

#### Code Splitting
```typescript
// Router (lazy loading)
const Dashboard = () => import('@/views/DashboardView.vue')
const Products = () => import('@/views/ProductsView.vue')

// Componentes pesados
const DataTable = defineAsyncComponent(() =>
  import('@/components/DataTable.vue')
)
```

#### Image Optimization
```vue
<!-- Lazy loading -->
<img loading="lazy" src="..." alt="..." />

<!-- WebP con fallback -->
<picture>
  <source srcset="image.webp" type="image/webp" />
  <img src="image.jpg" alt="..." />
</picture>

<!-- Blur placeholder -->
<img
  :src="imageUrl"
  :style="{ backgroundImage: `url(${blurDataUrl})` }"
  class="blur-placeholder"
/>
```

#### Bundle Size
- Tree-shake icons (usar imports específicos)
- Lazy load routes y componentes pesados
- Optimizar imágenes (WebP, comprimir)
- Usar CDN para assets estáticos
- Gzip/Brotli compression

---

## 🎨 Temas y Personalización

### Dark Mode (Principal)

Ya implementado como tema predeterminado. Colores optimizados para reducir fatiga visual.

### Light Mode (Opcional)

```vue
<ThemeToggle v-model="isDark" />

<script setup>
const isDark = useDark()  // VueUse composable
</script>
```

**Paleta Light:**
```javascript
surface: {
  base: '#ffffff',
  elevated: '#f8fafc',
  hover: '#f1f5f9',
}
text: {
  primary: '#0f172a',
  secondary: '#475569',
  tertiary: '#64748b',
}
```

### Brand Customization

```typescript
// Design tokens configurables
interface BrandConfig {
  colors: {
    primary: string
    primaryHover: string
    primaryGlow: string
  }
  borderRadius: 'sharp' | 'smooth' | 'rounded'
  density: 'compact' | 'comfortable' | 'spacious'
}

// Aplicar tema
const theme = useBrandTheme(brandConfig)
```

---

## 📱 Responsive Design Matrix

### Breakpoints

```javascript
screens: {
  'sm': '640px',   // Mobile landscape, small tablets
  'md': '768px',   // Tablets
  'lg': '1024px',  // Laptops
  'xl': '1280px',  // Desktops
  '2xl': '1536px', // Large desktops
}
```

### Component Adaptations

| Component | Mobile (< 768px) | Tablet (768-1024px) | Desktop (> 1024px) |
|-----------|------------------|---------------------|-------------------|
| **Sidebar** | Drawer overlay | Colapsable | Full width |
| **TopNavbar** | Hamburger menu | Condensed | Full features |
| **DataTable** | Card list | 3 cols visible | All cols |
| **StatCards** | 1 col stack | 2 cols | 4 cols |
| **Modal** | Full screen | 90% width | Fixed width |
| **Forms** | 1 col | 1 col | 2 cols |

### Mobile-First Utilities

```vue
<!-- Hide on mobile, show on desktop -->
<div class="hidden md:block">Desktop only</div>

<!-- Different layouts -->
<div class="flex flex-col md:flex-row gap-4">...</div>

<!-- Responsive padding -->
<div class="p-4 md:p-6 lg:p-8">...</div>

<!-- Touch-friendly sizes en móvil -->
<BaseButton class="h-12 md:h-10">Button</BaseButton>
```

---

## 🚀 Implementación Rápida

### Setup Inicial

```bash
# Instalar dependencias adicionales
npm install @vueuse/core @headlessui/vue @heroicons/vue

# Chart library (opcional)
npm install chart.js vue-chartjs

# Form validation
npm install @vuelidate/core @vuelidate/validators
```

### Estructura de Carpetas Recomendada

```
src/
├── components/
│   ├── base/              # Atómicos
│   │   ├── BaseButton.vue
│   │   ├── BaseInput.vue
│   │   ├── BaseCard.vue
│   │   └── ...
│   ├── layout/            # Layout components
│   │   ├── AppShell.vue
│   │   ├── TopNavbar.vue
│   │   ├── Sidebar.vue
│   │   └── PageHeader.vue
│   ├── data/              # Data display
│   │   ├── DataTable.vue
│   │   ├── StatCard.vue
│   │   └── Charts/
│   ├── feedback/          # Feedback components
│   │   ├── Toast.vue
│   │   ├── Modal.vue
│   │   ├── EmptyState.vue
│   │   └── LoadingSkeleton.vue
│   └── domain/            # Componentes específicos del negocio
│       ├── ProductCard.vue
│       ├── OrderSummary.vue
│       └── ...
├── composables/           # Lógica reutilizable
│   ├── useToast.ts
│   ├── useModal.ts
│   ├── useTable.ts
│   └── useDebouncedSearch.ts
├── design-system/         # Tokens y configuración
│   ├── tokens.ts          # Design tokens
│   ├── animations.ts      # Animaciones
│   └── theme.ts           # Tema configuración
└── views/                 # Páginas
```

### Código Inicial Rápido

```vue
<!-- views/DashboardView.vue -->
<template>
  <AppShell>
    <PageHeader
      title="Dashboard"
      subtitle="Welcome back, let's check your metrics"
    >
      <template #actions>
        <BaseButton variant="outline" :icon-left="FilterIcon">Filter</BaseButton>
        <BaseButton variant="primary" :icon-left="PlusIcon">New Order</BaseButton>
      </template>
    </PageHeader>

    <!-- KPI Cards -->
    <div class="grid grid-cols-1 md:grid-cols-2 xl:grid-cols-4 gap-6 mb-8">
      <StatCard
        v-for="stat in stats"
        :key="stat.id"
        v-bind="stat"
      />
    </div>

    <!-- Main Content -->
    <div class="grid grid-cols-1 xl:grid-cols-3 gap-8">
      <!-- Charts -->
      <BaseCard class="xl:col-span-2" variant="elevated">
        <template #header>
          <h3>Revenue Overview</h3>
        </template>
        <LineChart :data="revenueData" />
      </BaseCard>

      <!-- Recent Activity -->
      <BaseCard variant="elevated">
        <template #header>
          <h3>Recent Orders</h3>
        </template>
        <OrderList :orders="recentOrders" />
      </BaseCard>
    </div>
  </AppShell>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue'
import { AppShell, PageHeader, StatCard, BaseCard, BaseButton } from '@/components'
import { PlusIcon, FilterIcon } from '@heroicons/vue/24/outline'

const stats = ref([...])  // Tu data de métricas
const revenueData = ref([...])
const recentOrders = ref([...])

onMounted(async () => {
  // Fetch data
})
</script>
```

---

## 📚 Resources & Inspiración

### Design Systems de Referencia
- **Vercel Design System** - Minimalismo elegante
- **Stripe Dashboard** - Data visualization profesional
- **Linear App** - Performance y animaciones
- **Notion** - Flexibilidad y usabilidad
- **Figma UI** - Componentes pulidos

### Tools Recomendadas
- **Figma** - Diseño y prototipos
- **Storybook** - Documentación componentes
- **Chromatic** - Visual testing
- **Lighthouse** - Performance audits
- **axe DevTools** - Accessibility testing

---

## ✅ Checklist de Implementación

### Fase 1: Fundamentos (Semana 1-2)
- [ ] Setup design tokens (colores, tipografía, espaciado)
- [ ] Componentes base (Button, Input, Card, Select)
- [ ] Layout system (AppShell, Grid, Container)
- [ ] Tailwind config completo
- [ ] Dark theme perfeccionado

### Fase 2: Componentes Core (Semana 3-4)
- [ ] Data Table con sorting y filtrado
- [ ] Modal system completo
- [ ] Toast notifications
- [ ] Form components avanzados
- [ ] Navigation (Sidebar, TopNav, Breadcrumbs)

### Fase 3: Data & Feedback (Semana 5-6)
- [ ] Charts y visualizaciones
- [ ] StatCards con animation
- [ ] Loading states (skeletons)
- [ ] Empty states ilustrados
- [ ] Error boundaries

### Fase 4: Polish & Optimización (Semana 7-8)
- [ ] Animaciones y microinteracciones
- [ ] Responsive refinamiento
- [ ] Performance optimization
- [ ] Accessibility audit (WCAG AA)
- [ ] Documentation en Storybook

### Fase 5: Features Avanzadas (Semana 9+)
- [ ] Command Palette (CMD+K)
- [ ] Theme customization
- [ ] Export funcionalidad (PDF, Excel)
- [ ] Real-time updates
- [ ] Advanced search/filtering

---

## 🎓 Best Practices

### Performance
✅ Lazy load routes y componentes pesados
✅ Virtualizar listas largas (>100 items)
✅ Debounce en búsquedas (300ms)
✅ Optimistic updates para mejor UX
✅ Cache API responses inteligentemente

### Code Quality
✅ TypeScript strict mode
✅ Composables para lógica reusable
✅ Props validation siempre
✅ Emit events con payload typed
✅ Unit tests para componentes críticos

### UX Principles
✅ Feedback inmediato (<100ms percepción)
✅ Loading states para acciones >200ms
✅ Error messages útiles y accionables
✅ Confirmación para acciones destructivas
✅ Undo cuando sea posible

---

**Última actualización:** Febrero 13, 2026  
**Versión:** 2.0.0 (Enterprise Design System)  
**Mantenido por:** Equipo FerreCloud
