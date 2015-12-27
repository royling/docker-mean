#!/bin/bash

# Build image
# docker build -t royling/mean-dev -f /path/to/Dockerfile /path/to/contextDir

# Start mongodb
# TODO: data volume
MONGODB_CONTAINER_NAME=mongodb
docker run --name $MONGODB_CONTAINER_NAME -d -p 27017:27017 mongo:2

# Start mean-dev
# grunt task: `open` is not supported
COMMAND=npm install && bower install && grunt serve
docker run -it -p 9000:9000 -v $PWD:/workspace --link $MONGODB_CONTAINER_NAME royling/mean-dev $COMMAND

