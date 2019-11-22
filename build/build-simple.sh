export XAUTH=/tmp/.docker.xauth

echo "STEP 1/4: Building ros-dev:latest"
cd ../ros && docker-compose -f docker-compose.yml build

echo "STEP 2/4: Build ompl-dev:base"
cd ../ompl && docker-compose -f docker-compose.yml build

echo "STEP 3/4: Build ompl-dev:sawyer"
cd ../ompl/sawyer && docker-compose -f docker-compose.yml build

echo "STEP 4/4: Build ompl-dev:lfd"
cd ../ompl/lfd && docker-compose -f nvidia.docker-compose.yml build