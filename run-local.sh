#!/bin/sh -e

if [ -d $PWD/letsencrypt ]; then
	USRNAME=$USER
	sudo chown -R $USRNAME:$USRNAME $PWD/letsencrypt
fi

# Clean up
if [ $(docker ps -a -f "name=/apache-php-server$" -q) ]; then
  docker rm -f apache-php-server
fi

# Build the docker image
docker build -t darkmagus/apache-php-server .

# Run the docker container
docker run -tid -v $PWD/www:/var/www -v $PWD/letsencrypt/etc:/etc/letsencrypt -p 80:80 -p 443:443 --name "apache-php-server" darkmagus/apache-php-server

