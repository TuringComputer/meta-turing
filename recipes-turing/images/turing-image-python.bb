DESCRIPTION = "Image with Python Packages"

# Base this image on turing-image-x11
include turing-image-x11.bb

IMAGE_INSTALL_append = "\
  packagegroup-turing-python \
  \
  "