DESCRIPTION = "Turing Computer Production Scripts"

LICENSE = "CLOSED"

SRCREV = "${AUTOREV}"
PV = "v1"

SRC_URI = "file://install-emmc.sh \
           file://install-emmc-android.sh \
		   file://install-nand.sh \
           file://board-test.sh \
          "

do_compile() {
	:
}

do_install() {
	install -d ${D}${sbindir}
	install -m 0755 ${WORKDIR}/install-emmc.sh ${D}${sbindir}/install-emmc
	install -m 0755 ${WORKDIR}/install-emmc-android.sh ${D}${sbindir}/install-emmc-android
	install -m 0755 ${WORKDIR}/install-nand.sh ${D}${sbindir}/install-nand
	install -m 0755 ${WORKDIR}/board-test.sh ${D}${sbindir}/board-test
}
