# Build stage
FROM gradle:9.4.1-jdk17-alpine AS build

WORKDIR /workspace
COPY --chown=gradle:gradle . .
RUN gradle bootJar --no-daemon

# Runtime stage
FROM eclipse-temurin:17-jre-alpine

WORKDIR /app

RUN addgroup -S app && adduser -S app -G app

COPY --from=build --chown=app:app /workspace/build/libs/*.jar /app/app.jar

USER app

EXPOSE 8080

ENTRYPOINT ["java", "-XX:MaxRAMPercentage=75.0", "-jar", "/app/app.jar"]
