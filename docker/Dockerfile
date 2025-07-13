# source for https://github.com/UCLM-ARCO/arco-authors/packages/194314

FROM debian:trixie-slim
LABEL maintainer="David Villa <David.Villa@gmail.com>"
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        curl ca-certificates gnupg make && \
    rm -rf /var/lib/apt/lists/*

RUN curl -fsSL https://uclm-arco.github.io/debian/uclm-arco.asc -o /usr/share/keyrings/arco.gpg

RUN echo "deb [signed-by=/usr/share/keyrings/arco.gpg] https://uclm-arco.github.io/debian/ sid main" > /etc/apt/sources.list.d/arco.list && \
    echo "deb http://deb.debian.org/debian trixie main contrib non-free non-free-firmware" > /etc/apt/sources.list

RUN apt-get update && \
    apt-get install --no-install-recommends -y \
        arco-authors dbus git \
        texlive-xetex fonts-font-awesome fonts-liberation && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /var/cache/apt/* /var/cache/debconf/*-old && \
    rm -rf /var/log/* /tmp/* /var/tmp/* /usr/share/doc/*
