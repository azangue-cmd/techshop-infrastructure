# ============================================
# TechShop User Service - Dockerfile
# TODO pour les étudiants :
# - Implémenter un multi-stage build
# - Optimiser la taille de l'image
# - Ajouter un utilisateur non-root
# - Gérer les dépendances de manière optimale
# ============================================

FROM python:3.12-slim
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY app/ ./app/
EXPOSE 8001
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8001"]
