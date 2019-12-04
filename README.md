[![Build Status](https://travis-ci.com/jgkawell/docker-scripts.svg?branch=master)](https://travis-ci.com/jgkawell/docker-scripts)

# docker-scripts

This is a repository for helpful Docker scripts and tools.

Within this repository are Dockerfiles and docker-compose files that will build different images for ROS and OMPL development along with the needed tools for MoveIt!, Sawyer, and CC-LfD. While you can simply build these images, this takes a while and it is much easier to simply pull them from Docker Hub as they are already stored there.

## How to use

Before continuing, I highly recommend reading through [the full documentation](./docs/README.md). It will explain how to configure your system for hosting these containers as well as walk you though simply tutorials on how to use the tools provided.

### Download the image

I would suggest that you pick which image you want (by reading the README's within each folder) and then simply pull them with the below commands:

```
docker pull jgkawell/{repository}:{tag}
```

### Setup environment variables

Once you've pulled the image you're ready to start the container, but first be sure to set your `DISPLAY` environment variable so that this will be passed to the container for GUI forwarding:

```
# For a Linux host
export DISPLAY=:0

# For a Windows host
[Environment]::SetEnvironmentVariable("DISPLAY", "{your_ip_address}:0.0")
```

### Setup X server (GUI forwarding)

For a Windows host, you'll also need an X server application for GUI forwarding to work. [VcXsrv](https://sourceforge.net/projects/vcxsrv/) is a good one for Windows.

For a Linux host, the setup is a little more complicated since we can use hardware acceleration. Go [here](./docs/hardware-acceleration-linux.md) to find out how to set this up.

### Launching the containerss

Once all that is done, you can start a container using the provided launch scripts:

```
# Linux host
cd ./tools/linux
bash launch.sh {repository} {tag_prefix} {host_type}

# Windows host (still to come)
```
