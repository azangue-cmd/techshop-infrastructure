# ============================================
# TechShop Frontend - Optimized Dockerfile
# ============================================

# -------- Stage 1 : Build React --------
    FROM node:20-alpine AS build

    WORKDIR /app
    
    COPY CodeSource/frontend/package*.json ./
    
    RUN npm install
    
    COPY CodeSource/frontend .
    
    RUN npm run build
    
    # -------- Stage 2 : Nginx --------
    FROM nginx:alpine
    
    LABEL org.opencontainers.image.title="TechShop Frontend"
    LABEL org.opencontainers.image.description="React Frontend for TechShop"
    LABEL org.opencontainers.image.version="1.0.0"
    
    # Supprimer config par défaut
    RUN rm /etc/nginx/conf.d/default.conf
    
    # Copier config nginx
    COPY CodeSource/frontend/nginx.conf /etc/nginx/conf.d/default.conf
    
    # Copier build React depuis le stage build
    COPY --from=build /app/build /usr/share/nginx/html
    
    # Créer utilisateur non-root
    RUN addgroup -S appgroup && adduser -S appuser -G appgroup
    
    # Donner permissions nécessaires
    RUN mkdir -p /var/cache/nginx \
        && mkdir -p /var/run \
        && mkdir -p /run \
        && chown -R appuser:appgroup /var/cache/nginx \
        && chown -R appuser:appgroup /var/run \
        && chown -R appuser:appgroup /run \
        && chown -R appuser:appgroup /usr/share/nginx/html \
        && chown -R appuser:appgroup /etc/nginx
    
    USER appuser
    
    EXPOSE 80
    
    CMD ["nginx", "-g", "daemon off;"]
    