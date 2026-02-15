# 🎯 Enterprise UX Patterns & Best Practices - FerreCloud

## Patrones de Experiencia de Usuario de Clase Mundial

Este documento contiene patrones UX específicos usados por empresas tecnológicas líderes para crear experiencias que generan confianza, eficiencia y satisfacción.

---

## 📊 Data Display Patterns

### 1. **Progressive Disclosure** (Revelación Progresiva)

Mostrar información en capas, revelando detalles solo cuando el usuario los necesita.

```vue
<!-- Vista inicial: Resumida -->
<ProductCard>
  <h3>Producto XYZ</h3>
  <p class="text-slate-400">SKU: 12345</p>
  <p class="text-2xl font-bold">$199.99</p>
  <BaseButton size="sm" @click="showDetails = true">Ver Detalles</BaseButton>
</ProductCard>

<!-- Al hacer clic: Expandir inline o modal -->
<SlideOver v-model="showDetails">
  <!-- Información completa del producto -->
  <DetailedProductView :product="product" />
</SlideOver>
```

**Cuándo usar:**
- Listas de productos/órdenes con mucha metadata
- Dashboards con KPIs (click para drill-down)
- Configuraciones avanzadas (modo básico/avanzado)

---

### 2. **Empty States Contextuales**

Convertir estados vacíos en oportunidades de engagement.

```vue
<!-- ❌ MAL: Mensaje genérico -->
<div v-if="products.length === 0">
  <p>No hay productos.</p>
</div>

<!-- ✅ BIEN: Actionable y educativo -->
<EmptyState
  v-if="products.length === 0"
  :illustration="BoxIllustration"
  title="Tu catálogo está vacío"
  description="Comienza agregando tu primer producto al inventario"
>
  <template #actions>
    <BaseButton variant="primary" :icon-left="PlusIcon" @click="openProductForm">
      Agregar Producto
    </BaseButton>
    <BaseButton variant="outline" :icon-left="CloudArrowUpIcon">
      Importar desde CSV
    </BaseButton>
  </template>

  <template #footer>
    <div class="text-sm text-slate-400 mt-6">
      <p>¿Necesitas ayuda? 
        <a href="#" class="text-accent-400 hover:text-accent-300">
          Mira nuestra guía rápida
        </a>
      </p>
    </div>
  </template>
</EmptyState>
```

**Variantes por contexto:**

```typescript
// Primera vez (onboarding)
{
  title: "Bienvenido a tu Dashboard",
  description: "Configura tu cuenta para comenzar",
  cta: "Iniciar Setup Guiado"
}

// Sin resultados de búsqueda
{
  title: "No encontramos resultados",
  description: `No hay productos que coincidan con "${searchTerm}"`,
  cta: "Limpiar Filtros",
  suggestion: "Intenta con términos más generales"
}

// Sin permisos
{
  title: "Acceso Restringido",
  description: "No tienes permisos para ver este contenido",
  cta: "Contactar Administrador"
}

// Error temporal
{
  title: "Error al Cargar Datos",
  description: "Hubo un problema con la conexión",
  cta: "Reintentar",
  icon: ExclamationTriangleIcon
}
```

---

### 3. **Loading States Específicos** (No Spinners Genéricos)

```vue
<!-- ❌ MAL: Spinner genérico -->
<div v-if="loading">
  <Spinner />
  <p>Cargando...</p>
</div>

<!-- ✅ BIEN: Skeleton que preserve layout -->
<template v-if="loading">
  <div class="space-y-4 animate-pulse">
    <div class="flex items-center gap-4">
      <div class="w-12 h-12 bg-surface-2 rounded-xl"></div>
      <div class="flex-1 space-y-2">
        <div class="h-4 bg-surface-2 rounded w-3/4"></div>
        <div class="h-3 bg-surface-2 rounded w-1/2"></div>
      </div>
    </div>
  </div>
</template>

<!-- ✅ EXCELENTE: Skeleton + texto contextual -->
<LoadingSkeleton
  v-if="loading"
  type="product-card"
  :count="pageSize"
  message="Cargando productos..."
/>
```

**Niveles de Loading States:**

