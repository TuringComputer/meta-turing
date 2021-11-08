DESCRIPTION = "X11 image with lots of development tools and libraries for evaluating Turing Computer System on Modules."

# Base this image on turing-image-x11
include turing-image-x11.bb

IMAGE_INSTALL += " \
	${@bb.utils.contains("MACHINE_FEATURES", "touchscreen", "packagegroup-core-qt4e", "", d)} \
	packagegroup-turing-python \
	${@bb.utils.contains("SOC_FAMILY", "mx6ul", "", "packagegroup-turing-opencv", d)} \
	packagegroup-turing-mono \
    packagegroup-turing-nodejs \
	oracle-jse-jre \
	leafpad \
    "
    
# 3.5GB
#IMAGE_ROOTFS_SIZE = "3670016"
