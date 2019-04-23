FROM centos:latest

RUN yum -y update \
    && yum -y install \
       curl \
       ca-certificates \
       iputils \
       net-tools \
       java-1.8.0-openjdk \
       java-1.8.0-openjdk-devel \
       libaio \
    && yum -y clean all

ARG version
ARG url
ENV version ${version:-2.7.0}
ENV url ${url:-https://archive.apache.org/dist/activemq/activemq-artemis/${version}/apache-artemis-${version}-bin.tar.gz}

RUN groupadd -r artemis \
    && useradd -r -d /var/lib/artemis -m -g artemis artemis

WORKDIR /opt

RUN curl ${url} | tar xz \
    && mv /opt/apache-artemis-${version} /opt/artemis \
    && /opt/artemis/bin/artemis create /var/lib/artemis --name "Artemis cointainer" --user admin --password admin --allow-anonymous --http-host 0.0.0.0 --aio \
    && chown -R artemis.artemis /var/lib/artemis

EXPOSE 61616 5445 5672 1883 61613 8161
USER artemis:artemis
WORKDIR /var/lib/artemis
VOLUME /var/lib/artemis/etc /var/lib/artemis/data /var/lib/artemis/log

CMD ./bin/artemis run
