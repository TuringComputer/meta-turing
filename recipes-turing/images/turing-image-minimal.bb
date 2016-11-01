DESCRIPTION = "Minimalistic image for evaluating Turing Computer System on Modules."

# Base this image on core-image-base
include recipes-core/images/core-image-base.bb

IMAGE_FEATURES += "splash package-management ssh-server-openssh hwcodecs dev-pkgs nfs-server"

IMAGE_INSTALL_append = "\
  packagegroup-turing-essentials \
  packagegroup-turing-network-tools \
  \
  packagegroup-turing-linux-firmware \
  "