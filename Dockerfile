# Stage 1: Build the application
FROM maven:3.9 AS build

WORKDIR /app

COPY pom.xml .
COPY src ./src

RUN mvn clean package -DskipTests

# Stage 2: Create the runtime image
FROM alpine:latest

# Instalar o JRE
RUN apk --no-cache add openjdk17-jre-headless

WORKDIR /app

COPY --from=build /app/target/docker-0.0.1-SNAPSHOT.jar app.jar

EXPOSE 8080

# Define default values for JVM parameters
ENV JAVA_OPTS="-Xms256m -Xmx512m"

ENTRYPOINT ["sh", "-c", "java $JAVA_OPTS -jar app.jar"]
