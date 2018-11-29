FROM maven:alpine

# Install cli-rhea as global lib
RUN apk add git --no-cache && \
    mkdir /main && cd /main && \
    git clone https://github.com/rh-messaging/cli-java && \
    cd cli-java && \
    mvn package -DskipTests=true && \
    cp cli-qpid-jms/target/cli-qpid-jms-*-LATEST.jar /cli-qpid.jar && \
    cp cli-artemis-jms/target/cli-artemis-jms-*.jar /cli-artemis.jar && \
    cp cli-paho-java/target/cli-paho-java-*.jar /cli-paho.jar && \
    cp cli-activemq/target/cli-activemq-*.jar /cli-activemq.jar && \
    && echo "cli-java:("$(git rev-list --count HEAD).$(git rev-parse --short HEAD)")" >> /VERSION.txt
