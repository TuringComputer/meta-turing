DESCRIPTION = "Multimedia image for evaluating Turing Computer System on Modules."

IMAGE_FEATURES += "splash ssh-server-openssh hwcodecs dev-pkgs nfs-server"

LICENSE = "MIT"

inherit core-image

IMAGE_INSTALL_append = "\
  packagegroup-turing-essentials \
  packagegroup-turing-network-tools \
  \
  packagegroup-turing-linux-firmware \
  packagegroup-turing-multimedia-tools \
  \
  "
  