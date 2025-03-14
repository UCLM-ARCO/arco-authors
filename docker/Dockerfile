# source for https://github.com/UCLM-ARCO/arco-authors/packages/194314

FROM debian:bookworm-slim
LABEL maintainer="David Villa <David.Villa@gmail.com>"
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update; \
    apt-get install -y gnupg2 ca-certificates make; \
    echo "deb https://uclm-arco.github.io/debian/ sid main" > /etc/apt/sources.list.d/arco.list; \
    apt-key adv --fetch-keys https://uclm-arco.github.io/debian/uclm-arco.asc; \
    apt-get update; \
    apt-get install --no-install-recommends -y \
        arco-authors dbus git \
        texlive-xetex fonts-font-awesome fonts-liberation &&\
        apt-get -y clean; apt-get -y autoclean; apt-get -y autoremove &&\
        rm -rf /var/lib/apt/lists/* /var/cache/apt/* /var/cache/debconf/*-old &&\
        rm -rf /var/log/* /tmp/* /var/tmp/* /usr/share/doc/*
