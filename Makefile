.PHONY: all
all: all-centos all-rhel

.PHONY: all-centos
all-centos: sshd-service-centos6 sshd-service-centos7

.PHONY: all-rhel
all-rhel: sshd-service-rhel6 sshd-service-centos7

.PHONY: sshd-service
sshd-service: sshd-service-centos6 sshd-service-centos7

sshd-service-centos6:
	docker build -t local/sshd-service-centos7 sshd-service/centos6

sshd-service-centos7:
	docker build -t local/sshd-service-centos7 sshd-service/centos7

sshd-service-rhel6:
	docker build -t local/sshd-service-centos7 sshd-service/rhel6

sshd-service-rhel7:
	docker build -t local/sshd-service-centos7 sshd-service/rhel7

clean:
  rm -rf build || true
