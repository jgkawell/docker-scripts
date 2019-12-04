
for i in "$@"
do
case $i in
    -r|--repo)
        REPO=${NEXT}
        shift
        ;;
    -t|--tag)
        NEXT=i+1
        TAG=${NEXT}
        shift
        ;;
    -h|--host)
        NEXT=i+1
        HOST=${NEXT}
        shift
        ;;
    --help)
        # unknown option -> show help
        echo "Usage: bash launch.sh [options]"
        echo "  -r|--repo: Docker repository name (x11/ros/ompl)"
        echo "  -t|--tag: Docker repository tag prefix (base/sawyer/lfd)"
        echo "  -h|--host: Docker host type (windows/intel/nvidia)"
        exit
    ;;
esac
done

# Add the host tag and setup XAuth if it's Nvidia
if [ ${HOST}=='nvidia' ]; then
    HOST_TAG='-nvidia'
    source setup_xauth.sh
else
    HOST_TAG=''
fi

# For the OMPL repository, mark the subdirectory
if [ ${REPO}=='ompl' ]; then
    if [ ${TAG}=='base' ]; then
        SUB_DIR=''
    elif [ ${TAG}=='sawyer' ]; then
        SUB_DIR='sawyer/'
    elif [ ${TAG}=='lfd' ]; then
        SUB_DIR='lfd/'
    fi
fi

# Pull down the image
echo "Attempting to pull from: jgkawell/${REPO}:${TAG}${HOST_TAG}"
docker pull jgkawell/${REPO}:${TAG}${HOST_TAG}

# Add non-network local connections to control list
xhost +local:root

# Bring up the container
docker-compose -f ../../${REPO}/${SUB_DIR}${HOST}.docker-compose.yml up

# Remove non-network local connections from control list
xhost -local:root
