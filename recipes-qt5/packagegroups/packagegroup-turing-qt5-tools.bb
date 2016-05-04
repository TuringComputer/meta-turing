#
# Copyright (C) 2016 Turing Computer
#

SUMMARY = "Qt5 Packages for development on Turing Computer System on Modules"
LICENSE = "MIT"

inherit packagegroup

RDEPENDS_packagegroup-turing-qt5-tools = "\
    qtbase \
  	qtbase-fonts \
  	qtbase-plugins \
  	qtdeclarative \
  	qtmultimedia \
  	qtsvg \
  	qtsensors \
  	qtsystems \
  	qt3d \
  	qtwebkit \
  	qtconnectivity \
    "
