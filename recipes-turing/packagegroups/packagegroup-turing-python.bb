#
# Copyright (C) 2016 Turing Computer
#

SUMMARY = "Python packages for Turing Computer System on Modules"
LICENSE = "MIT"

inherit packagegroup

RDEPENDS_packagegroup-turing-python = "\
    python \
    python-core \
    python-modules \
    python-pip \
    python-setuptools \
    python-dbus \
    \
    "
