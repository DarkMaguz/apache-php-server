FROM debian:buster

RUN apt-get update && apt-get install -y git

RUN git clone https://github.com/letsencrypt/letsencrypt /opt/letsencrypt/src

RUN /opt/letsencrypt/src/letsencrypt-auto --os-packages-only
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN virtualenv --no-site-packages -p python2 /opt/letsencrypt/venv && \
	/opt/letsencrypt/venv/bin/pip install \
	--upgrade setuptools \
	-e /opt/letsencrypt/src/acme \
	-e /opt/letsencrypt/src \
	-e /opt/letsencrypt/src/certbot-apache

ENV PATH /opt/letsencrypt/venv/bin:$PATH

ENTRYPOINT [ "certbot" ]
