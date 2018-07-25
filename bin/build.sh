#!/usr/bin/env bash

set -e

DOCKER_TAG=${DOCKER_TAG:-`git rev-parse --short HEAD`} # default = commit hash
DOCKER_TAG_DEFAULT=latest

echo "Build a image - ${IMAGE_REPO}:${DOCKER_TAG_DEFAULT}"
docker build --pull -t ${IMAGE_REPO}:${DOCKER_TAG_DEFAULT} .
docker tag ${IMAGE_REPO}:${DOCKER_TAG_DEFAULT} ${IMAGE_REPO}:${DOCKER_TAG}
