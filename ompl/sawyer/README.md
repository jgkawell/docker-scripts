# ompl-dev:sawyer

This is a simple OMPL development box running Ubuntu 16.04 and ROS Kinetic Desktop, loaded with OMPL and MoveIt!.

Additionally, it has the needed tools from Rethink Robotics loaded for Sawyer development.

## Setup

I would suggest pulling this image from Docker Hub instead of building locally from the Dockerfile since it take a bit as long as your network is fast:

```
docker pull jgkawell/ompl-dev:sawyer
```

Once you've pulled the image you're ready to start the container using docker-compose:

```
docker-compose up
```

Then, in another terminal, SSH into the box:

```
docker exec -it ompl-dev-sawyer bash
```

## How to use

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

Just remember to run the `intera` script in each new terminal.
