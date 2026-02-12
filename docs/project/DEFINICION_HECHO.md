# 📋 Definition of Done (DoD)

El "Definition of Done" es una lista de criterios que debe cumplir cada issue para considerarse completado.

## 🎯 Para Todos los Issues

Un issue está **Done** cuando cumple **TODOS** estos criterios:

### Código
- [ ] El código está implementado según los criterios de aceptación del issue
- [ ] El código sigue las [convenciones de estilo](../../CONTRIBUIR.md#estándares-de-código)
- [ ] El código está bien documentado (docstrings, comentarios donde necesario)
- [ ] No hay código comentado o console.logs innecesarios
- [ ] No hay vulnerabilidades de seguridad evidentes

### Tests
- [ ] Se escribieron tests unitarios para el nuevo código
- [ ] Los tests unitarios pasan (`pytest` o `npm test`)
- [ ] Se escribieron tests de integración si aplica
- [ ] La cobertura de código es al menos 80% para nuevo código
- [ ] Todos los tests existentes siguen pasando

### Revisión
- [ ] El código fue revisado por al menos 1 desarrollador (2 para cambios críticos)
- [ ] Todos los comentarios de la revisión fueron resueltos
- [ ] El PR fue aprobado por los revisores

### Calidad
- [ ] No hay errores de linting (`flake8`, `eslint`)
- [ ] No hay warnings de TypeScript (si aplica)
- [ ] El código fue formateado con las herramientas del proyecto (`black`, `prettier`)
- [ ] No hay bugs conocidos en la funcionalidad

### Documentación
- [ ] La documentación del código está actualizada (docstrings, JSDoc)
- [ ] El README se actualizó si hay cambios en configuración o instalación
- [ ] Se actualizó la documentación de usuario si aplica
- [ ] Se agregaron comentarios explicativos en código complejo

### Integración
- [ ] El código se integró con la rama correspondiente (épica o main)
- [ ] No hay conflictos de merge
- [ ] La build de CI/CD pasa completamente
- [ ] Se probó localmente después del merge

### Funcional
- [ ] La funcionalidad cumple los criterios de aceptación del issue
- [ ] Se probó manualmente la funcionalidad (happy path)
- [ ] Se probaron casos edge y manejo de errores
- [ ] La funcionalidad funciona en todos los navegadores soportados (frontend)

### Limpieza
- [ ] Se eliminaron archivos temporales
- [ ] Se eliminaron dependencias no usadas
- [ ] No se committearon archivos de configuración local (`.env`, etc.)
- [ ] El historial de commits está limpio (no commits de "WIP" o "test")

## 🎨 Para Issues de Frontend

Además de los criterios generales:

- [ ] La UI es responsive (móvil, tablet, desktop)
- [ ] La UI cumple con los diseños (si existen)
- [ ] Se probó en Chrome, Firefox, Safari
- [ ] No hay errores en la consola del navegador
- [ ] La accesibilidad es adecuada (alt texts, ARIA labels)
- [ ] Las animaciones y transiciones son suaves
- [ ] Los estados de loading y error están implementados

## 🔧 Para Issues de Backend

Además de los criterios generales:

- [ ] Los endpoints están documentados en OpenAPI/Swagger
- [ ] Se validó la entrada de datos (Pydantic schemas)
- [ ] Se manejan correctamente los errores (try/catch, status codes)
- [ ] Se implementaron logs apropiados
- [ ] Se consideró la seguridad (autenticación, autorización)
- [ ] Se optimizaron las queries de base de datos
- [ ] Se probaron los endpoints con Postman/Insomnia

## 🗄️ Para Issues de Base de Datos

Además de los criterios generales:

- [ ] Las migraciones están creadas y probadas
- [ ] Las políticas RLS están implementadas (Supabase)
- [ ] Los índices necesarios están creados
- [ ] Se validó el rendimiento de las queries
- [ ] Se consideró la integridad de datos (constraints, foreign keys)
- [ ] Se probó rollback de migraciones
- [ ] Se documentaron los cambios de schema

## 📝 Para Issues de Documentación

Además de los criterios generales (donde aplique):

- [ ] La documentación está escrita en markdown
- [ ] Tiene tabla de contenidos si es larga
- [ ] Incluye ejemplos de código cuando es relevante
- [ ] Los links funcionan correctamente
- [ ] Las imágenes están optimizadas y se cargan
- [ ] La gramática y ortografía son correctas
- [ ] Es fácil de entender para el público objetivo

## 🐛 Para Bugs

Además de los criterios generales:

- [ ] Se identificó la causa raíz del bug
- [ ] Se corrigió la causa raíz (no solo los síntomas)
- [ ] Se agregó un test que reproduzca el bug
- [ ] El test falla antes del fix y pasa después
- [ ] Se verificó que no se rompió otra funcionalidad
- [ ] Se verificó que el bug no existe en otros lugares similares

## 🎯 Aceptación del Product Owner

Finalmente, para que un issue esté **completamente Done**:

- [ ] El Product Owner revisó la funcionalidad
- [ ] El Product Owner la acepta como completa
- [ ] Se marcó el issue como "Done" en el Project Board

## ⚠️ Excepciones

En algunos casos específicos, ciertos criterios pueden no aplicar:

- **Spikes técnicos**: Solo requieren documentación del hallazgo
- **Configuración**: Puede no requerir tests
- **Hotfixes críticos**: Pueden tener un proceso acelerado (documentado)

**Importante**: Cualquier excepción debe ser aprobada por el Scrum Master y Product Owner.

## ✅ Checklist para Pull Request

Cuando crees un PR, usa esta checklist en la descripción:

```markdown
## Definition of Done

### Código
- [ ] Implementado según criterios de aceptación
- [ ] Sigue convenciones de estilo
- [ ] Bien documentado

### Tests
- [ ] Tests unitarios escritos y pasando
- [ ] Tests de integración (si aplica)
- [ ] Cobertura ≥ 80%

### Revisión
- [ ] Code review completado
- [ ] Comentarios resueltos
- [ ] PR aprobado

### Documentación
- [ ] Documentación actualizada
- [ ] README actualizado si necesario

### Integración
- [ ] Sin conflictos de merge
- [ ] CI/CD pasando
- [ ] Probado localmente

### Funcional
- [ ] Cumple criterios de aceptación
- [ ] Probado manualmente
- [ ] Casos edge cubiertos

### Aceptación
- [ ] Product Owner aprueba
```

## 📊 Cómo Usar Este DoD

1. **Al iniciar un issue**: Revisa el DoD para entender qué se espera
2. **Durante el desarrollo**: Usa el DoD como checklist
3. **Antes de crear PR**: Verifica que cumples todos los criterios
4. **Durante code review**: Los revisores verifican el DoD
5. **Antes de cerrar issue**: Confirma que todo está cumplido

## 🔄 Evolución del DoD

Este Definition of Done es un documento vivo:

- Se revisa en cada Sprint Retrospective
- Se puede ajustar según aprendemos
- Cambios deben ser aprobados por todo el equipo
- Se documenta el historial de cambios

---

**Recuerda**: El DoD nos ayuda a mantener la calidad y a tener un entendimiento compartido de "completado". No es burocracia, es un contrato de calidad con nuestros usuarios.
