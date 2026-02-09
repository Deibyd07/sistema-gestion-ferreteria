# 📋 Guía Rápida de Templates

Esta guía explica cómo usar los templates simplificados de GitHub.

## 🎯 Filosofía de los Templates

Nuestros templates están diseñados para ser:
- ✅ **Rápidos de completar** (2-3 minutos)
- ✅ **Claros y directos** (sin campos confusos)
- ✅ **Efectivos** (capturan lo esencial)
- ✅ **Fáciles de usar** (incluso para principiantes)

## 📝 Templates Disponibles

### 1. 🐛 Bug Report

**Cuándo usar**: Cuando encuentres algo que no funciona correctamente.

**Campos principales**:
- ¿Qué está mal? (descripción corta)
- ¿Cómo reproducirlo? (pasos)
- ¿Qué debería pasar? (comportamiento esperado)
- Severidad (Critical/High/Medium/Low)

**Opcional**: Screenshots, información del entorno

**Tiempo estimado**: 2-3 minutos

---

### 2. ✨ Feature Request

**Cuándo usar**: Para proponer una nueva funcionalidad.

**Campos principales**:
- ¿Qué problema resuelve?
- ¿Cómo debería funcionar?
- Prioridad (High/Medium/Low)

**Opcional**: Información adicional, mockups

**Tiempo estimado**: 3-5 minutos

---

### 3. 📖 User Story

**Cuándo usar**: Para describir funcionalidades desde la perspectiva del usuario.

**Formato**: Como [rol], quiero [funcionalidad] para [beneficio]

**Campos principales**:
- User Story (formato específico)
- Criterios de aceptación (checklist)
- Prioridad

**Opcional**: Notas adicionales

**Tiempo estimado**: 5 minutos

---

### 4. 🔧 Tarea Técnica

**Cuándo usar**: Para mejoras técnicas (refactoring, deuda técnica, etc.)

**Campos principales**:
- Tipo (Refactoring/Deuda Técnica/Performance/Testing/Otro)
- ¿Qué necesita mejorarse?
- ¿Cómo mejorarlo?
- Prioridad

**Opcional**: Notas adicionales

**Tiempo estimado**: 3-4 minutos

---

### 5. 📚 Documentación

**Cuándo usar**: Para mejorar o agregar documentación.

**Campos principales**:
- Tipo (README/Guía de Instalación/API/etc.)
- ¿Qué falta o está mal?
- ¿Qué agregar/cambiar?
- Archivos afectados

**Tiempo estimado**: 2-3 minutos

---

### 6. 📋 Pull Request

**Cuándo usar**: Al crear cualquier PR.

**Campos principales**:
- ¿Qué hace este PR? (descripción en 2-3 líneas)
- Issue relacionado
- Checklist básico (solo 3 items esenciales)

**Opcional**: Screenshots, notas adicionales

**Tiempo estimado**: 1-2 minutos

## 💡 Tips para Usar los Templates

### Para Bug Reports
```markdown
✅ BUENO:
¿Qué está mal? 
"El formulario de productos acepta stock negativo (-5)"

¿Cómo reproducirlo?
1. Ir a Productos > Nuevo
2. Ingresar cantidad: -5
3. Clic en Guardar

¿Qué debería pasar?
"Mostrar error: 'La cantidad debe ser positiva'"

❌ EVITAR:
- Descripciones vagas ("no funciona", "está roto")
- Pasos incompletos
- No especificar qué esperabas
```

### Para Feature Requests
```markdown
✅ BUENO:
¿Qué problema resuelve?
"Como administrador, necesito ver qué productos se están agotando 
para reabastecerlos a tiempo."

¿Cómo debería funcionar?
"Un dashboard con:
- Lista de productos con stock bajo
- Alertas cuando stock < mínimo
- Botón para crear orden de compra"

❌ EVITAR:
- Propuestas muy vagas
- No explicar el "por qué"
- Falta de detalles sobre cómo debería funcionar
```

### Para User Stories
```markdown
✅ BUENO:
User Story:
"Como vendedor,
Quiero buscar productos rápidamente,
Para atender clientes más rápido."

Criterios de Aceptación:
- [ ] Barra de búsqueda visible en POS
- [ ] Busca por nombre o código
- [ ] Muestra resultados mientras escribo
- [ ] Enter selecciona primer resultado

❌ EVITAR:
- No seguir el formato "Como... quiero... para..."
- Criterios de aceptación vagos
- No especificar el rol de usuario
```

### Para Pull Requests
```markdown
✅ BUENO:
¿Qué hace este PR?
"Agrega validación de stock negativo en el formulario de productos.
Muestra error si el usuario intenta ingresar cantidad negativa."

Checklist:
☑ El código funciona y los tests pasan
☑ Actualicé la documentación (si aplica)
☑ Sin conflictos de merge

❌ EVITAR:
- Descripciones vagas ("arreglé cosas")
- No completar el checklist
- No referenciar el issue
- PRs muy grandes sin explicación
```

## 🚀 Flujo Rápido

### Reportar un Bug
1. Clic en "New Issue"
2. Seleccionar "🐛 Bug Report"
3. Completar 4 campos principales
4. Agregar screenshot si ayuda
5. Submit

**Total: ~2 minutos**

### Proponer Feature
1. Si es idea grande, discutir primero en Discussions
2. Crear "✨ Feature Request"
3. Completar 3 campos principales
4. Submit

**Total: ~3 minutos**

### Crear PR
1. Asegurar que el código funciona
2. Usar template de PR
3. Completar descripción en 2-3 líneas
4. Marcar checklist (3 items)
5. Submit

**Total: ~1-2 minutos**

## ❓ FAQ

### ¿Tengo que completar TODOS los campos?
No. Los campos marcados como "opcionales" puedes saltarlos. Completa solo lo esencial.

### ¿Qué pasa si no sé la prioridad?
Pon "Medium" por defecto. El Product Owner la ajustará si es necesario.

### ¿Puedo editar después de crear el issue?
Sí, siempre puedes editar los issues después de crearlos.

### ¿Qué hago si el template no se ajusta a mi caso?
Usa el que más se acerque y agrega una nota explicando tu situación específica.

### ¿Puedo crear un issue sin usar templates?
Preferimos que uses los templates porque aseguran que no falte información importante, pero no es obligatorio.

## 📊 Comparación: Antes vs Ahora

### Bug Report
**Antes**: 13 campos, ~5-7 minutos
**Ahora**: 5 campos + 1 opcional, ~2-3 minutos
**Reducción**: ~60% más rápido

### Feature Request
**Antes**: 10 campos, ~8-10 minutos
**Ahora**: 3 campos + 1 opcional, ~3-5 minutos
**Reducción**: ~65% más rápido

### Pull Request
**Antes**: Checklist de 40+ items, 6 secciones
**Ahora**: Checklist de 3 items esenciales, ultra simple
**Reducción**: ~90% más simple

## ✅ Principios de los Templates

1. **Lo esencial primero**: Solo pedimos información crítica
2. **Opcionales claramente marcados**: Sabes qué puedes saltar
3. **Ejemplos en placeholders**: Ves qué escribir
4. **Lenguaje claro**: Preguntas directas, sin jerga
5. **Rápida completación**: 2-5 minutos máximo

## 🎯 Objetivo

Hacer que contribuir sea **tan fácil que no haya excusas** para no hacerlo.

---

¿Dudas? Pregunta en [Discussions](https://github.com/Deibyd07/Proyecto-Ferreteria/discussions) 💬
