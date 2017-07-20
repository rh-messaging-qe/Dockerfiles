FROM registry.access.redhat.com/rhel6

MAINTAINER "Dominik Lenoch" <dlenoch@redhat.com>

RUN yum -y update; yum clean all
RUN yum -y install initscripts; yum clean all; rm /etc/rc.d/rc*.d/*

# Disable ttys
RUN rm /etc/init/serial.conf\
       /etc/init/tty.conf\
       /etc/init/start-ttys.conf

RUN yum -y install openssh-server openssh-clients &&\
    yum clean all &&\
    sed -i 's/#PermitRootLogin no/PermitRootLogin yes/' /etc/ssh/sshd_config &&\
    ssh-keygen -q -f /etc/ssh/ssh_host_rsa_key -N '' -t rsa &&\
    ssh-keygen -q -f /etc/ssh/ssh_host_ecdsa_key -N '' -t ecdsa &&\
    echo 'root:docker.io' | chpasswd &&\
    /etc/init.d/sshd start

EXPOSE 22

CMD ["/sbin/init"]
