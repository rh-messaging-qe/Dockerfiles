#
# Licensed to the Apache Software Foundation (ASF) under one
# or more contributor license agreements.  See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership.  The ASF licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License.  You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations
# under the License.
#

#
# Apache ActiveMQ Artemis image that downloads AMQ, creates
# a new instance, then defines two custom addresses and prepares
# the it to work on a basic HA scenario. The produced image can
# be a Master or a Slave (backup) instance.
#
# To build the image:
#   docker build --tag <user>/<image_name>:<tag> -f Dockerfile-activemq-artemis .
#
#

# Gets the latest Fedora from dockerhub
FROM fedora:30

LABEL maintainer=fgiorgetti@gmail.com

# Custom variables
ARG artemis_version
ARG instance_name
ARG admin_user
ARG admin_pass
ARG url_base
ENV artemis_version ${artemis_version:-2.10.0}
ENV instance_name ${instance_name:-broker1}
ENV admin_user ${admin_user:-admin}
ENV admin_pass ${admin_pass:-admin}
ENV url_base ${url_base:-https://archive.apache.org/dist/activemq/activemq-artemis/${artemis_version}}

RUN dnf -y install \
    ca-certificates \
    java-1.8.0-openjdk \
    java-1.8.0-openjdk-devel \
    libaio \
    wget \
    iputils \
    net-tools \
    && dnf clean all -y

# Creates a directory for extracting tar ball and creating broker instance
WORKDIR /opt

# Downloads binaries for ActiveMQ Artemis, creates and configure a new instance
RUN wget ${url_base}/apache-artemis-${artemis_version}-bin.tar.gz \
    && tar -zxvf apache-artemis-${artemis_version}-bin.tar.gz \
    && mv apache-artemis-${artemis_version} apache-artemis \
    && cd apache-artemis \
    && bin/artemis create /opt/${instance_name} --user ${admin_user} --password ${admin_pass} --allow-anonymous --http-host 0.0.0.0 --nio

# exposing broker ports
#
EXPOSE 61616 8161

# Starts the new broker instance
CMD /opt/$instance_name/bin/artemis run

