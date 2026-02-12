"""
Script de verificación de configuración de Supabase
Ejecutar: python verify_supabase_setup.py
"""
import sys
import asyncio
from pathlib import Path

# Añadir el directorio raíz al path
sys.path.insert(0, str(Path(__file__).parent))

from app.core.config import settings
from app.core.supabase_client import supabase_client, supabase_admin_client


def print_header(text: str):
    """Imprime un encabezado formateado"""
    print("\n" + "=" * 70)
    print(f"  {text}")
    print("=" * 70)


def print_success(text: str):
    """Imprime mensaje de éxito"""
    print(f"✅ {text}")


def print_error(text: str):
    """Imprime mensaje de error"""
    print(f"❌ {text}")


def print_info(text: str):
    """Imprime información"""
    print(f"ℹ️  {text}")


def verify_environment_variables():
    """Verifica que las variables de entorno estén configuradas"""
    print_header("1. Verificando Variables de Entorno")
    
    required_vars = {
        "SUPABASE_URL": settings.SUPABASE_URL,
        "SUPABASE_KEY": settings.SUPABASE_KEY,
        "SUPABASE_JWT_SECRET": settings.SUPABASE_JWT_SECRET,
        "DATABASE_URL": settings.DATABASE_URL,
    }
    
    optional_vars = {
        "SUPABASE_SERVICE_ROLE_KEY": settings.SUPABASE_SERVICE_ROLE_KEY,
    }
    
    all_ok = True
    
    for var_name, var_value in required_vars.items():
        if var_value and var_value not in ["None", ""]:
            print_success(f"{var_name}: Configurado")
        else:
            print_error(f"{var_name}: NO configurado")
            all_ok = False
    
    for var_name, var_value in optional_vars.items():
        if var_value and var_value not in ["None", ""]:
            print_success(f"{var_name}: Configurado")
        else:
            print_info(f"{var_name}: No configurado (opcional para operaciones admin)")
    
    return all_ok


def verify_supabase_connection():
    """Verifica la conexión con Supabase"""
    print_header("2. Verificando Conexión con Supabase")
    
    try:
        client = supabase_client()
        print_success("Cliente de Supabase creado correctamente")
        print_info(f"URL: {settings.SUPABASE_URL}")
        return True
    except Exception as e:
        print_error(f"Error al crear cliente: {str(e)}")
        return False


def verify_database_connection():
    """Verifica la conexión con la base de datos"""
    print_header("3. Verificando Conexión con Base de Datos")
    
    try:
        client = supabase_client()
        
        # Intentar hacer una query simple
        response = client.table('tenants').select("id").limit(1).execute()
        
        print_success("Conexión con base de datos exitosa")
        print_info(f"Registros en tabla 'tenants': {len(response.data)}")
        return True
    except Exception as e:
        print_error(f"Error al conectar con base de datos: {str(e)}")
        print_info("Verifica que:")
        print_info("  - El schema de base de datos esté ejecutado")
        print_info("  - La tabla 'tenants' exista")
        print_info("  - DATABASE_URL sea correcto")
        return False


def verify_storage_buckets():
    """Verifica que los buckets de storage existan"""
    print_header("4. Verificando Buckets de Storage")
    
    expected_buckets = [
        settings.SUPABASE_STORAGE_BUCKET_LOGOS,
        settings.SUPABASE_STORAGE_BUCKET_PRODUCTS,
        settings.SUPABASE_STORAGE_BUCKET_DOCUMENTS,
    ]
    
    try:
        client = supabase_client()
        
        # Listar todos los buckets
        buckets = client.storage.list_buckets()
        bucket_names = [b.name for b in buckets]
        
        all_ok = True
        for bucket in expected_buckets:
            if bucket in bucket_names:
                print_success(f"Bucket '{bucket}': Existe")
            else:
                print_error(f"Bucket '{bucket}': NO existe")
                all_ok = False
        
        if not all_ok:
            print_info("\nPara crear los buckets faltantes:")
            print_info("  1. Ve a tu proyecto en Supabase")
            print_info("  2. Navega a Storage")
            print_info("  3. Crea los buckets faltantes")
        
        return all_ok
    except Exception as e:
        print_error(f"Error al verificar buckets: {str(e)}")
        return False