1. **Inline** (< 100ms): Ninguno, imperceptible
2. **Short** (100-400ms): Cambio de cursor, disable button
3. **Medium** (400ms-2s): Skeleton loaders
4. **Long** (> 2s): Progress bar con porcentaje + posibilidad de cancelar

---

### 4. **Optimistic Updates**

Actualizar UI inmediatamente, revertir si falla.

```typescript
// composables/useOptimisticUpdate.ts
export function useOptimisticUpdate() {
  const toast = useToast()

  async function update<T>(
    item: T,
    updateFn: () => Promise<T>,
    {
      onSuccess,
      onError,
      rollback
    }: {
      onSuccess?: (data: T) => void
      onError?: (error: Error) => void
      rollback: () => void
    }
  ) {
    // 1. Update UI immediately (optimistic)
    onSuccess?.(item)

    try {
      // 2. Send request to backend
      const result = await updateFn()
      
      // 3. Confirm success (subtle feedback)
      toast.success('Cambios guardados', { duration: 2000 })
      
      return result
    } catch (error) {
      // 4. Rollback on error
      rollback()
      
      toast.error('Error al guardar', {
        description: 'Revirtiendo cambios...',
        action: {
          label: 'Reintentar',
          onClick: () => update(item, updateFn, { onSuccess, onError, rollback })
        }
      })
      
      onError?.(error as Error)
      throw error
    }
  }

  return { update }
}
```

**Ejemplo de uso:**

```vue
<script setup>
const { update } = useOptimisticUpdate()
const products = ref([...])

async function toggleFavorite(product) {
  const originalProducts = [...products.value]
  
  // Optimistic update
  const index = products.value.findIndex(p => p.id === product.id)
  products.value[index].isFavorite = !product.isFavorite
  
  await update(
    product,
    () => api.toggleFavorite(product.id),
    {
      rollback: () => {
        products.value = originalProducts
      }
    }
  )
}
</script>
```

---

## 🎨 Visual Hierarchy Patterns

### 5. **Smart Defaults & Visual Weight**

```vue
<!-- Jerarquía visual clara -->
<div class="space-y-6">
  <!-- Primary Action: Destacado -->
  <div class="flex items-center justify-between p-6 bg-gradient-to-br from-accent-500/10 to-cyan-500/10 border-2 border-accent-400/30 rounded-2xl">
    <div>
      <h3 class="text-xl font-bold text-slate-100">Acción Recomendada</h3>
      <p class="text-sm text-slate-400 mt-1">La mayoría de usuarios eligen esta opción</p>
    </div>
    <BaseButton variant="primary" size="lg">
      Continuar
    </BaseButton>
  </div>

  <!-- Secondary Options: Menos prominentes -->
  <div class="grid grid-cols-2 gap-4">
    <div class="p-4 bg-surface-elevated border border-surface-border rounded-xl hover:border-accent-400/20 transition-colors cursor-pointer">
      <h4 class="font-semibold text-slate-200">Opción Alternativa 1</h4>
      <p class="text-sm text-slate-400 mt-1">Para casos específicos</p>
    </div>
    <div class="p-4 bg-surface-elevated border border-surface-border rounded-xl hover:border-accent-400/20 transition-colors cursor-pointer">
      <h4 class="font-semibold text-slate-200">Opción Alternativa 2</h4>
      <p class="text-sm text-slate-400 mt-1">Para usuarios avanzados</p>
    </div>
  </div>

  <!-- Tertiary: Menos importante -->
  <button class="text-sm text-slate-500 hover:text-accent-400 underline">
    Ver todas las opciones
  </button>
</div>
```

---

### 6. **Progressive Complexity** (Modos Básico/Avanzado)

