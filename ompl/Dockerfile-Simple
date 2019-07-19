# We must build off of Ubuntu 16.04 for ROS Kinetic
FROM ubuntu:xenial

# Config file for easier tmux usage
COPY ./.tmux.conf /root/.tmux.conf

# Volume needed for X-server GUI passing to OS
VOLUME "/tmp/.X11-unix:/tmp/.X11-unix"

# Install misc needed packages
RUN apt -y update
RUN apt -y upgrade
RUN apt -y install git build-essential cmake tmux

# Install libccd (https://github.com/danfis/libccd):
RUN apt -y install m4
RUN cd ~/ \
        && git clone https://github.com/danfis/libccd.git \
        && cd libccd \
        && git checkout tags/v2.1 \
        && mkdir build \
        && cd build \
        && cmake -G "Unix Makefiles" -DBUILD_SHARED_LIBS=ON .. \
        && make -j `nproc` \
        && make install

# Install OctoMap (https://github.com/OctoMap/octomap/wiki/Compilation-and-Installation-of-OctoMap):
RUN apt -y install doxygen libqt4-dev libqt4-opengl-dev libqglviewer-dev-qt4
RUN cd ~/ \
        && git clone https://github.com/OctoMap/octomap.git \
        && cd octomap \
        && git checkout tags/v1.9.0 \
        && mkdir build \
        && cd build \
        && cmake .. \
        && make -j `nproc` \
        && make test \
        && make install

# Install FCL (https://github.com/flexible-collision-library/fcl):
RUN apt -y install libeigen3-dev
RUN cd ~/ \
        && git clone https://github.com/jgkawell/fcl.git \
        && cd fcl \
        && mkdir build \
        && cd build \
        && cmake .. \
        && make -j `nproc` \
        && make install

# Install ROS (https://ros.org/install):
RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu xenial main" > /etc/apt/sources.list.d/ros-latest.list'
RUN apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654
RUN apt -y update
RUN apt -y install ros-kinetic-desktop
RUN rosdep init && rosdep update
RUN echo "source /opt/ros/kinetic/setup.bash" >> ~/.bashrc
RUN apt -y install python-rosinstall python-rosinstall-generator python-wstool

# Install MoveIt! (https://moveit.ros.org/install/source/):
RUN apt -y install python-catkin-tools clang-format-3.9
RUN cd ~/ \
        && mkdir ws_moveit \
        && cd ws_moveit \
        && wstool init src \
        && wstool merge -t src https://raw.githubusercontent.com/ros-planning/moveit/master/moveit.rosinstall \
        && wstool update -t src \
        && rosdep -y install --from-paths src --ignore-src --rosdistro kinetic \
        && catkin config --extend /opt/ros/kinetic --cmake-args -DCMAKE_BUILD_TYPE=Release \
        && catkin config --blacklist \
                moveit_chomp_optimizer_adapter \
                moveit_planners_chomp \
                chomp_motion_planner \
        && catkin build

# Install OMPL (http://ompl.kavrakilab.org/installation.html):
RUN apt -y install pkg-config libboost-serialization-dev libboost-filesystem-dev libboost-system-dev libboost-program-options-dev libboost-test-dev libode-dev wget
RUN cd ~/ws_moveit/src \
        && git clone https://github.com/cairo-robotics/ompl.git \
        && cd ompl \
        && git checkout tags/1.2.3

# Make some changes to build files so OMPL with be found by MoveIt!
RUN cd ~/ws_moveit \
        && sed -i "s|DESTINATION \${CMAKE_INSTALL_LIBDIR}|DESTINATION /opt/ros/kinetic/lib/x86_64-linux-gnu |g" ./src/ompl/src/ompl/CMakeLists.txt \
        && sed -i "s|\${catkin_INCLUDE_DIRS}|\${OMPL_INCLUDE_DIRS} |g" ./src/moveit/moveit_planners/ompl/CMakeLists.txt \
        && sed -i "s|\${OMPL_INCLUDE_DIRS})|\${catkin_INCLUDE_DIRS}) |g" ./src/moveit/moveit_planners/ompl/CMakeLists.txt
RUN cd ~/ws_moveit/src/ompl \
        && wget https://raw.githubusercontent.com/ros-gbp/ompl-release/debian/kinetic/xenial/ompl/package.xml

# Finally install MoveIt! with our source OMPL
RUN cd ~/ws_moveit \
        && catkin clean -y \
        && catkin build
