# 🌳 Estrategia de Branching - Simplificada

## Estructura de Ramas

Estrategia simple y directa con **ramas por épicas**.

### Ramas Principales

#### `main`
- **Propósito**: Código estable y funcional
- **Estado**: Siempre debe estar en estado desplegable
- **Naming**: `main`

### Ramas de Trabajo

#### Ramas de Épicas
- **Propósito**: Desarrollar todas las issues de una épica completa
- **Base**: Se crean desde `main`
- **Merge a**: `main` cuando la épica está completa y probada
- **Naming**: `epic/N-nombre-corto`

**Ejemplos:**
- `epic/1-setup`
- `epic/2-database`
- `epic/3-auth`
- `epic/8-pos`

---

## 📋 Workflow Simple

### 1. Iniciar una Épica

```bash
# Asegurarse de estar en main actualizado
git checkout main
git pull origin main

# Crear y cambiar a la rama de épica
git checkout -b epic/N-nombre

# Ejemplo:
git checkout -b epic/2-database

# Push inicial
git push -u origin epic/2-database
```

### 2. Trabajar en las Issues de la Épica

**Opción A: Trabajar directamente en la épica (Recomendado para issues pequeñas)**

```bash
# Estar en la rama de épica
git checkout epic/2-database

# Hacer cambios de la issue
# ... editar archivos ...

# Commit con mensaje claro indicando la issue
git add .
git commit -m "feat(issue-5): diseño del modelo de base de datos"

# Push
git push origin epic/2-database
```

**Opción B: Crear rama temporal para issue compleja (Opcional)**

```bash
# Solo si la issue es muy compleja o experimental
git checkout epic/2-database
git checkout -b temp/issue-6-modelos-core

# Trabajar...
git add .
git commit -m "feat(issue-6): implementar modelos SQLAlchemy core"

# Merge de vuelta a la épica
git checkout epic/2-database
git merge temp/issue-6-modelos-core

# Eliminar rama temporal
git branch -d temp/issue-6-modelos-core

# Push de la épica
git push origin epic/2-database
```

### 3. Completar una Épica

```bash
# Asegurarse de que todo está pushed
git checkout epic/2-database
git push origin epic/2-database

# Cambiar a main y actualizar
git checkout main
git pull origin main

# Merge de la épica a main
git merge epic/2-database

# Si hay conflictos, resolverlos y commitear

# Push a main
git push origin main

# Opcional: Tag de versión importante
git tag -a v0.2.0 -m "Épica 2: Base de datos completa"
git push origin --tags

# Opcional: Eliminar rama de épica (si ya no la necesitas)
git branch -d epic/2-database
git push origin --delete epic/2-database
```

---

## 💬 Convenciones de Commits

### Formato Simple
```
<tipo>(issue-N): descripción clara
```

### Tipos
- `feat`: Nueva funcionalidad
- `fix`: Corrección de bug
- `docs`: Documentación
- `refactor`: Refactorización
- `test`: Tests

### Ejemplos
```bash
feat(issue-5): diseño del modelo de base de datos
feat(issue-23): CRUD de productos backend
fix(issue-35): corregir cálculo de totales en ventas
docs(issue-74): documentación de API con Swagger
test(issue-64): tests unitarios de modelos
```

---

## 🎯 Mapeo de Épicas

| Épica | Rama | Issues |
|-------|------|--------|
| 1. Configuración Inicial | `epic/1-setup` | #1-4 |
| 2. Base de Datos | `epic/2-database` | #5-10 |
| 3. Autenticación | `epic/3-auth` | #11-15 |
| 4. Gestión Tenants | `epic/4-tenants` | #16-19 |
| 5. Usuarios y Roles | `epic/5-users` | #20-22 |
| 6. PÉpicas del Proyecto

