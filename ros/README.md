# ros

This is a simple ROS development box running Ubuntu 16.04 and ROS Kinetic Desktop.

## Setup

I would suggest pulling this image from Docker Hub instead of building locally from the Dockerfile since it take a bit as long as your network is fast:

```
docker pull jgkawell/ros:latest
```

Once we've downloaded and extracted the image, we can launch it with the steps below. It's a little different depending on your most machine.


## Usage (Windows host)

Simply launch the container:

```
docker-compose up
```

Then, in another terminal, start a shell on the box:

```
docker exec -it ompl-sawyer bash
```

## Usage (Linux host)

Prerequisites: Make sure you've set up things properly [here](../../docs/hardware-acceleration-linux.md).

```
xhost +local:root
source ./tools/linux/setup_xauth.sh
docker-compose -f nvidia.docker-compose up
```

Then, in another terminal, start a shell on the box:

```
docker exec -it ros-nvidia bash
```

## How to use

After you've done the setup steps (for either Windows or Linux), you can simply start the container with a single command any other time you want to use it:

```
docker start ompl-sawyer{-nvidia} # for linux it'll have the -nvidia tag
```

And then jump into the container using the previously listed command:

```
docker exec -it ompl-sawyer{-nvidia} bash
```

## Using the tools

This is a fully functional ROS development box. Hack away!