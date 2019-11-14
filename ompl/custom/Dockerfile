# Build from basic ompl dev box
FROM jgkawell/ompl:basic

# Setup OMPL with custom code:
RUN cd ~/ws_moveit/src/ompl && git checkout custom-cost
COPY ./package.xml ~/ws_moveit/src/ompl/

# Setup Intera SDK (https://sdk.rethinkrobotics.com/intera/Workstation_Setup)
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

# Setup Sawyer simulator (https://sdk.rethinkrobotics.com/intera/Gazebo_Tutorial)
RUN apt -y update && apt -y install gazebo7 ros-kinetic-qt-build ros-kinetic-gazebo-ros-control ros-kinetic-gazebo-ros-pkgs ros-kinetic-ros-control ros-kinetic-control-toolbox ros-kinetic-realtime-tools ros-kinetic-ros-controllers ros-kinetic-xacro python-wstool ros-kinetic-tf-conversions ros-kinetic-kdl-parser ros-kinetic-sns-ik-lib
RUN cd ~/ws_moveit/src \
        && git clone https://github.com/RethinkRobotics/sawyer_simulator.git \
        && wstool merge sawyer_simulator/sawyer_simulator.rosinstall \
        && wstool update

# Setup Sawyer MoveIt (https://sdk.rethinkrobotics.com/intera/MoveIt_Tutorial)
RUN cd ~/ws_moveit/src \
        && wstool merge https://raw.githubusercontent.com/RethinkRobotics/sawyer_moveit/master/sawyer_moveit.rosinstall \
        && wstool update

# Add CustomObjective to OMPL in Sawyer MoveIt
RUN cd ~/ws_moveit/src/sawyer_moveit/sawyer_moveit_config/config \
        && sed -i "s|type: geometric::RRTstar|type: geometric::RRTstar\n    optimization_objective: CustomObjective|g" ./ompl_planning.yaml

# Clone the OMPL cost server demos
RUN cd  ~/ws_moveit/src \
        && git clone https://github.com/cairo-robotics/ompl_cost_server_demos.git

# Finally build the workspace
RUN catkin build

# Copy over config files
RUN mkdir ~/ws_moveit/config
COPY ./panda_demo.rviz ~/ws_moveit/config/panda_demo.rviz
COPY ./sawyer_moveit.rviz ~/ws_moveit/config/sawyer_moveit.rviz
COPY ./panda_pillar.scene ~/ws_moveit/config/panda_pillar.scene
