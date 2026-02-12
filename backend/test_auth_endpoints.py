"""
Script de prueba para endpoints de autenticación
Ejecutar con: python test_auth_endpoints.py
"""
import asyncio
import httpx
import json

BASE_URL = "http://localhost:8000/api/v1"

# Datos de prueba
TEST_USER = {
    "email": "usuario_prueba@example.com",
    "password": "Password123",
    "confirm_password": "Password123",
    "full_name": "Usuario de Prueba",
    "phone": "+1234567890"
}

async def test_endpoints():
    """Prueba todos los endpoints de autenticación"""
    
    async with httpx.AsyncClient() as client:
        print("=" * 60)
        print("🧪 PRUEBAS DE ENDPOINTS DE AUTENTICACIÓN")
        print("=" * 60)
        
        # 1. Registro de usuario
        print("\n1️⃣  Probando POST /auth/register...")
        try:
            response = await client.post(
                f"{BASE_URL}/auth/register",
                json=TEST_USER
            )
            print(f"   Status: {response.status_code}")
            if response.status_code == 201:
                data = response.json()
                print(f"   ✅ Usuario registrado: {data['user']['email']}")
                print(f"   ✅ Access Token recibido")
                access_token = data['session']['access_token']
                refresh_token = data['session']['refresh_token']
            else:
                print(f"   ❌ Error: {response.json()}")
                return
        except Exception as e:
            print(f"   ❌ Error: {str(e)}")
            return
        
        # 2. Login
        print("\n2️⃣  Probando POST /auth/login...")
        try:
            response = await client.post(
                f"{BASE_URL}/auth/login",
                json={
                    "email": TEST_USER["email"],
                    "password": TEST_USER["password"]
                }
            )
            print(f"   Status: {response.status_code}")
            if response.status_code == 200:
                data = response.json()
                print(f"   ✅ Login exitoso: {data['user']['email']}")
                print(f"   ✅ Access Token renovado")
                access_token = data['session']['access_token']
                refresh_token = data['session']['refresh_token']
            else:
                print(f"   ❌ Error: {response.json()}")
        except Exception as e:
            print(f"   ❌ Error: {str(e)}")
        
        # 3. Obtener usuario actual
        print("\n3️⃣  Probando GET /auth/me...")
        try:
            response = await client.get(
                f"{BASE_URL}/auth/me",
                headers={"Authorization": f"Bearer {access_token}"}
            )
            print(f"   Status: {response.status_code}")
            if response.status_code == 200:
                data = response.json()
                print(f"   ✅ Usuario obtenido: {data['email']}")
                print(f"   ✅ Nombre: {data.get('full_name', 'N/A')}")
            else:
                print(f"   ❌ Error: {response.json()}")
        except Exception as e:
            print(f"   ❌ Error: {str(e)}")
        
        # 4. Refresh token
        print("\n4️⃣  Probando POST /auth/refresh-token...")
        try:
            response = await client.post(
                f"{BASE_URL}/auth/refresh-token",
                json={"refresh_token": refresh_token}
            )
            print(f"   Status: {response.status_code}")
            if response.status_code == 200:
                data = response.json()
                print(f"   ✅ Token refrescado exitosamente")
                access_token = data['access_token']
            else:
                print(f"   ❌ Error: {response.json()}")
        except Exception as e:
            print(f"   ❌ Error: {str(e)}")
        
        # 5. Forgot password
        print("\n5️⃣  Probando POST /auth/forgot-password...")
        try:
            response = await client.post(
                f"{BASE_URL}/auth/forgot-password",
                json={"email": TEST_USER["email"]}
            )
            print(f"   Status: {response.status_code}")
            if response.status_code == 200:
                data = response.json()
                print(f"   ✅ {data['message']}")
            else:
                print(f"   ❌ Error: {response.json()}")
        except Exception as e:
            print(f"   ❌ Error: {str(e)}")
        
        # 6. Logout
        print("\n6️⃣  Probando POST /auth/logout...")
        try:
            response = await client.post(
                f"{BASE_URL}/auth/logout",
                headers={"Authorization": f"Bearer {access_token}"}
            )
            print(f"   Status: {response.status_code}")
            if response.status_code == 200:
                data = response.json()
                print(f"   ✅ {data['message']}")
            else:
                print(f"   ❌ Error: {response.json()}")
        except Exception as e:
            print(f"   ❌ Error: {str(e)}")
        
        print("\n" + "=" * 60)
        print("✨ PRUEBAS COMPLETADAS")
        print("=" * 60)
        print("\n📝 Notas:")
        print("   - Verifica tu configuración de Supabase en .env")
        print("   - Algunos endpoints requieren configuración adicional de Supabase")
        print("   - El endpoint /auth/reset-password requiere un token válido del email")

if __name__ == "__main__":
    print("\n⚠️  IMPORTANTE: Asegúrate de que el servidor esté corriendo en http://localhost:8000")
    print("   Ejecuta: uvicorn app.main:app --reload\n")
    
    asyncio.run(test_endpoints())
