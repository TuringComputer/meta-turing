#
# Copyright (C) 2016 Turing Computer
#

SUMMARY = "Test and production tools for Turing Computer System on Modules"
LICENSE = "MIT"

inherit packagegroup

RDEPENDS_packagegroup-turing-tools = "\
    ${@bb.utils.contains("SOC_FAMILY", "mx6ul", "", "unblank-fb2", d)} \
    turing-production-tools \
    "
