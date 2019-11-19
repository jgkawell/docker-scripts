# Use rocker to build OpenGL/Nvidia capable image
echo "Building hardware accelerated container with rocker..."
rocker --nvidia --noexecute jgkawell/ompl-dev:lfd

# Grab the image ID from the rocker build
IMAGE_ID=`docker images | awk '{print $3}' | awk 'NR==2'`

# Rename the image
docker tag $IMAGE_ID jgkawell/ompl-dev:lfd-nvidia

# Build and bring up the container
echo "Bring up the container with docker-compose..."
docker-compose -f nvidia.docker-compose.yml up
