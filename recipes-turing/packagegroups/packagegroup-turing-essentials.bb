#
# Copyright (C) 2016 Turing Computer
#

SUMMARY = "Essential test dependencies for Turing Computer System on Modules"
LICENSE = "MIT"

inherit packagegroup

RDEPENDS_packagegroup-turing-essentials = "\
    ${@bb.utils.contains("MACHINE_FEATURES", "touchscreen", "tslib-conf", "", d)} \
    ${@bb.utils.contains("MACHINE_FEATURES", "touchscreen", "tslib-tests", "", d)} \
    ${@bb.utils.contains("MACHINE_FEATURES", "touchscreen", "tslib-calibrate", "", d)} \
    ${@bb.utils.contains("MACHINE_FEATURES", "touchscreen", "tslib", "", d)} \
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
    cronie \
    watchdogd \
    rs485cfg \
    imx-kobs \
    "
