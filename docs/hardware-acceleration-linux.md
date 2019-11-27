# Setting up hardware acceleration on a Linux host

## Setup

You'll need to have Docker (`docker-ce`) installed on your Linux host machine. Follow the installation instruction [here](https://docs.docker.com/install/linux/docker-ce/ubuntu/). Also make sure to walk through the post-installation instructions [here](https://docs.docker.com/install/linux/linux-postinstall/) specifically to add your user to the `docker` usergroup.

After installing the Docker engine, you'll also need to install `docker-compose`. This is very simple and can be done using the official docs [here](https://docs.docker.com/compose/install/).

Once that is installed, you should be able to simply allow non-network local connections and then follow system specific instructions depending on whether you're running an Intel integrated GPU or an Nvidia dedicated GPU:

```
xhost +local:root # SEE SECURITY NOTE BELOW
```

## System specific instructions

1) [Intel integrated GPU](./linux-intel.md)
2) [Nvidia dedicated GPU](./linux-nvidia.md)

### Security Notice

Note that setting the `xhost` privilages in this way is not very secure since it opens up your system for being compromised. You can fix this by following the suggestions on [the ROS wiki about GUI applications in Docker](http://wiki.ros.org/docker/Tutorials/GUI). These alternative methods though are fairly complicated to set up and so are not addressed here. An easy way to close the security hole with this method is simply to run the below command whenever you are done with your work in the container:

```
xhost -local:root
```

You'll then need to rerun `xhost +local:root` anytime you want to use GUI's within your containers.
