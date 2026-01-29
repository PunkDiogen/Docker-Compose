FROM openjdk:8-jdk-alpine AS build

WORKDIR /app

COPY .mvn/ .mvn/
COPY mvnw ./ 
COPY pom.xml ./

RUN ./mvnw dependency:go-offline

COPY src/ src/

RUN ./mvnw package -DskipTests

FROM openjdk:8-jdk-alpine AS runtime

WORKDIR /app

RUN apk add --no-cache \
    bash\
    curl

COPY --from=build /app/target/*.jar app.jar
COPY wait-for-it.sh /wait-for-it.sh

RUN chmod +x /wait-for-it.sh

CMD ["sh", "-c", "/wait-for-it.sh ${POSTGRES_HOST}:${POSTGRES_PORT} --timeout=30 -- java -jar app.jar"]

EXPOSE 8081
