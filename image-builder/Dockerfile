FROM debian:latest

RUN apt-get -qq update && DEBIAN_FRONTEND=noninteractive \
    apt-get -yqq install \
        build-essential \
        git curl wget zip unzip gawk gettext file time \
        python python3 rsync man-db \
        libncurses-dev libssl-dev zlib1g-dev

ARG VERSION='19.07.8'
ARG ARCH=x86
ARG BOARD=64

ENV BASE_URL='https://downloads.openwrt.org/releases'
ENV PREFIX=openwrt-imagebuilder
ENV BASE_NAME=${PREFIX}-${VERSION}-${ARCH}-${BOARD}.Linux-${ARCH}_${BOARD}
ENV IMG_NAME=${BASE_NAME}.tar.xz
ENV IMG_URL=${BASE_URL}/${VERSION}/targets/${ARCH}/${BOARD}/${IMG_NAME}

RUN wget -P /data -q ${IMG_URL} && \
    tar -xf /data/${IMG_NAME} -C /data && \
    mkdir -p /home/build && \
    mv /data/${BASE_NAME} /home/build/openwrt

WORKDIR /home/build/openwrt

ONBUILD COPY files/ files/
ONBUILD COPY custom-*.sh ./
COPY docker-entrypoint.sh .
ENTRYPOINT [ "./docker-entrypoint.sh" ]
