DESCRIPTION = "Minimalistic image for evaluating Turing Computer System on Modules."

LICENSE = "MIT"

inherit core-image

IMAGE_INSTALL_append = "\
  tslib-conf tslib-tests tslib-calibrate tslib \
  nano iperf minicom i2c-tools strace libtool wget \
  wvdial canutils evtest \
  atmel-wireless-firmware \
  turing-production-tools \
  "
  