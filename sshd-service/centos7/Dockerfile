FROM centos/systemd

MAINTAINER "Dominik Lenoch" <dlenoch@redhat.com>

RUN yum update -y
RUN yum -y install openssh-server sudo openssh-clients &&\
    yum clean all &&\
    sed -i 's/#PermitRootLogin no/PermitRootLogin yes/' /etc/ssh/sshd_config &&\
    ssh-keygen -q -f /etc/ssh/ssh_host_rsa_key -N '' -t rsa &&\
    ssh-keygen -q -f /etc/ssh/ssh_host_ecdsa_key -N '' -t ecdsa &&\
    ssh-keygen -q -f /etc/ssh/ssh_host_ed25519_key -N '' -t ed25519 &&\
    echo 'root:docker.io' | chpasswd &&\
    systemctl enable sshd.service

VOLUME ["/sys/fs/cgroup"]
VOLUME ["/run"]

EXPOSE 22 5672 5673

CMD ["/usr/sbin/init"]
