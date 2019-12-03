# Build from Ubuntu 16.04
FROM ubuntu:xenial

# Install misc needed packages
RUN apt -y update && apt -y install git build-essential cmake tmux x11-apps

# Config file for easier tmux usage
COPY ./.tmux.conf ~/.tmux.conf

# Clean up apt
RUN rm -rf /var/lib/apt/lists/*
