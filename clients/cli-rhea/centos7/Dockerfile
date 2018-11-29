FROM centos:nodejs-8-centos7

# Install cli-rhea as global lib
RUN npm install cli-rhea -g
ENV NODE_PATH /usr/lib/node_modules

RUN addgroup -S cli-rhea && adduser -h /var/lib/cli-rhea -s /bin/ash -S cli-rhea -G cli-rhea
USER cli-rhea:cli-rhea
VOLUME /var/lib/cli-rhea
WORKDIR /var/lib/cli-rhea

CMD ["/bin/bash"]
