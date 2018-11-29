FROM openjdk:stretch

WORKDIR /main
COPY clients ./
COPY bin /usr/local/bin

RUN \
    chmod 0755 /main/* && \
    chmod +x /usr/local/bin/cli-*
RUN addgroup cli-java && useradd -d /var/lib/cli-java -ms /bin/bash -g cli-java -G cli-java cli-java
USER cli-java:cli-java
VOLUME /var/lib/cli-java
WORKDIR /var/lib/cli-java

CMD ["/bin/bash"]