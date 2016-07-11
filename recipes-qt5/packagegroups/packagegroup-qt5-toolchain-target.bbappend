FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

RDEPENDS_${PN} += " \
	qtcanvas3d-dev \
	qtcanvas3d \
  	qtcanvas3d-qmlplugins \
	qtquick1-dev \
    qtquick1-mkspecs \
    qtquick1-plugins \
    qtquick1-qmlplugins \
    qtquickcontrols-dev \
    qttranslations-qtquick1 \
    qttools-plugins \
    qtwebkit-dev \
    qtwebkit-mkspecs \
    qtwebkit-qmlplugins \
    qtwebengine-dev \
    qtwebengine-mkspecs \
    qtwebengine-plugins \
    qtwebengine-qmlplugins \
	"

