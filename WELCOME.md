# 🎉 ¡Bienvenido/a Contribuyente!

¡Gracias por tu interés en contribuir al Sistema de Gestión para Ferreterías! Esta guía te ayudará a empezar rápidamente.

## 🚀 Quick Start (5 minutos)

### 1. Configura tu Entorno

```bash
# Clona el repositorio
git clone https://github.com/Deibyd07/Proyecto-Ferreteria.git
cd Proyecto-Ferreteria

# Agrega el repositorio original como upstream
git remote add upstream https://github.com/Deibyd07/Proyecto-Ferreteria.git
```

**Sigue la [Guía de Instalación Completa](INSTALLATION.md)** para configurar backend y frontend.

### 2. Lee Documentación Esencial

**Requerido (15 minutos de lectura):**
- 📖 [CONTRIBUIR.md](docs/CONTRIBUIR.md) - Cómo contribuir (¡importante!)
- 🏃 [GUIA_SCRUM.md](docs/project/GUIA_SCRUM.md) - Cómo trabajamos
- 📜 [CODE_OF_CONDUCT.md](CODE_OF_CONDUCT.md) - Nuestras reglas

**Opcional pero útil:**
- 🌳 [ESTRATEGIA_RAMAS.md](docs/project/ESTRATEGIA_RAMAS.md) - Estrategia Git
- ✅ [DEFINICION_HECHO.md](docs/project/DEFINICION_HECHO.md) - Cuándo está "hecho"

### 3. Encuentra tu Primera Tarea

