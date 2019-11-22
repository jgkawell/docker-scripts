export XAUTH=/tmp/.docker.xauth

echo "STEP 1/4: Building ros-dev:nvidia"
docker-compose -f ../ros/nvidia.docker-compose.yml build

echo "STEP 2/4: Build ompl-dev:base-nvidia"
docker-compose -f ../ompl/nvidia.docker-compose.yml build

echo "STEP 3/4: Build ompl-dev:sawyer-nvidia"
docker-compose -f ../ompl/sawyer/nvidia.docker-compose.yml build

echo "STEP 4/4: Build ompl-dev:lfd-nvidia"
docker-compose -f ../ompl/lfd/nvidia.docker-compose.yml build