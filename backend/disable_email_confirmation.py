"""
Script para deshabilitar la confirmación de email en Supabase Auth (solo para desarrollo)
"""
import asyncio
from app.core.supabase_client import supabase_admin_client

async def disable_email_confirmation():
    """
    Actualiza la configuración de Supabase para deshabilitar la confirmación de email
    """
    print("=" * 70)
    print("CONFIGURACIÓN DE SUPABASE AUTH PARA DESARROLLO")
    print("=" * 70)
    print()
    
    print("⚠️  IMPORTANTE: Esta configuración debe usarse solo en desarrollo")
    print()
    
    print("Para deshabilitar la confirmación de email en Supabase:")
    print()
    print("1. Ve a tu proyecto en Supabase: https://app.supabase.com")
    print()
    print("2. En el sidebar, navega a: Authentication > Settings")
    print()
    print("3. En la sección 'Email Auth', busca:")
    print("   - 'Enable email confirmations' (Habilitar confirmación de email)")
    print()
    print("4. DESACTIVA esta opción (toggle off)")
    print()
    print("5. Guarda los cambios")
    print()
    print("=" * 70)
    print()
    
    print("Después de hacer esto, los usuarios podrán iniciar sesión")
    print("inmediatamente después de registrarse, sin necesidad de confirmar su email.")
    print()
    
    print("También puedes:")
    print("- Confirmar manualmente un usuario desde Authentication > Users")
    print("- Hacer clic en el usuario y marcar 'Email Confirmed'")
    print()
    
    print("=" * 70)
    print()
    
    # Intentar confirmar el usuario de prueba si existe
    try:
        print("Intentando confirmar usuario test@ferreteria.com manualmente...")
        admin = supabase_admin_client()
        
        # Lista todos los usuarios
        response = admin.auth.admin.list_users()
        
        # Buscar el usuario de prueba
        test_user = None
        for user in response:
            if user.email == "test@ferreteria.com":
                test_user = user
                break
        
        if test_user:
            print(f"✅ Usuario encontrado: {test_user.email}")
            print(f"   ID: {test_user.id}")
            
            # Confirmar el email del usuario
            admin.auth.admin.update_user_by_id(
                test_user.id,
                {"email_confirm": True}
            )
            
            print(f"✅ Email confirmado manualmente para test@ferreteria.com")
            print()
            print("Ahora puedes iniciar sesión con:")
            print("   Email: test@ferreteria.com")
            print("   Password: Test123456")
        else:
            print("ℹ️  No se encontró el usuario test@ferreteria.com")
            print("   Primero regístralo ejecutando: python test_login.py")
    
    except Exception as e:
        print(f"❌ Error al intentar confirmar usuario: {e}")
        print()
        print("ℹ️  Usa las instrucciones manuales arriba")
    
    print()
    print("=" * 70)


if __name__ == "__main__":
    asyncio.run(disable_email_confirmation())
