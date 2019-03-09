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

# Run the docker container
docker run --rm -v $PWD/letsencrypt/log:/var/log/letsencrypt -v $PWD/www:/var/www -v $PWD/letsencrypt/etc:/etc/letsencrypt -v $PWD/letsencrypt/lib:/var/lib/letsencrypt darkmagus/certbot renew

