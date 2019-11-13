# We must build off of Ubuntu 16.04 for ROS Kinetic
FROM osrf/ros:kinetic-desktop

# Config file for easier tmux usage
COPY ./.tmux.conf /root/.tmux.conf

# Volume needed for X-server GUI passing to OS
VOLUME "/tmp/.X11-unix:/tmp/.X11-unix"

# Install misc needed packages
RUN apt -y update && apt -y install git build-essential cmake tmux
RUN echo "source /opt/ros/kinetic/setup.bash" >> ~/.bashrc

# Install MoveIt! (https://moveit.ros.org/install/source/):
RUN apt -y update && apt -y install python-catkin-tools clang-format-3.9
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
RUN apt -y update && apt -y install pkg-config libboost-serialization-dev libboost-filesystem-dev libboost-system-dev libboost-program-options-dev libboost-test-dev libode-dev wget
RUN cd ~/ws_moveit/src \
        && git clone https://github.com/cairo-robotics/ompl.git \
        && cd ompl \
        && git checkout custom-cost

# Make some changes to build files so OMPL with be found by MoveIt!
RUN cd ~/ws_moveit \
        && sed -i "s|\${catkin_INCLUDE_DIRS}|\${OMPL_INCLUDE_DIRS} |g" ./src/moveit/moveit_planners/ompl/CMakeLists.txt \
        && sed -i "s|\${OMPL_INCLUDE_DIRS})|\${catkin_INCLUDE_DIRS}) |g" ./src/moveit/moveit_planners/ompl/CMakeLists.txt
RUN cd ~/ws_moveit/src/ompl \
        && wget https://raw.githubusercontent.com/ros-gbp/ompl-release/debian/kinetic/xenial/ompl/package.xml

# Install Intera SDK (https://sdk.rethinkrobotics.com/intera/Workstation_Setup)
RUN apt -y update && apt -y install git-core python-argparse python-vcstools python-rosdep ros-kinetic-control-msgs ros-kinetic-joystick-drivers ros-kinetic-xacro ros-kinetic-tf2-ros ros-kinetic-rviz ros-kinetic-cv-bridge ros-kinetic-actionlib ros-kinetic-actionlib-msgs ros-kinetic-dynamic-reconfigure ros-kinetic-trajectory-msgs ros-kinetic-rospy-message-converter
RUN cd ~/ws_moveit/src \
        && git clone https://github.com/RethinkRobotics/sawyer_robot.git \
        && wstool merge sawyer_robot/sawyer_robot.rosinstall \
        && wstool update

# Move and edit setup script
RUN cd ~/ws_moveit \
        && cp src/intera_sdk/intera.sh . \
        && sed -i "s|your_ip=\"192.168.XXX.XXX\"|\#your_ip= \"192.168.XXX.XXX\"|g" ./intera.sh \
        && sed -i "s|\#your_hostname=\"my_computer.local\"|your_hostname=\"localhost\"|g" ./intera.sh \
        && sed -i "s|ros_version=\"indigo\"|ros_version=\"kinetic\"|g" ./intera.sh

# Install Sawyer simulator (https://sdk.rethinkrobotics.com/intera/Gazebo_Tutorial)
RUN apt -y update && apt -y install gazebo7 ros-kinetic-qt-build ros-kinetic-gazebo-ros-control ros-kinetic-gazebo-ros-pkgs ros-kinetic-ros-control ros-kinetic-control-toolbox ros-kinetic-realtime-tools ros-kinetic-ros-controllers ros-kinetic-xacro python-wstool ros-kinetic-tf-conversions ros-kinetic-kdl-parser ros-kinetic-sns-ik-lib
RUN cd ~/ws_moveit/src \
        && git clone https://github.com/RethinkRobotics/sawyer_simulator.git \
        && wstool merge sawyer_simulator/sawyer_simulator.rosinstall \
        && wstool update

# Install Sawyer MoveIt (https://sdk.rethinkrobotics.com/intera/MoveIt_Tutorial)
RUN cd ~/ws_moveit/src \
        && wstool merge https://raw.githubusercontent.com/RethinkRobotics/sawyer_moveit/master/sawyer_moveit.rosinstall \
        && wstool update

# Add CustomObjective to OMPL in Sawyer MoveIt
RUN cd ~/ws_moveit/src/sawyer_moveit/sawyer_moveit_config/config \
        && sed -i "s|type: geometric::RRTstar|type: geometric::RRTstar\n    optimization_objective: CustomObjective|g" ./ompl_planning.yaml

# Clone the OMPL cost server demos
RUN cd  ~/ws_moveit/src \
        && git clone https://github.com/cairo-robotics/ompl_cost_server_demos.git \
        && catkin build

# Copy over config files
RUN mkdir ~/ws_moveit/config
COPY ./panda_demo.rviz ~/ws_moveit/config/panda_demo.rviz
COPY ./sawyer_moveit.rviz ~/ws_moveit/config/sawyer_moveit.rviz
COPY ./panda_pillar.scene ~/ws_moveit/config/panda_pillar.scene

# Cleanup apt
RUN rm -rf /var/lib/apt/lists/*
