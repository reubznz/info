#!/bin/bash

# ICINGA: (8080)

ContainerName="icinga"
ImageName="jordan/icinga2:latest"
DockerRunCommand() {
    docker run -d --name $ContainerName -p 8080:80 -e MYSQL_ROOT_USER=root -e MYSQL_ROOT_PASSWORD=root-mysql-password-goes-here -e DEFAULT_MYSQL_HOST=192.168.x.x -e DEFAULT_MYSQL_USER=icinga2 -e DEFAULT_MYSQL_PASS=mysql-password-goes-here -e ICINGA2_FEATURE_GRAPHITE=true -e ICINGA2_FEATURE_GRAPHITE_HOST=192.168.x.x -e ICINGA2_FEATURE_GRAPHITE_PORT=2003 -e ICINGA2_FEATURE_GRAPHITE_URL=http://192.168.x.x:8081 -e ICINGA2_FEATURE_DIRECTOR_PASS=icinga-director-password-goes-here -v /opt/docker/icinga2/etc/apache2/ssl:/etc/apache2/ssl -v /opt/docker/icinga2/etc/ssmtp/revaliases:/etc/ssmtp/revaliases -v /opt/docker/icinga2/etc/icinga2:/etc/icinga2 -v /opt/docker/icinga2/etc/icingaweb2:/etc/icingaweb2 -v /opt/docker/icinga2/etc/msmtp/msmtprc:/etc/msmtprc:ro -v /opt/docker/icinga2/etc/msmtp/aliases:/etc/aliases:ro -v /opt/docker/icinga2/var/lib/mysql:/var/lib/mysql -v /opt/docker/icinga2/var/lib/icinga2:/var/lib/icinga2 -v /opt/docker/icinga2/var/lib/php/sessions:/var/lib/php/sessions --restart unless-stopped $ImageName
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