```vue
<!-- Formulario con dos niveles -->
<form @submit.prevent="handleSubmit">
  <!-- Campos básicos (siempre visibles) -->
  <div class="space-y-4">
    <BaseInput v-model="form.name" label="Nombre del Producto" required />
    <BaseInput v-model="form.price" label="Precio" type="number" required />
    <BaseSelect v-model="form.category" label="Categoría" :options="categories" />
  </div>

  <!-- Toggle para mostrar avanzado -->
  <button
    type="button"
    @click="showAdvanced = !showAdvanced"
    class="flex items-center gap-2 mt-6 text-sm text-accent-400 hover:text-accent-300"
  >
    <ChevronRightIcon :class="['w-4 h-4 transition-transform', showAdvanced && 'rotate-90']" />
    {{ showAdvanced ? 'Ocultar' : 'Mostrar' }} opciones avanzadas
  </button>

  <!-- Campos avanzados (colapsables) -->
  <transition name="slide-down">
    <div v-if="showAdvanced" class="mt-6 p-6 bg-surface-elevated border border-surface-border rounded-xl space-y-4">
      <BaseInput v-model="form.sku" label="SKU" />
      <BaseInput v-model="form.barcode" label="Código de Barras" />
      <BaseTextarea v-model="form.notes" label="Notas Internas" rows="3" />
      <BaseSelect v-model="form.supplier" label="Proveedor" :options="suppliers" />
    </div>
  </transition>

  <div class="flex gap-3 mt-6">
    <BaseButton type="submit" variant="primary" :loading="submitting">
      Guardar Producto
    </BaseButton>
    <BaseButton type="button" variant="outline" @click="resetForm">
      Cancelar
    </BaseButton>
  </div>
</form>
```

---

## ⚡ Performance & Perceived Speed

### 7. **Instant Feedback** (< 100ms)

```vue
<!-- Cada interacción debe tener respuesta inmediata -->

<!-- Click en botón -->
<BaseButton
  @click="handleAction"
  class="active:scale-95 transition-transform duration-100"
>
  Acción Inmediata
</BaseButton>

<!-- Toggle switch -->
<button
  @click="toggle"
  :class="[
    'relative w-12 h-6 rounded-full transition-colors duration-200',
    isOn ? 'bg-accent-500' : 'bg-surface-3'
  ]"
>
  <span
    :class="[
      'absolute top-1 left-1 w-4 h-4 bg-white rounded-full transition-transform duration-200',
      isOn && 'translate-x-6'
    ]"
  />
</button>

<!-- Hover states -->
<div class="group relative p-4 hover:bg-surface-hover transition-colors duration-150 cursor-pointer">
  <p class="group-hover:text-accent-400 transition-colors duration-150">
    Item interactivo
  </p>
</div>
```

---

### 8. **Skeleton Screens Estratégicos**

```vue
<!-- components/LoadingSkeleton.vue -->
<template>
  <div class="animate-pulse">
    <!-- Preserve exact layout -->
    <component :is="skeletonComponent" />
  </div>
</template>

<script setup>
const skeletonComponents = {
  'product-card': ProductCardSkeleton,
  'data-table': DataTableSkeleton,
  'stat-card': StatCardSkeleton,
  'user-profile': UserProfileSkeleton,
}

// ProductCardSkeleton.vue
<div class="p-6 bg-surface-elevated rounded-xl border border-surface-border">
  <div class="aspect-square bg-surface-2 rounded-lg mb-4"></div>
  <div class="h-5 bg-surface-2 rounded w-3/4 mb-2"></div>
  <div class="h-4 bg-surface-2 rounded w-1/2 mb-4"></div>
  <div class="h-10 bg-surface-2 rounded"></div>
</div>
</script>
```

---

## 🚨 Error Handling Patterns

### 9. **Error States con Recovery Path**

