FROM openjdk:alpine

COPY ./cli-qpid.jar /cli-qpid.jar
COPY ./cli-artemis.jar /cli-artemis.jar
COPY ./cli-paho.jar /cli-paho.jar
COPY ./cli-activemq.jar /cli-activemq.jar

RUN addgroup -S cli-java && adduser -h /var/lib/cli-java -s /bin/ash -S cli-java -G cli-java 
VOLUME /var/lib/cli-java
USER cli-java:cli-java

# Entrypoint for shell 
CMD ["/bin/ash"]