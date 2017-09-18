DESCRIPTION = "Image with OpenCV libraries for evaluating Turing Computer System on Modules."

# Base this image on turing-image-x11
include turing-image-x11.bb

IMAGE_INSTALL_append = "\
  packagegroup-turing-opencv \
  \
  "