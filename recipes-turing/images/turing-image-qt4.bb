DESCRIPTION = "Image with QT4 libraries"

# Base this image on turing-image-x11
include turing-image-x11.bb

IMAGE_INSTALL_append = "\
  packagegroup-core-qt4e \
  \
  "