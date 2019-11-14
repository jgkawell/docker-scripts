# Build from ros dev box
FROM jgkawell/ros-dev:latest

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
                chomp_motion_planner

# Install OMPL (http://ompl.kavrakilab.org/installation.html):
RUN apt -y install pkg-config libboost-serialization-dev libboost-filesystem-dev libboost-system-dev libboost-program-options-dev libboost-test-dev libode-dev wget
RUN cd ~/ws_moveit/src \
        && git clone https://github.com/cairo-robotics/ompl.git \
        && cd ompl \
        && git checkout tags/1.2.3

# Make some changes to build files so OMPL will be found by MoveIt!
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
