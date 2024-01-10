#!/bin/bash

# ICINGA-MYSQL: (3306)

ContainerName="icinga-mysql"
ImageName="mariadb"
DockerRunCommand() {
    docker run -d --name $ContainerName -p 3306:3306 -e MYSQL_ROOT_PASSWORD=root-mysql-pasword-goes-here -e MYSQL_USER=icinga2 -e MYSQL_PASSWORD=mysql-password-goes-here -v /opt/docker/mysql:/var/lib/mysql --restart unless-stopped $ImageName
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
