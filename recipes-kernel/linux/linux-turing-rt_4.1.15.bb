# Turing Computer i.MX6 Real-Time Linux/kernel

LICENSE = "GPLv2"

require recipes-kernel/linux/linux-imx.inc
require recipes-kernel/linux/linux-dtb.inc

SUMMARY = "Turing 4.1.15 real-time kernel"
DESCRIPTION = "Linux kernel for Turing Machines, with full support for the i.MX6 features."

DEPENDS += "lzop-native bc-native"

SRCREV = "8f9118a77443fb69ee4bb03f2705419d51984c6e"
SRCBRANCH = "imx6x-4.1.15"

SRC_URI = "git://github.com/TuringComputer/linux.git;protocol=https;branch=${SRCBRANCH} \
           file://defconfig \
    	   https://www.kernel.org/pub/linux/kernel/projects/rt/4.1/older/patch-4.1.15-rt18.patch.gz;name=patch-4.1.15-rt18.patch \
           file://0001-fix-build.patch \
           file://0002-no-split-ptlocks.patch \
           file://0003-Work-around-CPU-stalls-in-the-imx-sdma-driver.patch \
		  " 

SRC_URI[patch-4.1.15-rt18.patch.md5sum] = "4763c22c4dcf49ba07cdf60984732fe4"
SRC_URI[patch-4.1.15-rt18.patch.sha256sum] = "a317242e5e79fccc204f170328469e79d1aa663501dc4ec5e425199fb0ac9605"

COMPATIBLE_MACHINE = "(imx6x-turing|imx6x-turing-smart)"
