# -------- Stage 1 : Build React --------
    # Utilisation d’une image Node.js légère (Alpine) pour compiler l’application React
    FROM node:20-alpine AS build

    # Définition du répertoire de travail à l’intérieur du conteneur
    WORKDIR /app
    
    # Copie des fichiers package.json et package-lock.json (s’ils existent)
    # Cette étape permet d’optimiser le cache Docker lors des builds
    COPY CodeSource/frontend/package*.json ./

    # Installation des dépendances JavaScript nécessaires au projet
    RUN npm install
    
    # Copie de l’ensemble du code source du frontend dans le conteneur
    COPY CodeSource/frontend .

    # Compilation de l’application React en mode production
    # Le résultat est généré dans le dossier /app/build
    RUN npm run build
    
    # -------- Stage 2 : Nginx --------
    # Utilisation d’une image Nginx légère pour servir les fichiers statiques en production
    FROM nginx:alpine
    
    # Ajout de labels OCI pour identifier et documenter l’image Docker
    LABEL org.opencontainers.image.title="TechShop Frontend"
    LABEL org.opencontainers.image.description="React Frontend for TechShop"
    LABEL org.opencontainers.image.version="1.0.0"
    
    # Suppression de la configuration Nginx par défaut
    # afin de remplacer par une configuration personnalisée
    RUN rm /etc/nginx/conf.d/default.conf

    # Copie de la configuration Nginx spécifique au frontend
    COPY CodeSource/frontend/nginx.conf /etc/nginx/conf.d/default.conf
    
    # Copie des fichiers compilés depuis l’étape de build vers le répertoire servi par Nginx
    COPY --from=build /app/build /usr/share/nginx/html
    
    # Création d’un utilisateur non-root pour améliorer la sécurité du conteneur
    RUN adduser -D -H -u 1001 appuser

    # Exécution du conteneur avec l’utilisateur non-root
    USER appuser
    
    # Exposition du port 80 pour l’accès HTTP au frontend
    EXPOSE 80

    # Démarrage du serveur Nginx en mode premier plan
    CMD ["nginx", "-g", "daemon off;"]
    