```vue
<template>
  <div v-if="error" class="max-w-md mx-auto text-center py-12">
    <!-- Icon contextual -->
    <div class="w-16 h-16 mx-auto mb-6 rounded-2xl bg-danger-500/10 flex items-center justify-center">
      <ExclamationTriangleIcon class="w-8 h-8 text-danger-400" />
    </div>

    <!-- Error message (user-friendly) -->
    <h3 class="text-xl font-semibold text-slate-100 mb-2">
      {{ getErrorTitle(error) }}
    </h3>
    <p class="text-slate-400 mb-6">
      {{ getErrorDescription(error) }}
    </p>

    <!-- Recovery actions -->
    <div class="flex flex-col sm:flex-row gap-3 justify-center">
      <BaseButton variant="primary" @click="retry">
        Reintentar
      </BaseButton>
      <BaseButton variant="outline" @click="goBack">
        Volver
      </BaseButton>
    </div>

    <!-- Additional help -->
    <div class="mt-8 p-4 bg-surface-elevated rounded-xl text-left">
      <p class="text-sm font-semibold text-slate-300 mb-2">¿Qué puedes hacer?</p>
      <ul class="text-sm text-slate-400 space-y-2">
        <li v-for="suggestion in errorSuggestions" :key="suggestion">
          • {{ suggestion }}
        </li>
      </ul>
    </div>

    <!-- Contact support -->
    <button @click="contactSupport" class="mt-6 text-sm text-accent-400 hover:text-accent-300">
      Contactar Soporte Técnico
    </button>

    <!-- Error ID (para soporte) -->
    <p class="mt-4 text-xs text-slate-600">
      Error ID: {{ error.id }}
    </p>
  </div>
</template>

<script setup>
function getErrorTitle(error) {
  const titles = {
    'network': 'Problemas de Conexión',
    'auth': 'Sesión Expirada',
    'permission': 'Acceso Denegado',
    'not-found': 'Recurso No Encontrado',
    'server': 'Error del Servidor',
    'validation': 'Datos Inválidos',
  }
  return titles[error.type] || 'Algo Salió Mal'
}

function getErrorDescription(error) {
  const descriptions = {
    'network': 'No pudimos conectar con el servidor. Verifica tu conexión a internet.',
    'auth': 'Tu sesión ha expirado por seguridad. Por favor inicia sesión nuevamente.',
    'permission': 'No tienes los permisos necesarios para realizar esta acción.',
    'not-found': 'El recurso que buscas no existe o fue eliminado.',
    'server': 'Nuestro servidor está experimentando problemas. Estamos trabajando en ello.',
    'validation': 'Algunos datos no son válidos. Revisa el formulario e intenta de nuevo.',
  }
  return descriptions[error.type] || error.message
}

const errorSuggestions = computed(() => {
  const suggestions = {
    'network': [
      'Verifica tu conexión a internet',
      'Intenta recargar la página',
      'Desactiva VPN o proxy si usas alguno'
    ],
    'auth': [
      'Inicia sesión nuevamente',
      'Verifica que tu usuario esté activo',
      'Contacta a tu administrador si el problema persiste'
    ],
  }
  return suggestions[error.value?.type] || [
    'Intenta realizar la acción nuevamente',
    'Recarga la página',
    'Contacta a soporte si el error continúa'
  ]
})
</script>
```

---

## 🎯 Form UX Patterns

### 10. **Inline Validation con Timing Inteligente**

```vue
<BaseInput
  v-model="form.email"
  label="Email"
  type="email"
  :error="emailError"
  :success="emailSuccess"
  @blur="validateEmail"
  @input="debouncedValidate"
>
  <template #hint>
    <transition name="fade" mode="out-in">
      <span v-if="validating" class="text-slate-400 flex items-center gap-2">
        <Spinner class="w-3 h-3" />
        Verificando email...
      </span>
      <span v-else-if="emailError" class="text-danger-400 flex items-center gap-2">
        <XCircleIcon class="w-4 h-4" />
        {{ emailError }}
      </span>
      <span v-else-if="emailSuccess" class="text-success-400 flex items-center gap-2">
        <CheckCircleIcon class="w-4 h-4" />
        Email disponible
      </span>
    </transition>
  </template>
</BaseInput>

<script setup>
import { useDebounceFn } from '@vueuse/core'

const emailError = ref('')
const emailSuccess = ref(false)
const validating = ref(false)

// Validar en blur (inmediato)
async function validateEmail() {
  if (!form.email) return
  
  validating.value = true
  emailError.value = ''
  emailSuccess.value = false

  try {
    // Validación básica
    if (!isValidEmail(form.email)) {
      emailError.value = 'Email inválido'
      return
    }

    // Verificar disponibilidad (API)
    const available = await checkEmailAvailability(form.email)
    
    if (!available) {
      emailError.value = 'Este email ya está registrado'
    } else {
      emailSuccess.value = true
    }
  } catch (error) {
    emailError.value = 'Error al validar email'
  } finally {
    validating.value = false
  }
}

// Validar mientras escribe (debounced)
const debouncedValidate = useDebounceFn(validateEmail, 500)
</script>
```

