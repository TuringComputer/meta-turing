#
# Copyright (C) 2016 Turing Computer
#

SUMMARY = "NodeJS packages for Turing Computer System on Modules"
LICENSE = "MIT"

inherit packagegroup

RDEPENDS_packagegroup-turing-nodejs = "\
    nodejs \
    nodejs-npm \
	nodejs-systemtap \
    node-red \
    \
    "
