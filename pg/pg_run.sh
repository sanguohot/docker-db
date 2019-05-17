#!/bin/bash
set -e
export LANG=en_US.UTF-8
DEFAULT_USER=root
DEFAULT_DB=postgres
DEFAULT_PORT=5432
DEFAULT_DATA=/opt/pg/data
DEFAULT_PWD=123456
DEFAULT_IMG=postgres:9-alpine
read -ep "input a data path(default $DEFAULT_DATA) :" myData
if  [ ! -n "$myData" ] ;then
	myData=$DEFAULT_DATA
fi
if [ ! -f "$myData" ]; then 
	mkdir -p "$myData" 
else
	echo "$myData already exist, next"
fi 
read -ep "input a password(default $DEFAULT_PWD) :" myPwd
if  [ ! -n "$myPwd" ] ;then
	myPwd=$DEFAULT_PWD
fi
read -ep "input a port(default $DEFAULT_PORT) :" myPort
if  [ ! -n "$myPort" ] ;then
	myPort=$DEFAULT_PORT
fi
echo "begin down $DEFAULT_IMG..."
docker pull $DEFAULT_IMG
docker run --name postgres -d -p $myPort:5432 \
-e POSTGRES_USER=$DEFAULT_USER \
-e POSTGRES_PASSWORD=$myPwd \
-e POSTGRES_DB=$DEFAULT_DB \
-e PGDATA=$myData \
-v $myData:$myData \
$DEFAULT_IMG
