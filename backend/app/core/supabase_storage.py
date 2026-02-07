"""
Utilidades para trabajar con Supabase Storage
"""
from typing import Optional, BinaryIO, List
from fastapi import HTTPException, status, UploadFile
from app.core.supabase_client import supabase_client
from app.core.config import settings
import uuid
from pathlib import Path


class SupabaseStorage:
    """Clase para manejar archivos en Supabase Storage"""
    
    # Tipos MIME permitidos por bucket
    ALLOWED_MIME_TYPES = {
        "company-logos": ["image/png", "image/jpeg", "image/jpg", "image/webp"],
        "product-images": ["image/png", "image/jpeg", "image/jpg", "image/webp"],
        "documents": [
            "application/pdf",
            "application/vnd.openxmlformats-officedocument.wordprocessingml.document",
            "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
            "text/csv"
        ]
    }
    
    @staticmethod
    def _validate_file_size(file_size: int):
        """Valida el tamaño del archivo"""
        if file_size > settings.SUPABASE_STORAGE_MAX_FILE_SIZE:
            max_mb = settings.SUPABASE_STORAGE_MAX_FILE_SIZE / (1024 * 1024)
            raise HTTPException(
                status_code=status.HTTP_413_REQUEST_ENTITY_TOO_LARGE,
                detail=f"El archivo excede el tamaño máximo permitido de {max_mb}MB"
            )
    
    @staticmethod
    def _validate_mime_type(bucket: str, mime_type: str):
        """Valida el tipo MIME del archivo"""
        allowed_types = SupabaseStorage.ALLOWED_MIME_TYPES.get(bucket, [])
        if allowed_types and mime_type not in allowed_types:
            raise HTTPException(
                status_code=status.HTTP_400_BAD_REQUEST,
                detail=f"Tipo de archivo no permitido. Tipos válidos: {', '.join(allowed_types)}"
            )
    
    @staticmethod
    def _generate_unique_filename(original_filename: str, tenant_id: Optional[str] = None) -> str:
        """
        Genera un nombre de archivo único para evitar colisiones.
        
        Args:
            original_filename: Nombre original del archivo
            tenant_id: ID del tenant (para organizar archivos por tenant)
        
        Returns:
            Ruta del archivo con nombre único
        """
        file_extension = Path(original_filename).suffix
        unique_id = str(uuid.uuid4())
        
        if tenant_id:
            return f"{tenant_id}/{unique_id}{file_extension}"
        
        return f"{unique_id}{file_extension}"
    
    @staticmethod
    async def upload_file(
        file: UploadFile,
        bucket: str,
        tenant_id: Optional[str] = None,
        custom_path: Optional[str] = None
    ) -> dict:
        """
        Sube un archivo a Supabase Storage.
        
        Args:
            file: Archivo a subir (FastAPI UploadFile)
            bucket: Nombre del bucket (company-logos, product-images, documents)
            tenant_id: ID del tenant (opcional, para organización)
            custom_path: Ruta personalizada (opcional, si no se usa nombre único)
        
        Returns:
            Dict con información del archivo subido:
            {
                "path": "ruta/del/archivo.jpg",
                "public_url": "https://...",
                "size": 12345,
                "mime_type": "image/jpeg"
            }
        
        Raises:
            HTTPException: Si hay error al subir
        """
        try:
            # Leer contenido del archivo
            file_content = await file.read()
            file_size = len(file_content)
            
            # Validaciones
            SupabaseStorage._validate_file_size(file_size)
            SupabaseStorage._validate_mime_type(bucket, file.content_type)
            
            # Generar nombre de archivo
            file_path = custom_path or SupabaseStorage._generate_unique_filename(
                file.filename, 
                tenant_id
            )
            
            # Subir archivo
            client = supabase_client()
            response = client.storage.from_(bucket).upload(
                path=file_path,
                file=file_content,
                file_options={
                    "content-type": file.content_type,
                    "upsert": "false"  # No sobrescribir si existe
                }
            )
            
            # Obtener URL pública
            public_url = client.storage.from_(bucket).get_public_url(file_path)
            
            return {
                "path": file_path,
                "public_url": public_url,
                "size": file_size,
                "mime_type": file.content_type,
                "original_filename": file.filename
            }
            
        except HTTPException:
            raise
        except Exception as e:
            raise HTTPException(
                status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
                detail=f"Error al subir archivo: {str(e)}"
            )
    
    @staticmethod
    async def download_file(bucket: str, file_path: str) -> bytes:
        """
        Descarga un archivo desde Supabase Storage.
        
        Args:
            bucket: Nombre del bucket
            file_path: Ruta del archivo en el bucket
        
        Returns:
            Contenido del archivo en bytes
        """
        try:
            client = supabase_client()
            response = client.storage.from_(bucket).download(file_path)
            return response
            
        except Exception as e:
            raise HTTPException(
                status_code=status.HTTP_404_NOT_FOUND,
                detail=f"Archivo no encontrado: {str(e)}"
            )
    
    @staticmethod
    async def delete_file(bucket: str, file_path: str):
        """
        Elimina un archivo de Supabase Storage.
        
        Args:
            bucket: Nombre del bucket
            file_path: Ruta del archivo a eliminar
        """
        try:
            client = supabase_client()
            client.storage.from_(bucket).remove([file_path])
            
        except Exception as e:
            raise HTTPException(
                status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
                detail=f"Error al eliminar archivo: {str(e)}"
            )
    
    @staticmethod
    async def list_files(bucket: str, folder: Optional[str] = None) -> List[dict]:
        """
        Lista archivos en un bucket/carpeta.
        
        Args:
            bucket: Nombre del bucket
            folder: Carpeta dentro del bucket (opcional)
        
        Returns:
            Lista de archivos con metadata
        """
        try:
            client = supabase_client()
            
            path = folder if folder else ""
            response = client.storage.from_(bucket).list(path)
            
            return response
            
        except Exception as e:
            raise HTTPException(
                status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
                detail=f"Error al listar archivos: {str(e)}"
            )
    
    @staticmethod
    async def get_public_url(bucket: str, file_path: str) -> str:
        """
        Obtiene la URL pública de un archivo.
        
        Args:
            bucket: Nombre del bucket
            file_path: Ruta del archivo
        
        Returns:
            URL pública del archivo
        """
        try:
            client = supabase_client()
            public_url = client.storage.from_(bucket).get_public_url(file_path)
            return public_url
            
        except Exception as e:
            raise HTTPException(
                status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
                detail=f"Error al obtener URL: {str(e)}"
            )
    
    @staticmethod
    async def create_signed_url(
        bucket: str, 
        file_path: str, 
        expires_in: int = 3600
    ) -> dict:
        """
        Crea una URL firmada temporal para acceso privado.
        
        Args:
            bucket: Nombre del bucket
            file_path: Ruta del archivo
            expires_in: Tiempo de expiración en segundos (default: 1 hora)
        
        Returns:
            Dict con signed_url y expires_at
        """
        try:
            client = supabase_client()
            response = client.storage.from_(bucket).create_signed_url(
                file_path, 
                expires_in
            )
            
            return {
                "signed_url": response["signedURL"],
                "expires_in": expires_in
            }
            
        except Exception as e:
            raise HTTPException(
                status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
                detail=f"Error al crear URL firmada: {str(e)}"
            )


# Funciones de conveniencia para buckets específicos

async def upload_company_logo(file: UploadFile, tenant_id: str) -> dict:
    """Sube logo de empresa"""
    return await SupabaseStorage.upload_file(
        file=file,
        bucket=settings.SUPABASE_STORAGE_BUCKET_LOGOS,
        tenant_id=tenant_id
    )


async def upload_product_image(file: UploadFile, tenant_id: str) -> dict:
    """Sube imagen de producto"""
    return await SupabaseStorage.upload_file(
        file=file,
        bucket=settings.SUPABASE_STORAGE_BUCKET_PRODUCTS,
        tenant_id=tenant_id
    )


async def upload_document(file: UploadFile, tenant_id: str) -> dict:
    """Sube documento"""
    return await SupabaseStorage.upload_file(
        file=file,
        bucket=settings.SUPABASE_STORAGE_BUCKET_DOCUMENTS,
        tenant_id=tenant_id
    )
