export XAUTH=/tmp/.docker.xauth

# Host can be either windows, intel (Linux), or nvidia (Linux)
HOST=$1

echo "STEP 1/4: Building ros-dev:$HOST"
docker-compose -f ../ros/$HOST.docker-compose.yml build

echo "STEP 2/4: Build ompl-dev:base-$HOST"
docker-compose -f ../ompl/$HOST.docker-compose.yml build

echo "STEP 3/4: Build ompl-dev:sawyer-$HOST"
docker-compose -f ../ompl/sawyer/$HOST.docker-compose.yml build

echo "STEP 4/4: Build ompl-dev:lfd-$HOST"
docker-compose -f ../ompl/lfd/$HOST.docker-compose.yml build