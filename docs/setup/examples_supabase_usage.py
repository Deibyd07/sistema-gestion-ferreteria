"""
Ejemplos de uso de los módulos de Supabase
Este archivo muestra cómo usar las funcionalidades de Auth y Storage
"""

# ============================================================================
# EJEMPLOS DE AUTENTICACIÓN (Supabase Auth)
# ============================================================================

from app.core.supabase_auth import SupabaseAuth
import asyncio


# Ejemplo 1: Registrar un nuevo usuario
async def example_signup():
    """Registra un nuevo usuario"""
    try:
        result = await SupabaseAuth.sign_up(
            email="usuario@ejemplo.com",
            password="contraseña123",
            metadata={
                "name": "Juan Pérez",
                "role": "vendedor",
                "tenant_id": "tenant-uuid-123"
            }
        )
        
        print("Usuario registrado:")
        print(f"  - ID: {result['user'].id}")
        print(f"  - Email: {result['user'].email}")
        print(f"  - Access Token: {result['session'].access_token}")
        
    except Exception as e:
        print(f"Error: {e}")


# Ejemplo 2: Iniciar sesión
async def example_signin():
    """Inicia sesión con email y contraseña"""
    try:
        result = await SupabaseAuth.sign_in(
            email="usuario@ejemplo.com",
            password="contraseña123"
        )
        
        print("Sesión iniciada:")
        print(f"  - Usuario: {result['user'].email}")
        print(f"  - Access Token: {result['access_token']}")
        print(f"  - Refresh Token: {result['refresh_token']}")
        
        # Guardar los tokens para usar en requests
        return result['access_token'], result['refresh_token']
        
    except Exception as e:
        print(f"Error: {e}")


# Ejemplo 3: Obtener usuario desde token
async def example_get_user(access_token: str):
    """Obtiene información del usuario desde el token"""
    try:
        user = await SupabaseAuth.get_user_from_token(access_token)
        
        print("Información del usuario:")
        print(f"  - ID: {user.id}")
        print(f"  - Email: {user.email}")
        print(f"  - Metadata: {user.user_metadata}")
        
    except Exception as e:
        print(f"Error: {e}")


# Ejemplo 4: Refrescar token
async def example_refresh_token(refresh_token: str):
    """Refresca el access token"""
    try:
        result = await SupabaseAuth.refresh_token(refresh_token)
        
        print("Token refrescado:")
        print(f"  - Nuevo Access Token: {result['access_token']}")
        
        return result['access_token']
        
    except Exception as e:
        print(f"Error: {e}")


# Ejemplo 5: Recuperar contraseña
async def example_reset_password():
    """Envía email de recuperación de contraseña"""
    try:
        await SupabaseAuth.reset_password_email("usuario@ejemplo.com")
        print("Email de recuperación enviado")
        
    except Exception as e:
        print(f"Error: {e}")


# ============================================================================
# EJEMPLOS DE STORAGE (Supabase Storage)
# ============================================================================

from app.core.supabase_storage import (
    SupabaseStorage,
    upload_company_logo,
    upload_product_image,
    upload_document
)
from fastapi import UploadFile
from io import BytesIO


# Ejemplo 6: Subir logo de empresa
async def example_upload_logo():
    """Sube logo de empresa"""
    try:
        # Simular archivo (en producción vendría de un request)
        file_content = b"contenido-de-imagen"
        file = UploadFile(
            filename="logo.png",
            file=BytesIO(file_content)
        )
        file.content_type = "image/png"
        
        result = await upload_company_logo(
            file=file,
            tenant_id="tenant-uuid-123"
        )
        
        print("Logo subido:")
        print(f"  - Ruta: {result['path']}")
        print(f"  - URL pública: {result['public_url']}")
        print(f"  - Tamaño: {result['size']} bytes")
        
        return result['path']
        
    except Exception as e:
        print(f"Error: {e}")


# Ejemplo 7: Subir imagen de producto
async def example_upload_product():
    """Sube imagen de producto"""
    try:
        file_content = b"contenido-de-imagen"
        file = UploadFile(
            filename="producto.jpg",
            file=BytesIO(file_content)
        )
        file.content_type = "image/jpeg"
        
        result = await upload_product_image(
            file=file,
            tenant_id="tenant-uuid-123"
        )
        
        print("Imagen de producto subida:")
        print(f"  - URL: {result['public_url']}")
        
        return result['path']
        
    except Exception as e:
        print(f"Error: {e}")


