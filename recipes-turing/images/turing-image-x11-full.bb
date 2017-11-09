DESCRIPTION = "X11 image with lots of development tools and libraries for evaluating Turing Computer System on Modules."

# Base this image on turing-image-x11
include turing-image-x11.bb

IMAGE_INSTALL += " \
	packagegroup-core-qt4e \
	packagegroup-turing-python \
	packagegroup-turing-opencv \
	packagegroup-turing-mono \
	packagegroup-turing-nodejs \
	oracle-jse-jre \
        ${@base_contains("SOC_FAMILY", "mx6ul", "", "chromium", d)} \
	leafpad \
    "
