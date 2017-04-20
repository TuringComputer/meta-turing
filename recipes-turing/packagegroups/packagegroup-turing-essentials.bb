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
    picocom \
    i2c-tools \
    strace \
    ltrace \
    ldd \
    libtool \ 
    pciutils \
    stress \
    memtester \
    evtest \
    mtd-utils \
    mtd-utils-ubifs \
  	imx-test \
  	util-linux \
  	coreutils \
  	usbutils \
  	cpufrequtils \
  	dbus \
  	alsa-utils \
    dosfstools \
    rt-tests \
    bc \
    pv \
    gawk \
    screen \
    logrotate \
    libidn \
    lsb \
    vim \
    file \
    perl-modules \
    unblank-fb2 \
    cronie \
    turing-production-tools \
    "
