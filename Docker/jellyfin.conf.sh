#!/bin/bash

# JELLYFIN: (8096, 8920, 7359, 1900)

ContainerName="jellyfin"
ImageName="lscr.io/linuxserver/jellyfin"
DockerRunCommand() {
    docker run -d --name $ContainerName -p 8096:8096 -p 8920:8920 -p 7359:7359/udp -p 1900:1900/udp -e PUID=1000 -e PGID=1000 -e TZ=Pacific/Auckland -e JELLYFIN_PublishedServerUrl=192.168.37.6 -v jellyfin_data:/config -v /media/Media/TV:/data/tvshows -v /media/Media/Movies:/data/movies -v /media/Media/Music:/data/music --device=/dev/dri:/dev/dri --restart unless-stopped $ImageName
}

echo "" > /tmp/docker_deploy.txt
docker ps | grep $ContainerName | awk '{print $2,"- Deployed",$4,$5,$6,"- Running for",$8,$9}' > /tmp/docker_deploy.txt

if [ -s '/tmp/docker_deploy.txt' ]; then
    echo "Found an instance of $ContainerName"
    echo ""
    cat /tmp/docker_deploy.txt
    echo ""
    echo " > Performing upgrade tasks"
    echo ""
    echo " > Pulling the latest image for $ContainerName ($ImageName)"
    docker pull $ImageName
    echo ""
    echo " > Stopping $ContainerName"
    docker stop $ContainerName
    echo ""
    echo " > Removing $ContainerName"
    docker rm $ContainerName
    echo ""
    echo " > Deploying $ContainerName"
    DockerRunCommand
    echo ""
    echo " > $ContainerName deployed!"
else
    echo "No matches for $ContainerName"
    echo ""
    echo " > Deploying $ContainerName"
    DockerRunCommand
    echo ""
    echo " > $ContainerName deployed!"
fi

echo "" > /tmp/docker_deploy.txt
