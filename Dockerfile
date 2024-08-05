# Use an official OpenJDK runtime as a parent image
FROM openjdk:17-jdk-slim

# Set the working directory in the container
WORKDIR /app

# Copy the jar file to the container
COPY target/my-app-1.0-SNAPSHOT.jar /app/my-app.jar

# Expose the port that the app runs on
EXPOSE 8081

# Run the jar file
ENTRYPOINT ["java", "-jar", "/app/my-app.jar"]