| # | Nombre Épica | Rama | Issues |
|---|--------------|------|--------|
| 1 | Configuración Inicial | `epic/1-setup` | #1-4 |
| 2 | Base de Datos | `epic/2-database` | #5-10 |
| 3 | Autenticación | `epic/3-auth` | #11-15 |
| 4 | Gestión Tenants | `epic/4-tenants` | #16-19 |
| 5 | Usuarios y Roles | `epic/5-users` | #20-22 |
| 6 | Productos | `epic/6-products` | #23-28 |
| 7 | Inventario | `epic/7-inventory` | #29-34 |
| 8 | POS | `epic/8-pos` | #35-40 |
| 9 | Cotizaciones | `epic/9-quotes` | #41-42 |
| 10 | Compras | `epic/10-purchases` | #43-46 |
| 11 | Clientes | `epic/11-customers` | #47-48 |
| 12 | Facturación | `epic/12-billing` | #49-52 |
| 13 | Reportes | `epic/13-reports` | #53-57 |
| 14 | Configuración | `epic/14-settings` | #58-59 |
| 15 | Auditoría | `epic/15-audit` | #60-61 |
| 16 | Notificaciones | `epic/16-notifications` | #62-63 |
| 17 | Testing | `epic/17-testing` | #64-66 |
| 18 | Performance | `epic/18-performance` | #67-69 |
| 19 | Despliegue | `epic/19-deployment` | #70-73 |
| 20 | Documentación | `epic/20-docs` | #74-76 |
| 21 | Features Premium | `epic/21-premium` | #77-80 |
  │    └─ Merge directo a main y develop
  │
  └─ develop (integración)
       │
       ├─ epic/1-setup
       │    ├─ feature/issue-1-config
       │    ├─ feature/issue-2-supabase
       │    └─ feature/issue-3-cicd
       │
       ├─ epic/2-database
       │    ├─ feature/issue-5-diseño-db
       │    ├─ feature/issue-6-modelos-core
       │    └─ ...
       │
      Flujo Visual

```
main
  │
  ├─── epic/1-setup
  │      ├─ commit: feat(issue-1): config inicial
  │      ├─ commit: feat(issue-2): supabase
  │      └─ merge → main
  │
  ├─── epic/2-database  
  │      ├─ commit: feat(issue-5): diseño db
  │      ├─ commit: feat(issue-6): modelos core
  │      └─ merge → main
  │
  └─── epic/3-auth
         ├─ commit: feat(issue-11): supabase auth
         └─ ...
```

---

## 🚀 Inicio Rápido

```bash
# Crear rama de épica
git checkout main
git pull origin main
git checkout -b epic/2-database
git push -u origin epic/2-database

# Trabajar en issues
git add .
git commit -m "feat(issue-5): diseño del modelo de base de datos"
git push origin epic/2-database

# Completar épica
git checkout main
git merge epic/2-database
git push origin main
```

# Eliminar rama local
git branch -d nombre-rama

# Eliminar rama remota
git push origin --delete nombre-rama

# Ver estado de todas las ramas
git branch -vv

# Cambiar a rama y actualizarla
git checkout nombre-rama && git pull

# Ver historial gráfico
git log --oneline --graph --all

# Ver diferencias entre ramas
git diff rama1..rama2

# Lista de commits entre ramas
git log rama1..rama2
```

---✅ Resumen de Ventajas

Esta estrategia simple ofrece:

✅ **Fácil de entender** - Solo main + épicas
✅ **Menos ramas que gestionar** - No hay develop ni features complejas
✅ **Aislamiento por épica** - Cada épica es independiente
✅ **Flexibilidad** - Puedes crear ramas temporales si lo necesitas
✅ **Historial limpio** - Commits organizados por issue
✅ **Fácil rollback** - Si una épica falla, simplemente no la merges

---

## 🆘 Comandos Rápidos

```bash
# Ver ramas
git branch -a

# Cambiar de rama
git checkout epic/N-nombre

# Actualizar rama actual
git pull origin nombre-rama

# Ver diferencias
git diff main..epic/2-database

# Eliminar rama
git branch -d epic/2-database
git push origin --delete epic/2-database

# Ver log gráfico
git log --oneline --graph
```