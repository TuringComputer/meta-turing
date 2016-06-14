# Turing Computer i.MX6 Linux/kernel

LICENSE = "GPLv2"

require recipes-kernel/linux/linux-imx.inc
require recipes-kernel/linux/linux-dtb.inc

SUMMARY = "Turing 3.14.52 kernel"
DESCRIPTION = "Linux kernel for Turing Machines, with full support for the i.MX6 features."

DEPENDS += "lzop-native bc-native"

SRCREV = "e0b664d72fe8e367ea1e9b019532f1330bc8076f"
SRCBRANCH = "imx6x-3.14.52"

SRC_URI = "git://github.com/TuringComputer/linux.git;protocol=https;branch=${SRCBRANCH} \
           file://defconfig"

COMPATIBLE_MACHINE = "(imx6x-turing|imx6x-turing-smart)"
