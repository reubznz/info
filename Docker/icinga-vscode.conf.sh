#!/bin/bash

# ICINGA-VSCODE: (8082)

ContainerName="icinga-vscode"
ImageName="ghcr.io/linuxserver/code-server"
DockerRunCommand() {
    docker run -d --name $ContainerName -p 8082:8443 -e PUID=1000 -e PGID=1000 -e TZ=Pacific/Auckland -v vscode_data:/config -v /opt/docker/icinga2/etc/icinga2:/config/icinga2 --restart unless-stopped $ImageName
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
