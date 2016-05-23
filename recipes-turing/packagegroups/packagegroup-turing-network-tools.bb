#
# Copyright (C) 2016 Turing Computer
#

SUMMARY = "Essential networking dependencies for Turing Computer System on Modules"
LICENSE = "MIT"

inherit packagegroup

RDEPENDS_packagegroup-turing-network-tools = "\
    dhcp-client \
    dhcp-server \
    hostapd \
    "
