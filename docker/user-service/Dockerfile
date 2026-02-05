# ============================================
# TechShop User Service - Optimized Dockerfile
# ============================================
# -------- Stage 1 : Builder --------
    FROM python:3.12-slim AS builder
    WORKDIR /app
    
    # Installation des dépendances système nécessaires
    RUN apt-get update \
        && apt-get install -y --no-install-recommends build-essential \
        && rm -rf /var/lib/apt/lists/*
    
    # Copie des dépendances Python
    COPY CodeSource/user-service/requirements.txt .
    
    # Installation des dépendances dans un dossier dédié
    RUN pip install --upgrade pip \
        && pip install --no-cache-dir --prefix=/install -r requirements.txt
    
    # -------- Stage 2 : Runtime --------
    FROM python:3.12-slim
    
    WORKDIR /app
    # Création d’un utilisateur non-root
    RUN useradd -m appuser
    
    # Copie des dépendances installées depuis le builder
    COPY --from=builder /install /usr/local
    
    # Copie du code source
    COPY CodeSource/user-service/app ./app
    
    # Changement d’utilisateur
    USER appuser
    
    # Exposition du port du service
    EXPOSE 8001
    # Lancement du service FastAPI via Uvicorn
    CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8001"]
    