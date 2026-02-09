# 🤝 Guía de Contribución

¡Gracias por tu interés en contribuir al Sistema de Gestión para Ferreterías! Este documento te guiará a través del proceso de contribución.

## 📋 Tabla de Contenidos

- [Código de Conducta](#código-de-conducta)
- [¿Cómo Puedo Contribuir?](#cómo-puedo-contribuir)
- [Configuración del Entorno](#configuración-del-entorno)
- [Flujo de Trabajo](#flujo-de-trabajo)
- [Estándares de Código](#estándares-de-código)
- [Proceso de Pull Request](#proceso-de-pull-request)
- [Metodología Scrum](#metodología-scrum)
- [Reportar Bugs](#reportar-bugs)
- [Proponer Nuevas Características](#proponer-nuevas-características)

## 📜 Código de Conducta

Este proyecto adhiere a un Código de Conducta. Al participar, se espera que lo respetes. Lee [CODE_OF_CONDUCT.md](CODE_OF_CONDUCT.md) para más detalles.

## 🎯 ¿Cómo Puedo Contribuir?

Hay muchas formas de contribuir a este proyecto:

### 1. Reportar Bugs

- Usa la plantilla de issue para bugs
- Incluye toda la información solicitada
- Agrega capturas de pantalla si es posible

### 2. Proponer Nuevas Características

- Usa la plantilla de issue para features
- Describe claramente el problema que resuelve
- Explica cómo beneficia al proyecto

### 3. Mejorar Documentación

- Corrige errores tipográficos
- Mejora explicaciones existentes
- Agrega ejemplos de uso
- Traduce documentación

### 4. Contribuir Código

- Elige un issue existente o propón uno nuevo
- Sigue la estrategia de branching
- Escribe tests para tu código
- Actualiza la documentación

### 5. Revisar Pull Requests

- Revisa el código de otros contribuyentes
- Proporciona feedback constructivo
- Prueba los cambios localmente

## 🛠️ Configuración del Entorno

### Prerrequisitos

Antes de comenzar, asegúrate de tener configurado:

1. **Git** configurado con tu información:
   ```bash
   git config --global user.name "Tu Nombre"
   git config --global user.email "tu@email.com"
   ```

2. **Entorno de desarrollo** completo (sigue [INSTALLATION.md](INSTALLATION.md))

3. **Fork del repositorio** en tu cuenta de GitHub

### Clonar tu Fork

```bash
# Clona tu fork
git clone https://github.com/TU_USERNAME/Proyecto-Ferreteria.git
cd Proyecto-Ferreteria

# Agrega el repositorio original como remote
git remote add upstream https://github.com/Deibyd07/Proyecto-Ferreteria.git

# Verifica los remotes
git remote -v
```

## 🔄 Flujo de Trabajo

Seguimos una estrategia de branching basada en épicas. Lee [BRANCHING_STRATEGY.md](docs/project/BRANCHING_STRATEGY.md) para detalles completos.

### Resumen del Flujo

1. **Sincroniza tu fork**:
   ```bash
   git checkout main
   git fetch upstream
   git merge upstream/main
   git push origin main
   ```

2. **Revisa el Sprint actual** en el [Project Board](https://github.com/Deibyd07/Proyecto-Ferreteria/projects)

3. **Elige un issue asignado al Sprint**:
   - Issues etiquetados con `good first issue` son buenos para principiantes
   - Comenta en el issue que vas a trabajar en él
   - Espera confirmación del Scrum Master o Product Owner

4. **Crea tu rama** desde la rama de la épica correspondiente:
   ```bash
   # Obtén la rama de la épica
   git fetch upstream
   git checkout epic/N-nombre-epica
   
   # Crea tu rama de trabajo
   git checkout -b feature/issue-123-descripcion-corta
   # o
   git checkout -b fix/issue-124-descripcion-corta
   ```

5. **Desarrolla tu solución**:
   ```bash
   # Haz tus cambios
   # Agrega commits siguiendo Conventional Commits
   git add .
   git commit -m "feat: agregar validación de inventario"
   ```

6. **Mantén tu rama actualizada**:
   ```bash
   # Regularmente sincroniza con la épica
   git fetch upstream
   git rebase upstream/epic/N-nombre-epica
   ```

7. **Push y crea Pull Request**:
   ```bash
   git push origin feature/issue-123-descripcion-corta
   ```
   - Ve a GitHub y crea el PR hacia la rama de la épica
   - Usa la plantilla de PR
   - Solicita revisión

## 💻 Estándares de Código

### Principios Generales

- **DRY** (Don't Repeat Yourself): No dupliques código
- **KISS** (Keep It Simple, Stupid): Mantén el código simple
- **SOLID**: Sigue los principios SOLID de diseño
- **Clean Code**: Código limpio y legible

### Backend (Python/FastAPI)

#### Estilo de Código

Seguimos [PEP 8](https://pep8.org/) con algunos ajustes:

```python
# Usa 4 espacios para indentación
# Longitud máxima de línea: 88 caracteres (Black formatter)
# Usa comillas dobles para strings

# ✅ Bueno
def calculate_total_price(
    quantity: int,
    unit_price: Decimal,
    tax_rate: float = 0.16
) -> Decimal:
    """
    Calcula el precio total incluyendo impuestos.
    
    Args:
        quantity: Cantidad de productos
        unit_price: Precio unitario del producto
        tax_rate: Tasa de impuesto (default: 16%)
    
    Returns:
        Precio total con impuestos
    """
    subtotal = quantity * unit_price
    tax = subtotal * Decimal(str(tax_rate))
    return subtotal + tax

# ❌ Malo
def calc(q,p,t=0.16):
    return q*p*(1+t)
```

#### Estructura de Archivos

```python
# 1. Imports estándar de Python
import os
from datetime import datetime
from typing import Optional

# 2. Imports de terceros
from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session

# 3. Imports locales
from app.core.security import get_current_user
from app.schemas.product import ProductCreate, ProductResponse
from app.services.product_service import ProductService
```

#### Type Hints

Usa type hints en todas las funciones:

```python
from typing import List, Optional
from decimal import Decimal

def get_products(
    skip: int = 0,
    limit: int = 100,
    search: Optional[str] = None
) -> List[ProductResponse]:
    pass
```

#### Docstrings

Usa Google style docstrings:

```python
def calculate_discount(
    price: Decimal,
    discount_percentage: float
) -> Decimal:
    """
    Calcula el precio con descuento aplicado.
    
    Args:
        price: Precio original del producto
        discount_percentage: Porcentaje de descuento (0-100)
    
    Returns:
        Precio con descuento aplicado
        
    Raises:
        ValueError: Si el descuento es negativo o mayor a 100
        
    Example:
        >>> calculate_discount(Decimal("100.00"), 10)
        Decimal("90.00")
    """
    if discount_percentage < 0 or discount_percentage > 100:
        raise ValueError("Discount must be between 0 and 100")
    
    discount_amount = price * Decimal(str(discount_percentage / 100))
    return price - discount_amount
```

#### Herramientas de Linting

```bash
# Instala las herramientas
pip install black isort flake8 mypy

# Formatea código con Black
black .

# Ordena imports
isort .

# Verifica estilo con Flake8
flake8 .

# Verifica tipos con MyPy
mypy .
```

### Frontend (TypeScript/Next.js)

#### Estilo de Código

Seguimos [Airbnb Style Guide](https://github.com/airbnb/javascript) con TypeScript:

```typescript
// Usa 2 espacios para indentación
// Usa comillas simples para strings
// Usa punto y coma

// ✅ Bueno
interface Product {
  id: string;
  name: string;
  price: number;
  stock: number;
}

export const calculateTotal = (
  products: Product[],
  taxRate: number = 0.16
): number => {
  const subtotal = products.reduce((sum, product) => {
    return sum + (product.price * product.stock);
  }, 0);
  
  return subtotal * (1 + taxRate);
};

// ❌ Malo
export const calc = (p: any, t: any) => {
  return p.reduce((s: any, x: any) => s + x.price * x.stock, 0) * (1 + t);
};
```

#### Componentes de React

```typescript
// Usa functional components con TypeScript
import { FC } from 'react';

interface ProductCardProps {
  product: Product;
  onAddToCart: (productId: string) => void;
}

export const ProductCard: FC<ProductCardProps> = ({ 
  product, 
  onAddToCart 
}) => {
  const handleClick = () => {
    onAddToCart(product.id);
  };

  return (
    <div className="product-card">
      <h3>{product.name}</h3>
      <p>${product.price.toFixed(2)}</p>
      <button onClick={handleClick}>
        Agregar al carrito
      </button>
    </div>
  );
};
```

#### Nombres de Archivos

- Componentes: `PascalCase.tsx` (ej: `ProductCard.tsx`)
- Utilidades: `camelCase.ts` (ej: `formatCurrency.ts`)
- Hooks: `useCamelCase.ts` (ej: `useProducts.ts`)
- Tipos: `types.ts` o `index.ts` en su carpeta

#### Herramientas de Linting

```bash
# Verifica código
npm run lint

# Corrige automáticamente
npm run lint:fix

# Verifica tipos
npm run type-check
```

### Git Commits

Usa [Conventional Commits](https://www.conventionalcommits.org/):

```bash
# Formato
<tipo>(<alcance>): <descripción>

# Tipos:
# feat: Nueva característica
# fix: Corrección de bug
# docs: Cambios en documentación
# style: Formato, sin cambios de código
# refactor: Refactorización de código
# test: Agregar o modificar tests
# chore: Mantenimiento, dependencias

# Ejemplos:
git commit -m "feat(products): agregar filtro por categoría"
git commit -m "fix(auth): corregir validación de token expirado"
git commit -m "docs(readme): actualizar guía de instalación"
git commit -m "test(inventory): agregar tests para actualización de stock"
```

### Tests

#### Backend (pytest)

```python
# tests/test_products.py
import pytest
from decimal import Decimal

def test_calculate_discount():
    """Test para calcular descuento correctamente."""
    price = Decimal("100.00")
    discount = 10
    
    result = calculate_discount(price, discount)
    
    assert result == Decimal("90.00")

def test_calculate_discount_invalid():
    """Test para validar descuento inválido."""
    price = Decimal("100.00")
    
    with pytest.raises(ValueError):
        calculate_discount(price, -10)
```

Ejecuta tests:
```bash
# Ejecutar todos los tests
pytest

# Con coverage
pytest --cov=app --cov-report=html

# Test específico
pytest tests/test_products.py::test_calculate_discount
```

#### Frontend (Jest/Testing Library)

```typescript
// __tests__/ProductCard.test.tsx
import { render, screen, fireEvent } from '@testing-library/react';
import { ProductCard } from '@/components/ProductCard';

describe('ProductCard', () => {
  const mockProduct = {
    id: '1',
    name: 'Martillo',
    price: 250.00,
    stock: 10
  };

  it('renderiza el producto correctamente', () => {
    render(
      <ProductCard 
        product={mockProduct} 
        onAddToCart={jest.fn()} 
      />
    );

    expect(screen.getByText('Martillo')).toBeInTheDocument();
    expect(screen.getByText('$250.00')).toBeInTheDocument();
  });

  it('llama onAddToCart al hacer clic', () => {
    const handleAddToCart = jest.fn();
    
    render(
      <ProductCard 
        product={mockProduct} 
        onAddToCart={handleAddToCart} 
      />
    );

    fireEvent.click(screen.getByText('Agregar al carrito'));
    expect(handleAddToCart).toHaveBeenCalledWith('1');
  });
});
```

Ejecuta tests:
```bash
# Ejecutar todos los tests
npm test

# Watch mode
npm test -- --watch

# Con coverage
npm test -- --coverage
```

## 🔍 Proceso de Pull Request

### Antes de Crear el PR

- [ ] Tu código compila sin errores
- [ ] Todos los tests pasan
- [ ] Has agregado tests para tu código nuevo
- [ ] Has actualizado la documentación
- [ ] Tu código sigue los estándares de estilo
- [ ] Has hecho rebase con la rama de la épica
- [ ] Los commits siguen Conventional Commits

### Crear el Pull Request

1. **Push a tu fork**:
   ```bash
   git push origin feature/issue-123-descripcion
   ```

2. **Abre el PR** en GitHub hacia la rama de la épica (no hacia `main`)

3. **Usa la plantilla de PR** y completa toda la información:
   - Descripción del cambio
   - Número de issue relacionado
   - Tipo de cambio
   - Checklist

4. **Asigna revisores**:
   - Solicit revisión del Scrum Master o equipo designado
   - Asigna labels apropiados

5. **Responde a los comentarios**:
   - Lee todos los comentarios de revisión
   - Haz los cambios solicitados
   - Responde a preguntas
   - Marca conversaciones como resueltas cuando corresponda

### Criterios de Aceptación del PR

Tu PR será aceptado cuando:

- ✅ Al menos 2 revisores lo aprueben (o 1 para cambios menores)
- ✅ Todos los tests de CI/CD pasen
- ✅ No haya conflictos con la rama base
- ✅ El código cumpla con los estándares
- ✅ La documentación esté actualizada

## 🏃 Metodología Scrum

Este proyecto usa Scrum. Lee [SCRUM_GUIDE.md](docs/project/SCRUM_GUIDE.md) para detalles completos.

### Roles

- **Product Owner**: Define las funcionalidades y prioridades
- **Scrum Master**: Facilita el proceso y remueve impedimentos
- **Development Team**: Todos los contribuyentes (¡tú!)

### Eventos

- **Sprint Planning**: Inicio de cada Sprint (cada 2 semanas)
- **Daily Standup**: Opcional para contribuyentes (comunicación asíncrona en GitHub)
- **Sprint Review**: Final del Sprint, demo de funcionalidades
- **Sprint Retrospective**: Mejora continua del proceso

### Artifacts

- **Product Backlog**: Todos los issues del proyecto
- **Sprint Backlog**: Issues del Sprint actual
- **Increment**: Código funcional al final del Sprint

### Cómo Participar

1. **Revisa el Sprint actual** en el [Project Board](https://github.com/Deibyd07/Proyecto-Ferreteria/projects)
2. **Participa en Sprint Planning** (anunciado en Discussions)
3. **Elige tareas del Sprint Backlog**
4. **Actualiza el progreso** moviendo issues en el board
5. **Participa en Sprint Review** demostrando tu trabajo

## 🐛 Reportar Bugs

### Antes de Reportar

1. **Busca en issues existentes** para evitar duplicados
2. **Verifica que sea un bug real** y no configuración incorrecta
3. **Prueba en la última versión** del código

### Cómo Reportar

1. Usa la plantilla de issue para bugs
2. Incluye:
   - Descripción clara del problema
   - Pasos para reproducir
   - Comportamiento esperado vs. actual
   - Screenshots/videos si es posible
   - Versiones de software
   - Logs de errores

Ejemplo:

```markdown
**Descripción**
El formulario de productos no valida stock negativo

**Pasos para Reproducir**
1. Ir a Productos > Nuevo Producto
2. Ingresar stock: -5
3. Hacer clic en Guardar

**Comportamiento Esperado**
Debería mostrar error: "El stock no puede ser negativo"

**Comportamiento Actual**
Guarda el producto con stock -5

**Screenshots**
[Adjuntar captura]

**Entorno**
- OS: Windows 11
- Navegador: Chrome 120
- Versión: v1.2.0
```

## ✨ Proponer Nuevas Características

### Proceso

1. **Abre un Discussion** primero para discutir la idea
2. **Espera feedback** del Product Owner y comunidad
3. **Si es aprobada**, se creará un issue formal
4. **Se priorizará** en el Product Backlog

### Template de Propuesta

```markdown
**Problema que Resuelve**
Como [tipo de usuario], necesito [funcionalidad] para [beneficio]

**Solución Propuesta**
Descripción detallada de cómo funcionaría

**Alternativas Consideradas**
Otras formas de resolver el problema

**Beneficios**
- Lista de beneficios para usuarios
- Impacto en el negocio

**Esfuerzo Estimado**
Pequeño / Mediano / Grande

**Mockups/Diseños**
[Adjuntar si es posible]
```

## 📚 Recursos Adicionales

- [Documentación del Proyecto](docs/project/sistema_gestion_ferreteria_completo.md)
- [Guía de Instalación](INSTALLATION.md)
- [Estrategia de Branching](docs/project/BRANCHING_STRATEGY.md)
- [Guía de Scrum](docs/project/SCRUM_GUIDE.md)
- [Discussions](https://github.com/Deibyd07/Proyecto-Ferreteria/discussions)

## ❓ Preguntas

Si tienes preguntas:

1. Revisa la documentación existente
2. Busca en [Discussions](https://github.com/Deibyd07/Proyecto-Ferreteria/discussions)
3. Haz una pregunta en Discussions (Q&A)
4. Únete a nuestra comunidad en [Discord/Slack] (si aplica)

---

¡Gracias por contribuir! Cada aporte, grande o pequeño, hace la diferencia. 🚀
