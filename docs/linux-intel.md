# Setting up hardware acceleration on a Linux host with an Intel GPU

## Setup

If you haven't already, go back and follow the prerequisite steps for [any Linux host](./hardware-acceleration-linux.md) then come back here.

## Running the container

On Intel, the setup is handled completely by the `docker-compose` files. All you need to do is make sure to call the Intel files instead of the Nvidia ones:

```
docker-compose -f intel.docker-compose up
```
