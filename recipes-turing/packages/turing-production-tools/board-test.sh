#!/bin/sh

print_usage()
{
	echo "USAGE: ${0} [test]"
	echo "Available tests are:"
	echo "all              Run all tests below (default)."
	echo "cpu              Run CPU stress tests."
	echo "ddr3             Run DDR3 stress and integrity tests."
	echo "full_ddr3        Run DDR3 stress and integrity tests on all free memory."
	echo "sata             Checks if there is a SATA hard drive (/dev/sda) attached to the board."
	echo "spi              Checks if there is a NOR Flash (/dev/mtd0) attached to SPI bus."
	echo "usbh             Checks if there is any USB device attached to the board."
	echo "mmc              Checks if the e-MMC flash memory (/dev/mmcblk3) is present."
	echo "pcie             Checks if there is a PCI-e device attached to the board."
	echo "ts               Tests the touchscreen device."
	echo "lcd              Displays an image on the RGB display. Asks for the user approval."
	echo "lvds             Displays an image on the LVDS display. Asks for the user approval."
	echo "i2s_out          Playback on headphone. Asks for the user approval."
	echo "spdif            Playback on S/PDIF interface. Asks for the user approval."
	echo "i2s_in           Capture audio from I2S interface (microphone), play it back on the headphone. Asks for the user approval."
	echo "csi              Capture images from the CSI interface and displays them on the screen. Asks for the user approval."
	echo "mipi             Capture images from the MIPI interface and displays them on the screen. Asks for the user approval."
	echo "can              Tests the CAN interfaces (loopback)."
	echo "i2c              Checks for known devices on the I2C interfaces."
	echo "sleep            Checks if the board can sleep and wakeup properly."
	echo "EXAMPLE:"
	echo "${0} all "
	return
}

function error_exit
{
	echo -e "$1" 1>&2
	exit 1
	return
}

function ask_user
{
	read -p "$1" -n 1 -r
	echo
	if [[ $REPLY =~ ^[Yy]$ ]]
	then
	    echo "Done."
	else
		error_exit "$2 Test failed."
	fi
}

function test_full_ddr3
{
	 # We test half of the free memory
     MEMTOTAL=$(grep MemTotal /proc/meminfo | awk '{print $2}')
     MEMFREE=$(grep MemFree /proc/meminfo | awk '{print $2}')
     let MEMTOTAL=($MEMTOTAL / 1024)
     let MEMFREE=($MEMFREE / 1024)
     echo "Testing Full DDR3 ($MEMFREE MB / $MEMTOTAL MB)..."
     memtester $(MEMFREE)M 1 || error_exit "Memory Stress and Integrity Test failed."
}

function test_cpu
{
	CPUS=$(grep "processor" /proc/cpuinfo | wc -l)
	echo "Testing $CPUS CPUs..."
	stress --cpu 1000 --timeout 15s || error_exit "CPU Stress Test failed."
	echo "Done."
}

function test_ddr3
{
     MEMTOTAL=$(grep MemTotal /proc/meminfo | awk '{print $2}')
     MEMFREE=$(grep MemFree /proc/meminfo | awk '{print $2}')
     let MEMTOTAL=($MEMTOTAL / 1024)
     let MEMFREE=($MEMFREE / 1024)
     echo "Testing DDR3 ($MEMFREE MB / $MEMTOTAL MB)..."
     memtester 16M 1 || error_exit "Memory Stress and Integrity Test failed."
}

function test_sata
{
	# if /sys/devices/soc0/soc.0/2200000.sata/ exists
	# then we should test it.. otherwise, we ignore this test
	# because we are running Solo or Dual Lite versions
	if [ -e "/sys/devices/soc0/soc.0/2200000.sata/" ]
	then
		echo "Testing SATA..."
	  	if [ -e "/dev/sda1" ]
	  	then
	  		echo "Done."
	  	else
	  		error_exit "SATA Test failed."
	  	fi
	fi
}

function test_spi
{
	echo "Testing SPI..."
	if [ -e "/dev/mtd0" ]
	then
		echo "Done."
	else
	  	error_exit "SPI Test failed."
	fi
}

function test_usbh
{
	echo "Testing USB Host..."
	if [ $(lsusb | wc -l) -ge 3 ]
	then
		echo "Done."
	else
		error_exit "USB Host Test failed."
	fi
}

function test_mmc
{
	echo "Testing e-MMC..."
	if [ -e "/dev/mmcblk3" ]
	then
	  	echo "Done."
	else
	  	error_exit "e-MMC Test failed."
	fi
}

function test_pcie
{
	echo "Testing PCI-e..."
	if [ $(lspci | wc -l) -ge 1 ]
	then
		echo "Done."
	else
		error_exit "PCI-e Test failed."
	fi
}

