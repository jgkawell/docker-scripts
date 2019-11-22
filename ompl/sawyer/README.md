# ompl-dev:sawyer

This is a simple OMPL development box running Ubuntu 16.04 and ROS Kinetic Desktop, loaded with OMPL and MoveIt!.

Additionally, it has the needed tools from Rethink Robotics loaded for Sawyer development.

## Setup

I would suggest pulling this image from Docker Hub instead of building locally from the Dockerfile since it take a bit as long as your network is fast:

```
docker pull jgkawell/ompl-dev:sawyer
```

Once we've downloaded and extracted the image, we can launch it with the steps below. It's a little different depending on your most machine.


## Usage (Windows host)

Simply launch the container:

```
docker-compose up
```

Then, in another terminal, start a shell on the box:

```
docker exec -it ompl-dev-sawyer bash
```

## Usage (Linux host)

Prerequisites: Make sure you've set up things properly [here](../../docs/hardware-acceleration-linux.md).

```
source ./tools/linux/setup_xauth.sh
docker-compose -f nvidia.docker-compose up
```

Then, in another terminal, start a shell on the box:

```
docker exec -it ompl-dev-sawyer-nvidia bash
```

## How to use

After you've done the setup steps (for either Windows or Linux), you can simply start the container with a single command any other time you want to use it:

```
docker start ompl-dev-sawyer{-nvidia} # for linux it'll have the -nvidia tag
```

And then jump into the container using the previously listed command:

```
docker exec -it ompl-dev-sawyer{-nvidia} bash
```

## Using the tools

For each new terminal you'll need to start a simulated Sawyer environment. Simply move into the workspace and start the `intera` script:

```
cd ~/ws_moveit
./intera.sh sim
```

Once you've done that, you can launch the simulated Sawyer bot:

```
roslaunch sawyer_gazebo sawyer_world.launch
```

In order to control Sawyer using MoveIt! in rviz, you can start the joint trajectory action server in one terminal...

```
rosrun intera_interface joint_trajectory_action_server.py
```

...and then launch MoveIt! in another terminal:

```
roslaunch sawyer_moveit_config sawyer_moveit.launch
```

Just remember to run the `intera.sh` script in each new terminal.
