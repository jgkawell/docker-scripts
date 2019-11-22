# Build from 16.04 for ROS Kinetic
FROM nvidia/opengl:1.0-glvnd-runtime-ubuntu16.04
FROM osrf/ros:kinetic-desktop-full

# Install misc needed packages
RUN apt -y update && apt -y install git build-essential cmake tmux

# Install ROS (http://wiki.ros.org/kinetic/Installation/Ubuntu)
RUN echo "source /opt/ros/kinetic/setup.bash" >> ~/.bashrc

# Config file for easier tmux usage
COPY ./.tmux.conf ~/.tmux.conf

# Needed for hardware acceleration
COPY --from=nvidia/opengl:1.0-glvnd-runtime-ubuntu16.04 /usr/local /usr/local
COPY --from=nvidia/opengl:1.0-glvnd-runtime-ubuntu16.04 /etc/ld.so.conf.d/glvnd.conf /etc/ld.so.conf.d/glvnd.conf
ENV NVIDIA_VISIBLE_DEVICES=all NVIDIA_DRIVER_CAPABILITIES=all

# Clean up apt
RUN rm -rf /var/lib/apt/lists/*
