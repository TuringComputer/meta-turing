#
# Copyright (C) 2016 Turing Computer
#

SUMMARY = "Essential networking dependencies for Turing Computer System on Modules"
LICENSE = "MIT"

inherit packagegroup

RDEPENDS_packagegroup-turing-network-tools = "\
    openssh-sftp-server \
    dhcp-client \
    dhcp-server \
    hostapd \
    wget \
    wvdial \
    iptables \
    openssl \
    ca-certificates \
    libssh2 \
    net-tools \
    libcurl \
    curl \
    netcat \
    apache2 \
    wpa-supplicant \
    nfs-utils \
    tcpdump \
    canutils \
    ethtool \
    bridge-utils \
    libnfc-nci \
    "
