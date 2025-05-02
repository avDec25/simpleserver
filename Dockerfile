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

# Run the application
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "simpleserver.jar"]