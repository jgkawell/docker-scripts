FROM ubuntu:xenial

COPY ./.tmux.conf /root/.tmux.conf

VOLUME "/tmp/.X11-unix:/tmp/.X11-unix"

RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu xenial main" > /etc/apt/sources.list.d/ros-latest.list'
RUN apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654
RUN apt update -y
RUN apt install -y tmux ros-kinetic-desktop-full
RUN rosdep init && rosdep update
RUN echo "source /opt/ros/kinetic/setup.bash" >> ~/.bashrc
