# Build from 16.04 for ROS Kinetic
FROM nvidia/opengl:1.0-glvnd-runtime-ubuntu16.04

# Install misc needed packages
RUN apt -y update && apt -y install git build-essential cmake tmux

# Install ROS (http://wiki.ros.org/kinetic/Installation/Ubuntu)
RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu xenial main" > /etc/apt/sources.list.d/ros-latest.list' \
    && apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654 \
    && apt -y update && apt -y install ros-kinetic-desktop-full \
    && rosdep init && rosdep update \
    && echo "source /opt/ros/kinetic/setup.bash" >> ~/.bashrc

# Install needed dependencies for building packages
RUN apt -y update && apt -y install python-rosinstall python-rosinstall-generator python-wstool

# Config file for easier tmux usage
COPY ./.tmux.conf ~/.tmux.conf

# Needed for hardware acceleration
COPY --from=nvidia/opengl:1.0-glvnd-runtime-ubuntu16.04 /usr/local /usr/local
COPY --from=nvidia/opengl:1.0-glvnd-runtime-ubuntu16.04 /etc/ld.so.conf.d/glvnd.conf /etc/ld.so.conf.d/glvnd.conf
ENV NVIDIA_VISIBLE_DEVICES=all NVIDIA_DRIVER_CAPABILITIES=all

# Clean up apt
RUN rm -rf /var/lib/apt/lists/*
