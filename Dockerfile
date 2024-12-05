FROM gradle:jdk17-corretto as build

WORKDIR /app

COPY ./src src/
COPY ./gradle gradle/
COPY build.gradle .
COPY gradlew .
COPY settings.gradle .

RUN ./gradlew build

FROM openjdk:17-jdk-slim

WORKDIR /app

COPY --from=build /app/build/libs/spring-boot-readonly-root-0.0.1-SNAPSHOT.jar .

# Create folders for tmp and logs and create a user
RUN adduser --disabled-password --gecos '' springuser && \
    mkdir -p /app/tmp /app/logs && \
    chown -R springuser:springuser /app

USER springuser

EXPOSE 8000/tcp

ENTRYPOINT ["java", "-Dserver.port=8000", "-Djava.io.tmpdir=/app/tmp", "-Dlogging.file.path=/app/logs", "-jar", "spring-boot-readonly-root-0.0.1-SNAPSHOT.jar"]
