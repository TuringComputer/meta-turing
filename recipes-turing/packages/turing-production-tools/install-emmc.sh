#!/bin/sh

print_usage()
{
	echo -e "\nUSAGE: ${0} --target=[target-dev] --fw-spl=[spl-image] --fw-img=[sdcard-image]\n"
	echo -e "EXAMPLE:"
	echo -e "${0} --fw-spl=SPL --fw-img=image.sdcard --target=mmcblk3\n"
	return
}

print_vars()
{
	echo "------------------------------------"
	echo FW_DIR=${FW_DIR}
	echo FW_SPL_IMAGE=${FW_SPL_IMAGE}
	echo FW_SDCARD_IMAGE=${FW_SPL_IMAGE}
	echo TARGET_MMC_DEV=${TARGET_MMC_DEV}
	echo "------------------------------------"
}

function print_bold
{
    echo ""
    echo -e "\e[1m\e[4m$1\e[0m"
    echo ""
}

function print_title
{
    echo ""
    echo -e "\e[93m\e[1m\e[4m$1\e[0m"
    echo ""
}

function print_success
{
    echo ""
    echo -e "\e[92m\e[1m$1\e[0m"
    echo ""
}

function error_exit
{
    echo ""
    echo -e "\e[31m\e[1m\e[4m$1\e[0m" 1>&2
    echo ""
	exit 1
	return
}

FW_DIR=$(pwd)
FW_SPL_IMAGE=SPL
FW_SDCARD_IMAGE=
TARGET_MMC_DEV=mmcblk3

#######################################
# Parse command-line arguments
#######################################

for i in $*
do
        case $i in
        --fw-spl=*)
	            FW_SPL_IMAGE=`echo $i | sed 's/[-a-zA-Z0-9]*=//'`
	            ;;
	    --fw-img=*)
	            FW_SDCARD_IMAGE=`echo $i | sed 's/[-a-zA-Z0-9]*=//'`
	            ;;
	    --target=*)
	            TARGET_MMC_DEV=`echo $i | sed 's/[-a-zA-Z0-9]*=//'`
	            ;;
        *)
                # unknown option
                print_usage
                exit 1
                ;;
        esac
done

# Starting
print_title "Installing firmware on e-MMC"

print_vars

# This has been commented out since kernel 4.1.15 does not need it anymore
#print_bold "Enabling boot partitions"
#echo 8 > /sys/devices/soc0/soc.0/2100000.aips-bus/219c000.usdhc/mmc_host/mmc3/mmc3:0001/boot_config || error_exit "Error while enabling boot at e-MMC"

print_bold "Enabling write operations on ${TARGET_MMC_DEV}boot0"
echo 0 > /sys/block/${TARGET_MMC_DEV}boot0/force_ro || error_exit "Error while enabling write operations ${TARGET_MMC_DEV}boot0"

print_bold "Erasing entire mmcblk3boot0 region"
dd if=/dev/zero of=/dev/${TARGET_MMC_DEV}boot0
sync

print_bold "Copying SPL to e-MMC 1st boot region"
dd if=${FW_DIR}/${FW_SPL_IMAGE} of=/dev/${TARGET_MMC_DEV}boot0 bs=1k seek=1 || error_exit "Error while copying SPL image to ${TARGET_MMC_DEV}boot0"
sync

print_bold "Enabling write operations on ${TARGET_MMC_DEV}boot1"
echo 0 > /sys/block/${TARGET_MMC_DEV}boot1/force_ro || error_exit "Error while enabling write operations ${TARGET_MMC_DEV}boot1"

print_bold "Erasing entire ${TARGET_MMC_DEV}boot1 region"
dd if=/dev/zero of=/dev/${TARGET_MMC_DEV}boot1
sync

print_bold "Copying SPL to e-MMC 2nd boot region"
dd if=${FW_DIR}/${FW_SPL_IMAGE} of=/dev/${TARGET_MMC_DEV}boot1 bs=1k seek=1 || error_exit "Error while copying SPL image to ${TARGET_MMC_DEV}boot1"
sync

if [ ! -z ${FW_SDCARD_IMAGE} ]
then
	print_bold "Installing the whole firmware image to e-MMC"
	dd if=${FW_DIR}/${FW_SDCARD_IMAGE} of=/dev/${TARGET_MMC_DEV} bs=1M || error_exit "Error while copying the firmware image to ${TARGET_MMC_DEV}"
	sync
fi

# Done
print_success "Firmware installed successfully!"
