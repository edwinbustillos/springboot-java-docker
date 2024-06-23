# Projeto Spring Boot com Docker

Este projeto é um exemplo de uma aplicação Java Spring Boot configurada para ser executada em um contêiner Docker, utilizando multi-stage builds com Alpine Linux e Java JDK 17. A aplicação expõe uma API na porta 8080.

## Pré-requisitos

- Docker
- Docker Compose

## Comandos para Rodar a Aplicação
Para construir e rodar a aplicação, execute o seguinte comando na raiz do projeto:
```
docker-compose up --build
```

Isso irá construir a imagem Docker e iniciar o contêiner, mapeando a porta 8080 do contêiner para a porta 8080 da máquina host. Você pode acessar a API em http://localhost:8080.

Parar a Aplicação
Para parar a aplicação, pressione Ctrl + C no terminal onde o Docker Compose está rodando.

Reiniciar a Aplicação
Se você fez alterações no código e deseja reiniciar a aplicação, execute:

## Acessar o Contêiner
Para acessar o shell do contêiner em execução, use:
```
docker-compose exec app sh
```

## Verificar Logs
Para verificar os logs do contêiner, use:
```
docker-compose logs -f
```

## Comandos para Destruir a Aplicação
Parar e Remover Contêineres
Para parar e remover os contêineres, execute:
```
docker-compose down
```

## Parar e Remover Contêineres, Redes, Volumes e Imagens
Para parar e remover todos os contêineres, redes, volumes e imagens associadas ao docker-compose.yml, execute:
```
docker-compose down --rmi all -v
```

## Configurações de JVM
Você pode ajustar as configurações de JVM modificando a variável de ambiente JAVA_OPTS no arquivo docker-compose.yml. Exemplo:
```
environment:
  - JAVA_OPTS=-Xms512m -Xmx1024m -XX:+UseG1GC -Dcom.sun.management.jmxremote
```
## Configurações de JVM
Você pode ajustar as configurações de JVM modificando a variável de ambiente JAVA_OPTS no arquivo docker-compose.yml. Exemplo:

```
environment:
  - JAVA_OPTS=-Xms512m -Xmx1024m -XX:+UseG1GC -Dcom.sun.management.jmxremote

```

## Estrutura do Dockerfile

```
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

```

## Contato
Para mais informações, entre em contato com edwin@bustillos.dev