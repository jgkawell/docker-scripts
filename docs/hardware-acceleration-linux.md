# Setting up hardware acceleration on a Linux host with Nvidia GPU

## Prerequisites

This has been tested on Ubuntu 16.04 running a few different Nvidia graphics cards. It's been verified working on driver version 440.

Other distros and drivers may also work, but your milage may vary.

## Setup

You'll need to have Docker (`docker-ce`) installed on your Linux host machine. Follow the installation instruction [here](https://docs.docker.com/install/linux/docker-ce/ubuntu/). Also make sure to walk through the post-installation instructions [here](https://docs.docker.com/install/linux/linux-postinstall/) specifically to add your user to the `docker` usergroup.

After installing the Docker engine, you'll also need to install `docker-compose`. This is very simple and can be done using the official docs [here](https://docs.docker.com/compose/install/).

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
xhost +local:root # SEE SECURITY NOTE BELOW
source ./tools/linux/setup_xauth.sh
docker-compose -f nvidia.docker-compose up
```

### Security Notice

Note that setting the `xhost` privilages in this way is not very secure since it opens up your system for being compromised. You can fix this by following the suggestions on [the ROS wiki about GUI applications in Docker](http://wiki.ros.org/docker/Tutorials/GUI). These alternative methods though are fairly complicated to set up and so are not addressed here. An easy way to close the security hole with this method is simply to run the below command whenever you are done with your work in the container:

```
xhost -local:root
```

You'll then need to rerun `xhost +local:root` anytime you want to use GUI's within your containers.
