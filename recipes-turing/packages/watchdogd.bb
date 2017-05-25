SUMMARY = "Simple watchdog daemon package based on AOSP watchdogd"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://LICENSE;md5=e1c1057227af9e0c160c192e1644d8f6"

SRC_URI = "git://github.com/TuringComputer/watchdogd.git"
SRCREV = "7ee7e237c333fb048b27870ee545acf8518c3ddd"
PV = "1.0.0+git${SRCPV}"

S = "${WORKDIR}/git"

inherit autotools

# The autotools configuration I am basing this on seems to have a problem with a race condition when parallel make is enabled
PARALLEL_MAKE = ""