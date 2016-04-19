#!/bin/sh

print_usage()
{
	echo -e "\nUSAGE: ${0} --fw-dir=[firmware-dir]\n"
	echo -e "EXAMPLE:"
	echo -e "${0} --fw-dir=/fw \n"
	return
}

FW_DIR="/fw"

#######################################
# Parse command-line arguments
#######################################

for i in $*
do
        case $i in
        --fw-dir=*)
                FW_DIR=`echo $i | sed 's/[-a-zA-Z0-9]*=//'`
                ;;
        *)
                # unknown option
                print_usage
                exit 1
                ;;
        esac
done


# Starting
echo "Installing firmware on e-MMC..."

# Enables boot partitions
echo 8 > /sys/devices/soc0/soc.0/2100000.aips-bus/219c000.usdhc/mmc_host/mmc3/mmc3:0001/boot_config || exit 1

# Enable writes to /dev/mmcblk3boot0

echo 0 > /sys/block/mmcblk3boot0/force_ro || exit 1

# Precaution: Erase entire eMMC boot region.

dd if=/dev/zero of=/dev/mmcblk3boot0
sync

# Copy SPL to eMMC 1st boot region.

dd if=${FW_DIR}/SPL of=/dev/mmcblk3boot0 bs=1k seek=1 || exit 1
sync

# Enable writes to /dev/mmcblk3boot1

echo 0 > /sys/block/mmcblk3boot1/force_ro || exit 1

# Precaution: Erase entire eMMC boot region.

dd if=/dev/zero of=/dev/mmcblk3boot1
sync

# Copy SPL to eMMC 2nd boot region.

dd if=${FW_DIR}/SPL of=/dev/mmcblk3boot1 bs=1k seek=1 || exit 1
sync

# Install the whole Yocto image to eMMC.

dd if=${FW_DIR}/turing-image-qt5-imx6x-turing.sdcard of=/dev/mmcblk3 bs=1k || exit 1
sync

# Done
echo "Firmware installed successfully!"