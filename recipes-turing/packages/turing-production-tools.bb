DESCRIPTION = "Turing Computer Production Scripts"

LICENSE = "CLOSED"

SRCREV = "${AUTOREV}"
PV = "v1"

SRC_URI = "file://install-emmc.sh \
          "

do_compile() {
	:
}

do_install() {
	install -d ${D}${sbindir}
	install -m 0755 ${WORKDIR}/install-emmc.sh ${D}${sbindir}/install-emmc
}
