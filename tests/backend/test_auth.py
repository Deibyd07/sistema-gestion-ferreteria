"""
Tests para autenticacion

NOTA: Los tests de auth estan listos para cuando se implemente
los endpoints de autenticacion. Actualmente solo incluyen tests
del token y validacion de headers.
"""
import pytest
from fastapi.testclient import TestClient


class TestAuthFixtures:
    """
    Tests para verificar que los fixtures de autenticacion funcionan correctamente
    """

    def test_sample_user_data_fixture(self, sample_user_data):
        """
        Test: El fixture sample_user_data debe contener datos validos
        """
        assert "email" in sample_user_data
        assert "password" in sample_user_data
        assert "nombre" in sample_user_data
        assert sample_user_data["email"] == "test@example.com"
        assert len(sample_user_data["password"]) > 8
        assert len(sample_user_data["nombre"]) > 0

    def test_sample_token_fixture(self, sample_token):
        """
        Test: El fixture sample_token debe contener un token valido
        """
        assert isinstance(sample_token, str)
        assert len(sample_token) > 0
        # Un token JWT valido tiene 3 partes separadas por puntos
        parts = sample_token.split(".")
        assert len(parts) == 3, "JWT token debe tener formato 'header.payload.signature'"

    def test_auth_headers_fixture(self, auth_headers, sample_token):
        """
        Test: El fixture auth_headers debe tener el formato correcto
        """
        assert isinstance(auth_headers, dict)
        assert "Authorization" in auth_headers
        assert auth_headers["Authorization"].startswith("Bearer ")
        assert sample_token in auth_headers["Authorization"]


class TestAuthEndpoints:
    """
    Tests para endpoints de autenticacion

    IMPORTANTE: Descomenta estos tests cuando implementes los endpoints
    """

    @pytest.mark.skip(reason="Endpoint no implementado aun")
    def test_register_user(self, client: TestClient, sample_user_data):
        """
        Test: POST /api/auth/register debe registrar un usuario
        """
        response = client.post("/api/auth/register", json=sample_user_data)
        assert response.status_code in [200, 201]
        data = response.json()
        assert "id" in data or "user" in data

    @pytest.mark.skip(reason="Endpoint no implementado aun")
    def test_register_duplicate_email(self, client: TestClient, sample_user_data):
        """
        Test: POST /api/auth/register debe rechazar si el email ya existe
        """
        # Registrar primer usuario
        client.post("/api/auth/register", json=sample_user_data)

        # Intentar registrar con el mismo email
        response = client.post("/api/auth/register", json=sample_user_data)
        assert response.status_code == 400

    @pytest.mark.skip(reason="Endpoint no implementado aun")
    def test_login_valid_credentials(self, client: TestClient, sample_user_data):
        """
        Test: POST /api/auth/login debe retornar token con credenciales validas
        """
        # Registrar usuario
        client.post("/api/auth/register", json=sample_user_data)

        # Hacer login
        login_data = {
            "username": sample_user_data["email"],
            "password": sample_user_data["password"],
        }
        response = client.post("/api/auth/login", data=login_data)
        assert response.status_code == 200
        data = response.json()
        assert "access_token" in data
        assert "token_type" in data
        assert data["token_type"] == "bearer"

    @pytest.mark.skip(reason="Endpoint no implementado aun")
    def test_login_invalid_credentials(self, client: TestClient):
        """
        Test: POST /api/auth/login debe rechazar credenciales invalidas
        """
        login_data = {
            "username": "invalid@example.com",
            "password": "wrongpassword",
        }
        response = client.post("/api/auth/login", data=login_data)
        assert response.status_code == 401

    @pytest.mark.skip(reason="Endpoint no implementado aun")
    def test_login_missing_fields(self, client: TestClient):
        """
        Test: POST /api/auth/login debe validar campos requeridos
        """
        response = client.post("/api/auth/login", data={})
        assert response.status_code == 422


class TestProtectedEndpoints:
    """
    Tests para endpoints protegidos que requieren autenticacion

    IMPORTANTE: Descomenta estos tests cuando implementes endpoints protegidos
    """

    @pytest.mark.skip(reason="Endpoint protegido no implementado aun")
    def test_protected_endpoint_without_auth(self, client: TestClient):
        """
        Test: Un endpoint protegido sin token debe retornar 401
        """
        response = client.get("/api/users/me")
        assert response.status_code == 401

    @pytest.mark.skip(reason="Endpoint protegido no implementado aun")
    def test_protected_endpoint_with_invalid_token(self, client: TestClient):
        """
        Test: Un endpoint protegido con token invalido debe retornar 401
        """
        headers = {"Authorization": "Bearer invalid-token"}
        response = client.get("/api/users/me", headers=headers)
        assert response.status_code == 401

    @pytest.mark.skip(reason="Endpoint protegido no implementado aun")
    def test_protected_endpoint_with_valid_token(self, client: TestClient, auth_headers):
        """
        Test: Un endpoint protegido con token valido debe retornar el recurso
        """
        response = client.get("/api/users/me", headers=auth_headers)
        assert response.status_code == 200
        data = response.json()
        assert "id" in data
        assert "email" in data
