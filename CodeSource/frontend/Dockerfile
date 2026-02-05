# ============================================
# TechShop Frontend - Dockerfile
# TODO pour les étudiants :
# - Implémenter un multi-stage build
# - Optimiser la taille de l'image
# - Ajouter un utilisateur non-root
# - Configurer les labels OCI
# ============================================

# Étape 1 : Build
FROM node:20-alpine AS build
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build

# Étape 2 : Serveur de production
FROM nginx:alpine
COPY --from=build /app/build /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
