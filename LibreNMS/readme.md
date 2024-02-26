apt install docker-compose

cd /opt

mkdir docker

cd docker

mkdir librenms

cd librenms

wget https://raw.githubusercontent.com/reubznz/info/main/LibreNMS/.env

wget https://raw.githubusercontent.com/reubznz/info/main/LibreNMS/librenms.env

wget https://raw.githubusercontent.com/reubznz/info/main/LibreNMS/msmtpd.env

wget https://raw.githubusercontent.com/reubznz/info/main/LibreNMS/compose.yml


Replace password in .env

nano .env

Replace password in msmtpd.env
nano msmtpd.env


docker-compose -d up
