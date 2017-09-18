#
# Copyright (C) 2016 Turing Computer
#

SUMMARY = "Essential multimedia packages for Turing Computer System on Modules"
LICENSE = "MIT"

inherit packagegroup

RDEPENDS_packagegroup-turing-multimedia-tools = "\
	packagegroup-fsl-tools-gpu \
	packagegroup-fsl-gstreamer1.0 \
    packagegroup-fsl-gstreamer1.0-full \
  	gstreamer1.0-plugins-imx \
  	${@bb.utils.contains("SOC_FAMILY", "mx6ul", "", "imx-vpu", d)} \
  	fmtools \
  	ffmpeg \
  	speex \
  	pulseaudio \
  	cairo pango fontconfig fontconfig-utils freetype \
  	packagegroup-fonts-truetype \
    alsa-lib alsa-state fsl-alsa-plugins \
    "
