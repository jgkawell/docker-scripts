#!/bin/bash

# Help documentation
if [[ "${1}" == "-h" ]] || [[ "${1}" == "--help" ]]; then
    echo "Usage: bash launch.sh [options]"
    echo "  \$1: Docker repository name"
    echo "  \$2: Docker repository tag"
    echo "  \$3: Docker host type (windows/intel/nvidia)"
    exit
fi

# Set globals
REPO=$1
TAG=$2
HOST=$3

# Add the host tag and setup XAuth if it's Nvidia
if [[ "${HOST}" == "nvidia" ]]; then
    HOST_TAG='-nvidia'
    source setup_xauth.sh
else
    HOST_TAG=''
fi

# For the OMPL repository, mark the subdirectory
if [[ "${REPO}" == "ompl" ]]; then
    if [[ "${TAG}" == "base" ]]; then
        SUB_DIR=''
    elif [[ "${TAG}" == "sawyer" ]]; then
        SUB_DIR='sawyer/'
    elif [[ "${TAG}" == "lfd" ]]; then
        SUB_DIR='lfd/'
    fi
fi

# Make sure not to accidentally overwrite local images/containers
if [[ "$(docker images -q jgkawell/${REPO}:${TAG}${HOST_TAG} 2> /dev/null)" == "" ]]; then
    # Pull down the image
    echo "The image does not exist. Pulling from Docker Hub."
    docker pull jgkawell/${REPO}:${TAG}${HOST_TAG}
else
    # Don't pull if local image already exists
    echo "The image already exists locally. Not pulling."
fi

# Add non-network local connections to control list
xhost +local:root

export IMAGE="jgkawell/${REPO}:${TAG}${HOST_TAG}"
export CONTAINER="${REPO}-${TAG}${HOST_TAG}"

# Bring up the container
docker-compose -f ./${HOST}.docker-compose.yml up

# Remove non-network local connections from control list
xhost -local:root
