DESCRIPTION = "XFCE image with lots of development tools and libraries for evaluating Turing Computer System on Modules."

# Base this image on turing-image-x11-full
include turing-image-x11-full.bb

IMAGE_INSTALL += " \
	packagegroup-xfce-extended \
    packagegroup-xfce-multimedia \
    "