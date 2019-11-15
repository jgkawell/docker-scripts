# ompl-dev:lfd

This is a simple OMPL development box running Ubuntu 16.04 and ROS Kinetic Desktop, loaded with OMPL and MoveIt!.

Additionally, it has the needed tools from Rethink Robotics loaded for Sawyer development.

In addition to Sawyer, this image also has the needed packages for CC-LfD from CAIRO Robotics and the development code for Feedback-Based CC-LfD.

## Setup

I would suggest pulling this image from Docker Hub instead of building locally from the Dockerfile since it take a bit as long as your network is fast:

```
docker pull jgkawell/ompl-dev:lfd
```

Once you've pulled the image you're ready to start the container using docker-compose:

```
docker-compose up
```

Then, in another terminal, SSH into the box:

```
docker exec -it ompl-dev-lfd bash
```

## How to use

The basics of how to use this are described [here](../sawyer/README.md).

The Feedback CC-LfD system is a work in progress. The instructions on how to run it are still to come...
