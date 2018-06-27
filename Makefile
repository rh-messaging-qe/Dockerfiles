.PHONY: all
all: all-centos all-rhel

.PHONY: all-centos
all-centos: sshd-service-centos6 sshd-service-centos7 cli-rhea-centos7

.PHONY: all-rhel
all-rhel: sshd-service-rhel6 sshd-service-centos7

.PHONY: all-alpine
all-centos: cli-rhea-alpine

.PHONY: all-ubuntu
all-ubuntu: qpid-dispatch-ubuntu

.PHONY: clients
clients: cli-rhea-centos7, cli-rhea-alpine

.PHONY: routers
routers: qpid-dispatch-ubuntu, qpid-dispatch-centos7

.PHONY: sshd-service
sshd-service: sshd-service-centos6 sshd-service-centos7

sshd-service-centos6:
	docker build -t rhmessagingqe/sshd-service:centos6 sshd-service/centos6

sshd-service-centos7:
	docker build -t rhmessagingqe/sshd-service:centos7 sshd-service/centos7

sshd-service-rhel6:
	docker build -t rhmessagingqe/sshd-service:rhel6 sshd-service/rhel6

sshd-service-rhel7:
	docker build -t rhmessagingqe/sshd-service:rhel7 sshd-service/rhel7

cli-rhea-centos7:
	docker build -t rhmessagingqe/cli-rhea:centos7 clients/cli-rhea/centos7

cli-rhea-alpine:
	docker build -t rhmessagingqe/cli-rhea:alpine clients/cli-rhea/alpine

cli-java-build:
	docker build -t cli-java-build clients/cli-java/_build
	docker run --name cli-java-build --rm -tid cli-java-build sh -c 'sleep 30'
	docker cp cli-java-build:/cli-qpid.jar clients/cli-java/cli-qpid.jar
	docker cp cli-java-build:/cli-artemis.jar clients/cli-java/cli-artemis.jar
	docker cp cli-java-build:/cli-paho.jar clients/cli-java/cli-paho.jar
	docker cp cli-java-build:/cli-activemq.jar clients/cli-java/cli-activemq.jar

cli-java-alpine: cli-java-build
	cp clients/cli-java/cli-*.jar clients/cli-java/alpine
	docker build -t rhmessagingqe/cli-java:alpine clients/cli-java/alpine
	rm clients/cli-java/alpine/cli-*.jar

qpid-dispatch-ubuntu:
	docker build -t rhmessagingqe/qpid-dispatch:ubuntu1804 routers/qdrouterd/ubuntu1804

qpid-dispatch-centos7:
	docker build -t rhmessagingqe/qpid-dispatch:centos7 routers/qdrouterd/centos7