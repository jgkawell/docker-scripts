# Using Sawyer in a simulated environment

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