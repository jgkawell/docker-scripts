# Setting up hardware acceleration on a Linux host with Nvidia GPU

## Prerequisites

This has been tested on a few different graphics card/driver/OS pairings:

- Nvidia driver versions: 418, 435, 440
- Ubuntu versions: 16.04, 18.04
- Graphic cards: 1050Ti (mobile), 1060, 1080Ti

Other distros, GPUs, and drivers may also work, but your milage may vary.

## Setup

If you haven't already, go back and follow the prerequisite steps for [any Linux host](./hardware-acceleration-linux.md) then come back here.

To leverage our Nvidia GPU, we need the `nvidia-docker2` package to handle the acceleration component. If you haven't already, make sure to setup your repository by following the instructions [here](https://nvidia.github.io/nvidia-docker/). Once that is done, you can simply use `apt` to install the package and then force the engine to restart:

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

## Running the container

Once that is installed, you should be able to simply source the setup script provided in this repository (this sets the `XAUTH` environment variable) and then use `docker-compose` to launch your container:

```
touch /tmp/.docker.xauth
source ./tools/linux/setup_xauth.sh
docker-compose -f nvidia.docker-compose up
```
