DESCRIPTION = "Image with QT5 libraries and demos for development."

# Base this image on turing-image-multimedia
include turing-image-multimedia.bb

IMAGE_INSTALL_append = "\
  packagegroup-turing-qt5 \
  \
  packagegroup-turing-qt5-demos \
  \
  "