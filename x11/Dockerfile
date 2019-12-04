### BASE STAGE ###

# Build from Ubuntu 16.04
FROM ubuntu:xenial AS base

# Install misc needed packages
RUN apt -y update && apt -y install git build-essential cmake tmux x11-apps

# Config file for easier tmux usage
COPY ./.tmux.conf ~/.tmux.conf

# Clean up apt
RUN rm -rf /var/lib/apt/lists/*


### NVIDIA STAGE ###

# Extra needed setup for Nvidia-based graphics
FROM base AS nvidia

# Copy over needed OpenGL files from Nvidia's image
COPY --from=nvidia/opengl:1.0-glvnd-runtime-ubuntu16.04 /usr/local /usr/local
COPY --from=nvidia/opengl:1.0-glvnd-runtime-ubuntu16.04 /etc/ld.so.conf.d/glvnd.conf /etc/ld.so.conf.d/glvnd.conf
