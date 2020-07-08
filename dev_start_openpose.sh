#!/bin/sh
# Varibles to edit
LOCAL_SRC_DIR=/home/user3/repos/playing_smplifyx
LOCAL_DATA_DIR=/mnt/datasets/DVP

#Build
docker stop portainer
docker stop openpose
docker rm portainer
docker rm openpose
docker build -t openpose Dockerfile/.
#Running
docker volume create portainer_dat
if [ ! "$(docker ps -q -f name=portainer)" ]; then
    docker stop portainer
    if [ "$(docker ps -aq -f status=exited -f name=portainer)" ]; then
        # cleanup
        docker rm portainer
    fi
    # run your container
    docker run -d -p 8001:8000 -p 9001:9000 --name=portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer
fi 
docker run --rm -p 8091:8091  -v $LOCAL_SRC_DIR:/workspace/local_station -v $LOCAL_DATA_DIR:/workspace/local_data --name openpose --gpus all --shm-size=1g --ulimit memlock=-1 -it openpose 
