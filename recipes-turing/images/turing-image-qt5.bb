DESCRIPTION = "Image with QT5 libraries and demo for development. \
Also includes many other packages for testing and manufacturing boards based on Turing Computer System on Modules"

IMAGE_FEATURES += "splash ssh-server-openssh hwcodecs dev-pkgs nfs-server"

LICENSE = "MIT"

inherit core-image

IMAGE_INSTALL_append = "\
  packagegroup-core-buildessential \
  \
  packagegroup-turing-essentials \
  packagegroup-turing-network-tools \
  \
  packagegroup-turing-linux-firmware \
  \
  packagegroup-turing-multimedia-tools \
  \
  packagegroup-turing-build-tools \
  packagegroup-turing-qt5-tools \
  \
  cinematicexperience \
  qt5-demo \
  "

