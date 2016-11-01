DESCRIPTION = "X11 image for evaluating Turing Computer System on Modules."

# Base this image on turing-image-multimedia
include turing-image-multimedia.bb

REQUIRED_DISTRO_FEATURES = "x11"

IMAGE_FEATURES += "x11-base"

IMAGE_INSTALL += " \
	packagegroup-turing-x11 \
    "