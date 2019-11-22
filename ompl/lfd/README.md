# ompl-dev:lfd

This is a simple OMPL development box running Ubuntu 16.04 and ROS Kinetic Desktop, loaded with OMPL and MoveIt!.

Additionally, it has the needed tools from Rethink Robotics loaded for Sawyer development.

In addition to Sawyer, this image also has the needed packages for CC-LfD from CAIRO Robotics and the development code for Feedback-Based CC-LfD (work in progress).

## Installation

I would suggest pulling this image from Docker Hub instead of building locally from the Dockerfile as long as your network is fast. Actually building the image can take a while:

```
docker pull jgkawell/ompl-dev:lfd
```

Once we've downloaded and extracted the image, we can launch it with the steps below. It's a little different depending on your most machine.

## Usage (Windows host)

Simply launch the container:

```
docker-compose up
```

Then, in another terminal, start a shell on the box:

```
docker exec -it ompl-dev-lfd bash
```

## Usage (Linux host)

Prerequisites: Make sure you've set up things properly [here](../../docs/hardware-acceleration-linux.md).

```
source ./linux/setup_xauth.sh
docker-compose -f nvidia.docker-compose up
```

Then, in another terminal, start a shell on the box:

```
docker exec -it ompl-dev-lfd-nvidia bash
```

## How to use

After you've done the setup steps (for either Windows or Linux), you can simply start the container with a single command any other time you want to use it:

```
docker start ompl-dev-lfd{-nvidia} # for linux it'll have the -nvidia tag
```

And then jump into the container using the previously listed command:

```
docker exec -it ompl-dev-lfd{-nvidia} bash
```

## Using the tools

The basics of how to use this are described [here](../sawyer/README.md).

The Feedback CC-LfD system is a work in progress. The instructions on how to run it are still to come...
