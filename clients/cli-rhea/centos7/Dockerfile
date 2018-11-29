FROM centos:7

# Install nodejs	
RUN curl --silent --location https://rpm.nodesource.com/setup_8.x | bash - &&\	
    yum -y install nodejs

# Install cli-rhea as global lib
RUN npm install cli-rhea -g
ENV NODE_PATH /usr/lib/node_modules

RUN groupadd -r cli-rhea && \
    useradd -r -d /var/lib/cli-rhea -m -g cli-rhea cli-rhea && \
    chown -R cli-rhea.cli-rhea /var/lib/cli-rhea

USER cli-rhea:cli-rhea
VOLUME /var/lib/cli-rhea
WORKDIR /var/lib/cli-rhea

CMD ["/bin/bash"]
