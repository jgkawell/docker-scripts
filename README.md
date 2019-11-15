# docker-scripts

This is a repository for helpful Docker scripts and tools.

## How to use

Within this repository are Dockerfiles and docker-compose files that will build different images for ROS and OMPL development along with the needed tools for MoveIt!, Sawyer, and CC-LfD. While you can simply build these images, this takes a while and it is much easier to simply pull them from Docker Hub as they are already stored there.

I would suggest that you pick which image you want (by reading the README's within each folder) and then simply start them with the below commands:

```
docker pull jgkawell/{repository}:{tag}
```

Once you've pulled the image you're ready to start the container, but first be sure to set your `DISPLAY` environment variable so that this will be passed to the container for GUI forwarding:

```
# For a Linux host
export DISPLAY={your_ip_address}:0.0

# For a Windows host
[Environment]::SetEnvironmentVariable("DISPLAY", "{your_ip_address}:0.0")
```

You'll also need an X server application on your host for this GUI forwarding to work.

NOTE: You may also need to set a volume for the X11 server to function properly. I haven't had any issues with it running Docker Desktop on WSL 2 with a Windows host, but your milage may vary. Below is the volume that needs to be set:

```
VOLUME "/tmp/.X11-unix:/tmp/.X11-unix"
```
