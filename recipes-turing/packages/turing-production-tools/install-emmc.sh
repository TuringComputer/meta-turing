#!/bin/sh

print_usage()
{
	echo -e "\nUSAGE: ${0} --fw-dir=[firmware-dir] --fw-dev=[firmware-dev] --install-rootfs=[true|false] --fw-img=[image-filename]\n"
	echo -e "EXAMPLE:"
	echo -e "${0} --fw-dir=/media/fw --fw-dev=/dev/mmcblk0p3 --install-rootfs=true --fw-img=image.sdcard\n"
	return
}

function error_exit
{
	echo "$1" 1>&2
	exit 1
	return
}

FW_DIR="/media/fw"
FW_DEV="/dev/mmcblk0p3"
INSTALL_ROOTFS=true
FW_IMAGE=image.sdcard

#######################################
# Parse command-line arguments
#######################################

for i in $*
do
        case $i in
        --fw-dir=*)
                FW_DIR=`echo $i | sed 's/[-a-zA-Z0-9]*=//'`
                ;;
        --fw-dev=*)
	            FW_DEV=`echo $i | sed 's/[-a-zA-Z0-9]*=//'`
	            ;;
        --install-rootfs=*)
	            INSTALL_ROOTFS=`echo $i | sed 's/[-a-zA-Z0-9]*=//'`
	            ;;
	    --fw-img=*)
	            FW_IMAGE=`echo $i | sed 's/[-a-zA-Z0-9]*=//'`
	            ;;
        *)
                # unknown option
                print_usage
                exit 1
                ;;
        esac
done

echo "Mounting firmware partition..."
mkdir -p ${FW_DIR} || error_exit "Error creating ${FW_DIR} mounting point"
mount ${FW_DEV} ${FW_DIR} || error_exit "Error mounting mmcblk0p3 at ${FW_DIR}"

# Starting
echo "Installing firmware on e-MMC..."

#echo "Enabling boot partitions..."
#echo 8 > /sys/devices/soc0/soc.0/2100000.aips-bus/219c000.usdhc/mmc_host/mmc3/mmc3:0001/boot_config || error_exit "Error while enabling boot at e-MMC"

echo "Enabling write operations on mmcblk3boot0..."
echo 0 > /sys/block/mmcblk3boot0/force_ro || error_exit "Error while enabling write operations mmcblk3boot0"

echo "Erasing entire mmcblk3boot0 region..."
dd if=/dev/zero of=/dev/mmcblk3boot0
sync

echo "Copying SPL to e-MMC 1st boot region..."
dd if=${FW_DIR}/SPL of=/dev/mmcblk3boot0 bs=1k seek=1 || error_exit "Error while copying SPL image to mmcblk3boot0"
sync

echo "Enabling write operations on mmcblk3boot1..."
echo 0 > /sys/block/mmcblk3boot1/force_ro || error_exit "Error while enabling write operations mmcblk3boot1"

echo "Erasing entire mmcblk3boot1 region..."
dd if=/dev/zero of=/dev/mmcblk3boot1
sync

echo "Copying SPL to e-MMC 2nd boot region..."
dd if=${FW_DIR}/SPL of=/dev/mmcblk3boot1 bs=1k seek=1 || error_exit "Error while copying SPL image to mmcblk3boot1"
sync

if [ "${INSTALL_ROOTFS}" == "true" ]
then
	echo "Installing the whole firmware image to e-MMC..."
	dd if=${FW_DIR}/${FW_IMAGE} of=/dev/mmcblk3 bs=1k || error_exit "Error while copying the firmware image to mmcblk3"
	sync
else
	echo "Copying just u-boot to e-MMC..."
	dd if=${FW_DIR}/u-boot.img of=/dev/mmcblk3 bs=1k seek=69 || error_exit "Error while copying u-boot image to mmcblk3"
	sync
fi

# Done
echo "Firmware installed successfully!"
