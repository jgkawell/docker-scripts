# ros-dev:latest

This is a simple ROS development box running Ubuntu 16.04 and ROS Kinetic Desktop.

## Setup

I would suggest pulling this image from Docker Hub instead of building locally from the Dockerfile since it take a bit as long as your network is fast:

```
docker pull jgkawell/ros-dev:latest
```

Once you've pulled the image you're ready to start the container using docker-compose:

```
docker-compose up
```

Then, in another terminal, SSH into the box:

```
docker exec -it ros-dev bash
```

## How to use

This is a fully functional ROS development box. Hack away!