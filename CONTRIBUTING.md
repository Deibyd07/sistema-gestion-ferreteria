# 🤝 Guía de Contribución

¡Gracias por tu interés en contribuir al Sistema de Gestión para Ferreterías! Esta guía te ayudará a hacer tu primera contribución de manera exitosa.

## 📋 Tabla de Contenidos

- [Código de Conducta](#código-de-conducta)
- [Cómo Contribuir](#cómo-contribuir)
- [Flujo de Trabajo](#flujo-de-trabajo)
- [Configuración del Entorno](#configuración-del-entorno)
- [Estándares de Código](#estándares-de-código)
- [Proceso de Pull Request](#proceso-de-pull-request)
- [Revisión de Código](#revisión-de-código)
- [Tipos de Contribuciones](#tipos-de-contribuciones)

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

## 🚀 Cómo Contribuir

### 1. Encuentra algo en qué trabajar

Puedes contribuir de varias formas:

- 🐛 **Bugs:** Busca issues con label `bug`
- ✨ **Features:** Busca issues con label `feature`
- 📚 **Documentación:** Busca issues con label `docs`
- 🧪 **Tests:** Mejora la cobertura de tests
- 🎨 **UI/UX:** Mejoras en la interfaz

**Para principiantes:**
Busca issues con label `good first issue` o `help wanted`

### 2. Comunica tus intenciones

Antes de empezar a trabajar:

1. Comenta en el issue que quieres trabajar en él
2. Si no existe issue, crea uno describiendo el problema/feature
3. Espera confirmación del maintainer antes de empezar

**Ejemplo de comentario:**
```
Hola! Me gustaría trabajar en este issue. 
Mi approach sería:
1. [Describe tu enfoque]
2. [Pasos a seguir]

¿Les parece bien este enfoque?
```

## 🔄 Flujo de Trabajo

### Diagrama del Flujo

```
┌─────────────────────────────────────────────────────────┐
│  1. Fork del repositorio                                │
└────────────────┬────────────────────────────────────────┘
                 │
┌────────────────▼────────────────────────────────────────┐
│  2. Clonar tu fork localmente                           │
│     git clone https://github.com/tu-usuario/repo.git    │
└────────────────┬────────────────────────────────────────┘
                 │
┌────────────────▼────────────────────────────────────────┐
│  3. Crear rama desde develop                            │
│     git checkout -b feature/mi-feature                  │
└────────────────┬────────────────────────────────────────┘
                 │
┌────────────────▼────────────────────────────────────────┐
│  4. Hacer cambios y commits                             │
│     git add .                                           │
│     git commit -m "feat: descripción del cambio"        │
└────────────────┬────────────────────────────────────────┘
                 │
┌────────────────▼────────────────────────────────────────┐
│  5. Mantener rama actualizada                           │
│     git fetch upstream                                  │
│     git merge upstream/develop                          │
└────────────────┬────────────────────────────────────────┘
                 │
┌────────────────▼────────────────────────────────────────┐
│  6. Push a tu fork                                      │
│     git push origin feature/mi-feature                  │
└────────────────┬────────────────────────────────────────┘
                 │
┌────────────────▼────────────────────────────────────────┐
│  7. Crear Pull Request                                  │
│     • Completar template                                │
│     • Linkar issues relacionados                        │
└────────────────┬────────────────────────────────────────┘
                 │
┌────────────────▼────────────────────────────────────────┐
│  8. CI/CD automático ejecuta                            │
│     • Linting                                           │
│     • Tests                                             │
│     • Security scan                                     │
└────────────────┬────────────────────────────────────────┘
                 │
┌────────────────▼────────────────────────────────────────┐
│  9. Code Review                                         │
│     • Reviewer revisa cambios                           │
│     • Feedback y solicitud de cambios                   │
└────────────────┬────────────────────────────────────────┘
                 │
┌────────────────▼────────────────────────────────────────┐
│  10. Aplicar feedback                                   │
│      git add .                                          │
│      git commit -m "fix: aplicar feedback de review"    │
│      git push                                           │
└────────────────┬────────────────────────────────────────┘
                 │
┌────────────────▼────────────────────────────────────────┐
│  11. Aprobación y Merge                                 │
│      • Squash and merge                                 │
│      • Delete branch automático                         │
└─────────────────────────────────────────────────────────┘
```

### Paso a Paso Detallado

#### 1️⃣ Fork y Clone

```bash
# 1. Hacer fork del repo en GitHub (botón "Fork")

# 2. Clonar tu fork
git clone https://github.com/TU_USUARIO/sistema-gestion-ferreteria.git
cd sistema-gestion-ferreteria

# 3. Agregar upstream (repositorio original)
git remote add upstream https://github.com/OWNER/sistema-gestion-ferreteria.git

# 4. Verificar remotes
git remote -v
# origin    https://github.com/TU_USUARIO/sistema-gestion-ferreteria.git (fetch)
# origin    https://github.com/TU_USUARIO/sistema-gestion-ferreteria.git (push)
# upstream  https://github.com/OWNER/sistema-gestion-ferreteria.git (fetch)
# upstream  https://github.com/OWNER/sistema-gestion-ferreteria.git (push)
```

#### 2️⃣ Crear Rama

```bash
# 1. Asegurarte de estar en develop actualizado
git checkout develop
git pull upstream develop

# 2. Crear nueva rama
git checkout -b feature/nombre-descriptivo

# Convenciones de nombres de rama:
# - feature/...  -> Nueva funcionalidad
# - fix/...      -> Corrección de bug
# - docs/...     -> Cambios en documentación
# - test/...     -> Agregar o modificar tests
# - refactor/... -> Refactorización
# - chore/...    -> Tareas de mantenimiento
```

#### 3️⃣ Hacer Cambios

```bash
# 1. Hacer tus cambios en los archivos

# 2. Verificar qué cambió
git status
git diff

# 3. Agregar cambios al staging
git add .
# O selectivamente:
git add archivo1.py archivo2.ts

# 4. Commit con mensaje descriptivo
git commit -m "feat: agregar endpoint de usuarios"

# Formato de mensajes de commit:
# tipo(scope opcional): descripción corta
#
# Cuerpo opcional más detallado
#
# Footer opcional (issues, breaking changes)
```

#### 4️⃣ Mantener Actualizado

```bash
# Periódicamente (y antes de crear PR):
git fetch upstream
git merge upstream/develop

# Si hay conflictos:
# 1. Resolver manualmente
# 2. git add .
# 3. git commit
```

#### 5️⃣ Validar Localmente

```bash
# BACKEND
cd backend

# Formatear
black .

# Linting
ruff check .

# Type checking
mypy app/

# Tests
pytest tests/backend/ -v

# Coverage
pytest tests/backend/ --cov=backend/app --cov-report=term

# ===================================

# FRONTEND
cd frontend

# Linting
npm run lint

# Formatear
npm run format

# Type check
npm run type-check

# Tests
npm test

# Build
npm run build
```

#### 6️⃣ Push y Pull Request

```bash
# 1. Push a tu fork
git push origin feature/nombre-descriptivo

# 2. Ir a GitHub y crear Pull Request
# 3. Completar template de PR
# 4. Linkar issues relacionados
# 5. Solicitar reviewers
```

## ⚙️ Configuración del Entorno

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

### Supabase Setup

1. Crear cuenta en [Supabase](https://supabase.com)
2. Crear nuevo proyecto
3. Obtener credenciales:
   - Project URL
   - Anon/Public Key
   - Service Role Key (para backend)
4. Ejecutar SQL schema:
   ```bash
   # Copiar contenido de docs/database/database_schema.sql
   # Pegar en Supabase SQL Editor
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

### 1. Antes de Crear el PR

**Checklist:**
- [ ] Código formateado (Black/Prettier)
- [ ] Linting pasando (Ruff/ESLint)
- [ ] Type checking pasando (MyPy/TypeScript)
- [ ] Tests escritos para nuevo código
- [ ] Todos los tests pasando localmente
- [ ] Coverage > 80%
- [ ] Documentación actualizada
- [ ] Rama actualizada con develop

```bash
# Ejecutar checklist completo

# Backend
cd backend
black . && \
ruff check . && \
mypy app/ && \
pytest tests/backend/ --cov=backend/app --cov-report=term

# Frontend
cd frontend
npm run lint && \
npm run type-check && \
npm test && \
npm run build
```

### 2. Crear el Pull Request

1. **Push a tu fork:**
   ```bash
   git push origin feature/tu-feature
   ```

2. **Ir a GitHub** y hacer click en "Compare & pull request"

3. **Completar el template:**

```markdown
## 📝 Descripción

Breve descripción de los cambios realizados.

## 🎯 Tipo de cambio

- [ ] 🐛 Bug fix (non-breaking change que corrige un issue)
- [x] ✨ Nueva feature (non-breaking change que agrega funcionalidad)
- [ ] 💥 Breaking change (fix o feature que causa que funcionalidad existente no funcione como se esperaba)
- [ ] 📝 Documentación
- [ ] 🎨 Mejora de UI/UX

## 🔗 Issues relacionados

Closes #123
Related to #456

## ✅ Checklist

- [x] Mi código sigue las guías de estilo del proyecto
- [x] He realizado una auto-revisión de mi código
- [x] He comentado mi código en áreas difíciles de entender
- [x] He actualizado la documentación correspondiente
- [x] Mis cambios no generan nuevos warnings
- [x] He agregado tests que prueban que mi fix es efectivo o mi feature funciona
- [x] Tests nuevos y existentes pasan localmente
- [x] Coverage de código se mantiene o mejora

## 📸 Screenshots (si aplica)

[Agregar screenshots si hay cambios visuales]

## 🧪 Cómo probar

1. Paso 1...
2. Paso 2...
3. Verificar que...

## 📝 Notas adicionales

Cualquier información adicional para los reviewers.
```

### 3. Durante el Review

#### Para el Autor:

- ✅ Responder a comentarios prontamente
- ✅ Hacer cambios solicitados
- ✅ Marcar conversaciones como resueltas
- ✅ Mantener la rama actualizada
- ✅ Agradecer el feedback

```bash
# Aplicar feedback
git add .
git commit -m "fix: aplicar feedback del review"
git push origin feature/tu-feature
```

#### Para el Reviewer:

- ✅ Revisar en las primeras 24 horas
- ✅ Ser constructivo y específico
- ✅ Sugerir mejoras, no solo criticar
- ✅ Aprobar si todo está bien
- ✅ Explicar el razonamiento de cambios solicitados

**Ejemplo de comentario constructivo:**
```markdown
❌ MAL:
"Este código está mal"

✅ BIEN:
"Sugiero usar un try-catch aquí para manejar el caso cuando el usuario no existe. 
Algo como:

```python
try:
    user = get_user(id)
except UserNotFound:
    raise HTTPException(status_code=404, detail="User not found")
```

Esto mejora la experiencia del usuario con errores más descriptivos."
```

### 4. Merge

Una vez aprobado:

1. **Squash and merge** (recomendado)
   - Combina todos los commits en uno
   - Mantiene historial limpio

2. **Delete branch** automático después del merge

3. **Update local:**
   ```bash
   git checkout develop
   git pull upstream develop
   git branch -d feature/tu-feature  # Eliminar rama local
   ```

## 🎨 Tipos de Contribuciones

### 🐛 Reportar Bugs

1. Buscar si el bug ya fue reportado
2. Si no existe, crear nuevo issue con template:

```markdown
**Descripción del bug**
Descripción clara y concisa del bug.

**Pasos para reproducir**
1. Ir a '...'
2. Click en '....'
3. Scroll down to '....'
4. Ver error

**Comportamiento esperado**
Lo que esperabas que sucediera.

**Comportamiento actual**
Lo que realmente sucede.

**Screenshots**
Si aplica, agregar screenshots.

**Información del entorno:**
 - OS: [e.g. Windows 11]
 - Browser [e.g. chrome, safari]
 - Version [e.g. 22]

**Contexto adicional**
Cualquier otra información relevante.
```

### ✨ Proponer Features

```markdown
**¿Tu feature request está relacionado a un problema?**
Descripción clara del problema. Ej: "Siempre me frustro cuando [...]"

**Solución propuesta**
Descripción clara de lo que quieres que suceda.

**Alternativas consideradas**
Otras soluciones o features que consideraste.

**Contexto adicional**
Cualquier otra información, screenshots, etc.
```

### 📚 Mejorar Documentación

- Corregir typos
- Mejorar explicaciones
- Agregar ejemplos
- Actualizar info desactualizada
- Traducir documentos

### 🧪 Escribir Tests

- Incrementar coverage
- Agregar tests de edge cases
- Mejorar tests existentes
- Agregar tests de integración

### 🎨 Mejorar UI/UX

- Mejorar diseño
- Agregar accesibilidad
- Optimizar performance
- Responsive design

## 📞 Obtener Ayuda

### Canales de Comunicación

- **GitHub Issues:** Para bugs y features
- **GitHub Discussions:** Para preguntas generales
- **Pull Requests:** Para revisión de código
- **Email:** [mantainer@example.com] - Para consultas privadas

### Preguntas Frecuentes

**P: ¿Cuánto tiempo toma que revisen mi PR?**
R: Generalmente dentro de 24-48 horas. Si tarda más, puedes hacer ping al reviewer.

**P: ¿Puedo trabajar en múltiples issues al mismo tiempo?**
R: Sí, pero recomendamos enfocarse en uno a la vez y usar ramas separadas para cada uno.

**P: ¿Qué hago si mi PR tiene conflictos?**
R: Actualiza tu rama con develop y resuelve los conflictos localmente.

**P: ¿Puedo contribuir si soy principiante?**
R: ¡Por supuesto! Busca issues con label "good first issue".

**P: ¿CI/CD falló en mi PR, qué hago?**
R: Revisa los logs, corrige los errores localmente, y haz push de nuevo.

## 🏆 Reconocimientos

Todos los contribuidores serán:
- ✨ Listados en el README
- 🎖️ Mencionados en release notes
- 🙏 Agradecidos públicamente

## 📚 Recursos Adicionales

- [Git Basics](https://git-scm.com/book/en/v2/Getting-Started-Git-Basics)
- [GitHub Flow](https://docs.github.com/en/get-started/quickstart/github-flow)
- [Conventional Commits](https://www.conventionalcommits.org/)
- [Semantic Versioning](https://semver.org/)
- [FastAPI Documentation](https://fastapi.tiangolo.com/)
- [Next.js Documentation](https://nextjs.org/docs)
- [React Testing Library](https://testing-library.com/docs/react-testing-library/intro/)

## 📄 Documentos Relacionados

- [CI_CD_PIPELINE.md](docs/CI_CD_PIPELINE.md) - Documentación completa de CI/CD
- [GITHUB_CONFIGURATION.md](.github/GITHUB_CONFIGURATION.md) - Configuración del repo
- [README.md](README.md) - Información general del proyecto

---

**¡Gracias por contribuir! 🎉**

Cada contribución, sin importar el tamaño, ayuda a hacer este proyecto mejor.

**Última actualización:** Febrero 2026
