DESCRIPTION = "Qt5 Demo Application as a Systemd Startup Service"

inherit systemd

LICENSE = "CLOSED"

SRCREV = "${AUTOREV}"
PV = "v1"

# Qt5 Demo Service
SRC_URI = "file://${PN}.service \
           file://${PN}.sh \
          "

do_compile() {
	:
}

do_install() {
	install -d ${D}${systemd_unitdir}/system/ ${D}${sysconfdir}/systemd/system/
	install -d ${D}${sbindir}
	
	install -m 0644 ${WORKDIR}/${PN}.service ${D}${systemd_unitdir}/system
	install -m 0755 ${WORKDIR}/${PN}.sh ${D}${sbindir}/${PN}
}

NATIVE_SYSTEMD_SUPPORT = "1"
SYSTEMD_PACKAGES = "${PN}"
SYSTEMD_SERVICE_${PN} = "${PN}.service"

RDEPENDS_${PN} = "cinematicexperience"