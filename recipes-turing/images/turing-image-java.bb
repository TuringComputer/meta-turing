DESCRIPTION = "Image with Oracle's Java Runtime Environment"

# Base this image on turing-image-x11
include turing-image-x11.bb

IMAGE_INSTALL_append = "\
  oracle-jse-jre \
  \
  "
