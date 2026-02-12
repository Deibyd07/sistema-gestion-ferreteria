# 🌳 Estrategia de Branching - Épicas con Pull Requests

## Estructura de Ramas

Estrategia basada en **ramas de épicas** con **Pull Requests para revisión en develop**.

### Ramas Principales

#### `main`
- **Propósito**: Código de producción estable y probado
- **Estado**: Siempre debe estar en estado desplegable
- **Nombrado**: `main`
- **Protección**: Requiere PR aprobado y todos los checks pasando

#### `develop`
- **Propósito**: Rama de integración y testing
- **Estado**: Código funcional pero en validación
- **Nombrado**: `develop`
- **Protección**: Requiere PR aprobado y CI/CD pasando
- **Flujo**: Los PRs de épicas se cierran aquí para revisión y testing

### Ramas de Trabajo

#### Ramas de Épicas
- **Propósito**: Desarrollar todas las issues de una épica completa
- **Base**: Se crean desde `develop`
- **Pull Request a**: `develop` para revisión y testing
- **Merge a**: `develop` después de aprobación, luego a `main` cuando está estable
- **Naming**: `epic/N-nombre-corto`
- **Ciclo de vida**: Una rama por épica, reutilizable durante toda la épica

**Ejemplos:**
- `epic/1-setup`
- `epic/2-database`
- `epic/3-auth`
- `epic/8-pos`

---

## 📋 Workflow Completo

### 1. Iniciar una Épica

```bash
# Asegurarse de estar en develop actualizado
git checkout develop
git pull origin develop

# Crear y cambiar a la rama de épica
git checkout -b epic/N-nombre

# Ejemplo:
git checkout -b epic/2-database

# Push inicial de la rama
git push -u origin epic/2-database
```

### 2. Trabajar en las Issues de la Épica

Mientras trabajas en la épica, haz commits regulares:

```bash
# Estar en la rama de épica
git checkout epic/2-database

# Hacer cambios de las issues
# ... editar archivos ...

# Commit con mensaje claro indicando la issue
git add .
git commit -m "feat(issue-5): diseño del modelo de base de datos"

# Push regularmente
git push origin epic/2-database
```

#### Actualizar Rama con develop

Periódicamente, mantén tu rama actualizada con develop para evitar conflictos:

```bash
# Fetch de cambios remotos
git fetch origin

# Merge de develop a tu rama
git merge origin/develop

# Si hay conflictos, resolverlos y hacer commit:
git add .
git commit -m "merge: actualizar con develop"
git push origin epic/2-database
```

### 3. Crear Pull Request

Cuando hayas completado features o quieras feedback:

```bash
# Asegurarse de estar actualizado
git fetch origin
git merge origin/develop

# Push antes de crear el PR
git push origin epic/2-database
```

**En GitHub:**
1. Ir al repositorio
2. Click en "Compare & pull request" (debería aparecer automáticamente)
3. Asegurarse de que:
   - **Base**: `develop`
   - **Compare**: `epic/2-database`
4. Completar el template de PR:
   - Describir los cambios
   - Linkar issues relacionadas
   - Agregar screenshots si aplica
5. Seleccionar reviewers
6. Crear el PR

### 4. Proceso de Revisión

#### Para el Autor del PR:

```bash
# Si hay cambios solicitados:
# 1. Hacer los cambios en los archivos
git add .
git commit -m "fix: aplicar feedback del review"
git push origin epic/2-database

# La rama se actualiza automáticamente en el PR
```

**Checklist:**
- ✅ Responder comentarios prontamente
- ✅ Aplicar cambios solicitados
- ✅ Marcar conversaciones como resueltas
- ✅ Mantener la rama actualizada
- ✅ Solicitar re-review cuando esté listo

#### Para el Reviewer:

- ✅ Revisar dentro de 24-48 horas
- ✅ Ser constructivo y específico
- ✅ Probar los cambios localmente si es necesario
- ✅ Aprobar cuando todo está correcto
- ✅ Explicar el razonamiento de cambios solicitados

### 5. Merge del PR

Una vez **aprobado** y **todos los checks pasaron**:

1. El reviewer o el autor hace click en "Squash and merge"
   - Esto combina todos los commits en uno
   - Mantiene el historial limpio

2. GitHub elimina automáticamente la rama remota

3. Actualizar localmente:
   ```bash
   git checkout develop
   git pull origin develop
   git branch -d epic/2-database  # Eliminar rama local
   ```

### 6. Pasar a Producción (develop → main)

Cuando TODAS las issues de la épica estén completadas y aprobadas en develop:

