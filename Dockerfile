FROM debian:buster
LABEL maintainer="David Villa <David.Villa@gmail.com>"
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update; \
    apt-get install -y gnupg2 ca-certificates make; \
    echo "deb https://uclm-arco.github.io/debian/ sid main" > /etc/apt/sources.list.d/arco.list; \
    apt-key adv --fetch-keys https://uclm-arco.github.io/debian/key.asc; \
    apt-get update; \
    apt-get install --no-install-recommends -y arco-authors; \
    apt-get -y clean; apt-get -y autoclean; apt-get -y autoremove