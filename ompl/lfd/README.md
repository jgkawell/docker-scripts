# ompl:lfd

This is a simple OMPL development box running Ubuntu 16.04 and ROS Kinetic Desktop, loaded with OMPL for custom cost functions and MoveIt!.

Additionally, it has the needed tools from Rethink Robotics loaded for Sawyer development and initialized for simulation.

In addition to Sawyer, this image also has the needed packages for CC-LfD from CAIRO Robotics and the development code for Feedback-Based CC-LfD (work in progress).


## Setup

I would suggest pulling this image from Docker Hub instead of building locally from the Dockerfile since it take a bit as long as your network is fast:

```
# For either a Windows host or a Linux host using Intel graphics
docker pull jgkawell/ompl:lfd

# For a Linux host using Nvidia graphics
docker pull jgkawell/ompl:lfd-nvidia
```

If you're running a Linux host then check [the documentation](../docs/hardware-acceleration-linux.md) for how to set up hardware acceleration which is needed for these images. It will work with either Nvidia or Intel graphics.


## Usage

Once we've downloaded and extracted the image, we can launch and jump into it using the steps below. It's a little different depending on your host machine:

```
docker-compose -f {host}.docker-compose.yml up
```

Be sure to replace `{host}` with either `windows`, `intel`, or `nvidia`.

Then, in another terminal, start a shell on the box:

```
docker exec -it {container_name} bash
```

Replace `{container_name}` with the name of the container you built which depends on the host you're using:

- `windows` or `intel` = `ompl-lfd`
- `nvidia` = `ompl-lfd-nvidia`


## Using the container

After you've done the setup steps, the container is now built and functional on your host machine. Anytime you want to use it you can simply start the container with a single command:

```
docker start {container_name}
```

And then jump into the container using the previously listed command:

```
docker exec -it {container_name} bash
```


## Using the tools

For an overview on using custom costs in OMPL, check out the tutorial [in the documentation](../../docs/custom-cost-ompl.md).

For an overview on using the Sawyer tools. Head over to [this page](../../docs/simulated-sawyer.md) in the documentation.

The Feedback CC-LfD system is a work in progress. The instructions on how to run it are still to come...
