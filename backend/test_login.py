"""
Script para probar el login con Supabase Auth
"""
import asyncio
import requests
from app.core.supabase_auth import SupabaseAuth

API_URL = "http://localhost:8000/api/v1"

def test_backend_health():
    """Probar que el backend esté corriendo"""
    try:
        response = requests.get("http://localhost:8000/")
        print(f"✅ Backend está corriendo: {response.status_code}")
        return True
    except Exception as e:
        print(f"❌ Error conectando al backend: {e}")
        return False


async def test_supabase_signup():
    """Probar registro directo con Supabase"""
    try:
        print("\n1️⃣ Probando registro con Supabase Auth...")
        result = await SupabaseAuth.sign_up(
            email="test@ferreteria.com",
            password="Test123456",
            metadata={
                "full_name": "Usuario de Prueba",
                "phone": "+1234567890"
            }
        )
        print(f"✅ Registro exitoso")
        print(f"   Usuario ID: {result['user'].id}")
        print(f"   Email: {result['user'].email}")
        print(f"   Confirmado: {result['user'].email_confirmed_at is not None}")
        return result['user'].email
    except Exception as e:
        error_msg = str(e)
        if "already registered" in error_msg.lower() or "already exists" in error_msg.lower():
            print(f"ℹ️ El usuario ya existe, continuando con pruebas de login...")
            return "test@ferreteria.com"
        else:
            print(f"❌ Error en registro: {e}")
            return None


async def test_supabase_signin(email: str):
    """Probar login directo con Supabase"""
    try:
        print(f"\n2️⃣ Probando login con Supabase Auth para {email}...")
        result = await SupabaseAuth.sign_in(
            email=email,
            password="Test123456"
        )
        print(f"✅ Login exitoso con Supabase")
        print(f"   Usuario: {result['user'].email}")
        print(f"   Access Token (primeros 20 chars): {result['access_token'][:20]}...")
        print(f"   Refresh Token (primeros 20 chars): {result['refresh_token'][:20]}...")
        return result['access_token']
    except Exception as e:
        print(f"❌ Error en login directo: {e}")
        return None


def test_backend_login_endpoint(email: str):
    """Probar el endpoint de login del backend"""
    try:
        print(f"\n3️⃣ Probando endpoint de login del backend /api/v1/auth/login...")
        response = requests.post(
            f"{API_URL}/auth/login",
            json={
                "email": email,
                "password": "Test123456"
            },
            headers={"Content-Type": "application/json"}
        )
        
        if response.status_code == 200:
            data = response.json()
            print(f"✅ Login exitoso vía API")
            print(f"   Usuario: {data['user']['email']}")
            print(f"   Access Token: {data['session']['access_token'][:20]}...")
            print(f"   Mensaje: {data.get('message', 'N/A')}")
            return data['session']['access_token']
        else:
            print(f"❌ Error en login: {response.status_code}")
            print(f"   Detalle: {response.text}")
            return None
    except Exception as e:
        print(f"❌ Error conectando al endpoint: {e}")
        return None


def test_protected_endpoint(access_token: str):
    """Probar un endpoint protegido con el token"""
    try:
        print(f"\n4️⃣ Probando endpoint protegido /api/v1/auth/me...")
        response = requests.get(
            f"{API_URL}/auth/me",
            headers={"Authorization": f"Bearer {access_token}"}
        )
        
        if response.status_code == 200:
            data = response.json()
            print(f"✅ Acceso a endpoint protegido exitoso")
            print(f"   Usuario: {data.get('email', 'N/A')}")
            return True
        else:
            print(f"❌ Error accediendo a endpoint protegido: {response.status_code}")
            print(f"   Detalle: {response.text}")
            return False
    except Exception as e:
        print(f"❌ Error: {e}")
        return False


async def main():
    """Ejecutar todas las pruebas"""
    print("=" * 70)
    print("PRUEBAS DE LOGIN CON SUPABASE AUTH")
    print("=" * 70)
    
    # 1. Verificar que el backend esté corriendo
    if not test_backend_health():
        print("\n❌ El backend no está corriendo. Inicia el servidor con:")
        print("   cd backend && python -m uvicorn app.main:app --reload")
        return
    
    # 2. Crear/obtener usuario de prueba
    email = await test_supabase_signup()
    if not email:
        print("\n❌ No se pudo crear el usuario de prueba")
        return
    
    # 3. Probar login directo con Supabase
    supabase_token = await test_supabase_signin(email)
    if not supabase_token:
        print("\n⚠️ El login directo con Supabase falló.")
        print("ℹ️ Esto puede ser porque el email no está confirmado o las credenciales son incorrectas.")
    
    # 4. Probar login a través del endpoint de la API
    api_token = test_backend_login_endpoint(email)
    if not api_token:
        print("\n❌ El endpoint de login de la API falló")
    else:
        # 5. Probar acceso a endpoint protegido
        test_protected_endpoint(api_token)
    
    print("\n" + "=" * 70)
    print("RESUMEN")
    print("=" * 70)
    
    if api_token:
        print("✅ El sistema de login está funcionando correctamente")
        print("✅ Puedes usar estas credenciales para probar el frontend:")
        print(f"   Email: {email}")
        print(f"   Password: Test123456")
    else:
        print("❌ Hay problemas con el sistema de login")
        print("\nVerifica:")
        print("  1. Que el backend esté corriendo en http://localhost:8000")
        print("  2. Que las credenciales de Supabase estén correctas en .env")
        print("  3. Que el usuario haya confirmado su email (revisa tu bandeja de entrada)")
    
    print("=" * 70)


if __name__ == "__main__":
    asyncio.run(main())
