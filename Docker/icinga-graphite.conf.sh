#!/bin/bash

# ICINGA-GRAPHITE: (8081, 2003, 2004, 2023, 2024, 9125, 9126)

ContainerName="icinga-graphite"
ImageName="graphiteapp/graphite-statsd"
DockerRunCommand() {
    docker run -d --name $ContainerName -p 8081:80 -p 2003-2004:2003-2004 -p 2023-2024:2023-2024 -p 9125:8125/udp -p 9126:8126 -v graphite_statsd:/opt/statsd/config -v graphite_conf:/opt/graphite/conf -v graphite_storage:/opt/graphite/storage -v graphite_log:/var/log -v graphite_logrotate:/etc/logrotate.d -v graphite_nginx:/etc/nginx -v graphite_custom:/opt/graphite/webapp/graphite/functions/custom -v graphite_redis:/var/lib/redis --restart unless-stopped $ImageName
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
