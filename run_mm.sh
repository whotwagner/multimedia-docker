#!/bin/bash

CMD=$1

# if this is set to 1
# all commands will be executed
# using docker-run (instead of docker-exec)
ALWAYSUSERUN=0

# If you change this name, just try to use
# a unique name.
IMAGE="hoti/multimedia"

# this user was built in the docker-image
# if you want to change the name, you'll
# have to change it inside of the Dockerfile 
# and then you have to rebuild the image
DOCKERUSER="pt"

NVIDIA="--device /dev/nvidia0:/dev/nvidia0 --device /dev/nvidiactl:/dev/nvidiactl"

# where do we save the persistent
# configurations of all our apps?
HOMEVOLUMES="$HOME/.mymultimediaapps"

if [ $# -eq 0 ]
then
echo "usage: $0 <build|skype|spotify|bash>"
exit 0
fi

if [ "$CMD" == "build" ]
then
echo "building.."
docker build -f Dockerfile -t $IMAGE .
exit 1
fi

# Create all the Configfiles if necessary
test -d $HOMEVOLUMES || mkdir $HOMEVOLUMES
test -d $HOMEVOLUMES/home || mkdir $HOMEVOLUMES/home
# test -d $HOMEVOLUMES/spotify || mkdir $HOMEVOLUMES/spotify
# test -d $HOMEVOLUMES/spotify/config || mkdir $HOMEVOLUMES/spotify/config
# test -d $HOMEVOLUMES/spotify/cache || mkdir $HOMEVOLUMES/spotify/cache
# test -d $HOMEVOLUMES/Skype || mkdir $HOMEVOLUMES/Skype

#    -v $HOMEVOLUMES/spotify/config:/home/${DOCKERUSER}/.config/spotify \
#    -v $HOMEVOLUMES/spotify/cache:/home/${DOCKERUSER}/.cache/spotify \
#    -v $HOMEVOLUMES/Skype:/home/${DOCKERUSER}/.Skype \

docker ps | grep "$IMAGE"
if [ $? -eq 1 ] || [ $ALWAYSUSERUN -eq 1 ]
then
# if there is not container using our build image-file
# run a new container
docker run -ti --rm \
    --name mm${CMD} \
    -e DISPLAY=unix$DISPLAY \
    -e PULSE_SERVER=unix:/run/pulse \
    -v $HOMEVOLUMES/home:/home/${DOCKERUSER}/ \
    -v /etc/localtime:/etc/localtime:ro \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -v /run/user/`id -u`/pulse/native:/run/pulse \
    -v /dev/video0:/dev/video0:rw \
    -p 10011:22 \
    --user ${DOCKERUSER} \
    --hostname mm${CMD} \
    $IMAGE /bin/bash -c "$CMD"
else
# if there is already a container using our build image-file
# then just execute our application in this container
DOCKERNAME=`docker ps | grep "${IMAGE}" | rev | awk '{print $1}' | rev`
docker exec -it $DOCKERNAME /bin/bash -c $CMD
fi
