# We must build off of Ubuntu 16.04 for ROS Kinetic
FROM ubuntu:xenial

# Setup variables for passing GUI to host OS
ENV DISPLAY ${DISPLAY}:0.0
ENV QT_GRAPHICSSYSTEM native
ENV CONTAINER_NAME ros-kinetic-dev

# Config file for easier tmux usage
COPY ./.tmux.conf /root/.tmux.conf

# Volume needed for X-server GUI passing to OS
VOLUME "/tmp/.X11-unix:/tmp/.X11-unix"

# Install misc needed packages
# Check to see if in Docker or normal Linux
RUN apt -y update
RUN apt -y upgrade
RUN apt -y install git build-essential cmake tmux
RUN mkdir -p ~/Documents/Software

# Install libccd (https://github.com/danfis/libccd):
RUN apt -y install m4
RUN cd ~/Documents/Software \
        && git clone https://github.com/danfis/libccd.git \
        && cd libccd \
        && mkdir build \
        && cd build \
        && cmake -G "Unix Makefiles" -DBUILD_SHARED_LIBS=ON .. \
        && make -j `nproc` \
        && make install

# Install OctoMap (https://github.com/OctoMap/octomap/wiki/Compilation-and-Installation-of-OctoMap):
RUN apt -y install doxygen libqt4-dev libqt4-opengl-dev libqglviewer-dev-qt4
RUN cd ~/Documents/Software \
        && git clone https://github.com/OctoMap/octomap.git \
        && cd octomap \
        && mkdir build \
        && cd build \
        && cmake .. \
        && make -j `nproc` \
        && make test \
        && make install

# Install FCL (https://github.com/flexible-collision-library/fcl):
RUN apt -y install libeigen3-dev
RUN cd ~/Documents/Software \
        && git clone https://github.com/jgkawell/fcl.git \
        && cd fcl \
        && mkdir build \
        && cd build \
        && cmake .. \
        && make -j `nproc` \
        && make install

# Install OMPL (http://ompl.kavrakilab.org/installation.html):
RUN apt -y install pkg-config libboost-serialization-dev libboost-filesystem-dev libboost-system-dev libboost-program-options-dev libboost-test-dev libode-dev
RUN export CXX=g++
RUN cd ~/Documents/Software \
        && git clone https://github.com/ompl/ompl.git \
        && cd ompl \
        && mkdir -p build/Release \
        && cd build/Release \
        && cmake ../.. \
        && make -j `nproc` \
        && make install

# Install ROS (https://ros.org/install):
RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu xenial main" > /etc/apt/sources.list.d/ros-latest.list'
RUN apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654
RUN apt -y update && apt -y install ros-kinetic-desktop-full
RUN rosdep init && rosdep update
RUN echo "source /opt/ros/kinetic/setup.bash" >> ~/.bashrc
RUN apt -y install python-rosinstall python-rosinstall-generator python-wstool

# Install MoveIt! (https://moveit.ros.org/install/source/):
RUN rosdep update && apt -y update && apt dist-upgrade
RUN apt -y install python-catkin-tools clang-format-3.9
RUN apt -y install ccache
RUN ccache --max-size=10
RUN echo 'export PATH=/usr/lib/ccache:$PATH' >> $HOME/.bashrc
RUN source $HOME/.bashrc
RUN cd ~/Documents/Software \
        && mkdir ws_moveit \
        && cd ws_moveit \
        && source /opt/ros/kinetic/setup.bash \
        && wstool init src \
        && wstool merge -t src https://raw.githubusercontent.com/ros-planning/moveit/master/moveit.rosinstall \
        && wstool update -t src \
        && rosdep -y install --from-paths src --ignore-src --rosdistro ${ROS_DISTRO} \
        && catkin config --extend /opt/ros/${ROS_DISTRO} --cmake-args -DCMAKE_BUILD_TYPE=Release \
        && catkin config --blacklist \
                moveit_chomp_optimizer_adapter \
                moveit_planners_chomp \
                chomp_motion_planner \
        && catkin build

# Remake OMPL to replace the one in MoveIt!:
RUN cd ~/Documents/Software/ompl \
        && rm -r build/ \
        && mkdir -p build/Release \
        && cd build/Release/ \
        && cmake -DCMAKE_INSTALL_PREFIX=/opt/ros/kinetic ../.. \
        && make -j `nproc` \
        && make install
