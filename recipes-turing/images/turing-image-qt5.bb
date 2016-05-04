DESCRIPTION = "Image with QT5 libraries and demo for development work. \
Also includes many other packages for testing and manufacturing boards based on Turing Computer System on Modules"

IMAGE_FEATURES += "splash package-management ssh-server-openssh ssh-server-dropbear hwcodecs dev-pkgs"

LICENSE = "MIT"

inherit core-image

IMAGE_INSTALL_append = "\
  packagegroup-core-buildessential \
  packagegroup-fsl-tools-testapps \
  packagegroup-turing-test-tools \
  packagegroup-turing-build-tools \
  packagegroup-turing-qt5-tools \
  \
  atmel-wireless-firmware \
  cinematicexperience \
  qt5-demo \
  "
  
IMAGE_DEV_MANAGER   = "udev"
IMAGE_INIT_MANAGER  = "systemd"
IMAGE_INITSCRIPTS   = " "
IMAGE_LOGIN_MANAGER = "busybox shadow"