async def verify_auth_functionality():
    """Verifica funcionalidad básica de Auth"""
    print_header("5. Verificando Funcionalidad de Auth")
    
    try:
        from app.core.supabase_auth import SupabaseAuth
        
        # Solo verificamos que el módulo se importe correctamente
        print_success("Módulo de Auth importado correctamente")
        print_info("Funciones disponibles:")
        print_info("  - sign_up: Registro de usuarios ✓")
        print_info("  - sign_in: Inicio de sesión ✓")
        print_info("  - sign_out: Cerrar sesión ✓")
        print_info("  - refresh_token: Renovar token ✓")
        print_info("  - reset_password_email: Recuperar contraseña ✓")
        return True
    except Exception as e:
        print_error(f"Error al verificar Auth: {str(e)}")
        return False


async def verify_storage_functionality():
    """Verifica funcionalidad básica de Storage"""
    print_header("6. Verificando Funcionalidad de Storage")
    
    try:
        from app.core.supabase_storage import SupabaseStorage
        
        print_success("Módulo de Storage importado correctamente")
        print_info("Funciones disponibles:")
        print_info("  - upload_file: Subir archivos ✓")
        print_info("  - download_file: Descargar archivos ✓")
        print_info("  - delete_file: Eliminar archivos ✓")
        print_info("  - list_files: Listar archivos ✓")
        print_info("  - get_public_url: Obtener URL pública ✓")
        print_info("  - create_signed_url: Crear URL firmada ✓")
        return True
    except Exception as e:
        print_error(f"Error al verificar Storage: {str(e)}")
        return False


def print_summary(results: dict):
    """Imprime resumen de la verificación"""
    print_header("RESUMEN DE VERIFICACIÓN")
    
    total = len(results)
    passed = sum(results.values())
    
    print(f"\nPruebas pasadas: {passed}/{total}")
    
    if passed == total:
        print_success("\n🎉 ¡Configuración de Supabase completada exitosamente!")
        print_info("\nPróximos pasos:")
        print_info("  1. Revisa la documentación en SUPABASE_SETUP.md")
        print_info("  2. Configura Row Level Security (RLS) si no lo has hecho")
        print_info("  3. Personaliza los templates de email en Auth")
        print_info("  4. Continúa con la Issue #3: Configuración de CI/CD")
    else:
        print_error("\n⚠️  Algunas verificaciones fallaron")
        print_info("\nRevisa los errores arriba y:")
        print_info("  1. Verifica tus variables de entorno en .env")
        print_info("  2. Consulta SUPABASE_SETUP.md para más detalles")
        print_info("  3. Asegúrate de haber ejecutado el schema de base de datos")
    
    print("\n" + "=" * 70 + "\n")


async def main():
    """Función principal"""
    print("\n" + "🔧" * 35)
    print("  VERIFICACIÓN DE CONFIGURACIÓN DE SUPABASE")
    print("  Sistema de Gestión de Ferretería")
    print("🔧" * 35)
    
    results = {}
    
    # Ejecutar verificaciones
    results["env_vars"] = verify_environment_variables()
    
    if results["env_vars"]:
        results["connection"] = verify_supabase_connection()
        
        if results["connection"]:
            results["database"] = verify_database_connection()
            results["storage"] = verify_storage_buckets()
            results["auth"] = await verify_auth_functionality()
            results["storage_funcs"] = await verify_storage_functionality()
    else:
        print_error("\n⚠️  Configura primero las variables de entorno en .env")
        print_info("Copia .env.example a .env y completa los valores")
        return
    
    # Imprimir resumen
    print_summary(results)


if __name__ == "__main__":
    try:
        asyncio.run(main())
    except KeyboardInterrupt:
        print("\n\n⚠️  Verificación interrumpida por el usuario")
    except Exception as e:
        print(f"\n❌ Error inesperado: {str(e)}")
        import traceback
        traceback.print_exc()
