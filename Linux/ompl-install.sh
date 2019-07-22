# Install misc needed packages
sudo apt -y update
sudo apt -y upgrade
sudo apt -y install git build-essential cmake wget

# Install ROS (https://ros.org/install):
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu xenial main" > /etc/apt/sources.list.d/ros-latest.list'
sudo apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654
sudo apt -y update
sudo apt -y install ros-kinetic-desktop
sudo rosdep init && rosdep update
echo "source /opt/ros/kinetic/setup.bash" >> ~/.bashrc
sudo apt -y install python-rosinstall python-rosinstall-generator python-wstool

# Install MoveIt! (https://moveit.ros.org/install/source/):
rosdep update
sudo apt -y install python-catkin-tools clang-format-3.9
cd ~/
mkdir ws_moveit
cd ws_moveit
wstool init src
wstool merge -t src https://raw.githubusercontent.com/ros-planning/moveit/master/moveit.rosinstall
wstool update -t src
rosdep -y install --from-paths src --ignore-src --rosdistro kinetic
catkin config --extend /opt/ros/kinetic --cmake-args -DCMAKE_BUILD_TYPE=Release
config --blacklist \
    moveit_chomp_optimizer_adapter \
    moveit_planners_chomp \
    chomp_motion_planner
catkin build
echo "source ~/ws_moveit/devel/setup.bash" >> ~/.bashrc

# Install OMPL (http://ompl.kavrakilab.org/installation.html):
sudo apt -y install pkg-config libboost-serialization-dev libboost-filesystem-dev libboost-system-dev libboost-program-options-dev libboost-test-dev libode-dev
cd ~/ws_moveit/src
git clone https://github.com/cairo-robotics/ompl.git
cd ompl
git checkout tags/1.2.3

# Make some changes to build files so OMPL with be found by MoveIt!
cd ~/ws_moveit
sed -i "s|DESTINATION \${CMAKE_INSTALL_LIBDIR}|DESTINATION /opt/ros/kinetic/lib/x86_64-linux-gnu |g" ./src/ompl/src/ompl/CMakeLists.txt
sed -i "s|\${catkin_INCLUDE_DIRS}|\${OMPL_INCLUDE_DIRS} |g" ./src/moveit/moveit_planners/ompl/CMakeLists.txt
sed -i "s|\${OMPL_INCLUDE_DIRS})|\${catkin_INCLUDE_DIRS}) |g" ./src/moveit/moveit_planners/ompl/CMakeLists.txt
# MoveIt! needs the package.xml file in order to locate OMPL for building
cd ~/ws_moveit/src/ompl
wget https://raw.githubusercontent.com/ros-gbp/ompl-release/debian/kinetic/xenial/ompl/package.xml

# Finally install MoveIt! with our source OMPL
cd ~/ws_moveit
sudo catkin clean -y
sudo catkin build # sudo is needed since we install OMPL in /opt
source ~/.bashrc