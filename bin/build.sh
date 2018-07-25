#!/usr/bin/env bash

set -e

DOCKER_TAG=${DOCKER_TAG:-latest}
DEFAULT_TAG=$(git rev-parse --short HEAD) # Default tag = commit hash

echo "Build a image - ${IMAGE_REPO}:${DEFAULT_TAG}"
docker build --pull -t ${IMAGE_REPO}:${DEFAULT_TAG} .
docker tag ${IMAGE_REPO}:${DEFAULT_TAG} ${IMAGE_REPO}:${DOCKER_TAG}
