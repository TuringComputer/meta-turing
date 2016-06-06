SUMMARY = "Atmel wilc1000 firmware files for use with Linux kernel"
SECTION = "kernel"

LICENSE = "CLOSED"

PV = "v14"
SRCREV = "972649eb26024be096d3f33cd2dd54d8309156de"
SRCBRANCH = "master"

SRC_URI = "git://github.com/atwilc3000/firmware.git;protocol=git;branch=${SRCBRANCH} \
          "
S = "${WORKDIR}/git"

inherit allarch

do_compile() {
	:
}

do_install() {
	install -d  ${D}/lib/firmware/atmel/
	cp -r * ${D}/lib/firmware/atmel/

	# remove unneeded file
	rm -f ${D}/lib/firmware/atmel/README.md
	rm -rf ${D}/lib/firmware/atmel/tools
	chmod -x ${D}/lib/firmware/atmel/*
}


FILES_${PN} = " \
  /lib/firmware/atmel/*.bin \
"
# TODO: use ALTERNATIVE like in "linux-firmware" package
