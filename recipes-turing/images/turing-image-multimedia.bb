DESCRIPTION = "Multimedia image for evaluating Turing Computer System on Modules."

# Base this image on turing-image-minimal
include turing-image-minimal.bb

IMAGE_INSTALL_append = "\
  packagegroup-core-buildessential \
  \
  packagegroup-turing-multimedia-tools \
  \
  packagegroup-turing-build-tools \
  \
  "