DESCRIPTION = "fmtools - Programs for Video for Linux Radio Cards"
LICENSE = "GPLv2"
LIC_FILES_CHKSUM = "file://${COREBASE}/meta/files/common-licenses/GPL-2.0;md5=801f80980d171dd6425610833a22dbe6"
PR = "r1"

SRC_URI = "http://benpfaff.org/fmtools/fmtools-2.0.7.tar.gz"
SRC_URI[md5sum] = "132b6d305b0c48eb8da0610873b15d62"
SRC_URI[sha256sum] = "75174e07d8cde6d4a8a5d7bbaa3a3b0760a850e7f6840cb7c6246227b18f5a39"

CFLAGS += "${LDFLAGS}"

do_install() {
    install -d ${D}${bindir}
    install -m 0755 ${S}/fm ${D}${bindir}/fm
    install -m 0755 ${S}/fmscan ${D}${bindir}/fmscan
}

inherit autotools