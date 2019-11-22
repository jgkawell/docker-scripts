# ompl-dev:base

This is a simple OMPL development box running Ubuntu 16.04 and ROS Kinetic Desktop, loaded with OMPL and MoveIt!.

## Setup

I would suggest pulling this image from Docker Hub instead of building locally from the Dockerfile since it take a bit as long as your network is fast:

```
docker pull jgkawell/ompl-dev:base
```

Once we've downloaded and extracted the image, we can launch it with the steps below. It's a little different depending on your most machine.


## Usage (Windows host)

Simply launch the container:

```
docker-compose up
```

Then, in another terminal, start a shell on the box:

```
docker exec -it ompl-dev bash
```

## Usage (Linux host)

Prerequisites: Make sure you've set up things properly [here](../docs/hardware-acceleration-linux.md).

```
source ./tools/linux/setup_xauth.sh
docker-compose -f nvidia.docker-compose up
```

Then, in another terminal, start a shell on the box:

```
docker exec -it ompl-dev-nvidia bash
```

## How to use

After you've done the setup steps (for either Windows or Linux), you can simply start the container with a single command any other time you want to use it:

```
docker start ompl-dev{-nvidia} # for linux it'll have the -nvidia tag
```

And then jump into the container using the previously listed command:

```
docker exec -it ompl-dev{-nvidia} bash
```

## How to use

This is a basic install of OMPL with the ability to run custom cost functions through a ROS service. Documentation on this is yet to come...
