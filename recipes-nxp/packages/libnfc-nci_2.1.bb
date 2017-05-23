SUMMARY = "Linux NFC stack for NCI based NXP NFC Controllers"
HOMEPAGE = "github.com/NXPNFCLinux/linux_libnfc-nci"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://src/include/linux_nfc_api.h;endline=17;md5=42fdb99b3ff2c12f594b22a774cb7308"
SECTION = "libs"

SRC_URI = "git://github.com/NXPNFCLinux/linux_libnfc-nci.git"
SRCREV = "81995a478acac6adadbba06bfa12ce3c83fecc1f"
PV = "2.1+git${SRCPV}"

S = "${WORKDIR}/git"

inherit autotools

PACKAGECONFIG ?= "pn7150"
PACKAGECONFIG[pn7150] = "--enable-pn7150,--enable-pn7120"

FILES_${PN} += " \
			   ${libdir}/libnfc_nci_linux-1.so \
			   ${sbindir}/nfcDemoApp \
			   "
			   
# Make sure it isn’t in the dev package’s files list
FILES_SOLIBSDEV = "${libdir}/libnfc_nci_linux.so"