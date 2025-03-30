FROM maven:3.8.3-openjdk-17 AS builder

WORKDIR /workspace/app

COPY .mvn .mvn
COPY mvnw .
COPY pom.xml .

# Install dependencies
RUN mvn dependency:go-offline

COPY src src

# Build the application
RUN mvn clean package -DskipTests

# -----------------------------------------------------------------------------
# Runtime stage
# -----------------------------------------------------------------------------
FROM eclipse-temurin:17-jre-ubi9-minimal
WORKDIR /app

ARG APP_NAME
ARG APP_VERSION

# Application metadata
LABEL maintainer="Quentin Vu <quentindevops@gmail.com>" \
      app.name=${APP_NAME} \
      app.version=${APP_VERSION}

# Copy JAR from builder stage
COPY --from=builder /workspace/app/target/*.jar app.jar

ENV APP_NAME=backend-service \
    SERVER_PORT=8082 \
    DATABASE_SERVICE_URL=http://database-service:8081

# Set environment variables
ENV JAVA_OPTS="-XX:+UseContainerSupport -XX:MaxRAMPercentage=75.0"

# Expose port
EXPOSE ${SERVER_PORT}

ENTRYPOINT ["sh", "-c", "java ${JAVA_OPTS} -jar app.jar"]
