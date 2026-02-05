# ============================================
# TechShop API Gateway - Optimized Dockerfile
# ============================================

# -------- Base image --------
    FROM node:20-alpine

    # Définition du répertoire de travail
    WORKDIR /app
    
    # Copie des fichiers de dépendances en premier (optimisation du cache Docker)
    COPY CodeSource/api-gateway/package*.json ./
    
    # Installation des dépendances nécessaires à l’exécution
    # npm install est utilisé car aucun package-lock.json n’est garanti
    RUN npm install --only=production
    
    # Copie du code source de l’API Gateway
    COPY CodeSource/api-gateway/src ./src
    
    # Création d’un utilisateur non-root pour renforcer la sécurité
    RUN addgroup -S appgroup && adduser -S appuser -G appgroup
    
    # Changement d’utilisateur
    USER appuser
    
    # Exposition du port utilisé par l’API Gateway
    EXPOSE 3000
    
    # Healthcheck pour vérifier que l’API est accessible
    HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
      CMD wget -qO- http://localhost:3000/health || exit 1
    
    # Commande de démarrage de l’API Gateway
    CMD ["node", "src/server.js"]
    