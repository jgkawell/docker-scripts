# Install misc needed packages
sudo apt -y update
sudo apt -y upgrade
sudo apt -y install git build-essential cmake tmux wget python-pip

# Install ROS (https://ros.org/install):
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu xenial main" > /etc/apt/sources.list.d/ros-latest.list'
sudo apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654
sudo apt -y update
sudo apt -y install ros-kinetic-desktop
sudo rosdep init && rosdep update
echo "source /opt/ros/kinetic/setup.bash" >> ~/.bashrc

# Install needed dependencies for building packages
sudo apt -y install python-rosinstall python-rosinstall-generator python-wstool

# Config file for easier tmux usage
cp ../../ros/config/.tmux.conf ~/.tmux.conf
