# LibreNMS Docker Install

## Prerequisites

`sudo apt install docker-compose`

## LibreNMS

```
cd /opt
mkdir docker
cd docker
mkdir librenms
cd librenms
wget https://raw.githubusercontent.com/reubznz/info/main/LibreNMS/.env
wget https://raw.githubusercontent.com/reubznz/info/main/LibreNMS/librenms.env
wget https://raw.githubusercontent.com/reubznz/info/main/LibreNMS/msmtpd.env
wget https://raw.githubusercontent.com/reubznz/info/main/LibreNMS/compose.yml
```

Replace password in .env

```nano .env```

Replace email and password in msmtpd.env

```nano msmtpd.env```

## Deploy Containters

```sudo docker-compose -d up```

## Links

https://github.com/librenms/librenms/tree/master/mibs

https://wadman.co.nz/2022/01/02/Viewing-LibreNMS-data-in-Grafana/
