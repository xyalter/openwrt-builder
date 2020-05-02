#!/usr/bin/env bash

TEMPLATES_PATH=$(pwd)/../templates

source $TEMPLATES_PATH/util.sh
source $TEMPLATES_PATH/base/build-base.sh

# cp_test(dst_path)
cp_test(){
    rm -rf $1/ && mkdir -p $1/files
    cp_base $1 && \
    cp -r files/* $1/files/
    cp Dockerfile $1/
}

# build_test(image_name, envfile)
build_test(){
    build_image $1 $2 \
        PACKAGES="luci luci-i18n-base-zh-cn luci-i18n-firewall-zh-cn \
            shadow-chpasswd openssh-sftp-server \
            bind-dig curl libustream-openssl \
            -dnsmasq dnsmasq-full -ip-tiny ip-full \
            mwan3 keepalived miniupnpd etherwake \
            kmod-tun softethervpn" \
        FILES="files/"
}

build() {
    local image_name=test
    local temp_dir=$image_name-temp

    cp_test $temp_dir
    chmod +x $temp_dir/files/etc/uci-defaults/99_test-network.sh

    build_docker $image_name
    build_test $image_name ./env.list
    cp_rootfs $image_name
    cp_vmdk $image_name
    remove_instance $image_name
    rm -rf $temp_dir
}

build
