# ============================================
# TechShop Product Service - Optimized Dockerfile
# ============================================

# -------- Stage 1 : Build --------
    FROM maven:3.9-eclipse-temurin-17 AS builder
    WORKDIR /app
    # Copier pom.xml pour optimiser le cache
    COPY CodeSource/product-service/pom.xml .
    # Télécharger les dépendances
    RUN mvn dependency:go-offline -B
    # Copier le code source
    COPY CodeSource/product-service/src ./src
    # Compiler l'application
    RUN mvn package -DskipTests -B
    # -------- Stage 2 : Runtime --------
    FROM eclipse-temurin:17-jre-alpine
    WORKDIR /app
    # Ajouter labels OCI
    LABEL org.opencontainers.image.title="TechShop Product Service"
    LABEL org.opencontainers.image.description="Spring Boot Product Microservice"
    LABEL org.opencontainers.image.version="1.0.0"
    # Créer utilisateur non-root
    RUN addgroup -S appgroup && adduser -S appuser -G appgroup
    # Copier le fichier JAR
    COPY --from=builder /app/target/*.jar app.jar
    # Changer utilisateur
    USER appuser
    # Exposer le port du service
    EXPOSE 8002
    # Lancer le microservice
    ENTRYPOINT ["java", "-jar", "app.jar"]
    