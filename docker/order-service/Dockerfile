# ============================================
# TechShop Order Service - Optimized Dockerfile
# ============================================

# -------- Stage 1 : Build --------
    FROM golang:1.21-alpine AS builder

    WORKDIR /app
    
    # Installer certificats nécessaires
    RUN apk add --no-cache ca-certificates
    
    # Copier tout le code source du order-service
    COPY CodeSource/order-service .
    
    # Corriger et télécharger les dépendances
    RUN go mod tidy
    RUN go mod download
    
    # Compiler binaire statique optimisé
    RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 \
        go build -ldflags="-w -s" -o order-service ./cmd/server
    
    
    # -------- Stage 2 : Runtime minimal sécurisé --------
    FROM alpine:3.19
    
    WORKDIR /app
    
    # Installer certificats SSL nécessaires
    RUN apk --no-cache add ca-certificates
    
    # Créer utilisateur non-root pour sécurité
    RUN addgroup -S appgroup && adduser -S appuser -G appgroup
    
    # Copier le binaire depuis le stage builder
    COPY --from=builder /app/order-service .
    
    # Utiliser utilisateur non-root
    USER appuser
    
    # Labels OCI (bonne pratique DevOps)
    LABEL org.opencontainers.image.title="TechShop Order Service"
    LABEL org.opencontainers.image.description="Go Order Microservice"
    LABEL org.opencontainers.image.version="1.0.0"
    
    # Exposer le port du service
    EXPOSE 8003
    
    # Lancer le service
    CMD ["./order-service"]
    