[![Build Status](https://travis-ci.com/jgkawell/docker-scripts.svg?branch=master)](https://travis-ci.com/jgkawell/docker-scripts)

# docker-scripts

This is a repository for helpful Docker scripts and tools.

This most helpful aspect of this repository is within the `tools` directory. This directory contains `docker-compose` files as well as a couple of bash scripts that together allow for easy launching of Docker containers with X11 server forwarding (GUI apps) for Docker hosts that are Windows, Linux with Intel-based graphics, and Linux with Nvidia-based graphics.

While this repository mainly holds documentation and launch/configuration scripts, it also contains a Dockerfile which sets up a simple Ubuntu container that is capable of X11 server forwarding.

## How to use

Before continuing, I highly recommend reading through [the full documentation](https://github.com/jgkawell/docker-scripts/wiki). It will explain how to configure your system for hosting X11 capable containers.

### Setup X server (GUI forwarding)

#### Windows Host

NOTE: I'm assuming you're running Docker through the new WSL2 instead of the old way. This is the only way my launch script will run (since it runs in bash).

You'll need an X server application for GUI forwarding to work. [VcXsrv](https://sourceforge.net/projects/vcxsrv/) is a good one for Windows. Make sure to *unselect* "Native opengl" and *select* "Disable access control" while leaving all the other VcXsrv settings with their defaults.

Also be sure to set the `DISPLAY` environment variable to your current IP address before launching the containers (you can find this under Settings -> Network & Internet -> Status -> Properties)

```
export DISPLAY={ip_address}:0
```

#### Linux Host

For a Linux host the setup is a little more complicated since we can use hardware acceleration. Go [here](https://github.com/jgkawell/docker-scripts/wiki/Linux-Host-(Generic)) to find out how to set this up.

### Launching containers

Once all that is done, you can start a container using the provided launch script:

```
bash ./tools/launch.sh {user} {repository} {tag} {host}
```

Make sure to use the user, repository, tag, and host that you would like. For example, using the image built with the Dockerfile in this repository on a *Linux computer running Intel graphics* would look like this:

```
bash ./tools/launch.sh jgkawell x11 base intel
```
