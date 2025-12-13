# Multi-stage build để tối ưu kích thước image

# Stage 1: Build application
FROM maven:3.9.5-eclipse-temurin-17 AS builder

WORKDIR /app

# Copy pom.xml và download dependencies trước (tận dụng Docker cache)
COPY pom.xml .
RUN mvn dependency:go-offline -B

# Copy source code và build
COPY src ./src
RUN mvn clean package -DskipTests -B

# Stage 2: Runtime
FROM eclipse-temurin:17-jre

WORKDIR /app

# Install curl for healthcheck
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*

# Copy jar file từ builder stage
COPY --from=builder /app/target/*.jar app.jar

# Expose port
EXPOSE 8088

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=60s --retries=3 \
  CMD curl -f http://localhost:${PORT:-8088}/api/v1/healthcheck || exit 1

# Run application with dynamic port
ENTRYPOINT ["sh", "-c", "java -jar app.jar --server.port=${PORT:-8088}"]
