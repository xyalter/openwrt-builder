#!/bin/ash
#
# Copyright (C) 2019 xxy1991
#

uci -q batch <<-EOF >/dev/null
    set network.lan=interface
    set network.lan.ifname='eth0.9'
    set network.lan.proto='static'
    set network.lan.ipaddr='10.146.9.1'
    set network.lan.netmask='255.255.255.0'

    set network.wan=interface
    set network.wan.ifname='eth1.3'
    set network.wan.proto='dhcp'
    set network.wan.dns='127.0.0.1'

    commit network
EOF

exit 0
