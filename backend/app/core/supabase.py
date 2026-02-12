"""
Cliente de Supabase para el backend
"""
from typing import Optional
from supabase import create_client, Client
from app.core.config import settings


class SupabaseClient:
    """Cliente singleton de Supabase"""
    
    _instance: Optional[Client] = None
    
    @classmethod
    def get_client(cls) -> Client:
        """
        Obtiene la instancia única del cliente de Supabase.
        
        Returns:
            Client: Cliente de Supabase configurado
            
        Raises:
            ValueError: Si las credenciales de Supabase no están configuradas
        """
        if cls._instance is None:
            if not settings.SUPABASE_URL or not settings.SUPABASE_KEY:
                raise ValueError(
                    "Las credenciales de Supabase no están configuradas. "
                    "Verifica que SUPABASE_URL y SUPABASE_KEY estén en el archivo .env"
                )
            
            cls._instance = create_client(
                supabase_url=settings.SUPABASE_URL,
                supabase_key=settings.SUPABASE_KEY
            )
        
        return cls._instance
    
    @classmethod
    def get_auth(cls):
        """
        Obtiene el cliente de autenticación de Supabase.
        
        Returns:
            Auth: Cliente de autenticación
        """
        return cls.get_client().auth
    
    @classmethod
    def get_storage(cls):
        """
        Obtiene el cliente de almacenamiento de Supabase.
        
        Returns:
            Storage: Cliente de almacenamiento
        """
        return cls.get_client().storage
    
    @classmethod
    def get_database(cls):
        """
        Obtiene el cliente de base de datos de Supabase (PostgREST).
        
        Returns:
            PostgREST: Cliente de base de datos
        """
        return cls.get_client().postgrest


# Instancia global del cliente
def get_supabase_client() -> Client:
    """
    Función helper para obtener el cliente de Supabase.
    
    Returns:
        Client: Cliente de Supabase configurado
        
    Example:
        ```python
        from app.core.supabase import get_supabase_client
        
        supabase = get_supabase_client()
        response = supabase.table('users').select('*').execute()
        ```
    """
    return SupabaseClient.get_client()


# Función helper para autenticación
def get_supabase_auth():
    """
    Función helper para obtener el cliente de autenticación.
    
    Returns:
        Auth: Cliente de autenticación
        
    Example:
        ```python
        from app.core.supabase import get_supabase_auth
        
        auth = get_supabase_auth()
        session = auth.sign_in_with_password({
            "email": "user@example.com",
            "password": "password123"
        })
        ```
    """
    return SupabaseClient.get_auth()


# Función helper para storage
def get_supabase_storage():
    """
    Función helper para obtener el cliente de almacenamiento.
    
    Returns:
        Storage: Cliente de almacenamiento
        
    Example:
        ```python
        from app.core.supabase import get_supabase_storage
        
        storage = get_supabase_storage()
        storage.from_('product-images').upload('image.jpg', file_data)
        ```
    """
    return SupabaseClient.get_storage()
