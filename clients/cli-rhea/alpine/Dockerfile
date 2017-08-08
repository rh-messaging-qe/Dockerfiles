FROM node:alpine

MAINTAINER "Dominik Lenoch" <dlenoch@redhat.com>

# Install cli-rhea as global lib
RUN npm install cli-rhea -g
ENV NODE_PATH /usr/lib/node_modules

# Entrypoint for shell 
ENTRYPOINT ["/bin/ash"]
