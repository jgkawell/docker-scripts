# ompl-dev:lfd

This is a simple OMPL development box running Ubuntu 16.04 and ROS Kinetic Desktop, loaded with OMPL and MoveIt!.

Additionally, it has the needed tools from Rethink Robotics loaded for Sawyer development.

In addition to Sawyer, this image also has the needed packages for CC-LfD from CAIRO Robotics and the development code for Feedback-Based CC-LfD (work in progress).

## Install

I would suggest pulling this image from Docker Hub instead of building locally from the Dockerfile as long as your network is fast. Actually building the image can take a while:

```
docker pull jgkawell/ompl-dev:lfd
```

## Setup (Windows host)

You'll need to have Docker Desktop installed on your Windows host machine. Follow the installation instructions [here](https://docs.docker.com/docker-for-windows/install/).

Once you've pulled the image you're ready to start the container using docker-compose:

```
docker-compose up
```

Then, in another terminal, SSH into the box:

```
docker exec -it ompl-dev-lfd bash
```

## Setup (Linux host)

Prerequisites: You'll need Ubuntu 16.04 or 18.04 with an Nvidia graphics card and compatible drivers (I don't know all the Linux distros and drivers that work with this method, but let me know which ones you have if it doesn't work).

You'll need to have Docker (`docker-ce`) installed on your Linux host machine. Follow the installation instruction [here](https://docs.docker.com/install/linux/docker-ce/ubuntu/). Also make sure to walk through the post-installation instructions [here](https://docs.docker.com/install/linux/linux-postinstall/) specifically to add your user to the `docker` usergroup.

On Linux, we can leverage the hardware acceleration of our host to greatly improve the performance of GUI applications (rviz, Gazebo, etc.). However, this requires an Nvidia GPU with the CUDA toolkit installed. You can find the installation instructions for CUDA [here](https://docs.nvidia.com/cuda/cuda-installation-guide-linux/index.html#ubuntu-installation) and the download for the toolkit on Ubuntu [here](https://developer.nvidia.com/cuda-downloads?target_os=Linux&target_arch=x86_64&target_distro=Ubuntu).

We'll also need a program called `rocker` from [OSRF](https://www.openrobotics.org/) that will help setup the needed components for our Docker images.

The program is distributed through the ROS repositories so if you don't have those configured go [here](http://wiki.ros.org/kinetic/Installation/Ubuntu) (if you already have ROS installed on your host machine you're all set). Then run the command below:

```
sudo apt-get install python3-rocker
```

More installation options and info can be found at the `rocker` GitHub [here](https://github.com/osrf/rocker).

Once that is installed, you should be able to simply source the setup script provided in this repo and then run the launch script also provided:

```
source setup_xauth.sh
./run_nvidia.sh
```

Those commands should create your container named `ompl-dev-lfd` and automatically start it up. You can then jump into the box:

```
docker exec -it ompl-dev-lfd bash
```

## How to use

After you've done the setup steps (for either Windows or Linux), you can simply start the container with a single command any other time you want to use it:

```
docker start ompl-dev-lfd
```

And then jump into the container using the previously listed command:

```
docker exec -it ompl-dev-lfd bash
```

## Using the tools

The basics of how to use this are described [here](../sawyer/README.md).

The Feedback CC-LfD system is a work in progress. The instructions on how to run it are still to come...
