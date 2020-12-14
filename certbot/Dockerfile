FROM debian:buster

RUN apt-get update && apt-get install -y git python3 virtualenv python3-virtualenv python3-venv python3-pip libaugeas0 augeas-lenses

RUN git clone https://github.com/letsencrypt/letsencrypt /opt/letsencrypt/src

RUN /opt/letsencrypt/src/letsencrypt-auto --os-packages-only
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN virtualenv --no-site-packages -p python3 /opt/letsencrypt/venv
RUN /opt/letsencrypt/venv/bin/pip3 install --upgrade setuptools -e /opt/letsencrypt/src/acme -e /opt/letsencrypt/src/certbot-apache

ENV PATH /opt/letsencrypt/venv/bin:$PATH

ENTRYPOINT [ "certbot" ]
