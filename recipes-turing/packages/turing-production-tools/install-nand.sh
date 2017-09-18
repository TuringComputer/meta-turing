#!/bin/sh

function print_usage
{
	echo -e "\nUSAGE: ${0} --spl=[spl-image] --uboot=[uboot-image] --kernel=[kernel-zImage] --dtbul0=[DTB-UL0] --dtbul1=[DTB-UL1] --dtbull0=[DTB-ULL0] --dtbull1=[DTB-UL1] --ubi=[ubi-image]\n"
	echo -e "EXAMPLE:"
	echo -e "${0} --spl=SPL --uboot=u=boot.img --kernel=zImage --dtbul0=imx6ul-turing-eval.dtb --dtbull0=imx6ull-turing-eval.dtb --rootfs=turing-image-x11-full-imx6ul-turing.ubi\n"
	return
}

function print_vars
{
	echo "------------------------------------"
	echo FW_DIR=${FW_DIR}
	echo FW_SPL_IMAGE=${FW_SPL_IMAGE}
	echo FW_UBOOT_IMAGE=${FW_UBOOT_IMAGE}
	echo FW_KERNEL_IMAGE=${FW_KERNEL_IMAGE}
	echo FW_DTBUL0_IMAGE=${FW_DTBUL0_IMAGE}
	echo FW_DTBULL0_IMAGE=${FW_DTBULL0_IMAGE}
	echo FW_DTBUL1_IMAGE=${FW_DTBUL1_IMAGE}
	echo FW_DTBULL1_IMAGE=${FW_DTBULL1_IMAGE}
	echo FW_UBI_IMAGE=${FW_UBI_IMAGE}
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
FW_UBOOT_IMAGE=u-boot.img
FW_KERNEL_IMAGE=zImage
FW_DTBUL0_IMAGE=""
FW_DTBULL0_IMAGE=""
FW_DTBUL1_IMAGE=""
FW_DTBULL1_IMAGE=""
FW_UBI_IMAGE=""

#######################################
# Parse command-line arguments
#######################################

for i in $*
do
        case $i in
        --spl=*)
	            FW_SPL_IMAGE=`echo $i | sed 's/[-a-zA-Z0-9]*=//'`
	            ;;
	    --uboot=*)
	            FW_UBOOT_IMAGE=`echo $i | sed 's/[-a-zA-Z0-9]*=//'`
	            ;;
	    --kernel=*)
	            FW_KERNEL_IMAGE=`echo $i | sed 's/[-a-zA-Z0-9]*=//'`
	            ;;
	    --dtbul0=*)
	            FW_DTBUL0_IMAGE=`echo $i | sed 's/[-a-zA-Z0-9]*=//'`
	            ;;
	    --dtbull0=*)
	            FW_DTBULL0_IMAGE=`echo $i | sed 's/[-a-zA-Z0-9]*=//'`
	            ;;
	    --dtbul1=*)
	            FW_DTBUL1_IMAGE=`echo $i | sed 's/[-a-zA-Z0-9]*=//'`
	            ;;
	    --dtbull1=*)
	            FW_DTBULL1_IMAGE=`echo $i | sed 's/[-a-zA-Z0-9]*=//'`
	            ;;
	    --rootfs=*)
	            FW_UBI_IMAGE=`echo $i | sed 's/[-a-zA-Z0-9]*=//'`
	            ;;
        *)
                # unknown option
                print_usage
                exit 1
                ;;
        esac
done

# Starting
print_title "Installing firmware on NAND"

print_vars

if [ ! -z ${FW_SPL_IMAGE} ]
then
	print_bold "Erasing partition /dev/mtd0"
	flash_erase /dev/mtd0 0 0
	print_bold "Installing SPL image..."
	kobs-ng init -v -x --search_exponent=1 --chip_0_size=0xe00000 ${FW_DIR}/${FW_SPL_IMAGE} || error_exit "Error while installing SPL image."
	sync
fi	

if [ ! -z ${FW_UBOOT_IMAGE} ]
then
	print_bold "Erasing partition /dev/mtd1"
	flash_erase /dev/mtd1 0 0
	print_bold "Installing u-boot image..."
	nandwrite -p /dev/mtd1 ${FW_DIR}/${FW_UBOOT_IMAGE} || error_exit "Error while installing u-boot image."
	sync
fi

if [ ! -z ${FW_KERNEL_IMAGE} ]
then
	print_bold "Erasing partition /dev/mtd3"
	flash_erase /dev/mtd3 0 0
	print_bold "Installing kernel image..."
	nandwrite -p /dev/mtd3 ${FW_DIR}/${FW_KERNEL_IMAGE} || error_exit "Error while installing kernel image."
	sync
fi

if [ ! -z ${FW_DTBUL0_IMAGE} ]
then
	print_bold "Erasing partition /dev/mtd4"
	flash_erase /dev/mtd4 0 0
	print_bold "Installing first DTB image for i.MX6UL"
	nandwrite -p /dev/mtd4 ${FW_DIR}/${FW_DTBUL0_IMAGE} || error_exit "Error while installing first DTB image for i.MX6UL."
	sync
fi

if [ ! -z ${FW_DTBULL0_IMAGE} ]
then
	print_bold "Erasing partition /dev/mtd5"
	flash_erase /dev/mtd5 0 0
	print_bold "Installing first DTB image for i.MX6ULL"
	nandwrite -p /dev/mtd5 ${FW_DIR}/${FW_DTBULL0_IMAGE} || error_exit "Error while installing first DTB image for i.MX6ULL."
	sync
fi	

if [ ! -z ${FW_DTBUL1_IMAGE} ]
then
	print_bold "Erasing partition /dev/mtd6"
	flash_erase /dev/mtd6 0 0
	print_bold "Installing second DTB image for i.MX6UL"
	nandwrite -p /dev/mtd6 ${FW_DIR}/${FW_DTBUL0_IMAGE} || error_exit "Error while installing second DTB image for i.MX6UL."
	sync
fi

if [ ! -z ${FW_DTBULL1_IMAGE} ]
then
	print_bold "Erasing partition /dev/mtd7"
	flash_erase /dev/mtd7 0 0
	print_bold "Installing second DTB image for i.MX6ULL"
	nandwrite -p /dev/mtd7 ${FW_DIR}/${FW_DTBULL0_IMAGE} || error_exit "Error while installing second DTB image for i.MX6ULL."
	sync
fi	

if [ ! -z ${FW_UBI_IMAGE} ]
then
	print_bold "Erasing partition /dev/mtd8"
	flash_erase /dev/mtd8 0 0
	print_bold "Installing UBI rootfs into /dev/mtd8"
	ubiformat /dev/mtd8 -f ${FW_DIR}/${FW_UBI_IMAGE}  -s 8192
	sync
fi

# Done
print_success "Firmware installed successfully!"
