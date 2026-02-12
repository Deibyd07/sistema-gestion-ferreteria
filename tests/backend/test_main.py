"""
Tests para el endpoint de health check y configuracion basica
"""
from fastapi.testclient import TestClient


def test_health_check(client: TestClient):
    """
    Test: El endpoint de health check debe retornar 200 OK
    """
    response = client.get("/health")
    assert response.status_code == 200, f"Expected 200, got {response.status_code}"
    data = response.json()
    assert "status" in data, "Response should contain 'status' field"
    assert data["status"] == "healthy", f"Expected 'healthy', got {data['status']}"


def test_root_endpoint(client: TestClient):
    """
    Test: El endpoint raiz debe retornar 200
    """
    response = client.get("/")
    assert response.status_code == 200, f"Expected 200, got {response.status_code}"
    data = response.json()
    assert "message" in data, "Response should contain 'message' field"
    assert "version" in data, "Response should contain 'version' field"
    assert "status" in data, "Response should contain 'status' field"


def test_api_docs_available(client: TestClient):
    """
    Test: La documentacion de API debe estar disponible en /api/docs
    """
    response = client.get("/api/docs")
    assert response.status_code == 200, f"Expected 200, got {response.status_code}"


def test_openapi_schema(client: TestClient):
    """
    Test: El esquema OpenAPI debe estar disponible
    """
    response = client.get("/api/openapi.json")
    assert response.status_code == 200, f"Expected 200, got {response.status_code}"
    data = response.json()
    assert "openapi" in data, "OpenAPI schema should be present"
    assert "paths" in data, "Paths should be present in OpenAPI schema"


def test_database_connection(db_session):
    """
    Test: La conexion a la base de datos debe funcionar
    """
    from sqlalchemy import text

    result = db_session.execute(text("SELECT 1"))
    value = result.scalar()
    assert value == 1, f"Expected 1, got {value}"
