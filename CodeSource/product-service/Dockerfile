# ============================================
# TechShop Product Service - Dockerfile
# TODO pour les étudiants :
# - Implémenter un multi-stage build (Maven + JRE)
# - Utiliser un JRE minimal (Eclipse Temurin)
# - Optimiser les layers avec le layer-tools de Spring Boot
# - Ajouter un utilisateur non-root
# ============================================

# Étape 1 : Build avec Maven
FROM maven:3.9-eclipse-temurin-17 AS build
WORKDIR /app
COPY pom.xml .
RUN mvn dependency:go-offline -B
COPY src/ ./src/
RUN mvn package -DskipTests -B

# Étape 2 : Runtime
FROM eclipse-temurin:17-jre-alpine
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar
EXPOSE 8002
ENTRYPOINT ["java", "-jar", "app.jar"]
