#!/bin/sh

function print_usage
{
	echo -e "\nUSAGE: ${0} --target=[target-dev] --fw-spl=[spl-image] --fw-u-boot=[u-boot-image] --fw-boot=[boot-image] --fw-recovery=[recovery-image] --fw-system=[system-raw-image] --create-partitions=[true|false]\n"
	echo -e "EXAMPLE:"
	echo -e "${0} --fw-spl=SPL-imx6q --fw-u-boot=u-boot-imx6q.img --fw-boot=boot-imx6q.img --fw-recovery=recovery-imx6q.img --fw-system=system_raw.img --target=mmcblk3\n"
	return
}

function print_vars
{
	echo "------------------------------------"
	echo FW_DIR=${FW_DIR}
	echo FW_SPL_IMAGE=${FW_SPL_IMAGE}
	echo FW_UBOOT_IMAGE=${FW_UBOOT_IMAGE}
	echo FW_BOOT_IMAGE=${FW_BOOT_IMAGE}
	echo FW_RECOVERY_IMAGE=${FW_RECOVERY_IMAGE}
	echo FW_SYSTEM_IMAGE=${FW_SYSTEM_IMAGE}
	echo TARGET_MMC_DEV=/dev/${TARGET_MMC_DEV}
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
FW_SPL_IMAGE=SPL-imx6q
FW_UBOOT_IMAGE=u-boot-imx6q.img
FW_BOOT_IMAGE=boot-imx6q.img
FW_RECOVERY_IMAGE=recovery-imx6q.img
FW_SYSTEM_IMAGE=system_raw.img
TARGET_MMC_DEV=mmcblk3
CREATE_PARTITIONS=true

# partition size in MB
BOOTLOADER_SIZE=16
BOOT_ROM_SIZE=16
SYSTEM_ROM_SIZE=512
CACHE_SIZE=512
RECOVERY_ROM_SIZE=16
DEVICE_SIZE=8
MISC_SIZE=6
DATAFOOTER_SIZE=2

#######################################
# Parse command-line arguments
#######################################

for i in $*
do
        case $i in
        --fw-spl=*)
	            FW_SPL_IMAGE=`echo $i | sed 's/[-a-zA-Z0-9]*=//'`
	            ;;
	    --fw-system=*)
	            FW_SYSTEM_IMAGE=`echo $i | sed 's/[-a-zA-Z0-9]*=//'`
	            ;;
	    --fw-boot=*)
	            FW_BOOT_IMAGE=`echo $i | sed 's/[-a-zA-Z0-9]*=//'`
	            ;;
	    --fw-u-boot=*)
	            FW_UBOOT_IMAGE=`echo $i | sed 's/[-a-zA-Z0-9]*=//'`
	            ;;
	    --fw-recovery=*)
	            FW_RECOVERY_IMAGE=`echo $i | sed 's/[-a-zA-Z0-9]*=//'`
	            ;;
	    --create-partitions=*)
	            CREATE_PARTITIONS=`echo $i | sed 's/[-a-zA-Z0-9]*=//'`
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

print_title "Installing Android firmware on /dev/${TARGET_MMC_DEV}"

print_vars

# This has been commented out since kernel 4.1.15 does not need it anymore
#print_bold "Enabling boot partitions"
#echo 8 > /sys/devices/soc0/soc.0/2100000.aips-bus/219c000.usdhc/mmc_host/mmc3/mmc3:0001/boot_config || error_exit "Error while enabling boot at e-MMC"

print_bold "Enabling write operations on ${TARGET_MMC_DEV}boot0"
echo 0 > /sys/block/${TARGET_MMC_DEV}boot0/force_ro || error_exit "Error while enabling write operations ${TARGET_MMC_DEV}boot0"

print_bold "Erasing entire mmcblk3boot0 region"
dd if=/dev/zero of=/dev/${TARGET_MMC_DEV}boot0
sync

if [ ! -z ${FW_SPL_IMAGE} ]
then
	print_bold "Installing SPL to e-MMC 1st boot region"
	dd if=${FW_DIR}/${FW_SPL_IMAGE} of=/dev/${TARGET_MMC_DEV}boot0 bs=1k seek=1 || error_exit "Error while copying SPL image to ${TARGET_MMC_DEV}boot0"
	sync
else
	print_bold "Skipping instalation of SPL to e-MMC 2nd boot region"
fi

print_bold "Enabling write operations on ${TARGET_MMC_DEV}boot1"
echo 0 > /sys/block/${TARGET_MMC_DEV}boot1/force_ro || error_exit "Error while enabling write operations ${TARGET_MMC_DEV}boot1"

print_bold "Erasing entire ${TARGET_MMC_DEV}boot1 region"
dd if=/dev/zero of=/dev/${TARGET_MMC_DEV}boot1
sync

if [ ! -z ${FW_SPL_IMAGE} ]
then
	print_bold "Installing SPL to e-MMC 2nd boot region"
	dd if=${FW_DIR}/${FW_SPL_IMAGE} of=/dev/${TARGET_MMC_DEV}boot1 bs=1k seek=1 || error_exit "Error while copying SPL image to ${TARGET_MMC_DEV}boot1"
	sync
