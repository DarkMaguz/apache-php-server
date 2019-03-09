#!/bin/sh -e

sudo rm -rf letsencrypt/
mkdir -p letsencrypt/etc/live/example.com

# Build the docker image
docker build -t darkmagus/apache-php-server .

# Clean up
if [ $(docker ps -a -f "name=/tmp$" -q) ]; then
  docker rm -f tmp
fi

# Temporarily use ssl-cert-snakeoil certificates until we have our own
docker create --name "tmp" darkmagus/apache-php-server
docker cp tmp:/etc/ssl/certs/ssl-cert-snakeoil.pem letsencrypt/etc/live/example.com/fullchain.pem
docker cp tmp:/etc/ssl/private/ssl-cert-snakeoil.key letsencrypt/etc/live/example.com/privkey.pem
docker rm -f tmp

./run-local.sh
sleep 5
rm -rf letsencrypt/etc/live/example.com
./get-cert.sh
