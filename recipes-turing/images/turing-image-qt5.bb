DESCRIPTION = "Image with QT5 libraries and demo for development work. \
Also includes many other packages for testing and manufacturing boards based on Turing Computer System on Modules"

IMAGE_FEATURES += "splash package-management ssh-server-openssh ssh-server-dropbear hwcodecs dev-pkgs"

LICENSE = "MIT"

inherit core-image

IMAGE_INSTALL_append = "gcc g++ binutils libgcc libgcc-dev libstdc++ libstdc++-dev libstdc++-staticdev \
  autoconf automake ccache chkconfig glib-networking glibmm \
  packagegroup-core-buildessential pkgconfig  \
  boost cmake zlib glib-2.0 packagegroup-fsl-tools-testapps \
  \
  gdbserver \
  qtbase \
  qtbase-fonts \
  qtbase-plugins \
  qtdeclarative \
  qtmultimedia \
  qtsvg \
  qtsensors \
  qtsystems \
  qt3d \
  qtwebkit \
  qtconnectivity \
  cinematicexperience \
  openssh-sftp-server \
  dbus \
  gdb \
  imx-vpu \
  imx-test \
  packagegroup-fsl-gstreamer1.0-full \
  tslib-conf tslib-tests tslib-calibrate tslib \
  nano iperf minicom i2c-tools strace libtool git wget \
  wvdial canutils evtest \
  atmel-wireless-firmware \
  turing-production-tools \
  qt5-demo \
  "
  
IMAGE_DEV_MANAGER   = "udev"
IMAGE_INIT_MANAGER  = "systemd"
IMAGE_INITSCRIPTS   = " "
IMAGE_LOGIN_MANAGER = "busybox shadow"
