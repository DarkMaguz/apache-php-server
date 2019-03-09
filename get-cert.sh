#!/bin/sh -e

if [ -d $PWD/letsencrypt ]; then
	USRNAME=$USER
	sudo chown -R $USRNAME:$USRNAME $PWD/letsencrypt
fi

# Clean up
if [ $(docker ps -a -f "name=/certbot$" -q) ]; then
  docker rm -f certbot
fi

# Build the docker image
docker build -t darkmagus/certbot certbot/

mkdir -p letsencrypt/log
mkdir -p letsencrypt/www
mkdir -p letsencrypt/etc
mkdir -p letsencrypt/lib

# Run the docker container
docker run -it -v $PWD/letsencrypt/log:/var/log/letsencrypt -v $PWD/www:/var/www -v $PWD/letsencrypt/etc:/etc/letsencrypt -v $PWD/letsencrypt/lib:/var/lib/letsencrypt --name "certbot" darkmagus/certbot certonly --webroot --webroot-path /var/www --agree-tos --non-interactive --email example.com@gmail.com -d example.com -d www.example.com

