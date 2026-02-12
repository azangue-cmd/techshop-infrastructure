# ============================================
# TechShop Database - PostgreSQL Dockerfile
# ============================================

# Utiliser l'image officielle PostgreSQL légère
FROM postgres:16-alpine

# Définir les variables par défaut (peuvent être surchargées par docker run ou docker-compose)
ENV POSTGRES_DB=techshop
ENV POSTGRES_USER=techshop
ENV POSTGRES_PASSWORD=techshop

# Labels OCI (bonne pratique DevOps)
LABEL org.opencontainers.image.title="TechShop Database"
LABEL org.opencontainers.image.description="PostgreSQL Database for TechShop Microservices"
LABEL org.opencontainers.image.version="1.0.0"

# Copier script d'initialisation SQL
# Ce script sera exécuté automatiquement au premier démarrage
COPY CodeSource/database/init/01-init.sql /docker-entrypoint-initdb.d/01-init.sql

# Exposer le port PostgreSQL
EXPOSE 5432

# Utiliser l'utilisateur postgres (déjà configuré dans l'image officielle)
USER postgres
