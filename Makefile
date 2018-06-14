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

qpid-dispatch-ubuntu:
	docker build -t rhmessagingqe/qpid-dispatch:ubuntu1804 routers/qdrouterd/ubuntu1804

qpid-dispatch-centos7:
	docker build -t rhmessagingqe/qpid-dispatch:centos7 routers/qdrouterd/centos7