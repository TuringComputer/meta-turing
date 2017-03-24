#
# Copyright (C) 2016 Turing Computer
#

SUMMARY = "OpenCV packages for Turing Computer System on Modules"
LICENSE = "MIT"

inherit packagegroup

RDEPENDS_packagegroup-turing-opencv = "\
    libopencv-core-dev \
    libopencv-highgui-dev \
    libopencv-imgproc-dev \
    libopencv-objdetect-dev \
    libopencv-ml-dev \
    \
    "
