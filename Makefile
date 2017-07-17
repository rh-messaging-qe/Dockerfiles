.PHONY: all
all: sshd-service

.PHONY: sshd-service
sshd-service: sshd-service-centos6 sshd-service-centos7

sshd-service-centos6:

sshd-service-centos7:

clean:
  rm -rf build || true