Ve al [Project Board](https://github.com/Deibyd07/Proyecto-Ferreteria/projects):

1. **Busca issues etiquetados** `good first issue`
2. **Lee el issue** completamente
3. **Comenta** que vas a trabajar en él
4. **Espera confirmación** antes de empezar

### 4. ¡Empieza a Contribuir!

```bash
# Sincroniza con la rama principal
git checkout main
git fetch upstream
git merge upstream/main

# Cambia a la rama de la épica correspondiente
git checkout epic/N-nombre-epica

# Crea tu rama de trabajo
git checkout -b feature/issue-123-descripcion-corta

# ¡Haz tus cambios!
# ... programa ...

# Commit con Conventional Commits
git add .
git commit -m "feat: agregar validación de productos"

# Push y crea PR
git push origin feature/issue-123-descripcion-corta
```

Luego ve a GitHub y **crea tu Pull Request** usando la plantilla.

## 📚 Mapa de Documentación

### Para Empezar
| Documento | ¿Para qué? | Tiempo |
|-----------|-----------|--------|
| [README.md](README.md) | Visión general del proyecto | 5 min |
| [INSTALLATION.md](INSTALLATION.md) | Setup completo | 30 min |
| [CONTRIBUIR.md](docs/CONTRIBUIR.md) | Guía de contribución | 15 min |

### Metodología
| Documento | ¿Para qué? | Tiempo |
|-----------|-----------|--------|
| [GUIA_SCRUM.md](docs/project/GUIA_SCRUM.md) | Cómo trabajamos con Scrum | 20 min |
| [BACKLOG_PRODUCTO.md](docs/project/BACKLOG_PRODUCTO.md) | Roadmap y funcionalidades | 10 min |
| [DEFINICION_HECHO.md](docs/project/DEFINICION_HECHO.md) | Criterios de calidad | 5 min |
| [ESTRATEGIA_RAMAS.md](docs/project/ESTRATEGIA_RAMAS.md) | Estrategia de Git | 10 min |

### Desarrollo
| Documento | ¿Para qué? | Tiempo |
|-----------|-----------|--------|
| [backend/README.md](backend/README.md) | Documentación del backend | 15 min |
| [frontend/README.md](frontend/README.md) | Documentación del frontend | 15 min |
| [DISEÑO_BASE_DATOS.md](docs/database/DISEÑO_BASE_DATOS.md) | Schema de BD | 10 min |

### Setup Técnico
| Documento | ¿Para qué? | Tiempo |
|-----------|-----------|--------|
| [SETUP_SUPABASE.md](docs/setup/SETUP_SUPABASE.md) | Configurar Supabase | 20 min |
| [GUIA_EJECUCION_BD.md](docs/setup/GUIA_EJECUCION_BD.md) | Ejecutar scripts SQL | 15 min |
| [SETUP_SENTRY.md](docs/setup/SETUP_SENTRY.md) | Configurar monitoreo | 10 min |

## 🎯 Tipos de Contribución

### 🐛 Reportar un Bug

1. Busca si ya existe el issue
2. Usa la plantilla **Bug Report**
3. Incluye toda la información solicitada
4. Agrega screenshots si es posible

[Reportar Bug →](https://github.com/Deibyd07/Proyecto-Ferreteria/issues/new?template=bug_report.yml)

### ✨ Proponer Feature

1. Discute la idea primero en [Discussions](https://github.com/Deibyd07/Proyecto-Ferreteria/discussions)
2. Si se aprueba, crea un issue con la plantilla **Feature Request**
3. Espera que se priorice en el Product Backlog

[Proponer Feature →](https://github.com/Deibyd07/Proyecto-Ferreteria/issues/new?template=feature_request.yml)

### 💻 Escribir Código

1. Elige un issue del Sprint actual
2. Comenta que vas a trabajar en él
3. Sigue la guía de contribución
4. Crea PR con la plantilla

[Ver Sprint Actual →](https://github.com/Deibyd07/Proyecto-Ferreteria/projects)

### 📝 Mejorar Documentación

1. Encuentra documentación incorrecta o incompleta
2. Crea un issue con la plantilla **Documentation**
3. O directamente crea un PR con tus mejoras

[Mejorar Docs →](https://github.com/Deibyd07/Proyecto-Ferreteria/issues/new?template=documentation.yml)

### 👀 Revisar PRs

1. Ve a [Pull Requests abiertos](https://github.com/Deibyd07/Proyecto-Ferreteria/pulls)
2. Revisa el código
3. Proporciona feedback constructivo
4. Aprueba o solicita cambios

## 💡 Tips para Nuevos Contribuyentes

### ✅ DO (Hacer)

- ✅ Lee la documentación antes de preguntar
- ✅ Busca en issues existentes antes de crear uno nuevo
- ✅ Comenta en el issue antes de empezar a trabajar
- ✅ Escribe tests para tu código
- ✅ Sigue las convenciones de código del proyecto
- ✅ Pide ayuda si te atascas
- ✅ Actualiza la documentación si cambias funcionalidad
- ✅ Sé paciente con las revisiones de código
- ✅ Responde a comentarios en tu PR

### ❌ DON'T (No hacer)

- ❌ No trabajes en issues sin comentar primero
- ❌ No hagas PRs muy grandes (divide en partes más pequeñas)
- ❌ No ignores los estándares de código
- ❌ No te ofendas por feedback en code reviews
- ❌ No hagas commit de código sin tests
- ❌ No uses lenguaje ofensivo
- ❌ No esperes respuestas inmediatas (proyecto async)
- ❌ No hagas commits sin seguir Conventional Commits

## 🤝 Obtener Ayuda

### ¿Tienes Preguntas?

1. **Busca primero** en documentación y issues existentes
2. **Pregunta en [Discussions](https://github.com/Deibyd07/Proyecto-Ferreteria/discussions)** (categoría Q&A)
3. **Comenta en el issue** relevante
4. **Menciona** a otros contribuyentes si necesitas ayuda específica

### ¿Encontraste un Problema?

1. **Bug en el código**: Crea un [Bug Report](https://github.com/Deibyd07/Proyecto-Ferreteria/issues/new?template=bug_report.yml)
2. **Bloqueado en desarrollo**: Comenta en tu issue con label `impediment`
3. **Problema con documentación**: Crea un [Documentation Issue](https://github.com/Deibyd07/Proyecto-Ferreteria/issues/new?template=documentation.yml)

### Comunidad

- 💬 [GitHub Discussions](https://github.com/Deibyd07/Proyecto-Ferreteria/discussions) - Preguntas, ideas, feedback
- 🐛 [GitHub Issues](https://github.com/Deibyd07/Proyecto-Ferreteria/issues) - Bugs y features
- 📋 [Project Board](https://github.com/Deibyd07/Proyecto-Ferreteria/projects) - Progreso del Sprint

## 🎓 Recursos de Aprendizaje

### Si eres nuevo en...

**Git/GitHub:**
- [GitHub Guides](https://guides.github.com/)
- [Git Handbook](https://guides.github.com/introduction/git-handbook/)
- [GitHub Flow](https://guides.github.com/introduction/flow/)

**Python/FastAPI:**
- [FastAPI Tutorial](https://fastapi.tiangolo.com/tutorial/)
- [Python Official Tutorial](https://docs.python.org/3/tutorial/)
- [Real Python](https://realpython.com/)

**TypeScript/Next.js:**
- [Next.js Learn](https://nextjs.org/learn)
- [TypeScript Handbook](https://www.typescriptlang.org/docs/handbook/intro.html)
- [React Docs](https://react.dev/)

**Scrum:**
- [Scrum Guide](https://scrumguides.org/)
- [Agile Alliance](https://www.agilealliance.org/agile101/)

**Supabase:**
- [Supabase Docs](https://supabase.com/docs)
- [Supabase Tutorials](https://supabase.com/docs/guides/getting-started)

## 📝 Checklist para tu Primera Contribución

- [ ] Leí README.md
- [ ] Instalé el proyecto localmente siguiendo INSTALLATION.md
- [ ] Leí CONTRIBUIR.md completamente
- [ ] Leí CODE_OF_CONDUCT.md
- [ ] Entiendo la metodología Scrum básica
- [ ] Configuré Git con mi nombre y email
- [ ] Agregué el repositorio upstream
- [ ] Exploré el Project Board
- [ ] Encontré un issue `good first issue`
- [ ] Comenté en el issue que voy a trabajar
- [ ] Esperé confirmación
- [ ] Creé mi rama de trabajo
- [ ] Hice mis cambios
- [ ] Escribí tests
- [ ] Todos los tests pasan
- [ ] Actualicé documentación
- [ ] Creé el PR usando la plantilla
- [ ] Solicité revisión

## 🎉 ¡Tu Primera Contribución!

Cuando completes tu primera contribución:

1. **Serás agregado** a la lista de contribuyentes
2. **Ganarás experiencia** en un proyecto real
3. **Ayudarás** a crear una herramienta útil
4. **Aprenderás** de otros desarrolladores
5. **Construirás tu portafolio**

## 🌟 Próximos Pasos

Después de tu primera contribución:

1. **Participa en Sprint Review** para ver demos
2. **Asiste a Sprint Planning** para elegir próximos issues
3. **Revisa PRs** de otros contribuyentes
4. **Propón mejoras** en Retrospectives
5. **Mentoriza** a nuevos contribuyentes
6. **Toma ownership** de una épica completa

## 📞 Contacto

**Product Owner**: [@Deibyd07](https://github.com/Deibyd07)

**¿Preguntas?** 
- Abre un [Discussion](https://github.com/Deibyd07/Proyecto-Ferreteria/discussions)
- Comenta en un issue relevante
- Revisa la [documentación](README.md#-documentación)

---

## 🙏 Gracias

Gracias por considerar contribuir a este proyecto. Cada contribución, grande o pequeña, hace la diferencia.

**¿Listo?** 🚀

1. [Instala el proyecto](INSTALLATION.md)
2. [Lee la guía de contribución](docs/CONTRIBUIR.md)
3. [Encuentra tu primer issue](https://github.com/Deibyd07/Proyecto-Ferreteria/labels/good%20first%20issue)
4. ¡Empieza a contribuir!

---

**Happy Coding! 💻✨**
