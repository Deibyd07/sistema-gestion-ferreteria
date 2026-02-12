# 🤝 Guía de Contribución

¡Gracias por tu interés en contribuir al Sistema de Gestión para Ferreterías! Esta guía te ayudará a hacer tu primera contribución de manera exitosa.

## 📋 Tabla de Contenidos

- [Código de Conducta](#código-de-conducta)
- [Antes de Empezar](#antes-de-empezar)
- [Flujo de Trabajo](#flujo-de-trabajo)
- [Configuración del Entorno](#configuración-del-entorno)
- [Estándares de Código](#estándares-de-código)
- [Proceso de Pull Request](#proceso-de-pull-request)
- [Revisión de Código](#revisión-de-código)
- [Tipos de Contribuciones](#tipos-de-contribuciones)
- [Obtener Ayuda](#obtener-ayuda)

## 🎯 Código de Conducta

### Nuestros Principios

- **Respeto:** Tratamos a todos con respeto y profesionalismo
- **Colaboración:** Trabajamos juntos para mejorar el proyecto
- **Calidad:** Nos esforzamos por mantener altos estándares de código
- **Aprendizaje:** Fomentamos el aprendizaje continuo
- **Inclusión:** Todos son bienvenidos a contribuir

### Comportamiento Esperado

✅ **SÍ hacer:**
- Ser respetuoso y profesional
- Proporcionar feedback constructivo
- Aceptar críticas constructivas
- Enfocarse en lo mejor para el proyecto
- Ayudar a otros miembros

❌ **NO hacer:**
- Usar lenguaje ofensivo o inapropiado
- Ataques personales o trolling
- Compartir información privada de otros
- Conducta poco profesional
- Spam o autopromoción

## 🚀 Antes de Empezar

### Estructura del Proyecto

```
- main/               → Código de producción ✅
- develop/            → Rama de integración y testing
- epic/N-nombre/      → Ramas de épicas (tu rama de trabajo)
```

### Conceptos Clave

- **Épica**: Un grupo de issues relacionadas que forman una característica completa
- **Issue**: Una tarea, bug o feature a implementar
- **Pull Request (PR)**: Solicitud para revisar y fusionar cambios
- **Review**: Proceso donde otro desarrollador verifica tu código

### Tu Primera Contribución

1. **Elige una Épica** o crea una nueva rama desde `develop`
2. **Crea commits** en tu rama con cambios pequeños
3. **Abre un Pull Request** para que revisar y prueben tus cambios
4. **Responde feedback** del review
5. **Merge automático** una vez aprobado

## 🎯 Código de Conducta

### Nuestros Principios

- **Respeto:** Tratamos a todos con respeto y profesionalismo
- **Colaboración:** Trabajamos juntos para mejorar el proyecto
- **Calidad:** Nos esforzamos por mantener altos estándares de código
- **Aprendizaje:** Fomentamos el aprendizaje continuo
- **Inclusión:** Todos son bienvenidos a contribuir

### Comportamiento Esperado

✅ **SÍ hacer:**
- Ser respetuoso y profesional
- Proporcionar feedback constructivo
- Aceptar críticas constructivas
- Enfocarse en lo mejor para el proyecto
- Ayudar a otros miembros

❌ **NO hacer:**
- Usar lenguaje ofensivo o inapropiado
- Ataques personales o trolling
- Compartir información privada de otros
- Conducta poco profesional
- Spam o autopromoción

## 🔄 Flujo de Trabajo

### 📊 Diagrama del Flujo

```
┌──────────────────────────────────────────────────────────────┐
│  REPOSITORIO PRINCIPAL                                       │
│  ┌────────────────────────────────────────────────────────┐  │
│  │ main (Producción)                                      │  │
│  │ • Siempre estable y funcional                          │  │
│  │ • Requiere PR aprobado                                 │  │
│  └────────────┬─────────────────────────────────────────┘  │
│               │                                             │
│  ┌────────────▼─────────────────────────────────────────┐  │
│  │ develop (Integración)                                │  │
│  │ • Cole cambios de todas las épicas                  │  │
│  │ • Validación y testing                              │  │
│  │ • Requiere PR aprobado + CI/CD pasando              │  │
│  └────────────┬──────────────────────────────────────┬─┘  │
│               │                                      │      │
│  ┌────────────▼────────┐                      ┌─────▼───┐  │
│  │ epic/1-setup        │  epic/2-database    │epic/N... │  │
│  │ • Tu rama           │  • Tu rama          │• Tu rama │  │
│  │ • Cambios locales   │  • Cambios locales  │• Cambios │  │
│  │ • PR a develop      │  • PR a develop     │• PR      │  │
│  └─────────────────────┘  └─────────────────┘ └─────────┘  │
│                                                             │
└──────────────────────────────────────────────────────────────┘
```

### Paso a Paso Detallado

#### 1️⃣ Clone el Repositorio

```bash
# Asuma que ya tienes acceso al repositorio

# Clonar el repo
git clone https://github.com/tu-organizacion/sistema-gestion-ferreteria.git
cd sistema-gestion-ferreteria

# Ver ramas disponibles
git branch -a

# Listar épicas activas
git branch -a | grep epic/
```

#### 2️⃣ Selecciona o Crea tu Rama de Épica

```bash
# Opción A: Usar una épica existente
git checkout epic/2-database
git pull origin epic/2-database

# Opción B: Crear nueva rama de épica desde develop
git checkout develop
git pull origin develop
git checkout -b epic/8-pos
git push -u origin epic/8-pos
```

#### 3️⃣ Trabajar en tu Rama

```bash
# Asegúrate de estar en tu rama
git checkout epic/2-database

# Hacer cambios en los archivos
# ... editar, crear, eliminar archivos ...

# Ver qué cambió
git status
git diff

# Agregar cambios al staging
git add .
# O selectivamente:
git add archivo1.py archivo2.ts

# Hacer commit
git commit -m "feat(issue-5): diseño del modelo de base de datos"

# Push a tu rama
git push origin epic/2-database
```

#### 4️⃣ Mantener tu Rama Actualizada

```bash
# Antes de crear un PR o periódicamente
git fetch origin

# Ver si develop tiene cambios
git log HEAD..origin/develop --oneline

# Mergear cambios de develop
git merge origin/develop

# Si hay conflictos, resolverlos:
# 1. Abrir archivos con conflictos
# 2. Resolver manualmente (tu IDE puede ayudarte)
# 3. git add archivo-resuelto.py
# 4. git commit -m "merge: resolver conflictos con develop"

# Push
git push origin epic/2-database
```

#### 5️⃣ Crear un Pull Request

```bash
# Push tu rama si no lo has hecho
git push origin epic/2-database
```

**En GitHub:**
1. Ir a https://github.com/tu-organizacion/sistema-gestion-ferreteria
2. Debería ver un banner "Compare & pull request" (sino, click en "Pull requests")
3. **Importante:** Verificar que:
   - **Base**: `develop` (NO `main`)
   - **Compare**: `epic/2-database`
4. Completar el template del PR:
   - **Título**: Descripción breve de los cambios
   - **Descripción**: Explicar qué cambió y por qué
   - **Issues**: Linkar issues relacionadas (Closes #5, #6)
   - **Screenshots**: Si hay cambios visuales
5. Seleccionar **Reviewers** (tus compañeros de equipo)
6. Click en "Create pull request"

#### 6️⃣ Proceso de Revisión

**Si el reviewer solicita cambios:**

```bash
# 1. Hacer los cambios solicitados
# ... editar archivos ...

# 2. Commit
git add .
git commit -m "fix: aplicar feedback del review"

# 3. Push
git push origin epic/2-database

# ¡La rama se actualiza automáticamente en el PR!
# No necesitas crear un nuevo PR

# 4. Responder al comentario en GitHub
# "Cambios aplicados. Listo para re-review!"
```

**Para el Reviewer:**

- Revisar código
- Probar localmente si es necesario
- Agregar comentarios específicos
- Solicitar cambios o aprobar

#### 7️⃣ Merge del Pull Request

Una vez **aprobado** y **CI/CD pasando**:

1. El reviewer o tú hacen click en "Squash and merge"
2. GitHub automáticamente:
   - Combina todos tus commits en uno
   - Lo fusiona a `develop`
   - Elimina la rama remota
3. En tu máquina:
   ```bash
   git checkout develop
   git pull origin develop
   git branch -d epic/2-database  # Eliminar rama local
   ```

#### 8️⃣ Validación en develop

Tu código ahora está en `develop`:

- ✅ CI/CD automático se ejecuta
- ✅ Tests se corren
- ✅ Otros desarrolladores pueden ver tu código
- ✅ Se puede hacer testing integrado

#### 9️⃣ Pasar a main (Cuando épica está completa)

Cuando todas las issues de la épica estén hechas y validadas en develop:

```bash
# Crear PR develop → main
# (Puede ser automatizado o manual según tu proceso)
git checkout main
git pull origin main
git merge develop
git push origin main

# Tag de version (opcional)
git tag -a v1.0.0 -m "Release v1.0.0"
git push origin --tags
```

## ⚙️ Configuración del Entorno

### Requisitos Previos

- Git instalado
- Python 3.10+ (para backend)
- Node.js 18+ (para frontend)
- npm 8+ o yarn
- PostgreSQL 13+ (Supabase)
- Una cuenta en Supabase (gratuita)

### Backend (Python/FastAPI)

```bash
# 1. Navegar al directorio backend
cd backend

# 2. Crear entorno virtual
python -m venv venv

# 3. Activar entorno virtual
# Windows
venv\Scripts\activate
# Linux/Mac
source venv/bin/activate

# 4. Instalar dependencias
pip install -r requirements.txt

# 5. Crear archivo .env
cp .env.example .env
# Editar .env con tus credenciales

# 6. Verificar instalación
python -m pytest tests/backend/ -v
```

### Frontend (Next.js/TypeScript)

```bash
# 1. Navegar al directorio frontend
cd frontend

# 2. Instalar dependencias
npm install

# 3. Crear archivo .env.local
cp .env.example .env.local
# Editar .env.local con tus credenciales

# 4. Ejecutar en modo desarrollo
npm run dev

# 5. Abrir en navegador
# http://localhost:3000

# 6. Verificar tests
npm test
```

### Validar Cambios Antes de Hacer PR

**Checklist de validación:**

```bash
# BACKEND
cd backend

# 1. Formateo
black app/ tests/

# 2. Linting
ruff check app/ tests/

# 3. Type checking
mypy app/

# 4. Tests
pytest tests/backend/ -v

# 5. Coverage (debe ser > 80%)
pytest tests/backend/ --cov=app --cov-report=term-missing

# ===================================

# FRONTEND
cd frontend

# 1. Linting
npm run lint

# 2. Formateo
npm run format

# 3. Type check
npm run type-check

# 4. Tests
npm test

# 5. Build
npm run build
```

**Script de validación completa:**

```bash
# Desde la raíz del proyecto
# Backend
cd backend && \
black . && \
ruff check . && \
mypy app/ && \
pytest tests/backend/ --cov=app && \
cd ..

# Frontend
cd frontend && \
npm run lint && \
npm run type-check && \
npm test && \
npm run build && \
cd ..

echo "✅ Validación completa exitosa!"
```

### Supabase Setup

1. Crear cuenta en [Supabase](https://supabase.com)
2. Crear nuevo proyecto
3. Obtener credenciales:
   - Project URL: `https://[project-id].supabase.co`
   - Anon/Public Key: De Settings → API
   - Service Role Key: De Settings → API
4. Copiar a `.env` (backend) y `.env.local` (frontend)
5. Ejecutar SQL schema:
   ```bash
   # En Supabase SQL Editor, copiar los scripts:
   # - docs/database/database_schema.sql
   # - docs/database/rls_policies.sql
   # - docs/database/storage_policies.sql
   ```
6. Verificar setup:
   ```bash
   cd backend
   python verify_supabase_setup.py
   ```

## 📝 Estándares de Código

### Python (Backend)

#### Code Style

```python
# ✅ BIEN: Usar Black format
def get_user_by_email(email: str) -> Optional[User]:
    """
    Obtiene un usuario por su email.
    
    Args:
        email: Email del usuario
        
    Returns:
        Usuario si existe, None si no
    """
    return db.query(User).filter(User.email == email).first()


# ❌ MAL: Sin format, sin types, sin docstring
def getUserByEmail(email):
    return db.query(User).filter(User.email==email).first()
```

#### Type Hints

```python
# ✅ BIEN: Usar type hints
from typing import Optional, List
from pydantic import BaseModel

def get_users(
    skip: int = 0,
    limit: int = 100,
    filter_active: bool = True
) -> List[User]:
    """Get paginated users list."""
    query = db.query(User)
    if filter_active:
        query = query.filter(User.is_active == True)
    return query.offset(skip).limit(limit).all()


# ❌ MAL: Sin type hints
def get_users(skip=0, limit=100, filter_active=True):
    query = db.query(User)
    if filter_active:
        query = query.filter(User.is_active == True)
    return query.offset(skip).limit(limit).all()
```

#### Error Handling

```python
# ✅ BIEN: Manejo específico de errores
from fastapi import HTTPException, status

@router.get("/users/{user_id}")
async def get_user(user_id: int) -> User:
    try:
        user = await user_service.get_by_id(user_id)
        if not user:
            raise HTTPException(
                status_code=status.HTTP_404_NOT_FOUND,
                detail=f"User with id {user_id} not found"
            )
        return user
    except DatabaseError as e:
        logger.error(f"Database error getting user {user_id}: {e}")
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail="Error accessing database"
        )


# ❌ MAL: Errores genéricos
@router.get("/users/{user_id}")
async def get_user(user_id: int):
    try:
        user = await user_service.get_by_id(user_id)
        return user
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
```

### TypeScript/React (Frontend)

#### Component Structure

```typescript
// ✅ BIEN: Functional component con TypeScript
import { FC } from 'react';

interface UserCardProps {
  user: {
    id: number;
    name: string;
    email: string;
  };
  onEdit?: (id: number) => void;
}

export const UserCard: FC<UserCardProps> = ({ user, onEdit }) => {
  const handleEdit = () => {
    if (onEdit) {
      onEdit(user.id);
    }
  };

  return (
    <div className="user-card">
      <h3>{user.name}</h3>
      <p>{user.email}</p>
      {onEdit && (
        <button onClick={handleEdit}>Edit</button>
      )}
    </div>
  );
};


// ❌ MAL: Sin tipos, props desestructuradas incorrectamente
export default function UserCard(props) {
  return (
    <div className="user-card">
      <h3>{props.user.name}</h3>
      <p>{props.user.email}</p>
      <button onClick={() => props.onEdit(props.user.id)}>Edit</button>
    </div>
  );
}
```

#### Custom Hooks

```typescript
// ✅ BIEN: Custom hook con TypeScript
import { useState, useEffect } from 'react';

interface UseUserReturn {
  user: User | null;
  loading: boolean;
  error: Error | null;
  refetch: () => Promise<void>;
}

export const useUser = (userId: number): UseUserReturn => {
  const [user, setUser] = useState<User | null>(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<Error | null>(null);

  const fetchUser = async () => {
    try {
      setLoading(true);
      const data = await apiClient.getUser(userId);
      setUser(data);
      setError(null);
    } catch (err) {
      setError(err as Error);
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    fetchUser();
  }, [userId]);

  return { user, loading, error, refetch: fetchUser };
};


// ❌ MAL: Sin tipos, sin manejo de errores
export const useUser = (userId) => {
  const [user, setUser] = useState(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    apiClient.getUser(userId).then(data => {
      setUser(data);
      setLoading(false);
    });
  }, [userId]);

  return { user, loading };
};
```

### Testing

#### Backend Tests (pytest)

```python
# ✅ BIEN: Test descriptivo con setup y assertions claras
import pytest
from fastapi.testclient import TestClient

def test_create_user_success(client: TestClient, db_session):
    """
    Given: Datos válidos de usuario
    When: POST /api/users/
    Then: Usuario creado con status 201
    """
    # Arrange
    user_data = {
        "email": "test@example.com",
        "name": "Test User",
        "password": "SecurePass123!"
    }
    
    # Act
    response = client.post("/api/users/", json=user_data)
    
    # Assert
    assert response.status_code == 201
    data = response.json()
    assert data["email"] == user_data["email"]
    assert data["name"] == user_data["name"]
    assert "password" not in data  # No exponer password
    assert "id" in data


# ❌ MAL: Test sin estructura, sin docstring
def test_user(client):
    response = client.post("/api/users/", json={"email": "test@example.com"})
    assert response.status_code == 201
```

#### Frontend Tests (Jest + RTL)

```typescript
// ✅ BIEN: Test con setup y casos claros
import { render, screen, fireEvent, waitFor } from '@testing-library/react';
import { UserCard } from './UserCard';

describe('UserCard', () => {
  const mockUser = {
    id: 1,
    name: 'John Doe',
    email: 'john@example.com'
  };

  it('should render user information', () => {
    render(<UserCard user={mockUser} />);
    
    expect(screen.getByText('John Doe')).toBeInTheDocument();
    expect(screen.getByText('john@example.com')).toBeInTheDocument();
  });

  it('should call onEdit with user id when edit button clicked', () => {
    const mockOnEdit = jest.fn();
    render(<UserCard user={mockUser} onEdit={mockOnEdit} />);
    
    const editButton = screen.getByRole('button', { name: /edit/i });
    fireEvent.click(editButton);
    
    expect(mockOnEdit).toHaveBeenCalledWith(1);
    expect(mockOnEdit).toHaveBeenCalledTimes(1);
  });

  it('should not render edit button when onEdit not provided', () => {
    render(<UserCard user={mockUser} />);
    
    expect(screen.queryByRole('button', { name: /edit/i })).not.toBeInTheDocument();
  });
});


// ❌ MAL: Test sin describe, sin casos específicos
it('works', () => {
  render(<UserCard user={{id: 1, name: 'John', email: 'john@example.com'}} />);
  expect(screen.getByText('John')).toBeInTheDocument();
});
```

## 🔍 Proceso de Pull Request

### ¿Qué es un Pull Request?

Un **Pull Request (PR)** es una solicitud para revisar y fusionar tus cambios al código principal. Te permite:

- ✅ Compartir cambios con el equipo
- ✅ Recibir feedback antes de mergear
- ✅ Ejecutar tests automáticos
- ✅ Documentar cambios
- ✅ Aprender de otros developers

### Template de Pull Request

Cuando crees un PR, completa este template:

```markdown
## 📝 Descripción

Breve descripción de los cambios realizados. ¿Qué problema resuelves?

## 🎯 Tipo de Cambio

- [x] ✨ Nueva feature (non-breaking, agrega funcionalidad)
- [ ] 🐛 Bug fix (corrige comportamiento incorrecto)
- [ ] 💥 Breaking change (código existente no funcionará igual)
- [ ] 📝 Documentación (cambios en docs)
- [ ] 🎨 UI/UX improvement

## 🔗 Issues relacionados

Closes #123 (número del issue)
Related to #456

## ✅ Checklist de Autor

- [ ] Mi código sigue las guías de estilo del proyecto
- [ ] Realicé auto-revisión de mi código
- [ ] Agregué comentarios donde fue necesario
- [ ] Actualicé documentación relevante
- [ ] Sin nuevos warnings generados
- [ ] Agregué tests para nueva funcionalidad
- [ ] Tests nuevos pasan localmente
- [ ] Coverage se mantiene o mejora (>80%)
- [ ] Validé cambios localmente (lint, format, type-check)

## 🧪 Cómo Probar

Pasos para que el reviewer pruebe los cambios:

1. Checkout a mi rama: `git checkout epic/2-database`
2. Instala dependencias: `npm install` o `pip install -r requirements.txt`
3. Ejecuta tests: `npm test` o `pytest`
4. Abre http://localhost:3000 (frontend) o http://localhost:8000 (backend)
5. Verifica que... [describir qué probar]

## 📸 Screenshots (si aplica)

[Agregar screenshots si hay cambios visuales o UI]

Antes:
![screenshot anterior]

Después:
![screenshot nuevo]

## 📝 Notas Adicionales

Cualquier información que ayude al reviewer a entender mejor:
- Decisiones de diseño
- Alternativas consideradas
- Limitaciones conocidas
- Mejoras futuras

## 🔄 Checklist de Reviewer

- [ ] Código es claro y legible
- [ ] Cambios alinean con lo solicitado
- [ ] No hay cambios no relacionados
- [ ] Tests cubren casos importantes
- [ ] Sin duplicación de código
- [ ] Performance es aceptable
- [ ] No hay issues de seguridad
```

### 1️⃣ Antes de Crear el PR

**Validación obligatoria:**

```bash
# Backend
cd backend && \
black . && \
ruff check . && \
mypy app/ && \
pytest tests/backend/ --cov=app --cov-report=term-missing && \
cd ..

# Frontend
cd frontend && \
npm run lint && \
npm run type-check && \
npm test && \
npm run build && \
cd ..
```

### 2️⃣ Crear el PR

```bash
# 1. Push final
git push origin epic/2-database

# 2. En GitHub:
#    a. Click "Compare & pull request"
#    b. Verificar: Base=develop, Compare=epic/2-database
#    c. Completar template
#    d. Click "Create pull request"
```

### 3️⃣ Review y Feedback

**Como Autor:**

- ✅ Monitorear comentarios
- ✅ Responder preguntas claramente
- ✅ Hacer cambios solicitados
- ✅ Re-request review cuando esté listo

```bash
# Si te piden cambios:
git add .
git commit -m "fix: aplicar feedback del review (#123)"
git push origin epic/2-database
# Comentar en GitHub: "Cambios aplicados, listo para re-review"
```

**Como Reviewer:**

- ✅ Revisar en 24-48 horas
- ✅ Ser constructivo y específico
- ✅ Probar cambios si es posible
- ✅ Sugerir mejoras, no solo criticar

### 4️⃣ Merge

Una vez aprobado:

```bash
# GitHub automáticamente:
# 1. "Squash and merge" (recomendado)
# 2. Combina todos tus commits en uno
# 3. Fusiona a develop
# 4. Elimina rama remota

# En tu máquina:
git checkout develop
git pull origin develop
git branch -d epic/2-database
```

## 📚 Revisión de Código

### Principios de Revisión

La revisión de código es para:
- ✅ Mejorar la calidad
- ✅ Compartir conocimiento
- ✅ Encontrar bugs antes de producción
- ✅ Mantener consistencia

NO es para:
- ❌ Controlar
- ❌ Criticar personalmente
- ❌ Demostrar superioridad
- ❌ Rechazar sin razón

### Para el Autor: Recibir Feedback

**✅ Hacer:**
```markdown
"Buen punto! Agregaré validación adicional para ese caso edge.
Gracias por el feedback."
```

**❌ No Hacer:**
```markdown
"Eso está mal especificado en el issue"
"No entendés como funciona"
```

### Para el Reviewer: Dar Feedback

**✅ Constructivo:**
```markdown
"Sugerencia: Considerar agregar validación aquí.
Ejemplo:
```python
if not user:
    raise ValueError("User is required")
```

Esto evitaría errores silenciosos."
```

**❌ No constructivo:**
```markdown
"Esto está mal"
"¿Por qué escribís así?"
```

### Checklist del Reviewer

- [ ] **Funcionalidad**: ¿Hace lo que promete?
- [ ] **Tests**: ¿Hay tests? ¿Pasan?
- [ ] **Estilo**:¿Sigue convenciones del proyecto?
- [ ] **Performance**: ¿Hay problemas de performance?
- [ ] **Seguridad**: ¿Hay vulnerabilidades?
- [ ] **Documentación**: ¿Está documentado?
- [ ] **Simplicidad**: ¿Se puede simplificar?
- [ ] **Duplication**: ¿Hay código duplicado?

### Ejemplo de Review Completo

**Buen Review:**

```markdown
Excelentes cambios! Algunas sugerencias:

1. **En api.py línea 45**: Considerar wrappear en try-catch para UserNotFound
   ```python
   try:
       user = db.get_user(id)
   except UserNotFound:
       raise HTTPException(404, "No encontrado")
   ```

2. **Tests**: Tests están completos y bien estructurados. ¿Probaste con datos vacíos?

3. **Documentación**: La docstring de get_user sería mejor con un ejemplo:
   ```python
   def get_user(id: int) -> User:
       """
       Obtiene usuario por ID.
       
       Args:
           id: ID del usuario
           
       Returns:
           Usuario si existe
           
       Raises:
           UserNotFound: Si el usuario no existe
           
       Example:
           >>> user = get_user(123)
           >>> user.name
           'John Doe'
       """
   ```

4. **Performance**: La query al DB está optimizada? ¿Necesita índice en users.id?

Luce bien! Con estos cambios, apruebaré. 👍
```

## � Tipos de Contribuciones

### 🐛 Reportar Bugs

[Ver guía completa en GITHUB_ISSUES.md]

**Paso rápido:**
1. Click en "Issues" → "New issue"
2. Seleccionar "Bug report"
3. Describir el problema con pasos para reproducir
4. Agregar screenshots si es posible

### ✨ Proponer Features

[Ver guía completa en GITHUB_ISSUES.md]

**Paso rápido:**
1. Click en "Issues" → "New issue"
2. Seleccionar "Feature request"
3. Explicar el problema que resuelve
4. Proponer solución

### 📚 Mejorar Documentación

- Corregir typos y errores
- Mejorar explicaciones poco claras
- Agregar ejemplos
- Actualizar documentación desactualizada
- Traducir contenido

**Crear un PR con:**
```bash
git commit -m "docs: mejorar sección de instalación"
```

### 🧪 Escribir Tests

- Incrementar cobertura (target >80%)
- Tests de edge cases
- Mejorar tests existentes
- Tests de integración

**Crear un PR con:**
```bash
git commit -m "test: agregar casos para validación de email"
```

### 🎨 Mejorar UI/UX

- Mejora de diseño visual
- Accesibilidad (a11y)
- Optimización de performance
- Responsive design

---

## 📖 Documentación Relacionada

**Guías Detalladas:**
- [docs/project/BRANCHING_STRATEGY.md](./docs/project/BRANCHING_STRATEGY.md) - Estrategia de ramas con épicas
- [GITHUB_ISSUES.md](./GITHUB_ISSUES.md) - Crear y gestionar issues
- [GITHUB_PULL_REQUESTS.md](./GITHUB_PULL_REQUESTS.md) - Guía detallada de PRs
- [GITHUB_PROJECTS.md](./GITHUB_PROJECTS.md) - Usar GitHub Projects
- [INSTALLATION.md](./INSTALLATION.md) - Instalación paso a paso

**Documentación del Proyecto:**
- [README.md](./README.md) - Información general
- [docs/README.md](./docs/README.md) - Índice de documentación
- [docs/CI_CD_PIPELINE.md](./docs/CI_CD_PIPELINE.md) - CI/CD automático

---

## 📞 Obtener Ayuda

### Canales de Comunicación

- **GitHub Issues:** Para reportar bugs o solicitar features
- **GitHub Discussions:** Para preguntas generales y discusiones
- **Pull Requests:** Para revisión de código
- **Email:** [contacto@proyecto.com] - Para consultas sensibles

### Preguntas Frecuentes

**P: Como principiante, ¿por dónde empiezo?**
R: 
1. Completa la instalación ([INSTALLATION.md](./INSTALLATION.md))
2. Lee [docs/project/BRANCHING_STRATEGY.md](./docs/project/BRANCHING_STRATEGY.md)
3. Busca issues con label `good-first-issue`
4. Comenta que quieres trabajar en él
5. Sigue el flujo de PR

**P: ¿Cuánto tiempo toma que revisen mi PR?**
R: Generalmente 24-48 horas. Si tarda más, puedes hacer un comentario recordándole al reviewer.

**P: ¿Puedo trabajar en múltiples issues/épicas al mismo tiempo?**
R: Sí, pero es recomendable enfocarse en uno o máximo dos. Usa ramas separadas para cada uno.

**P: ¿Mi PR tiene conflictos con develop, qué hago?**
R: Es normal. Actualiza tu rama:
```bash
git fetch origin
git merge origin/develop
# Resuelve conflictos
git add .
git commit -m "merge: resolver conflictos"
git push origin epic/rama
```

**P: ¿Qué significa "Squash and merge"?**
R: GitHub combina todos tus commits en uno solo antes de mergear. Mantiene el historial limpio.

**P: ¿CI/CD falló en mi PR, qué es eso?**
R: Son validaciones automáticas (tests, linting, etc.). Revisa los logs en la pestaña "Checks" del PR.

**P: ¿Cómo dejo comentarios en un PR?**
R: 
- En la pestaña "Conversation" escribes comentarios generales
- En la pestaña "Files changed" haces clic en una línea para comentar específicamente

**P: ¿Necesito permisos especiales para hacer PR?**
R: No. Cualquiera puede hacer fork, crear ramas y hacer PR. Solo personas autorizadas pueden mergear.

---

## 🏆 Reconocimientos

Todos los contribuidores serán:
- ✨ Listados en [CONTRIBUTORS.md](./CONTRIBUTORS.md)
- 🎖️ Mencionados en el release notes de cada versión
- 🙏 Agradecidos en documentación del proyecto

---

## 📚 Recursos Adicionales

### Git y GitHub
- [Git Documentation](https://git-scm.com/doc)
- [GitHub Guides](https://guides.github.com/)
- [GitHub Flow](https://guides.github.com/introduction/flow/)
- [Semantic Commit Messages](https://www.conventionalcommits.org/)

### Backend (Python/FastAPI)
- [FastAPI Documentation](https://fastapi.tiangolo.com/)
- [SQLAlchemy ORM](https://docs.sqlalchemy.org/)
- [Pytest](https://docs.pytest.org/)
- [Black Code Formatter](https://black.readthedocs.io/)

### Frontend (Next.js/TypeScript)
- [Next.js Documentation](https://nextjs.org/docs)
- [React Documentation](https://react.dev/)
- [TypeScript Handbook](https://www.typescriptlang.org/docs/)
- [Jest Testing](https://jestjs.io/)

### Base de Datos
- [Supabase Documentation](https://supabase.com/docs)
- [PostgreSQL](https://www.postgresql.org/docs/)
- [Supabase Realtime](https://supabase.com/docs/guides/realtime)

### Otros
- [REST API Best Practices](https://restfulapi.net/)
- [SOLID Principles](https://en.wikipedia.org/wiki/SOLID)
- [Clean Code](https://www.oreilly.com/library/view/clean-code-a/9780136083238/)

---

**¡Gracias por tu interés en contribuir! 🎉**

Cada contribución, sin importar el tamaño, nos ayuda a mejorar.

**Última actualización:** Febrero 2026
