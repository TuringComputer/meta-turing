# Turing Computer i.MX6 Linux/kernel

LICENSE = "GPLv2"

require recipes-kernel/linux/linux-imx.inc
require recipes-kernel/linux/linux-dtb.inc

SUMMARY = "Turing 4.1.15 kernel"
DESCRIPTION = "Linux kernel for Turing Machines, with full support for the i.MX6 features."

DEPENDS += "lzop-native bc-native"

SRCREV = "78230fcbb6247390c54c778dcd1983b54d265882"
SRCBRANCH = "imx6x-4.1.15"

SRC_URI = "git://github.com/TuringComputer/linux.git;protocol=https;branch=${SRCBRANCH} \
           file://defconfig"

COMPATIBLE_MACHINE = "(imx6ul-turing|imx6x-turing|imx6x-turing-smart)"
