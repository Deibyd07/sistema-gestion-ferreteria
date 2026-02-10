# 📌 Gestión de Issues - Guía Completa

¿No sabes cómo reportar un bug o solicitar una feature? ¡Esta guía es para ti!

## 📋 Tabla de Contenidos

- [¿Qué es un Issue?](#qué-es-un-issue)
- [Tipos de Issues](#tipos-de-issues)
- [Crear un Issue](#crear-un-issue)
- [Ciclo de Vida del Issue](#ciclo-de-vida-del-issue)
- [Labels (Etiquetas)](#labels-etiquetas)
- [Issues y Épicas](#issues-y-épicas)
- [Mejores Prácticas](#mejores-prácticas)

---

## ¿Qué es un Issue?

Un **Issue** es una tarea, bug, feature o idea documentada en GitHub. Es el punto de partida para:

- 📝 Reportar problemas
- ✨ Solicitar nuevas funcionalidades
- 📚 Mejorar documentación
- 🎯 Planificar trabajo
- 👥 Colaborar en soluciones

**Componentes de un Issue:**
- **Título**: Descripción breve y clara
- **Descripción**: Contexto y detalles
- **Labels**: Categorías (bug, feature, docs, etc.)
- **Assignee**: Quién está trabajando en eso
- **Project**: Parte de una épica o proyecto
- **Milestones**: Versión objetivo

---

## Tipos de Issues

### 1. 🐛 Bug Report (Reporte de Error)

**Cuándo crear:**
- Encontraste algo que no funciona
- Comportamiento inesperado
- Error en la aplicación

**No es un bug:**
- Falta de entendimiento (pregunta en Discussions)
- Solicitud de soporte
- Deseo de cambio de comportamiento

**Plantilla de Bug:**

```markdown
## 📝 Descripción

Descripción clara y concisa del problema.
"Cuando hago [acción], sucede [comportamiento inesperado] en lugar de [comportamiento esperado]"

## 🔧 Reproducción

Pasos para reproducir el problema:
1. Ir a '...'
2. Hacer clic en '....'
3. Scroll a '....'
4. Ver error

## 😐 Comportamiento Esperado

Lo que debería pasar normalmente.

## 😕 Comportamiento Actual

Qué es lo que realmente pasó.

## 📸 Screenshots

[Si aplica, agregar capturas de pantalla o videos]

## 💻 Información del Sistema

- **OS**: [Windows 11 / Ubuntu 22.04 / macOS 13]
- **Browser**: [Chrome 120 / Firefox 121 / Safari]
- **Versión del Proyecto**: [v1.0.0 / develop / main]
- **Python**: [3.10 / 3.11]
- **Node.js**: [18.0.0 / 20.0.0]

## 📎 Contexto Adicional

Cualquier otra información relevante:
- ¿Comenzó recientemente en una versión específica?
- ¿Afecta a una funcionalidad específica?
- ¿Hay workaround?
```

**Ejemplo de Buen Bug Report:**

```markdown
## 📝 Descripción

El botón "Guardar" en el formulario de productos no funciona cuando el precio supera 100,000.

## 🔧 Reproducción

1. Ir a Productos
2. Crear nuevo producto
3. Ingresar precio: 150,000
4. Click en Guardar
5. Nada sucede (sin error visible)

## 😐 Comportamiento Esperado

El producto se debe guardar correctamente.

## 😕 Comportamiento Actual

El producto no se guarda y el navegador no muestra ningún error.

## 📸 Screenshots

[Video mostrando el problema]

## 💻 Información del Sistema

- **OS**: Windows 11
- **Browser**: Chrome 120
- **Versión**: develop
- **Node.js**: 20.0.0

## 📎 Contexto Adicional

Este problema comenzó desde la versión v0.8.0. 
El workaround es agregar una letra al final del precio (150000a) pero eso no es válido.
```

---

### 2. ✨ Feature Request (Solicitud de Feature)

**Cuándo crear:**
- Quieres una nueva función
- Mejora a funcionalidad existente
- Idea de producto

**Plantilla de Feature:**

```markdown
## 📝 Descripción

Descripción clara de la feature que quieres.
Incluye el valor que proporciona.

## 🎯 Problema que Resuelve

¿A qué problema o necesidad del usuario responde?
"A menudo los usuarios quieren [problema] pero no pueden porque [razón]"

## 💡 Solución Propuesta

Cómo visualizas que funcione.
- Paso 1: ...
- Paso 2: ...
- Resultado: ...

## 🔄 Alternativas Consideradas

Otras formas de resolver el mismo problema.

## 📎 Contexto Adicional

- Casos de uso
- Ejemplos de aplicaciones similares
- Mockups/wireframes si aplica
```

**Ejemplo de Buen Feature Request:**

```markdown
## 📝 Descripción

Agregar filtro de búsqueda en la lista de productos.

## 🎯 Problema que Resuelve

Cuando hay muchos productos (100+), es difícil encontrar lo que buscas.
Los usuarios quieren poder buscar por nombre o categoría.

## 💡 Solución Propuesta

Agregar una barra de búsqueda en la páginas de Productos:
1. Usuario ingresa texto en la barra de búsqueda
2. La lista se filtra en tiempo real
3. Búsqueda insensible a mayúsculas/minúsculas
4. Busca en nombre y descripción

## 🔄 Alternativas Consideradas

1. Usar autocomplete con dropdown: Mejor para seleccionar, pero requiere más clicks
2. Filtros avanzados: Más poderoso, pero complejo para usuarios nuevos

## 📎 Contexto Adicional

Competencia como Home Depot tiene búsqueda en tiempo real.
Esto mejoraría:
- Experiencia del usuario al 80%
- Velocidad de búsqueda al 90%
- Reducción de clics

[Mockup adjunto]
```

---

### 3. 📚 Documentation (Documentación)

**Cuándo crear:**
- Documentación ausente o confusa
- Ejemplos de código desactualizados
- Faltan pasos en guías
- Typos

**Plantilla:**

```markdown
## 📝 Descripción

¿Qué documentación falta o está mal?

## 🎯 Sección Afectada

[Link a la documentación]

## 🔧 Problema

Qué está confuso o falta:
- Falta explicación de...
- El ejemplo no funciona porque...
- Há un typo en...

## 💡 Solución

Cómo debería verse la documentación.
```

**Ejemplo:**

```markdown
## 📝 Descripción

La sección de "Setup de Supabase" está desactualizada.

## 🎯 Sección Afectada

docs/setup/SETUP_SUPABASE.md

## 🔧 Problema

Los pasos mencionan Supabase v1 pero ahora es v2.
Las keys se llaman diferente y el setup cambió.

## 💡 Solución

Actualizar con instrucciones para Supabase v2 incluyendo:
- Nuevas ubicaciones de keys en el dashboard
- Cambios en RLS policies
- Nuevos pasos de auth
```

---

### 4. 🧪 Test/Chore (Pruebas y Tareas)

**Cuándo crear:**
- Aumentar cobertura de tests
- Refactorización necesaria
- Dependencias desactualizadas
- Tareas de mantenimiento

**Plantilla simple:**

```markdown
## 📝 Descripción

Qué trabajo necesita hacerse.

## ✅ Checklist

- [ ] Item 1
- [ ] Item 2
- [ ] Item 3

## 💡 Notas

Contexto adicional.
```

---

## Crear un Issue

### Paso a Paso

1. **Ir al Repositorio**
   - https://github.com/tu-organizacion/sistema-gestion-ferreteria

2. **Click en "Issues"**
   - Top navigation bar

3. **Click en "New issue"**
   - Botón verde

4. **Seleccionar Tipo**
   - Bug report
   - Feature request
   - Documentation
   - Custom

5. **Completar Plantilla**
   - Sigue la plantilla del tipo elegido
   - Sé específico y detallado
   - Incluye ejemplos

6. **Agregar Labels**
   - Categoría principal (bug, feature, docs)
   - Prioridad (high, medium, low)
   - Componente afectado (backend, frontend, db)

7. **Opcional: Proyecto**
   - Si es parte de una épica, selecciona el proyecto

8. **Click "Submit new issue"**

---

## Ciclo de Vida del Issue

### Estados del Issue

```
┌─────────────┐
│   OPEN      │  Nuevo, sin asignar
│  (Backlog)  │
└──────┬──────┘
       │
       │ "Me asigno a esto"
       │
┌──────▼──────────┐
│   IN PROGRESS   │  Alguien está trabajando
│   (Sprint)      │
└──────┬──────────┘
       │
       │ "Abrí un PR para esto"
       │
┌──────▼──────────┐
│   IN REVIEW     │  Esperando aprobación del PR
└──────┬──────────┘
       │
       │ "PR fue mergeado"
       │
┌──────▼──────────┐
│   CLOSED        │  Completado
│   (Done)        │
└─────────────────┘
```

### Transiciones Típicas

**Flujo Normal:**
```
Open (backlog) → In Progress (asignado) → In Review (PR creado) → Closed (PR mergeado)
```

**Si No es Válido:**
```
Open → Closed (as invalid)
```

**Si es Duplicado:**
```
Open → Closed (as duplicate) → Linkar a issue original
```

---

## Labels (Etiquetas)

### Categoría Principal

| Label | Significado | Color |
|-------|-------------|-------|
| `bug` | Error/defecto | Rojo 🔴 |
| `feature` | Nueva funcionalidad | Verde 🟢 |
| `docs` | Documentación | Azul 🔵 |
| `test` | Tests/QA | Naranja 🟠 |
| `chore` | Tareas de mantenimiento | Gris ⚫ |

### Prioridad

| Label | Significado |
|-------|-------------|
| `priority-critical` | Detiene el trabajo, arreglar ASAP |
| `priority-high` | Importante, debería ser en próxima versión |
| `priority-medium` | Normal, arreglar cuando sea posible |
| `priority-low` | Nice to have, baja urgencia |

### Componentes

| Label | Parte del Código |
|-------|-----------------|
| `backend` | Servidor/API (Python/FastAPI) |
| `frontend` | Interfaz web (Next.js/TypeScript) |
| `database` | Base de datos (Supabase/PostgreSQL) |
| `infra` | DevOps/CI-CD/Deployment |

### Otros

| Label | Significado |
|-------|-------------|
| `good-first-issue` | Perfecto para principiantes |
| `help-wanted` | Necesita atención |
| `epic` | Contiene múltiples issues relacionadas |
| `blocked-by` | Bloqueado por otro issue |
| `wontfix` | No será arreglado (cerrado) |
| `duplicate` | Duplicado de otro issue |
| `invalid` | No es válido o falta información |

---

## Issues y Épicas

### Relación Issue ↔ Épica

```
Epic/1-Setup (Issue Principal)
├── Issue #1: Configurar repositorio
├── Issue #2: Setup de Supabase
├── Issue #3: Configurar CI/CD
└── Issue #4: Setup de Sentry

Epic/2-Database (Issue Principal)
├── Issue #5: Diseño DB
├── Issue #6: Modelos SQLAlchemy
└── Issue #7: Migrations
```

### Cómo Asignar Issue a una Épica

1. Al crear el issue, en la sección "Projects"
2. Selecciona el proyecto (epic/N-nombre)
3. Automáticamente aparecerá en esa épica

O directamente en la épica:
1. Abre el proyecto/épica
2. Click en "+" para agregar issue
3. Busca o crea el issue

---

## Mejores Prácticas

### ✅ Hacer

**Sé específico:**
```
✅ BIEN: "El botón guardar no funciona cuando el precio supera 100,000 en Chrome"
❌ MAL: "No funciona"
```

**Incluye contexto:**
```
✅ BIEN:
Sistema operativo: Windows 11
Navegador: Chrome 120
Versión: develop
Pasos para reproducir: 1. 2. 3.

❌ MAL: "Tengo un problema"
```

**Busca primero:**
```
✅ Busca si el issue ya existe antes de crear uno nuevo
❌ Crear issue duplicados
```

**Usa plantillas:**
```
✅ Completa la plantilla proporcionada
❌ Escribir description al azar
```

### ❌ No Hacer

**Evita:**
- Spam o autopromoción
- Lenguaje ofensivo
- Ataques personales
- Información privada
- Issues demasiado genéricos

### Ejemplo Perfecto

```markdown
## 🐛 Descripción

Al intentar crear una nueva factura con más de 10 items,
el formulario falla con error 500 en el servidor.

## 🔧 Reproducción

1. Ir a Facturaciones
2. Click en "Nueva Factura"
3. Agregar item (repetir 10+ veces)
4. Hacer scroll en el formulario
5. Ver error 500

## 😐 Esperado

Debería permitir agregar múltiples items sin límite

## 😕 Real

Error 500 después de 10 items

## 📸 Screenshots

[Error log adjunto]
[Video screencast]

## 💻 Sistema

- OS: Ubuntu 22.04
- Browser: Firefox 121
- Version: develop (commit abc123)
- Python: 3.11

## 📎 Notas

Parece estar relacionado con los cambios en el serializer
de items que se hicieron en el PR #424
```

---

## Workflow Típico del Equipo

### 1. Creación del Issue
**Cualquiera:**
- Reporta un bug o idea
- Completa plantilla
- Selecciona labels y épica

### 2. Triaje
**Maintainer:**
- Review del issue
- Agrega labels faltantes
- Filtra issues inválidos
- Asigna prioridad

### 3. Planning
**Team Lead:**
- Estima esfuerzo
- Asigna a desarrollador
- Enlaza a épica/proyecto
- Define "Definition of Done"

### 4. Desarrollo
**Desarrollador:**
- Crea rama desde épica
- Comenta progreso en issue
- Abre PR linkeado al issue

### 5. Cierre
**Reviewer:**
- Aprueba PR
- Mergea cambios
- Issue cierra automáticamente

---

## Templates de Referencia Rápida

### Bug (30 segundos)

```
Qué: [Una línea]
Cómo reproducir: [3 pasos]
Esperado: [Lo que debería pasar]
Real: [Lo que pasó]
Context: [OS, navegador, versión]
```

### Feature (30 segundos)

```
Qué: [Nueva funcionalidad]
Por qué: [Problema que resuelve]
Cómo: [Descripción básica]
Alternativas: [Otros enfoques]
```

### Documentation (30 segundos)

```
Dónde: [Link a doc]
Problema: [Qué confunde]
Solución: [Cómo debería ser]
```

---

## Preguntas Frecuentes

**P: ¿Debo reportar bugs pequeños?**
R: Sí! Incluso un typo o un botón misalineado es válido.

**P: ¿Mi idea es demasiado ambiciosa?**
R: Crea el issue de todas formas. El equipo puede desglosarlo en sub-issues.

**P: ¿Cuándo cierra un issue?**
R: Cuando el PR relacionado está mergeado en develop o main.

**P: ¿Qué si alguien ya está trabajando?**
R: Busca ramas abiertas o PRs. Si está inactivo, pregunta si puedes ayudar.

**P: ¿Puedo cambiar de opinion en mi issue?**
R: Completamente! Edita el issue o comenta con nuevos detalles.

---

**¡Gracias por contribuir reportando issues! 🙏**

Sin reportes claros, los bugs se escapan a producción.

**Última actualización:** Febrero 2026
