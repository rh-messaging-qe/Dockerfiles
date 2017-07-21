FROM rhmessagingqe/sshd-service:centos7

MAINTAINER "Dominik Lenoch" <dlenoch@redhat.com>

# Install nodejs
RUN curl --silent --location https://rpm.nodesource.com/setup_6.x | bash - &&\
    yum -y install nodejs

# Install cli-rhea as global lib
RUN npm install cli-rhea -g
ENV NODE_PATH /usr/lib/node_modules

EXPOSE 22

CMD ["/sbin/init"]