```bash
# Crear PR de develop → main (si es necesario) o merge directo
git checkout main
git pull origin main

git merge develop
git push origin main

# Agregar tag de versión (opcional pero recomendado)
git tag -a v0.2.0 -m "Épica 2: Base de datos completa"
git push origin --tags
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

## 📊 Diagrama del Flujo de Trabajo

```
┌─────────────────────────────────────────────────────────────────┐
│                    FLUJO DE TRABAJO CON ÉPICAS                  │
└─────────────────────────────────────────────────────────────────┘

                               MAIN (Producción)
                                    ▲
                                    │
                    Cuando épica está probada y lista
                    (puede requerir aprobación adicional)
                                    │
                               DEVELOP (Integración)
                                    ▲
                                    │
                    PR aprobado + CI/CD pasando
                                    │
                    ┌───────────────┴────────────────┐
                    │                                │
              epic/1-setup                     epic/2-database
              epic/3-auth                      epic/4-tenants
                 ┌─ issues                        ┌─ issues
                 └─ branches temporales           └─ branches temporales
                    locales (opcional)               locales (opcional)

FLUJO:
1. Crear rama epic/* desde develop
2. Haz commits en la rama
3. Mantén actualizada con develop
4. Crea PR epic/* → develop
5. Solicita review
6. Reviewer aprueba
7. Merge a develop (squash and merge)
8. Cuando épica completa, mergea develop → main si es necesario
```

---

## 🎯 Mapeo de Épicas

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

---

## 🚀 Inicio Rápido

```bash
# 1. Crear rama de épica
git checkout develop
git pull origin develop
git checkout -b epic/2-database
git push -u origin epic/2-database

# 2. Trabajar en la épica
git add .
git commit -m "feat(issue-5): diseño del modelo de base de datos"
git push origin epic/2-database

# 3. Mantener actualizado
git fetch origin
git merge origin/develop
git push origin epic/2-database

# 4. Crear PR en GitHub (epic/2-database → develop)

# 5. Después del merge, actualizar localmente
git checkout develop
git pull origin develop
git branch -d epic/2-database
```

---

## 🆘 Comandos Útiles

```bash
# Ver todas las ramas
git branch -a

# Cambiar de rama
git checkout epic/N-nombre

# Actualizar rama actual
git pull origin nombre-rama

# Ver diferencias entre ramas
git diff main..epic/2-database
git diff develop..epic/2-database

# Ver cambios no pusheados
git log origin/develop..HEAD

# Eliminar rama local
git branch -d epic/2-database

# Eliminar rama remota
git push origin --delete epic/2-database

# Ver log gráfico
git log --oneline --graph --all

# Rebasar (si prefieres en lugar de merge)
git rebase origin/develop
```

---

## ⚠️ Resolución de Conflictos

Si tienes conflictos al actualizar:

```bash
# 1. Actualizar desde develop
git fetch origin
git merge origin/develop

# 2. Aparecerán archivos con conflictos (marcados con <<<<<<<, =======, >>>>>>>)

# 3. Resolver conflictos manualmente (tu editor puede ayudarte)

# 4. Marcar como resueltos
git add archivo-resuelto.py

# 5. Hacer commit
git commit -m "merge: resolver conflictos con develop"

# 6. Push
git push origin epic/2-database
```

---

## ✅ Resumen de Ventajas

Esta estrategia ofrece:

✅ **Fácil de entender** - Épicas → Pull Requests → develop → main  
✅ **Revisión de código obligatoria** - Todos los cambios pasan por PR  
✅ **Testing antes de merge** - CI/CD valida automáticamente  
✅ **Histórico limpio** - Squash and merge mantiene commits organizados  
✅ **Colaboración mejorada** - Code review facilita aprendizaje  
✅ **Rollback simple** - Si hay problemas, revert al commit anterior  
✅ **Integración stageda** - develop es para validación antes de producción  

---

## 📚 Buenas Prácticas

### ✅ Hacer

- Mantener ramas sincronizadas con develop regularmente
- Hacer commits pequeños y frecuentes
- Escribir mensajes de commit descriptivos
- Responder promptamente a reviews
- Probar localmente antes de push
- Usar meaningful branch names

### ❌ No Hacer

- Mergear directamente sin PR
- Desactualizar ramas (pueden causar conflictos grandes)
- Hacer commits enormes con muchos cambios
- Ignorar feedback del review
- Pushear código sin pasar tests localmente
- Usar nombres genéricos como "bugfix" o "new-feature"

---

**Última actualización:** Febrero 2026
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