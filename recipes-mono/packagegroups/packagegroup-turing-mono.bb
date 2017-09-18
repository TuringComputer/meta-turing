#
# Copyright (C) 2016 Turing Computer
#

SUMMARY = "Mono Packages for development on Turing Computer System on Modules"
LICENSE = "MIT"

inherit packagegroup

RDEPENDS_packagegroup-turing-mono = "\
	tzdata \
	mono \
  	gtk-sharp \
  	mono-helloworld \
  	taglib-sharp \
  	fsharp \
  	libgdiplus \
  	mono-basic \
    "
