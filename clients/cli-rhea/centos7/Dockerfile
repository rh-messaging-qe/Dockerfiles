FROM centos:7

# Install nodejs
RUN curl --silent --location https://rpm.nodesource.com/setup_8.x | bash - &&\
    yum -y install nodejs

# Install cli-rhea as global lib
RUN npm install cli-rhea -g
ENV NODE_PATH /usr/lib/node_modules

CMD ["/bin/bash"]
