#!/bin/bash

# NAME: PROMETHEUS-SNMP-EXPORTER (9116)

ContainerName="prometheus-snmp-exporter"
ImageName="prom/snmp-exporter"
DockerRunCommand() {
    docker run -d --name $ContainerName -p 9116:9116 --restart unless-stopped $ImageName
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
    echo " "
fi

echo "" > /tmp/docker_deploy.txt
