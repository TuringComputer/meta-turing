# Turing Computer i.MX6x U-boot

require recipes-bsp/u-boot/u-boot.inc

DESCRIPTION = "U-boot which includes support for Turing Machines."

PROVIDES += "u-boot"

PV = "2015.04"

LICENSE = "GPLv2+"
LIC_FILES_CHKSUM = "file://Licenses/README;md5=c7383a594871c03da76b3707929d2919"

SRCREV = "451ccbac378f2a9ba09450b407eb273564cac0e3"
SRCBRANCH = "imx-2015.04"

SRC_URI = "git://github.com/TuringComputer/uboot.git;protocol=https;branch=${SRCBRANCH}"

S = "${WORKDIR}/git"

PACKAGE_ARCH = "${MACHINE_ARCH}"
COMPATIBLE_MACHINE = "(imx6x-turing|imx53-turing)"
