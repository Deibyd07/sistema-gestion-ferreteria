"""
Configuracion de pytest y fixtures compartidos
"""
from pathlib import Path
import sys

import pytest
from fastapi.testclient import TestClient
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
from sqlalchemy.pool import StaticPool

ROOT_DIR = Path(__file__).resolve().parents[2]
BACKEND_PATH = ROOT_DIR / "backend"
if str(BACKEND_PATH) not in sys.path:
    sys.path.insert(0, str(BACKEND_PATH))

from app.main import app
from app.db.base import Base
from app.db.session import get_db


# Base de datos de prueba en memoria
SQLALCHEMY_TEST_DATABASE_URL = "sqlite:///:memory:"

engine = create_engine(
    SQLALCHEMY_TEST_DATABASE_URL,
    connect_args={"check_same_thread": False},
    poolclass=StaticPool,
)
TestingSessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)


@pytest.fixture(scope="function")
def db_session():
    """
    Crea una sesion de base de datos para cada test
    """
    Base.metadata.create_all(bind=engine)
    session = TestingSessionLocal()
    try:
        yield session
    finally:
        session.close()
        Base.metadata.drop_all(bind=engine)


@pytest.fixture(scope="function")
def client(db_session):
    """
    Crea un cliente de prueba de FastAPI
    """
    def override_get_db():
        try:
            yield db_session
        finally:
            pass

    app.dependency_overrides[get_db] = override_get_db
    with TestClient(app) as test_client:
        yield test_client
    app.dependency_overrides.clear()


@pytest.fixture
def sample_user_data():
    """
    Datos de usuario de ejemplo para pruebas
    """
    return {
        "email": "test@example.com",
        "password": "TestPassword123!",
        "nombre": "Test User",
    }


@pytest.fixture
def sample_token():
    """
    Token JWT de ejemplo para pruebas
    Usar cuando se implemente autenticacion
    """
    return "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IlRlc3QgVXNlciIsImlhdCI6MTUxNjIzOTAyMn0.test"


@pytest.fixture
def auth_headers(sample_token):
    """
    Headers de autenticacion para pruebas
    Usar cuando se implemente autenticacion en endpoints
    """
    return {"Authorization": f"Bearer {sample_token}"}
