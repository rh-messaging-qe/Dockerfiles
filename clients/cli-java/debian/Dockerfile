FROM openjdk:stretch

WORKDIR /main
COPY clients ./
COPY bin /usr/local/bin
WORKDIR /var/lib/cli-java
RUN \
    chmod 0755 /main/* && \
    chmod +x /usr/local/bin/cli-* && \
    mkdir certs
RUN addgroup -S cli-java && adduser -h /var/lib/cli-java -s /bin/ash -S cli-java -G cli-java
VOLUME /var/lib/cli-java
USER cli-java:cli-java
VOLUME /var/lib/cli-java

CMD ["bash"]