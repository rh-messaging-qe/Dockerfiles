FROM openjdk:alpine

WORKDIR /main
COPY clients ./
COPY bin /usr/local/bin

RUN \
    chmod 0755 /main/* && \
    chmod +x /usr/local/bin/cli-*
RUN addgroup -S cli-java && adduser -h /var/lib/cli-java -s /bin/ash -S cli-java -G cli-java
USER cli-java:cli-java
VOLUME /var/lib/cli-java
WORKDIR /var/lib/cli-java

CMD ["/bin/ash"]