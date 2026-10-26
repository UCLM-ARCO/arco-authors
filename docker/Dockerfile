# source for https://github.com/UCLM-ARCO/arco-authors/packages/194314
# build from the repository root: docker build -f docker/Dockerfile .

FROM debian:trixie-slim AS build
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y --no-install-recommends build-essential debhelper

COPY . /src/arco-authors
WORKDIR /src/arco-authors
RUN dpkg-buildpackage -b -us -uc


FROM debian:trixie-slim
LABEL maintainer="David Villa <David.Villa@gmail.com>"
ENV DEBIAN_FRONTEND=noninteractive

ADD --chmod=644 https://uclm-arco.github.io/debian/uclm-arco.asc /usr/share/keyrings/arco.asc
COPY --from=build /src/arco-authors_*_all.deb /tmp/

RUN echo "deb http://deb.debian.org/debian trixie main contrib non-free non-free-firmware" > /etc/apt/sources.list && \
    apt-get update && \
    apt-get install -y --no-install-recommends ca-certificates make && \
    echo "deb [signed-by=/usr/share/keyrings/arco.asc] https://uclm-arco.github.io/debian/ sid main" > /etc/apt/sources.list.d/arco.list && \
    apt-get update && \
    apt-get install --no-install-recommends -y \
        /tmp/arco-authors_*_all.deb dbus git \
        texlive-xetex fonts-font-awesome fonts-liberation && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /var/cache/apt/* /var/cache/debconf/*-old && \
    rm -rf /var/log/* /tmp/* /var/tmp/* /usr/share/doc/*
