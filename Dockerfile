FROM ubuntu:16.04
FROM openjdk:8
COPY $Workspace/target/spring-petclinic-2.1.0.BUILD-SNAPSHOT.jar /opt/spring-petclinic/spring-petclinic.jar
ENTRYPOINT java -jar /opt/spring-petclinic/spring-petclinic.jar
EXPOSE 8080
