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

CMD ["sh", "-c", "/wait-for-it.sh ${SESSION_SERVICE_HOST}:${SESSION_SERVICE_PORT} --timeout=120 -- \ 
&& /wait-for-it.sh ${HOTEL_SERVICE_HOST}:${HOTEL_SERVICE_PORT} --timeout=120 -- \
&& /wait-for-it.sh ${PAYMENT_SERVICE_HOST}:${PAYMENT_SERVICE_PORT} --timeout=120 -- \
&& /wait-for-it.sh ${REPORT_SERVICE_HOST}:${REPORT_SERVICE_PORT} --timeout=120 -- \
&& /wait-for-it.sh ${LOYALTY_SERVICE_HOST}:${LOYALTY_SERVICE_PORT} --timeout=120 -- \
&& java -jar app.jar"]

EXPOSE 8087
