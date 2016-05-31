#
# Copyright (C) 2016 Turing Computer
#

SUMMARY = "Essential test dependencies for Turing Computer System on Modules"
LICENSE = "MIT"

inherit packagegroup

RDEPENDS_packagegroup-turing-test-tools = "\
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
    wvdial \
    canutils \
    evtest \
    ethtool \
    mtd-utils \
    mtd-utils-ubifs \
    ${@base_contains("SOC_FAMILY", "mx6ul", "", "imx-vpu", d)} \
  	imx-test \
  	util-linux \
  	coreutils \
  	cpufrequtils \
    turing-production-tools \
    "