# Ejemplo 8: Descargar archivo
async def example_download_file(file_path: str):
    """Descarga un archivo"""
    try:
        content = await SupabaseStorage.download_file(
            bucket="company-logos",
            file_path=file_path
        )
        
        print(f"Archivo descargado: {len(content)} bytes")
        
        # Guardar archivo localmente
        with open("downloaded_logo.png", "wb") as f:
            f.write(content)
        
    except Exception as e:
        print(f"Error: {e}")


# Ejemplo 9: Listar archivos en un bucket
async def example_list_files():
    """Lista archivos de un tenant"""
    try:
        files = await SupabaseStorage.list_files(
            bucket="product-images",
            folder="tenant-uuid-123"
        )
        
        print(f"Archivos encontrados: {len(files)}")
        for file in files:
            print(f"  - {file['name']} ({file['metadata']['size']} bytes)")
        
    except Exception as e:
        print(f"Error: {e}")


# Ejemplo 10: Crear URL firmada (temporal)
async def example_signed_url(file_path: str):
    """Crea una URL temporal para acceso privado"""
    try:
        result = await SupabaseStorage.create_signed_url(
            bucket="documents",
            file_path=file_path,
            expires_in=3600  # 1 hora
        )
        
        print("URL firmada creada:")
        print(f"  - URL: {result['signed_url']}")
        print(f"  - Expira en: {result['expires_in']} segundos")
        
        return result['signed_url']
        
    except Exception as e:
        print(f"Error: {e}")


# Ejemplo 11: Eliminar archivo
async def example_delete_file(file_path: str):
    """Elimina un archivo"""
    try:
        await SupabaseStorage.delete_file(
            bucket="product-images",
            file_path=file_path
        )
        
        print(f"Archivo eliminado: {file_path}")
        
    except Exception as e:
        print(f"Error: {e}")


# ============================================================================
# EJEMPLO DE USO EN UN ENDPOINT FASTAPI
# ============================================================================

from fastapi import APIRouter, Depends, HTTPException, status, File, UploadFile as FastAPIUploadFile
from fastapi.security import HTTPBearer, HTTPAuthorizationCredentials

router = APIRouter()
security = HTTPBearer()


# Middleware para autenticar requests
async def get_current_user(
    credentials: HTTPAuthorizationCredentials = Depends(security)
):
    """Obtiene el usuario actual desde el token JWT"""
    try:
        token = credentials.credentials
        user = await SupabaseAuth.get_user_from_token(token)
        return user
    except Exception:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Token inválido o expirado"
        )


# Endpoint protegido: Obtener perfil de usuario
@router.get("/me")
async def get_profile(current_user = Depends(get_current_user)):
    """Obtiene el perfil del usuario autenticado"""
    return {
        "id": current_user.id,
        "email": current_user.email,
        "metadata": current_user.user_metadata
    }


# Endpoint: Subir imagen de producto
@router.post("/products/{product_id}/image")
async def upload_product_image_endpoint(
    product_id: int,
    file: FastAPIUploadFile = File(...),
    current_user = Depends(get_current_user)
):
    """Sube imagen para un producto"""
    
    # Validar tipo de archivo
    if file.content_type not in ["image/png", "image/jpeg", "image/jpg"]:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="Solo se permiten imágenes PNG o JPEG"
        )
    
    # Obtener tenant_id del usuario
    tenant_id = current_user.user_metadata.get("tenant_id")
    
    # Subir archivo
    result = await SupabaseStorage.upload_file(
        file=file,
        bucket="product-images",
        tenant_id=tenant_id,
        custom_path=f"{tenant_id}/products/{product_id}/{file.filename}"
    )
    
    return {
        "message": "Imagen subida exitosamente",
        "url": result["public_url"],
        "path": result["path"]
    }


# ============================================================================
# EJECUTAR EJEMPLOS
# ============================================================================

async def run_examples():
    """Ejecuta todos los ejemplos"""
    print("\n" + "="*70)
    print("  EJEMPLOS DE USO - SUPABASE AUTH Y STORAGE")
    print("="*70 + "\n")
    
    # Auth
    print("\n--- AUTENTICACIÓN ---\n")
    await example_signup()
    access_token, refresh_token = await example_signin()
    if access_token:
        await example_get_user(access_token)
        await example_refresh_token(refresh_token)
    
    # Storage
    print("\n--- STORAGE ---\n")
    logo_path = await example_upload_logo()
    if logo_path:
        await example_download_file(logo_path)
    
    await example_list_files()


if __name__ == "__main__":
    # Ejecutar ejemplos
    asyncio.run(run_examples())
