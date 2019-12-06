FROM maven:alpine

# Install cli-rhea as global lib
RUN apk add git --no-cache && \
    mkdir /main && cd /main && \
    git clone https://github.com/rh-messaging/cli-java --depth 1  && \
    cd cli-java && \
    mvn package -DskipTests=true && \
    # I'd like to make a dinner reservation for 12
    mvn dependency:purge-local-repository -DactTransitively=false -DreResolve=false && \
    rm -rf ~/.m2 && \
    cp /main/cli-java/cli-qpid-jms/target/cli-qpid-jms-*[0-9].jar /cli-qpid.jar && \
    cp /main/cli-java/cli-artemis-jms/target/cli-artemis-jms-*[0-9].jar /cli-artemis.jar && \
    cp /main/cli-java/cli-paho-java/target/cli-paho-java-*[0-9].jar /cli-paho.jar && \
    cp /main/cli-java/cli-activemq/target/cli-activemq-*[0-9].jar /cli-activemq.jar && \
    echo "cli-java:("$(git rev-list --count HEAD).$(git rev-parse --short HEAD)")" >> /VERSION.txt && \
    echo "package info:("$(ls cli-*/target/cli-*.jar)")" >> /VERSION.txt
