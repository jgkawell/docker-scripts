# docker-scripts


# Volume needed for X-server GUI passing to OS
VOLUME "/tmp/.X11-unix:/tmp/.X11-unix"

# Also need to set DISPLAY env variable