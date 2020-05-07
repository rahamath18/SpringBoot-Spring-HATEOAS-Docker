FROM java:8
ARG JAR_FILE=target/SpringBoot-Spring-HATEOAS-Docker-1.0-PROD.jar
WORKDIR d:/opt/app
EXPOSE 8001 3306
COPY ${JAR_FILE} app.jar
ENTRYPOINT ["java","-jar","app.jar"]