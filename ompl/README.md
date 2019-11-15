# ompl-dev:base

This is a simple OMPL development box running Ubuntu 16.04 and ROS Kinetic Desktop, loaded with OMPL and MoveIt!.

## Setup

I would suggest pulling this image from Docker Hub instead of building locally from the Dockerfile since it take a bit as long as your network is fast:

```
docker pull jgkawell/ompl-dev:base
```

Once you've pulled the image you're ready to start the container using docker-compose:

```
docker-compose up
```

Then, in another terminal, SSH into the box:

```
docker exec -it ompl-dev-base bash
```

## How to use

This is a basic install of OMPL with the ability to run custom cost functions through a ROS service. Documentation on this is yet to come...
