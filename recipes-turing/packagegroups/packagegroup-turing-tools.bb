#
# Copyright (C) 2016 Turing Computer
#

SUMMARY = "Test and production tools for Turing Computer System on Modules"
LICENSE = "MIT"

inherit packagegroup

RDEPENDS_packagegroup-turing-tools = "\
    unblank-fb2 \
    turing-production-tools \
    "
