import pytest
from app import app

@pytest.fixture
def client():
    with app.test_client() as client:
        yield client

def test_home(client):
    """Checking if code response 200 works"""
    response = client.get("/")
    assert response.status_code == 200

def test_404(client):
    """Checking if code response 404 works"""
    response = client.get("/notfound")
    assert response.status_code == 404