else
	print_bold "Skipping instalation of SPL to e-MMC 2nd boot region"
fi

if [ ! -z ${FW_UBOOT_IMAGE} ]
then
	print_bold "Installing u-boot image on /dev/${TARGET_MMC_DEV}"
	dd if=${FW_DIR}/${FW_UBOOT_IMAGE} of=/dev/${TARGET_MMC_DEV} bs=1k seek=69  || error_exit "Error while copying u-boot image to ${TARGET_MMC_DEV}boot1"
	sync
else
	print_bold "Skipping instalation of u-boot image on /dev/${TARGET_MMC_DEV}"
fi	

if [ "$CREATE_PARTITIONS" = "true" ]
then
    print_bold "Creating Android partitions"
    
    # call sfdisk to create partition table
	# get total card size
	seprate=40
	total_size=`sfdisk -s /dev/${TARGET_MMC_DEV}`
	total_size=`expr ${total_size} / 1024`
	boot_rom_sizeb=`expr ${BOOT_ROM_SIZE} + ${BOOTLOADER_SIZE}`
	extend_size=`expr ${SYSTEM_ROM_SIZE} + ${CACHE_SIZE} + ${DEVICE_SIZE} + ${MISC_SIZE} + ${DATAFOOTER_SIZE} + ${seprate}`
	data_size=`expr ${total_size} - ${boot_rom_sizeb} - ${RECOVERY_ROM_SIZE} - ${extend_size} + ${seprate}`
    
    echo "------------------------------------"
	echo "BOOT       : ${boot_rom_sizeb}MB    "
	echo "RECOVERY   : ${RECOVERY_ROM_SIZE}MB "
	echo "SYSTEM     : ${SYSTEM_ROM_SIZE}MB   "
	echo "CACHE      : ${CACHE_SIZE}MB        "
	echo "DATA       : ${data_size}MB         "
	echo "MISC       : ${MISC_SIZE}MB         "
	echo "DEVICE     : ${DEVICE_SIZE}MB       "
	echo "DATAFOOTER : ${DATAFOOTER_SIZE}MB   "
	echo "------------------------------------"
    
sfdisk --force /dev/${TARGET_MMC_DEV} << EOF
,${boot_rom_sizeb}M,L
,${RECOVERY_ROM_SIZE}M,L
,${extend_size}M,E
,${data_size}M,L
,${SYSTEM_ROM_SIZE}M,L
,${CACHE_SIZE}M,L
,${DEVICE_SIZE}M,L
,${MISC_SIZE}M,L
,${DATAFOOTER_SIZE}M,L
EOF
	
# adjust the partition reserve for bootloader.
sfdisk --force /dev/${TARGET_MMC_DEV} -N1 << EOF
${BOOTLOADER_SIZE}M,${BOOT_ROM_SIZE}M,83
EOF

    mkfs.ext4 /dev/${TARGET_MMC_DEV}p4 -LDATA
    mkfs.ext4 /dev/${TARGET_MMC_DEV}p5 -LSYSTEM
    mkfs.ext4 /dev/${TARGET_MMC_DEV}p6 -LCACHE
    mkfs.ext4 /dev/${TARGET_MMC_DEV}p7 -LDEVICE
    
    sync
else
	print_bold "Skipping creation of Android partitions"
fi

sync

if [ ! -z ${FW_BOOT_IMAGE} ]
then
	print_bold "Installing boot image on /dev/${TARGET_MMC_DEV}"
	dd if=${FW_DIR}/${FW_BOOT_IMAGE} of=/dev/${TARGET_MMC_DEV}p1  || error_exit "Error while installing boot image to ${TARGET_MMC_DEV}p1"
	sync
else
	print_bold "Skipping instalation of boot image on /dev/${TARGET_MMC_DEV}"
fi

if [ ! -z ${FW_RECOVERY_IMAGE} ]
then
	print_bold "Installing recovery image on /dev/${TARGET_MMC_DEV}"
	dd if=${FW_DIR}/${FW_RECOVERY_IMAGE} of=/dev/${TARGET_MMC_DEV}p2 || error_exit "Error while installing recovery image to ${TARGET_MMC_DEV}p2"
	sync
else
	print_bold "Skipping instalation of recovery image on /dev/${TARGET_MMC_DEV}"
fi

if [ ! -z ${FW_SYSTEM_IMAGE} ]
then
	print_bold "Installing system image on /dev/${TARGET_MMC_DEV}"
	pv ${FW_DIR}/${FW_SYSTEM_IMAGE} > /dev/${TARGET_MMC_DEV}p5  || error_exit "Error while installing system image to ${TARGET_MMC_DEV}p5"
	sync
else
	print_bold "Skipping instalation of system image on /dev/${TARGET_MMC_DEV}"
fi

# Done
print_success "Firmware installed successfully!"