**Reglas de Timing:**
- **onChange**: Solo validación local (formato, longitud)
- **onBlur**: Validación completa + API calls
- **onSubmit**: Validación final + feedback claro

---

### 11. **Multi-Step Forms con Progress**

```vue
<template>
  <div class="max-w-3xl mx-auto">
    <!-- Progress Stepper -->
    <StepProgress
      :steps="steps"
      :current="currentStep"
      class="mb-12"
    />

    <!-- Form Steps -->
    <form @submit.prevent="handleNext">
      <transition :name="transitionName" mode="out-in">
        <component
          :is="currentStepComponent"
          :key="currentStep"
          v-model="formData"
          @validate="handleValidation"
        />
      </transition>

      <!-- Navigation -->
      <div class="flex items-center justify-between mt-8 pt-8 border-t border-surface-border">
        <BaseButton
          v-if="currentStep > 0"
          variant="ghost"
          @click="handleBack"
          :icon-left="ChevronLeftIcon"
        >
          Atrás
        </BaseButton>
        <div v-else></div>

        <div class="flex items-center gap-3">
          <!-- Save draft -->
          <BaseButton
            v-if="currentStep < steps.length - 1"
            variant="outline"
            @click="saveDraft"
          >
            Guardar Borrador
          </BaseButton>

          <!-- Next/Submit -->
          <BaseButton
            type="submit"
            variant="primary"
            :loading="submitting"
            :disabled="!isStepValid"
          >
            {{ isLastStep ? 'Finalizar' : 'Continuar' }}
            <ChevronRightIcon v-if="!isLastStep" class="w-4 h-4 ml-1" />
          </BaseButton>
        </div>
      </div>

      <!-- Step indicator (mobile) -->
      <p class="text-center text-sm text-slate-400 mt-4">
        Paso {{ currentStep + 1 }} de {{ steps.length }}
      </p>
    </form>
  </div>
</template>

<script setup>
const steps = [
  { id: 1, label: 'Información Básica', component: StepBasicInfo },
  { id: 2, label: 'Detalles', component: StepDetails },
  { id: 3, label: 'Confirmación', component: StepConfirmation },
]

const currentStep = ref(0)
const transitionName = ref('slide-left')
const isStepValid = ref(false)

function handleBack() {
  if (currentStep.value > 0) {
    transitionName.value = 'slide-right'
    currentStep.value--
  }
}

function handleNext() {
  if (isLastStep.value) {
    submitForm()
  } else {
    transitionName.value = 'slide-left'
    currentStep.value++
  }
}

async function saveDraft() {
  const toast = useToast()
  try {
    await api.saveDraft(formData)
    toast.success('Borrador guardado')
  } catch (error) {
    toast.error('Error al guardar borrador')
  }
}
</script>

<style scoped>
.slide-left-enter-active,
.slide-left-leave-active,
.slide-right-enter-active,
.slide-right-leave-active {
  transition: all 0.3s cubic-bezier(0.16, 1, 0.3, 1);
}

.slide-left-enter-from {
  transform: translateX(30px);
  opacity: 0;
}

.slide-left-leave-to {
  transform: translateX(-30px);
  opacity: 0;
}

.slide-right-enter-from {
  transform: translateX(-30px);
  opacity: 0;
}

.slide-right-leave-to {
  transform: translateX(30px);
  opacity: 0;
}
</style>
```

---

## 🔍 Search & Filter Patterns

### 12. **Smart Search con Sugerencias**

