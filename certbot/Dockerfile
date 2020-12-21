FROM debian:buster

RUN apt-get update && apt-get install -y git python3 virtualenv python3-virtualenv python3-venv python3-pip libaugeas0 augeas-lenses

RUN git clone https://github.com/certbot/certbot /opt/certbot/src

RUN /opt/certbot/src/certbot-auto --os-packages-only
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN virtualenv --no-site-packages -p python3 /opt/certbot/venv
RUN /opt/certbot/venv/bin/pip3 install --upgrade setuptools -e /opt/certbot/src/acme -e /opt/certbot/src/certbot-apache

ENV PATH /opt/certbot/venv/bin:$PATH

ENTRYPOINT [ "certbot" ]
