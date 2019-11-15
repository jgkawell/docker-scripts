# Build from ros dev box
FROM jgkawell/ros-dev:latest

# Install MoveIt! (https://moveit.ros.org/install/source/):
RUN apt -y update && apt -y install python-catkin-tools clang-format-3.9
RUN cd ~/ \
        && mkdir ws_moveit \
        && cd ws_moveit \
        && wstool init src \
        && wstool merge -t src https://raw.githubusercontent.com/cairo-robotics/moveit/custom-cost/moveit.rosinstall \
        && wstool update -t src \
        && rosdep -y install --from-paths src --ignore-src --rosdistro kinetic \
        && catkin config --extend /opt/ros/kinetic --cmake-args -DCMAKE_BUILD_TYPE=Release \
        && catkin config --blacklist \
                moveit_chomp_optimizer_adapter \
                moveit_planners_chomp \
                chomp_motion_planner

# Install OMPL (http://ompl.kavrakilab.org/installation.html):
RUN apt -y update && apt -y install pkg-config libboost-serialization-dev libboost-filesystem-dev libboost-system-dev libboost-program-options-dev libboost-test-dev libode-dev wget
RUN cd  ~/ws_moveit/src \
        && git clone https://github.com/cairo-robotics/ompl.git \
        && cd ompl \
        && git checkout custom-cost

# Setup Intera SDK (https://sdk.rethinkrobotics.com/intera/Workstation_Setup)
RUN apt -y update && apt -y install git-core python-argparse python-vcstools python-rosdep ros-kinetic-control-msgs ros-kinetic-joystick-drivers ros-kinetic-xacro ros-kinetic-tf2-ros ros-kinetic-rviz ros-kinetic-cv-bridge ros-kinetic-actionlib ros-kinetic-actionlib-msgs ros-kinetic-dynamic-reconfigure ros-kinetic-trajectory-msgs ros-kinetic-rospy-message-converter
RUN cd ~/ws_moveit/src \
        && git clone https://github.com/RethinkRobotics/sawyer_robot.git \
        && wstool merge sawyer_robot/sawyer_robot.rosinstall \
        && wstool update

# Move and edit setup script for local sims
RUN cd ~/ws_moveit \
        && cp src/intera_sdk/intera.sh . \
        && sed -i "s|your_ip=\"192.168.XXX.XXX\"|\#your_ip= \"192.168.XXX.XXX\"|g" ./intera.sh \
        && sed -i "s|\#your_hostname=\"my_computer.local\"|your_hostname=\"localhost\"|g" ./intera.sh \
        && sed -i "s|ros_version=\"indigo\"|ros_version=\"kinetic\"|g" ./intera.sh

# Setup Sawyer simulator (https://sdk.rethinkrobotics.com/intera/Gazebo_Tutorial)
RUN apt -y update && apt -y install gazebo7 ros-kinetic-qt-build ros-kinetic-gazebo-ros-control ros-kinetic-gazebo-ros-pkgs ros-kinetic-ros-control ros-kinetic-control-toolbox ros-kinetic-realtime-tools ros-kinetic-ros-controllers ros-kinetic-xacro python-wstool ros-kinetic-tf-conversions ros-kinetic-kdl-parser ros-kinetic-sns-ik-lib
RUN cd ~/ws_moveit/src \
        && git clone https://github.com/RethinkRobotics/sawyer_simulator.git \
        && wstool merge sawyer_simulator/sawyer_simulator.rosinstall \
        && wstool update

# Install Sawyer MoveIt!
RUN cd ~/ws_moveit/src \
        && git clone https://github.com/cairo-robotics/sawyer_moveit.git \
        && cd sawyer_moveit \
        && git checkout custom-cost \
        && cd .. \
        && wstool merge sawyer_moveit/sawyer_moveit.rosinstall \
        && wstool update

# Clone the OMPL cost server demos
RUN cd  ~/ws_moveit/src \
        && git clone https://github.com/cairo-robotics/ompl_cost_server_demos.git

RUN echo "Rebuild from here"

# Copy in package.xml into OMPL for ROS building
COPY ./custom/package.xml /root/ws_moveit/src/ompl/package.xml

# Finally install MoveIt! with our source OMPL
RUN cd ~/ws_moveit && catkin build

# Copy over config files
RUN cd ~/ws_moveit && mkdir config
COPY ./custom/sawyer_moveit.rviz /root/ws_moveit/config/sawyer_moveit.rviz
COPY ./panda_demo.rviz /root/ws_moveit/config/panda_demo.rviz
COPY ./pillar.scene /root/ws_moveit/config/pillar.scene

# Source the workspace with each new terminal
RUN echo "source ~/ws_moveit/devel/setup.bash" >> ~/.bashrc

# Clean up apt
RUN rm -rf /var/lib/apt/lists/*
