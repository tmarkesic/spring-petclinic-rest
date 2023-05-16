FROM openjdk:latest as build

WORKDIR /build 

COPY pom.xml mvnw ./

COPY .mvn /build/.mvn

RUN ./mvnw -B dependency:go-offline

COPY . .

RUN ./mvnw clean install

FROM openjdk:latest

WORKDIR /app

COPY --from=build /build/target/spring-petclinic-rest-3.0.2.jar /app

EXPOSE 9966

CMD ["java", "-jar", "spring-petclinic-rest-3.0.2.jar"]
