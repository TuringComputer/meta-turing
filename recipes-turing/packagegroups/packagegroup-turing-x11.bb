#
# Copyright (C) 2016 Turing Computer
#

SUMMARY = "X11 packages for Turing Computer System on Modules"
LICENSE = "MIT"

inherit packagegroup

RDEPENDS_packagegroup-turing-x11 = "\
    libice \
    libice-dev \
    libsm \
    libsm-dev \
    libx11 \
    libxcalibrate \
    libxext \
    libxinerama \
    libxmu \
    libxt \
    libx11-locale \
    mkfontdir \
    mkfontscale \
    x11-common-dev \
    xextproto-dev \
    xproto-dev \
    xserver-xorg-dev \
    xserver-xorg-utils \    
    icu \    
    \
    "
