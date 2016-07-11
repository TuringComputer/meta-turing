#
# Copyright (C) 2016 Turing Computer
#

SUMMARY = "Essential build dependencies for Turing Computer System on Modules"
LICENSE = "MIT"

inherit packagegroup

RDEPENDS_packagegroup-turing-build-tools = "\
    libgcc \
    libgcc-dev \
    libstdc++-staticdev \
  	ccache \
  	chkconfig \
  	glib-networking \
  	glibmm \
  	boost \
  	cmake \
  	zlib \
  	glib-2.0 \
  	gdbserver \
  	openssh-sftp-server \
	gdb \
    "
