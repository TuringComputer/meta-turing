#
# Copyright (C) 2016 Turing Computer
#

SUMMARY = "Firmware files for Turing Computer System on Modules"
LICENSE = "MIT"

inherit packagegroup

RDEPENDS_packagegroup-turing-linux-firmware = "\
	atmel-wireless-firmware \
	linux-firmware-iwlwifi-135-6 \
	linux-firmware-iwlwifi-3160-7 \
	linux-firmware-iwlwifi-3160-8 \
	linux-firmware-iwlwifi-3160-9 \
	linux-firmware-iwlwifi-6000-4 \
	linux-firmware-iwlwifi-6000g2a-5 \
	linux-firmware-iwlwifi-6000g2a-6 \
	linux-firmware-iwlwifi-6000g2b-6 \
	linux-firmware-iwlwifi-6050-4 \
	linux-firmware-iwlwifi-6050-5 \
	linux-firmware-iwlwifi-7260-7 \
	linux-firmware-iwlwifi-7260-8 \
	linux-firmware-iwlwifi-7260-9 \
	linux-firmware-iwlwifi-7265-8 \
	linux-firmware-iwlwifi-7265-9 \
    "