```vue
<template>
  <div class="relative" v-click-outside="closeResults">
    <BaseInput
      v-model="searchQuery"
      placeholder="Buscar productos, clientes, órdenes..."
      :icon-left="MagnifyingGlassIcon"
      @input="handleSearch"
      @focus="showResults = true"
      @keydown="handleKeyboard"
    >
      <template #suffix>
        <kbd class="px-2 py-1 text-xs bg-surface-2 rounded border border-surface-border">
          ⌘K
        </kbd>
      </template>
    </BaseInput>

    <!-- Search Results Dropdown -->
    <transition name="slide-down">
      <div
        v-if="showResults && (hasResults || searching)"
        class="absolute top-full mt-2 w-full bg-surface-elevated border border-surface-border rounded-xl shadow-dark-xl z-50 overflow-hidden"
      >
        <!-- Loading -->
        <div v-if="searching" class="p-4 text-center text-sm text-slate-400">
          <Spinner class="w-4 h-4 inline-block mr-2" />
          Buscando...
        </div>

        <!-- Results by category -->
        <div v-else-if="hasResults" class="max-h-96 overflow-y-auto">
          <div v-for="category in categorizedResults" :key="category.type" class="py-2">
            <p class="px-4 py-2 text-xs font-semibold text-slate-500 uppercase tracking-wider">
              {{ category.label }}
            </p>
            <button
              v-for="(result, index) in category.items"
              :key="result.id"
              :ref="el => resultRefs[index] = el"
              @click="selectResult(result)"
              :class="[
                'w-full px-4 py-3 flex items-center gap-3 hover:bg-surface-hover transition-colors text-left',
                selectedIndex === index && 'bg-surface-hover'
              ]"
            >
              <component :is="result.icon" class="w-5 h-5 text-slate-400 flex-shrink-0" />
              <div class="flex-1 min-w-0">
                <p class="font-medium text-slate-200" v-html="highlightMatch(result.title)" />
                <p v-if="result.subtitle" class="text-sm text-slate-400 truncate">
                  {{ result.subtitle }}
                </p>
              </div>
              <ChevronRightIcon class="w-4 h-4 text-slate-600" />
            </button>
          </div>
        </div>

        <!-- No results -->
        <div v-else class="p-8 text-center">
          <MagnifyingGlassIcon class="w-12 h-12 mx-auto text-slate-600 mb-3" />
          <p class="text-sm text-slate-400">
            No encontramos resultados para "{{ searchQuery }}"
          </p>
        </div>

        <!-- Quick actions -->
        <div class="border-t border-surface-border bg-surface-base px-4 py-3">
          <p class="text-xs text-slate-500 mb-2">Acciones rápidas</p>
          <div class="flex gap-2">
            <button class="px-3 py-1.5 text-xs bg-surface-2 hover:bg-surface-3 rounded-lg transition-colors">
              Búsqueda Avanzada
            </button>
            <button class="px-3 py-1.5 text-xs bg-surface-2 hover:bg-surface-3 rounded-lg transition-colors">
              Ver Todo
            </button>
          </div>
        </div>
      </div>
    </transition>
  </div>
</template>

<script setup>
import { useDebounceFn } from '@vueuse/core'

const searchQuery = ref('')
const searching = ref(false)
const showResults = ref(false)
const results = ref([])
const selectedIndex = ref(0)

const handleSearch = useDebounceFn(async () => {
  if (!searchQuery.value.trim()) {
    results.value = []
    return
  }

  searching.value = true
  
  try {
    results.value = await api.search(searchQuery.value)
  } finally {
    searching.value = false
  }
}, 300)

// Keyboard navigation
function handleKeyboard(event) {
  if (!showResults.value || !hasResults.value) return

  switch (event.key) {
    case 'ArrowDown':
      event.preventDefault()
      selectedIndex.value = Math.min(selectedIndex.value + 1, totalResults.value - 1)
      scrollToSelected()
      break
    case 'ArrowUp':
      event.preventDefault()
      selectedIndex.value = Math.max(selectedIndex.value - 1, 0)
      scrollToSelected()
      break
    case 'Enter':
      event.preventDefault()
      selectResult(flatResults.value[selectedIndex.value])
      break
    case 'Escape':
      showResults.value = false
      break
  }
}

// Highlight search matches
function highlightMatch(text) {
  const regex = new RegExp(`(${searchQuery.value})`, 'gi')
  return text.replace(regex, '<mark class="bg-accent-400/20 text-accent-300">$1</mark>')
}
</script>
```

---

## 📱 Mobile-First Patterns

### 13. **Touch-Friendly Interactions**

