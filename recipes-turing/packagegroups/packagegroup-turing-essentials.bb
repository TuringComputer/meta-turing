#
# Copyright (C) 2016 Turing Computer
#

SUMMARY = "Essential test dependencies for Turing Computer System on Modules"
LICENSE = "MIT"

inherit packagegroup

RDEPENDS_packagegroup-turing-essentials = "\
    tslib-conf \
    tslib-tests \
    tslib-calibrate \
    tslib \
    nano \
    iperf \
    minicom \
    i2c-tools \
    strace \
    libtool \ 
    pciutils \
    stress \
    memtester \
    canutils \
    evtest \
    mtd-utils \
    mtd-utils-ubifs \
  	imx-test \
  	util-linux \
  	coreutils \
  	cpufrequtils \
  	ethtool \
  	dbus \
  	alsa-utils \
    dosfstools \
    rt-tests \
    unblank-fb2 \
    turing-production-tools \
    "
