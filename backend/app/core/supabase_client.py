"""
Cliente de Supabase para autenticación y storage
"""
from typing import Optional
from supabase import create_client, Client
from app.core.config import settings


class SupabaseClient:
    """Cliente singleton de Supabase"""
    
    _instance: Optional[Client] = None
    _admin_instance: Optional[Client] = None
    
    @classmethod
    def get_client(cls) -> Client:
        """
        Obtiene el cliente de Supabase con la API key pública (anon key).
        Usado para operaciones normales de usuarios.
        """
        if cls._instance is None:
            if not settings.SUPABASE_URL or not settings.SUPABASE_KEY:
                raise ValueError(
                    "SUPABASE_URL y SUPABASE_KEY deben estar configurados en .env"
                )
            
            cls._instance = create_client(
                settings.SUPABASE_URL,
                settings.SUPABASE_KEY
            )
        
        return cls._instance
    
    @classmethod
    def get_admin_client(cls) -> Client:
        """
        Obtiene el cliente de Supabase con la service role key.
        Usado para operaciones administrativas que requieren privilegios elevados.
        ⚠️ USAR CON PRECAUCIÓN: Tiene acceso completo a la base de datos.
        """
        if cls._admin_instance is None:
            if not settings.SUPABASE_URL or not settings.SUPABASE_SERVICE_ROLE_KEY:
                raise ValueError(
                    "SUPABASE_URL y SUPABASE_SERVICE_ROLE_KEY deben estar configurados en .env"
                )
            
            cls._admin_instance = create_client(
                settings.SUPABASE_URL,
                settings.SUPABASE_SERVICE_ROLE_KEY
            )
        
        return cls._admin_instance


# Instancias convenientes para importar
supabase_client = SupabaseClient.get_client
supabase_admin_client = SupabaseClient.get_admin_client
