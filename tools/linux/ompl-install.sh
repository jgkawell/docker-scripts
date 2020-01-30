# Install MoveIt! (https://moveit.ros.org/install/source/):
rosdep update
sudo apt -y install python-catkin-tools clang-format-3.9
cd ~/
mkdir catkin_ws
cd catkin_ws
wstool init src
wstool merge -t src https://raw.githubusercontent.com/cairo-robotics/moveit/custom-cost-kinetic/moveit.rosinstall
wstool update -t src
rosdep -y install --from-paths src --ignore-src --rosdistro kinetic
catkin config --extend /opt/ros/kinetic --cmake-args -DCMAKE_BUILD_TYPE=Release
catkin config --blacklist \
    moveit_chomp_optimizer_adapter \
    moveit_planners_chomp \
    chomp_motion_planner


# Install OMPL (http://ompl.kavrakilab.org/installation.html):
sudo apt -y install pkg-config libboost-serialization-dev libboost-filesystem-dev libboost-system-dev libboost-program-options-dev libboost-test-dev libode-dev
cd ~/catkin_ws/src
git clone https://github.com/cairo-robotics/ompl.git
cd ompl
git checkout custom-cost

# Copy over files
mkdir ~/catkin_ws/config
cp ../../ompl/config/panda_demo.rviz ~/catkin_ws/config/panda_demo.rviz
cp ../../ompl/config/pillar.scene ~/catkin_ws/config/pillar.scene
cp ../../ompl/config/package.xml ~/catkin_ws/src/ompl/package.xml

# Source and build
cd ~/catkin_ws
sudo catkin build

echo "source ~/catkin_ws/devel/setup.bash" >> ~/.bashrc