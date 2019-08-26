FROM openjdk:8
COPY target/spring-petclinic-2.1.0.BUILD-SNAPSHOT.jar /opt/spring-petclinic/spring-petclinic.jar
ENTRYPOINT java -jar /opt/spring-petclinic/spring-petclinic.jar
EXPOSE 8080
