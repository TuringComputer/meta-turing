#
# Copyright (C) 2016 Turing Computer
#

SUMMARY = "Qt5 Packages for development on Turing Computer System on Modules"
LICENSE = "MIT"

inherit packagegroup

RDEPENDS_packagegroup-turing-qt5-tools = "\
        qtbase \
  	qtbase-fonts \
  	qtbase-plugins \
  	qtcanvas3d \
  	qtcanvas3d-qmlplugins \
  	qtconnectivity \
  	qtconnectivity-qmlplugins \
  	qtdeclarative \
  	qtdeclarative-plugins \
  	qtdeclarative-qmlplugins \
  	qtenginio \
  	qtenginio-qmlplugins \
  	qtgraphicaleffects \
  	qtgraphicaleffects-qmlplugins \
  	qtimageformats \
  	qtimageformats-plugins \
  	qtlocation \
  	qtlocation-plugins \
  	qtlocation-qmlplugins \
  	qtmultimedia \
  	qtmultimedia-plugins \
  	qtmultimedia-qmlplugins \
  	qtquick1 \
  	qtquick1-plugins \
  	qtquick1-qmlplugins \
  	qtquickcontrols \
  	qtscript \
  	qtsensors \
  	qtsensors-plugins \
  	qtsensors-qmlplugins \
  	qtserialport \
  	qtsvg \
  	qtsvg-plugins \
  	qtsystems \
  	qtsystems-qmlplugins \
  	qttranslations \
  	qttools \
  	qttools-plugins \
  	qtwebchannel \
  	qtwebchannel-qmlplugins \
  	qtwebkit \
  	qtwebkit-qmlplugins \
  	qtwebsockets \
  	qtwebsockets-qmlplugins \
  	qtxmlpatterns \
    "