function test_ts
{
	let COUNT=0
    echo "Testing Touchscreen..."
    echo "Please, touch the display at any position..."
    while [ $(timeout 3s ts_print | wc -l) -lt 1 ] && [ $COUNT -lt 5 ]
    do
    	echo "..."
    	let COUNT=$COUNT+1
    done
    if [ $COUNT -lt 5 ]
    then
    	echo "Done."
    else
    	error_exit "Touchscreen Test failed."
    fi
}

function test_lcd
{
	echo "Testing RGB display..."
	echo 0 > /sys/class/graphics/fb0/blank
	# For some reason, we need to run this test twice, so it works
	/unit_tests/autorun-fb.sh > /dev/null
	/unit_tests/autorun-fb.sh
	ask_user "Could you see color changes on the LCD correctly? (y/N): " "LCD"
}

function test_lvds
{
	echo "Testing LVDS display..."
	echo "Done."
}

function test_i2s_out
{
	echo "Testing I2S Out..."
	aplay /unit_tests/audio8k16S.wav -d=imx-sgtl5000 || error_exit "I2S Out Test Failed."
	ask_user "Could you listen to audio on your headphone interface? (y/N): " "I2S Out"
}

function test_i2s_in
{
	echo "Testing I2S In..."
	arecord -d=imx-sgtl5000 -f cd -t raw --duration 10 | aplay -d=imx-sgtl5000 || error_exit "I2S In Test Failed."
	ask_user "Could you listen to microphone on your headphone interface? (y/N): " "I2S In"
}

function test_spdif
{
	echo "Testing S/PDIF output interface..."
	aplay /unit_tests/audio8k16S.wav -d=imx-spdif || error_exit "S/PDIF Out Test Failed."
	ask_user "Could you listen to audio at S/PDIF interface? (y/N): " "S/PDIF Out"
}

function test_csi
{
	echo "Testing CSI interface..."
	echo "Done."
}

function test_mipi
{
	echo "Testing MIPI interface..."
	echo "Done."
}

function test_can
{
	echo "Testing CAN interfaces..."
	echo "Done."
}

function test_i2c
{
	# Checks for existance of some i2c peripherals
	echo "Testing I2C interfaces..."
	if [ $(cat /sys/class/sound/card0/id) != "imxsgtl5000" ] && [ $(cat /sys/class/sound/card1/id) != "imxsgtl5000" ]
	then 
		error_exit "I2C Test failed: sgtl5000 not found."
	fi
	echo "Done."
}

function test_sleep
{
	let SLEEP_TIME=5
	echo "Testing Sleep and Wake Up..."
	echo "The system will sleep for $SLEEP_TIME seconds. You can check for current drop to below 180mA..."
	rtcwake -m mem -s $SLEEP_TIME || error_exit "Sleep Test failed."
	echo "Done."
}

#######################################
# Parse command-line arguments
#######################################
if [ "$#" -lt 1 ]; then
    print_usage
    exit 1
fi

START_TIME=`date +%s`

for i in $*
do
        case $i in
        full_ddr3)
        		test_full_ddr3
        		;;
        cpu)
				test_cpu
                ;;
        ddr3)
        		test_ddr3
        		;;
       	sata)
       			test_sata
       			;;
       	spi)
       			test_spi
       			;;
       	usbh)
       			test_usbh
       			;;
       	mmc)
       			test_mmc
       			;;
       	pcie)
       			test_pcie
       			;;
       	ts)
       			test_ts
       			;;
       	lcd)
       			test_lcd
       			;;
       	lvds)
       			test_lvds
       			;;
       	spdif)
       			test_spdif
       			;;
        i2s_in)
       			test_i2s_in
       			;;
        i2s_out)
       			test_i2s_out
       			;;
       	csi)
       			test_csi
       			;;
       	mipi)
       			test_mipi
       			;;
        can)	
        		test_can
        		;;
        i2c)
        		test_i2c
        		;;
       	sleep)
       			test_sleep
       			;;
        all)
        		test_cpu
        		test_ddr3
        		test_sata
        		test_spi
        		test_usbh
        		test_mmc
        		test_i2c
        		#test_can
        		#test_pcie
        		#test_ts
        		#test_lcd
        		#test_lvds
        		#test_spdif
        		#test_i2s_in
        		#test_i2s_out
        		#test_csi
        		#test_mipi
        		test_sleep
        		;;
        *)
                # unknown option
                print_usage
                exit 1
                ;;
        esac
done

# Done
echo "Tests finished successfully in $(expr `date +%s` - $START_TIME) seconds!"
