#
# Copyright (C) 2016 Turing Computer
#

SUMMARY = "Qt5 Demos on Turing Computer System on Modules"
LICENSE = "MIT"

inherit packagegroup

RDEPENDS_packagegroup-turing-qt5-demos = "\
    qtsmarthome \
    qt5ledscreen \
    quitbattery \
    qt5everywheredemo \ 
    qt5nmapcarousedemo \
    qt5nmapper \
    cinematicexperience \
    quitindicators \
    \
    qt5-demo \
    "
