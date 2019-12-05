echo "---------- (1/5) X11 IMAGES ----------"
docker pull jgkawell/x11:base
docker build -f ./x11/Dockerfile --target base --cache-from jgkawell/x11:base -t jgkawell/x11:base ./x11
docker build -f ./x11/Dockerfile --target nvidia --cache-from jgkawell/x11:base -t jgkawell/x11:base-nvidia ./x11
echo "---------- (2/5) ROS IMAGES ----------"
docker pull jgkawell/ros:base
docker build -f ./ros/Dockerfile --target base --cache-from jgkawell/ros:base -t jgkawell/ros:base ./ros
docker build -f ./ros/Dockerfile --target nvidia --cache-from jgkawell/ros:base -t jgkawell/ros:base-nvidia ./ros
echo "---------- (3/5) OMPL BASE IMAGES ----------"
docker pull jgkawell/ompl:base
docker build -f ./ompl/Dockerfile --target base --cache-from jgkawell/ompl:base -t jgkawell/ompl:base ./ompl
docker build -f ./ompl/Dockerfile --target nvidia --cache-from jgkawell/ompl:base -t jgkawell/ompl:base-nvidia ./ompl
echo "---------- (4/5) OMPL SAWYER IMAGES ----------"
docker pull jgkawell/ompl:sawyer
docker build -f ./ompl/sawyer/Dockerfile --target base --cache-from jgkawell/ompl:sawyer -t jgkawell/ompl:sawyer ./ompl
docker build -f ./ompl/sawyer/Dockerfile --target nvidia --cache-from jgkawell/ompl:sawyer -t jgkawell/ompl:sawyer-nvidia ./ompl
echo "---------- (5/5) OMPL LFD IMAGES ----------"
docker pull jgkawell/ompl:lfd
docker build -f ./ompl/lfd/Dockerfile --target base --cache-from jgkawell/ompl:lfd -t jgkawell/ompl:lfd ./ompl
docker build -f ./ompl/lfd/Dockerfile --target nvidia --cache-from jgkawell/ompl:lfd -t jgkawell/ompl:lfd-nvidia ./ompl
