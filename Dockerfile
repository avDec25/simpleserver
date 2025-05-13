# Build stage
FROM maven:3.9.9-amazoncorretto-17 AS builder
WORKDIR /simpleserver

# Copy the Maven file to leverage caching
COPY pom.xml .

# Download dependencies (this layer can be cached if dependencies don't change)
RUN mvn dependency:go-offline -B

# Copy the source code
COPY src ./src

# Build the application
RUN mvn package -DskipTests

# Runtime stage
FROM amazoncorretto:17
WORKDIR /simpleserver

# Copy the jar from the build stage
COPY --from=builder /simpleserver/target/*.jar simpleserver.jar

# Copy JMX exporter and config
COPY jmx_prometheus_javaagent.jar /opt/jmx_exporter/
COPY jmx_config.yml /opt/jmx_exporter/

EXPOSE 8080
EXPOSE 9090

# Run the application
ENTRYPOINT [ \
        "java", \
        "-javaagent:/opt/jmx_exporter/jmx_prometheus_javaagent.jar=9090:/opt/jmx_exporter/jmx_config.yml", \
        "-Duser.timezone=Asia/Tokyo", \
        "-jar", \
        "simpleserver.jar" \
    ]