```vue
<!-- Botones y links con área táctil adecuada (min 44x44px) -->
<button class="min-h-[44px] min-w-[44px] flex items-center justify-center">
  <Icon class="w-5 h-5" />
</button>

<!-- Swipe actions en listas (móvil) -->
<div
  v-for="item in items"
  :key="item.id"
  v-touch:swipe.left="() => showActions(item)"
  class="relative overflow-hidden"
>
  <!-- Contenido principal -->
  <div class="bg-surface-elevated p-4">
    {{ item.title }}
  </div>

  <!-- Acciones reveladas con swipe -->
  <div class="absolute inset-y-0 right-0 flex translate-x-full transition-transform">
    <button class="px-6 bg-blue-500 text-white">Editar</button>
    <button class="px-6 bg-danger-500 text-white">Eliminar</button>
  </div>
</div>

<!-- Pull to refresh -->
<PullToRefresh @refresh="handleRefresh">
  <DataList :items="items" />
</PullToRefresh>

<!-- Bottom sheet para acciones (móvil) -->
<BottomSheet v-model="showSheet">
  <div class="p-6 space-y-2">
    <button class="w-full p-4 text-left hover:bg-surface-hover rounded-xl">
      Acción 1
    </button>
    <button class="w-full p-4 text-left hover:bg-surface-hover rounded-xl">
      Acción 2
    </button>
  </div>
</BottomSheet>
```

---

## 🎯 Microinteractions que IMPORTAN

### 14. **Feedback Háptico (PWA/Mobile)**

```typescript
// composables/useHaptics.ts
export function useHaptics() {
  function vibrate(pattern: number | number[] = 10) {
    if ('vibrate' in navigator) {
      navigator.vibrate(pattern)
    }
  }

  function success() {
    vibrate([10, 20, 10]) // Short-short pattern
  }

  function error() {
    vibrate([20, 10, 20, 10, 20]) // Longer pattern
  }

  function tap() {
    vibrate(5) // Very short
  }

  return { vibrate, success, error, tap }
}

// Uso en componentes
const haptics = useHaptics()

function handleDelete() {
  haptics.error()
  // ... delete logic
}

function handleSuccess() {
  haptics.success()
  // ... success logic
}
```

---

## 🏆 Best Practices Summary

### Do's ✅

1. **Feedback inmediato** - Toda acción < 100ms de respuesta visual
2. **Loading states específicos** - Skeletons que preserven layout
3. **Optimistic updates** - UI responde antes que el servidor
4. **Smart defaults** - Jerarquía visual clara, acción principal obvia
5. **Error recovery** - Siempre ofrecer un camino de salida
6. **Progressive disclosure** - Información en capas, no todo a la vez
7. **Contextual empty states** - Convertir vacío en oportunidad
8. **Keyboard shortcuts** - Para usuarios power
9. **Consistent animations** - Misma duración y easing en todo
10. **Mobile-first** - Touch-friendly desde el diseño inicial

### Don'ts ❌

1. **Spinners genéricos** - Usar skeleton screens específicos
2. **"Loading..."** sin contexto - Decir QUÉ se está cargando
3. **Errores técnicos al usuario** - Traducir a lenguaje humano
4. **Acciones sin confirmar** - Especialmente destructivas
5. **Formularios sin inline validation** - Validar progresivamente
6. **Información densa sin jerarquía** - Todo look igual = nada destacashade
7. **Ignorar estados vacíos** - Son oportunidades de onboard
8. **Animaciones lentas** - Máximo 400ms para la mayoría
9. **Colores sin significado** - Rojo = error, Verde = success (consistencia)
10. **Ignorar mobile** - 60%+ de tráfico es móvil

---

## 📐 Enterprise Metrics

Medir estos KPIs para validar tu UX:

```
⏱️ Time to Interactive (TTI): < 3s
📊 First Contentful Paint: < 1.5s
🎯 Task Success Rate: > 90%
⚡ Form Completion Time: -30% vs baseline
😊 User Satisfaction (NPS): > 50
🔄 Error Recovery Rate: > 85%
📱 Mobile Bounce Rate: < 40%
```

---

**Implementando estos patrones, FerreCloud tendrá UX de clase mundial que compite con Stripe, Linear, Vercel y las mejores apps SaaS.** 🚀
