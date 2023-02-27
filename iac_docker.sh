#!/bin/bash

#instalacao docker
apt-get install docker.io

#criacao da pasta/volume mysql e app
mkdir /var/lib/docker/volumes/mysql
mkdir /var/lib/docker/volumes/app

#copiar arquivo index.php para app
cp index.php /var/lib/docker/volumes/app

#subir mysql
docker run -d --name data-server -v "/var/lib/docker/volumes/mysql:/var/lib/mysql" -e MYSQL_ROOT_PASSWORD=12345 mysql:5.7

#CONFIGURAR BANCO
docker exec -i data-server mysql -uroot -p12345  < banco.sql

#subir apache
docker run -d --name web-server -v "/var/lib/docker/volumes/app/:/app" -p 80:80 webdevops/php-apache:alpine-php7
