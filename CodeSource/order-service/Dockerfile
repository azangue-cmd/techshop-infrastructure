# ============================================
# TechShop Order Service - Dockerfile
# TODO pour les étudiants :
# - Implémenter un multi-stage build
# - Compiler un binaire statique
# - Utiliser une image scratch ou distroless
# - Ajouter un utilisateur non-root
# ============================================

# Étape 1 : Build
FROM golang:1.21-alpine AS build
WORKDIR /app
COPY go.mod go.sum* ./
RUN go mod download
COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -o order-service ./cmd/server

# Étape 2 : Runtime minimal
FROM alpine:3.19
RUN apk --no-cache add ca-certificates curl
WORKDIR /app
COPY --from=build /app/order-service .
EXPOSE 8003
CMD ["./order-service"]
