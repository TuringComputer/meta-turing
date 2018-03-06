# Turing Computer i.MX u-boot

require recipes-bsp/u-boot/u-boot.inc

DESCRIPTION = "U-boot which includes support for Turing Machines."

PROVIDES += "u-boot"

PV = "2017.03"

LICENSE = "GPLv2+"
LIC_FILES_CHKSUM = "file://Licenses/README;md5=a2c678cfd4a4d97135585cad908541c6"

SRCREV = "ad53385e6f82e876761d6aee4786ce122510b8ce"
SRCBRANCH = "imx-2017.03"

SRC_URI = "git://github.com/TuringComputer/uboot.git;protocol=https;branch=${SRCBRANCH}"

S = "${WORKDIR}/git"

PACKAGE_ARCH = "${MACHINE_ARCH}"
COMPATIBLE_MACHINE = "(imx6ul-turing|imx6x-turing|imx6x-turing-smart|imx53-turing)"
