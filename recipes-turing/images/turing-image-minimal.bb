DESCRIPTION = "Minimalistic image for evaluating Turing Computer System on Modules."

LICENSE = "MIT"

inherit core-image

IMAGE_INSTALL_append = "\
  packagegroup-turing-test-tools \
  packagegroup-fsl-tools-testapps \
  packagegroup-turing-network-tools \
  \
  atmel-wireless-firmware \
  linux-firmware \
  "
  