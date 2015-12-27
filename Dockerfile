FROM node:argon
MAINTAINER Roy Ling<royling0024@gmail.com>

LABEL Description="Used to set up dev environment of MEAN stack"

RUN npm install -g grunt-cli bower yo
RUN npm install -g generator-angular-fullstack

WORKDIR /workspace

RUN useradd -ms /bin/bash docker

# yo & bower are not allowed to run as a root
USER docker

