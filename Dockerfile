FROM java
ADD target/gs-spring-boot-0.1.0.jar //
//Expose 8080
ENTRYPOINT ["java", "-jar", "/gs-spring-boot-0.1.0.jar"]
