#!/bin/bash

# Help documentation
if [[ "${1}" == "-h" ]] || [[ "${1}" == "--help" ]]; then
    echo "Usage: bash launch.sh [options]"
    echo "  \$1: Docker repository name (x11/ros/ompl)"
    echo "  \$2: Docker repository tag prefix (base/sawyer/lfd)"
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
    echo "Setting up XAuth..."
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

# Pull down the image
echo "Attempting to pull from: jgkawell/${REPO}:${TAG}${HOST_TAG}"
docker pull jgkawell/${REPO}:${TAG}${HOST_TAG}

# Add non-network local connections to control list
xhost +local:root

# Bring up the container
echo "Using docker-compose file: ${REPO}/${SUB_DIR}${HOST}.docker-compose.yml"
docker-compose -f ../../${REPO}/${SUB_DIR}${HOST}.docker-compose.yml up

# Remove non-network local connections from control list
xhost -local:root
