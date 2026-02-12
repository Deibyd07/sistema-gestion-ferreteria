# 📊 GitHub Projects - Gestión del Trabajo

Cómo usar GitHub Projects para organizar épicas, issues y tracking del trabajo.

## 📋 Tabla de Contenidos

- [¿Qué es un Project?](#qué-es-un-project)
- [Estructura](#estructura)
- [Board Kanban](#board-kanban)
- [Cómo Usar](#cómo-usar)
- [Mejores Prácticas](#mejores-prácticas)

---

## ¿Qué es un Project?

Un **GitHub Project** es un tablero para organizar y rastrear trabajo. Similar a Trello, Jira, Asana.

### Beneficios

✅ **Centralizado**: Todo en GitHub, no necesitas otra herramienta
✅ **Automático**: Los Issues se actualizan solos
✅ **Visual**: Cómo van las cosas en tiempo real
✅ **Colaborativo**: El equipo ve el progreso
✅ **Flexible**: Personalizable por proyecto

### Tipos de Views

- **Board**: Kanban (columnas: To Do, In Progress, Done)
- **Table**: Vista de tabla con filtros
- **Roadmap**: Timeline visual
- **Custom**: Tu propia vista

---

## Estructura

### Proyectos por Épica

```
PROYECTO: Epic/1-Setup
├── Issue #1: Configurar repo
├── Issue #2: Setup Supabase
├── Issue #3: Setup CI/CD
└── Issue #4: Setup Sentry

PROYECTO: Epic/2-Database
├── Issue #5: Diseño DB
├── Issue #6: Modelos SQLAlchemy
└── Issue #7: Migrations

PROYECTO: Epic/N-...
└── Issue #N: ...
```

### Estados en el Board

```
┌───────────┬──────────────┬──────────────────┬────────┐
│  BACKLOG  │ IN PROGRESS  │  IN REVIEW (PR)  │  DONE  │
│           │              │                  │        │
│ #1 Setup  │ #2 Database  │ #3 Config CI/CD  │ #4 Done│
│ #5 Models │ #6 Auth API  │                  │        │
│           │              │                  │        │
└───────────┴──────────────┴──────────────────┴────────┘
```

---

## Board Kanban

### Columnas Estándar

| Columna | Significado | Descripción |
|---------|-------------|-------------|
| **📋 Backlog** | No empezado | Issue creado, sin asignación |
| **🚀 In Progress** | En desarrollo | Alguien está trabajando en esto |
| **👀 In Review** | Esperando revisión | PR abierto, esperando aprobación |
| **✅ Done** | Completado | PR mergeado, issue finalmente |

### Cards (Tarjetas)

Cada issue es una tarjeta:

```
┌─────────────────────────┐
│ Issue #5: Diseño DB     │
│                         │
│ Assignees:              │
│ @juan, @maria           │
│                         │
│ Labels:                 │
│ bug, priority-high      │
│                         │
│ Progress: 60% done      │
│ Epic: #2-database       │
└─────────────────────────┘
```

---

## Cómo Usar

### 1. Crear un Proyecto

**En GitHub:**

1. Ir al repositorio
2. Click en "Projects" tab
3. Click en "New project"
4. Nombre: `Epic/2-Database`
5. Template: "Kanban"
6. Crear

### 2. Agregar Issues al Proyecto

**Opción A: Directo desde el Issue**

```
Abres Issue #5
En la sección "Projects", seleccionas: Epic/2-Database
El issue aparece automáticamente en Backlog
```

**Opción B: Desde el Project**

```
Abres el Project
Click en "+" en la columna Backlog
Busca o crea el issue
Se agrega automáticamente
```

### 3. Mover Cards en el Board

```
Drag & Drop:

┌────────────┐
│ Issue #5   │ ← Click y arrastrar
│ Diseño DB  │
└────────────┘
     ↓
   (soltar en In Progress)
     ↓
┌────────────────┐
│ Issue #5       │ ← Ahora aquí
│ Diseño DB      │
│ @juan assigned │
└────────────────┘
```

Automáticamente:
- Se actualiza el estado del issue
- Los assignees ven la notificación
- El historial queda registrado

### 4. Mantener Actualizado

**Al iniciar a trabajar:**

```
1. Ver el Project
2. Ver Backlog
3. Tomar un issue
4. Asignarte a ti mismo
5. Mover a In Progress
6. Actualizar rama: git pull origin develop
7. Crear rama: git checkout -b epic/2-database
```

**Al completar trabajo:**

```
1. Push los cambios
2. Crear PR
3. Mover issue a "In Review"
4. Cuando PR es aprovado: mover a Done
```

---

## Mejores Prácticas

### ✅ Hacer

**Mantener Sincronizado:**
```
✅ Cuando empiezas: In Progress
✅ Cuando creas PR: In Review
✅ Cuando mergea PR: Done
```

**Asignar Issues:**
```
✅ En Progress: asignado a alguien
✅ Backlog: sin asignación
✅ Done: sin asignación (completado)
```

**Labels Consistentes:**
```
✅ Usar mismos labels en todos los issues
✅ Priority: high, medium, low
✅ Component: backend, frontend, db
✅ Status: bug, feature, docs, test, chore
```

### ❌ No Hacer

**Issues Incompletos:**
```
❌ Issue sin definición clara
❌ Issue sin criterios de aceptación
❌ Issue en Done pero PR no merged
```

**Board Desactualizado:**
```
❌ Card en In Progress pero nadie trabaja
❌ Card en In Review pero no hay PR
❌ Dejar issues sin mover días
```

**Sobrecargar:**
```
❌ 20 issues en In Progress de una persona
❌ Issues sin stories points
❌ Sin respetar capacidad del equipo
```

---

## Workflow Típico

### Sprint Planning

**Monday 9:00 AM:**

```
1. Abrir Epic Project
2. Ver qué falta en Backlog
3. Estimar esfuerzo de issues
4. Asignar issues al equipo
5. Move a In Progress
6. Cada dev crea rama desde epic/*
```

### Durante la Semana

**Cada Dev:**

```
Public -> In Progress -> In Review -> Done

Mañana:
1. Ver Project
2. Sé asignado a Issue #5
3. Mover a In Progress
4. git checkout epic/2-database
5. git pull origin develop
6. Trabajar...
7. Cuando terminas: PR
8. Mover a In Review

Tarde:
9. PR review queda esperando
10. Mientras: Tomar otro issue
11. Si hay feedback: aplicar
12. PR se mergea: mover a Done
```

### Friday Review

**Friday 5:00 PM:**

```
1. Ver Project
2. Contar Done issues
3. Ver Backlog vs In Progress
4. Celebrar progreso
5. Plan para próxima semana
```

---

## Ejemplo Real: Epic/2-Database

### Vista Inicial (Lunes)

```
BACKLOG           IN PROGRESS        IN REVIEW     DONE
─────────────────────────────────────────────────────

#5 Diseño DB      #6 Modelos Core               #4 Setup ✓
#7 Migrations     
#8 Fixtures       
#9 Seed data      
```

### Miércoles por la Mañana

```
BACKLOG           IN PROGRESS        IN REVIEW     DONE
─────────────────────────────────────────────────────

#8 Fixtures       #7 Migrations      #5 Diseño DB   
#9 Seed data      #8 Fixtures     (Juan: PR #512) 
                  #9 Seed data       
                                  #6 Modelos
                                  (Maria: PR #513)

                                     
```

### Viernes EOD

```
BACKLOG           IN PROGRESS        IN REVIEW     DONE
─────────────────────────────────────────────────────

               #9 Seed data     [Ninguno]     #4 Setup ✓
                                              #5 Diseño DB ✓
                                              #6 Modelos ✓
                                              #7 Migrations ✓
                                              #8 Fixtures ✓
                                              
Progreso: 83% (5/6 done)
```

---

## Integraciones Automáticas

GitHub Project se actualiza automáticamente cuando:

| Evento | Acción |
|--------|--------|
| Issue creado | Aparece en Backlog |
| PR abierto linkeado | Se mueve a In Review |
| PR mergeado | Se mueve a Done |
| Issue cerrado | Se mueve a Done |
| Asignación | Actualiza el card |
| Label agregado | Visible en el card |

### Ejemplo

```
1. Abres PR #512 (Closes #5)
   ↓
2. GitHub automáticamente:
   - Vincula PR con Issue
   - Mueve Issue a In Review
   - Muestra "PR #512" en el card
   ↓
3. Cuando mergeas:
   - GitHub cierra Issue #5
   - Mueve a Done
   - Registra timestamp
```

---

## Custom Views (Avanzado)

### Table View

```
Útil para: Ver todos los fields a la vez

Issue    │ Status   │ Assignee │ Label      │ Epic
────────────────────────────────────────────────────
#5       │ Done     │ Juan     │ feature    │ #2
#6       │ In Prog  │ Maria    │ feature    │ #2
#7       │ In Rev   │ Juan     │ feature    │ #2
#8       │ Backlog  │ -        │ feature    │ #2
```

### Filtros

```
Mostrar solo issues asignados a "Juan":
- Filter → Assignee → Juan

Mostrar solo "bugs":
- Filter → Label → bug

Mostrar solo In Progress:
- Filter → Status → In Progress
```

### Grouping

```
Agrupar por Assignee:
- Group by → Assignee

Agrupar por Priority:
- Group by → Label
```

---

## Reporting

### Velocity (Velocidad)

```
Semana 1: 5 issues done
Semana 2: 7 issues done
Semana 3: 6 issues done

Promedio: 6 issues/semana
```

### Burndown Chart

```
Issues restantes:
┌─────────────────────┐
│ 10 │                │
│    │  ╱              │
│  8 │ ╱               │
│    │╱                │
│  6 │                 │
│    │                 │
│  4 │                 │
│    │                 │
│  2 │                 │
│    │_________________|
│  0 └─────────────────┘
  Mon Tue Wed Thu Fri
```

### Epic Health

```
Epic/1-Setup:  ✅ 100% (4/4 done)
Epic/2-Database: 🟡 75% (3/4 in progress)
Epic/3-Auth:  ⚠️  20% (1/5 started)
```

---

## Preguntas Frecuentes

**P: ¿Debo meter todos los issues en un Project?**
R: Mínimo, todos los de la épica. Tareas muy pequeñas pueden omitirse.

**P: ¿Qué pasa si alguien mueve wrongly?**
R: No hay problema, todo está registrado. Revierte si es necesario.

**P: ¿Puedo tener issue en múltiples Projects?**
R: Sí, pero generalmente uno por issue.

**P: ¿Qué pasa con las milestones?**
R: Projects reemplaza milestones. Usa uno u otro, no ambos.

**P: ¿Cómo veo cuánto falta?**
R: En el Project, ve la barra de progreso visual en cada columna.

**P: ¿Puedo ver Project en mobile?**
R: Sí, GitHub mobile muestra Projects pero con vista limitada.

---

## Checklist Semanal

- [ ] Project actualizado (cards en columnas correctas)
- [ ] Todos los PRs linkeados a issues
- [ ] Todos los issues tienen assignee o están en Backlog
- [ ] Labels consistentes
- [ ] Done column limpia (sin WIP)
- [ ] Backlog priorizado
- [ ] Sprint planning hecho si hay cambios
- [ ] Team sabe qué trabajar (In Progress tiene items)

---

**¡Usa Projects para mantener equipo en sincronía! 🎯**

La transparencia en el trabajo elimina bloqueos y mejora collaboration.

**Última actualización:** Febrero 2026
