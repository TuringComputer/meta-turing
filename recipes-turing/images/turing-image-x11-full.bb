DESCRIPTION = "X11 image with lots of development tools and libraries for evaluating Turing Computer System on Modules."

# Base this image on turing-image-x11
include turing-image-x11.bb

IMAGE_INSTALL += " \
	packagegroup-core-qt4e \
	packagegroup-turing-python \
	oracle-jse-jre \
	chromium \
	firefox \
	libmysqlclient-dev \
    mariadb \
    "