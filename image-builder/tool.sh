#!/usr/bin/env bash

build(){
    docker build -t ghcr.io/lesscodex/pkg/openwrt:imagebuilder .
}

get_package(){
    docker pull ghcr.io/lesscodex/pkg/openwrt:imagebuilder
    docker run -d -i --name openwrt-imagebuilder ghcr.io/lesscodex/pkg/openwrt:imagebuilder

    FILE_NAME=openwrt-imagebuilder-23.05.4-x86-64.Linux-x86_64.tar.xz

    docker cp openwrt-imagebuilder:"/data/${FILE_NAME}" .
    docker container stop openwrt-imagebuilder
    docker container rm openwrt-imagebuilder
}

info(){
    echo 'Please execute with a option:'
    echo 'build - manual build at local.'
    echo 'getpack - download openwrt-imagebuilder package in docker image.'
}

if [ -n "$1" ];
then
    case $1 in
        build)
            build
            ;;
        getpack)
            get_package
            ;;
        *)
            info
            ;;
    esac
else info
fi
