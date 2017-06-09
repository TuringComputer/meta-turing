SUMMARY = "Small application to configure a serial (TTY) port in RS485 mode for Turing Boards"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://LICENSE;md5=e1c1057227af9e0c160c192e1644d8f6"

SRC_URI = "git://github.com/TuringComputer/rs485_cfg.git"
SRCREV = "dfda8fd970333cfa2cd5ea3140950bda581d184a"
PV = "1.0.0+git${SRCPV}"

S = "${WORKDIR}/git"

inherit autotools

# The autotools configuration I am basing this on seems to have a problem with a race condition when parallel make is enabled
PARALLEL_MAKE = ""