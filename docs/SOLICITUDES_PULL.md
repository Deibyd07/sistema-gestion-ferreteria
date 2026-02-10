# 🔀 Pull Requests - Guía Detallada

Aprende cómo crear, revisar y mergear pull requests de forma profesional.

## 📋 Tabla de Contenidos

- [¿Qué es un Pull Request?](#qué-es-un-pull-request)
- [Flujo Completo](#flujo-completo)
- [Crear un PR](#crear-un-pr)
- [Template del PR](#template-del-pr)
- [Durante el Review](#durante-el-review)
- [Merge](#merge)
- [Buenas Prácticas](#buenas-prácticas)
- [Troubleshooting](#troubleshooting)

---

## ¿Qué es un Pull Request?

Un **Pull Request (PR)** es una solicitud para revisar y fusionar tus cambios al código principal.

### Por qué PRs?

```
❌ SIN PRs:
- Cualquiera mergea código directamente
- Sin revisión
- Bugs llegan a producción
- Nadie aprende del código de otros

✅ CON PRs:
- Código revisado antes de mergear
- CI/CD valida automáticamente
- Oportunidad para feedback
- Knowledge sharing
- Historial de decisiones
- Rollback simple si hay problemas
```

---

## Flujo Completo

```
┌─────────────────────────────────────────────────────────┐
│  YA HICISTE CAMBIOS EN TU RAMA epic/*                   │
└──────────────────┬──────────────────────────────────────┘
                   │
                   │ git push origin epic/rama
                   │
┌──────────────────▼──────────────────────────────────────┐
│  GITHUB DETECTA CAMBIOS                                 │
│  (Banner "Compare & pull request" aparece)              │
└──────────────────┬──────────────────────────────────────┘
                   │
                   │ Click en "Compare & pull request"
                   │
┌──────────────────▼──────────────────────────────────────┐
│  CREAR PR                                               │
│  • Título y descripción                                 │
│  • Linkar issues                                        │
│  • Seleccionar reviewers                                │
└──────────────────┬──────────────────────────────────────┘
                   │
                   │ Click "Create pull request"
                   │
┌──────────────────▼──────────────────────────────────────┐
│  CI/CD AUTOMÁTICO CORRE                                 │
│  • Tests                                                │
│  • Lint                                                 │
│  • Build                                                │
│  (Esperar a que pasen)                                  │
└──────────────────┬──────────────────────────────────────┘
                   │
                   │ (Passing checks ✅)
                   │
┌──────────────────▼──────────────────────────────────────┐
│  REVIEWERS REVISAN X2 (aprox 24-48 horas)              │
│  • Leen código                                          │
│  • Dejan comentarios/sugerencias                        │
│  • Aprueban o solicitan cambios                         │
└──────────────────┬──────────────────────────────────────┘
                   │
        ┌──────────┴──────────┐
        │                     │
┌───────▼─────┐       ┌────────▼──────┐
│ APROBADO ✅ │       │ CAMBIOS ⚠️     │
└───────┬─────┘       └────────┬──────┘
        │                      │
        │                      │ Haces cambios
        │                      │ git add .
        │                      │ git commit -m "fix: feedback"
        │                      │ git push origin epic/rama
        │                      │
        │                      │ CI/CD corre de nuevo
        │                      │
        │                      │ Re-request review
        │                      │
        │                      └──────────┐
        │                                  │
        │             (Loop hasta ✅)  │
        │                                  │
        │<─────────────────────────────────┘
        │
┌───────▼──────────────────────────────┐
│  MERGE                                │
│  "Squash and merge"                   │
│  • GitHub combina commits             │
│  • Fusiona a develop                  │
│  • Elimina rama                       │
│  • Cierra automáticamente issues      │
└───────────────────────────────────────┘
```

---

## Crear un PR

### Paso 1: Hacer Push

```bash
# Asegúrate de estar en tu rama
git checkout epic/2-database

# Push los cambios
git push origin epic/2-database
```

### Paso 2: Abre PR en GitHub

1. Ir a https://github.com/tu-organizacion/sistema-gestion-ferreteria
2. Debería ver un banner amarillo:
   ```
   epic/2-database had recent pushes
   [Compare & pull request] [Dismiss]
   ```
3. Click en "Compare & pull request"

### Paso 3: Revisa Info Automática

Verifica:
- **Base**: `develop` ✅
- **Compare**: `epic/2-database` ✅
- **Conflicts**: "This branch has no conflicts" ✅

### Paso 4: Completa el Template

[Ver sección Template](#template-del-pr)

### Paso 5: Selecciona Reviewers

```
⚙️ Assignees:
- [Tu nombre] (asignatee automático)

🔍 Reviewers:
- Selecciona 1-2 compañeros
- Elige Senior Developer si es cambio importante
```

### Paso 6: Crea el PR

Click en **"Create pull request"**

---

## Template del PR

### Asegúrate de Rellenar TODO

```markdown
## 📝 Descripción

[REQUERIDO: Explicar los cambios en 2-3 líneas]
Qué cambió y por qué.

## 🎯 Tipo de Cambio

- [ ] 🐛 Bug fix (change that fixes an issue)
- [x] ✨ New feature (change adds functionality)
- [ ] 💥 Breaking change (causes existing functionality to not work)
- [ ] 📝 Documentation update

## 🔗 Issues Relacionadas

[RECOMENDADO: Linkar a issues]
Closes #123
Related to #456, #789

## ✅ Checklist

- [ ] Código formateado (Black/Prettier)
- [ ] Linting pasando (Ruff/ESLint)
- [ ] Type check pasando (mypy/TypeScript)
- [ ] Tests creados/actualizados
- [ ] Todos los tests pasan
- [ ] Documentación actualizada
- [ ] Sin cambios no deseados en el PR
- [ ] Rama actualizada con develop

## 🧪 Cómo Probar

[REQUERIDO: Pasos para que el reviewer pruebe]
1. Checkout mi rama: `git checkout epic/2-database`
2. Instala deps: `npm install`
3. Ejecuta app: `npm run dev`
4. Abre http://localhost:3000
5. Verifica que:
   - [Feature funciona como se espera]
   - [Caso edge funciona]
   - [Errors mencionan claramente]

## 📸 Screenshots

[OPCIONAL pero recomendado si hay cambios visuales]

Antes:
![Screenshot anterior o N/A]

Después:
![Screenshot nuevo o N/A]

## 📝 Notas Adicionales

[OPCIONAL: Cualquier info útil]
- Decisiones de diseño importantes
- Alternativas consideradas
- TODOs futuros
- Limitaciones conocidas
```

### Ejemplo Real

```markdown
## 📝 Descripción

Agregué validación de email en el registro de usuarios.
Ahora valida formato y revisa duplicados en tiempo real.

## 🎯 Tipo de Cambio

- [x] ✨ New feature
- [x] 🐛 Bug fix (previene registros con email duplicado)

## 🔗 Issues Relacionadas

Closes #45
Related to #12

## ✅ Checklist

- [x] black app/ tests/
- [x] ruff check passed
- [x] mypy app/ passed
- [x] pytest tests/ passed with 88% coverage
- [x] Documentación actualizada en INSTALLATION.md
- [x] No hay cambios accidentales

## 🧪 Cómo Probar

1. Checkout: `git checkout epic/3-auth`
2. Install: `pip install -r requirements.txt`
3. Run: `python -m uvicorn app.main:app --reload`
4. Test:
   - POST /api/auth/register con email válido → success
   - POST /api/auth/register con email inválido → error 400
   - POST /api/auth/register con email duplicado → error 409
   - Validación ocurre mientras escribes (frontend)

## 📸 Screenshots

Antes:
[Sin validación en tiempo real]

Después:
![Mensaje de error instantáneo]

## 📝 Notas

- Validación regex para RFC 5322
- Check en DB para duplicados
- Mensaje de error user-friendly
- Próximo: Enviar email de confirmación
```

---

## Durante el Review

### Para el Autor: Recibir Feedback

#### Comentarios Generales → Tab "Conversation"

```
Tu PR ha sido marcado con "changes requested".
Lee los comentarios en la pestaña "Conversation".
```

#### Comentarios en Línea → Tab "Files changed"

```
El reviewer comentó específicamente en una línea.
Verás el comentario directamente en el diff.
```

#### Tipos de Feedback

**🔴 Red Flag (bloqueador):**
```
Este cambio tiene un problema de seguridad...
```
→ DEBE ser arreglado antes de mergear

**🟡 Yellow Flag (sugerencia):**
```
Sugerencia: Considerad usar...
```
→ Discutible, pero buena idea implementar

**🟢 Green Flag (aprobado):**
```
Looks good to me! ✅
```
→ Aprobado

#### Cómo Responder

```markdown
✅ BIEN:
"Buen punto. Cambié a usar async/await en lugar de .then()
He pusheado los cambios. Ready for re-review."

❌ MAL:
"Eso está mal especificado en el issue"
"No hay problema con ese código"
```

#### Proceso si hay Cambios Solicitados

1. **Lee el comentario** completo
2. **Haz los cambios** en tu rama local
   ```bash
   git add .
   git commit -m "fix: aplicar feedback del review"
   git push origin epic/2-database
   ```
3. **Responde el comentario** en GitHub
   ```
   Cambios aplicados en ac3d1fa. ✅
   ```
4. **Re-request review**
   - Click en el nombre del reviewer
   - Click en "re-request review"

### Para el Reviewer: Dar Feedback

#### Checklist de Review

```
Completitud:
✅ ¿Los cambios resuelven el issue?
✅ ¿Se menciona todo lo relevante?
✅ ¿No hay TODOs sin resolver?

Código:
✅ ¿El código es legible?
✅ ¿Sigue convenciones del proyecto?
✅ ¿Hay lógica extraña?
✅ ¿Hay duplicación?

Tests:
✅ ¿Hay tests?
✅ ¿Los tests pasan?
✅ ¿Coverage adecuado (>80%)?
✅ ¿Edge cases cubiertos?

Performance:
✅ ¿Hay consultas N+1?
✅ ¿Hay loops innecesarios?
✅ ¿Memory leaks?

Seguridad:
✅ ¿Validación de inputs?
✅ ✅ Auth/permiso checks?
✅ ¿SQL injection protección?
✅ ¿XSS protección?

Documentación:
✅ ¿Docstrings/comentarios?
✅ ¿README actualizado?
✅ ¿Change log actualizado?
```

#### Cómo Comentar (Bien)

**❌ MAL:**
```
"Este código está mal"
"¿Por qué hiciste esto?"
"Esto no funciona"
```

**✅ BIEN:**
```
"Buen inicio! Sugiero que en lugar de parse manualmente,
uses json.loads() que es más robusta y maneja edge cases:

```python
try:
    data = json.loads(input_str)
except json.JSONDecodeError as e:
    raise ValueError(f"Invalid JSON: {e}")
```

Esto te permite capturar errores específicamente.
Alternativamente, podrías usar pydantic para validación automática."
```

#### Hacer Comentarios

1. Click en la línea en "Files changed"
2. Escribe tu comentario
3. Click "Start a review" (si es el primero)
4. O "Reply" (si está en una conversación)
5. Cuando termines: Click "Review changes"

#### Entregar Review

En "Review changes":
- **Comment**: Feedback pero sin bloquear
- **Approve**: Los cambios están bien ✅
- **Request changes**: Cambios necesarios ❌

---

## Merge

### Cuándo Mergear

✅ Mergear cuando:
- [ ] Todos los checks pasan (CI/CD)
- [ ] Al menos 1 aprobación
- [ ] Conflictos resueltos
- [ ] Tests pasan
- [ ] Código es limpio

❌ No mergear si:
- [ ] Checks fallando
- [ ] Issues no resueltos
- [ ] PR muy grande (>500 cambios)

### Cómo Mergear

1. Scroll hasta el bottom del PR
2. Click "Squash and merge"
3. Edita mensaje si es necesario
4. Click "Confirm squash and merge"

GitHub automáticamente:
- Combina todos tus commits en uno
- Lo fusiona a `develop`
- Elimina tu rama
- Cierra issues relacionadas

### Después del Merge

Tu rama local está desactualizada. Sincroniza:

```bash
git checkout develop
git pull origin develop
git branch -d epic/2-database
```

---

## Buenas Prácticas

### ✅ Hacer

**Commits Pequeños:**
```bash
✅ BIEN:
"feat: agregar validación de email"
"test: agregar test para validación"
"docs: actualizar INSTALLATION.md"

❌ MAL:
"cambios"
"fixes"
"actualizado"
"hecho"
```

**Descripción Clara:**
```
✅ "Agregar endpoint GET /api/users/:id con validación RLS"
❌ "api stuff"
```

**Linkar Issues:**
```
✅ Closes #45, Related to #12
❌ Sin mencionar issues
```

**Rebase si es Necesario:**
```bash
# Si develop cambió mucho, rebase:
git checkout epic/2-database
git pull --rebase origin develop
git push --force-with-lease origin epic/2-database
```

### ❌ No Hacer

**PRs Enormes:**
```
❌ 500+ líneas en un PR
❌ Múltiples features no relacionadas

✅ PRs pequeñas, enfocadas
✅ Una idea por PR
```

**Requests sin Info:**
```
❌ Input inválido sin validación
❌ Sin error messages claros

✅ Validar siempre
✅ Mensajes descriptivos
```

**Sin Tests:**
```
❌ Nuevo código sin tests
❌ Coverage < 80%

✅ Agregar tests para nuevo código
✅ Mantener coverage > 80%
```

**Ignorar Feedback:**
```
❌ "Mi código está bien, no cambio"
❌ Defender lo indefendible

✅ Escuchar y aprender
✅ Estar abierto a mejoras
```

---

## Troubleshooting

### Conflictos de Merge

**El problema:**
```
❌ "This branch has conflicts that must be resolved"
```

**La solución:**
```bash
git fetch origin
git merge origin/develop

# Git marca los conflictos con: <<<<<<<, =======, >>>>>>>
# Edita los archivos y elige qué code mantener

git add .
git commit -m "merge: resolver conflictos con develop"
git push origin epic/2-database
```

### Tests Fallando

**En "Checks" del PR:**
```
❌ Test: test_create_user failed
```

**Pasos:**
1. Lee el error en los logs
2. Reproduce localmente:
   ```bash
   pytest tests/ -v
   ```
3. Arregla el test
4. Push nuevamente

### Cambios No Deseados en el PR

**El problema:**
```
Tu PR contiene cambios que no debes (formato de archivo, env, etc)
```

**La solución:**
```bash
# No incluyas archivos específicos
git reset HEAD archivo-no-deseado.txt
# Edita .gitignore para el futuro
echo "archivo-ignorado.txt" >> .gitignore
git add .gitignore
git commit -m "chore: actualizar .gitignore"
git push origin epic/2-database
```

### Rama Desactualizada

**El problema:**
```
⚠️ This branch is X commits behind develop
```

**La solución:**
```bash
git fetch origin
git merge origin/develop
# o rebase
git rebase origin/develop
git push origin epic/2-database
```

---

## Flujo Rápido (Resumen)

```bash
# 1. Hacer cambios (ya hecho)
git add .
git commit -m "feat: descripción"

# 2. Push
git push origin epic/2-database

# 3. Crear PR en GitHub
# Click "Compare & pull request"
# Llenar template
# Click "Create pull request"

# 4. Esperar review
# Si piden cambios:

git add .
git commit -m "fix: feedback"
git push origin epic/2-database
# Re-request review en GitHub

# 5. Merge
# Click "Squash and merge"

# 6. Cleanup
git checkout develop
git pull origin develop
git branch -d epic/2-database
```

---

## Preguntas Frecuentes

**P: ¿Puedo editar un PR después de crearlo?**
R: Sí! Haz push a la misma rama. El PR se actualiza automáticamente.

**P: ¿Cuántos reviews necesito?**
R: Mínimo 1. Recomendado 2 si es cambio importante.

**P: ¿Cuánto tarda en pasar CI/CD?**
R: Generalmente 2-5 minutos. Espera a ✅ all checks passed.

**P: ¿Puedo mergear mi propio PR?**
R: No, otra persona debe aprobar. Esto evita código no revisado.

**P: ¿Debo "suara and merge" o "merge commit"?**
R: Usa "Squash and merge" para mantener historial limpio.

**P: ¿Qué pasa con mi rama después del merge?**
R: Se elimina automáticamente. Puedes crear nuevas ramas desde develop.

---

**¡Felicidades! Ahora sabes cómo usar PRs profesionalmente 🎉**

**Última actualización:** Febrero 2026
