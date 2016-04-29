# Turing Computer i.MX6 Linux/kernel

LICENSE = "GPLv2"

require recipes-kernel/linux/linux-imx.inc
require recipes-kernel/linux/linux-dtb.inc

SUMMARY = "Turing 3.14.28 kernel"
DESCRIPTION = "Linux kernel for Turing Machines, with full support for the i.MX6 features."

DEPENDS += "lzop-native bc-native"

SRCREV = "2243c0b4a26bb14cda0a2b8f13ee1a954a17caa1"
SRCBRANCH = "imx6x-3.14.28"

SRC_URI = "git://github.com/TuringComputer/linux.git;protocol=https;branch=${SRCBRANCH} \
           file://defconfig"

COMPATIBLE_MACHINE = "(imx6x-turing|imx6x-turing-smart)"
