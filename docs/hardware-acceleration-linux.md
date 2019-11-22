# Setting up hardware acceleration on a Linux host with Nvidia GPU

## Prerequisites

This has been tested on Ubuntu 16.04 running a few different Nvidia graphics cards. It's been verified working on driver version 440.

Other distros and drivers may also work, but your milage may vary.

## Setup

You'll need to have Docker (`docker-ce`) installed on your Linux host machine. Follow the installation instruction [here](https://docs.docker.com/install/linux/docker-ce/ubuntu/). Also make sure to walk through the post-installation instructions [here](https://docs.docker.com/install/linux/linux-postinstall/) specifically to add your user to the `docker` usergroup.

Additionally, we need the `nvidia-docker2` package to handle the acceleration component. If you haven't already, make sure to setup your repository by following the instructions [here](https://nvidia.github.io/nvidia-docker/). Once that is done, you can simply use `apt` to install the package:

```
sudo apt install nvidia-docker2
sudo pkill -SIGHUP dockerd
```
Once that is installed, we still need to set the default docker runtime to `nvidia`. This is configured in a JSON file on your host machine at `/etc/docker/daemon.json`. Open it up in your favorite text editor and then add `"default-runtime": "nvidia"` at the highest level. It should look something like this:

```
{
    "default-runtime": "nvidia",
    "runtimes": {
        "nvidia": {
            "path": "nvidia-container-runtime",
            "runtimeArgs": []
        }
    }
}
```

Once that is installed, you should be able to simply source the setup script provided in this repository (this sets the `XAUTH` environment variable) and then use `docker-compose` to launch your container:

```
source ./tools/linux/setup_xauth.sh
docker-compose -f nvidia.docker-compose up
```
