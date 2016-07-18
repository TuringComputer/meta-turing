#!/bin/sh

print_usage()
{
	echo "USAGE: ${0} [test]"
	echo "Available tests are:"
	echo "all              Run all tests below."
	echo "cpu              Run CPU stress tests."
	echo "ddr3             Run DDR3 stress and integrity tests."
	echo "full_ddr3        Run DDR3 stress and integrity tests on all free memory."
	echo "sata             Checks if there is a SATA hard drive (/dev/sda) attached to the board."
	echo "spi              Checks if there is a NOR Flash (/dev/mtd0) attached to SPI bus."
	echo "usbh             Checks if there is any USB device attached to the board."
	echo "modem            Checks if 3G Modem is working."
	echo "mmc              Checks if the e-MMC flash memory (/dev/mmcblk3) is present."
	echo "pcie             Checks if there is a PCI-e device attached to the board."
	echo "ts               Tests the touchscreen device."
	echo "lcd              Displays an image on the RGB display. Asks for the user approval."
	echo "lvds             Displays an image on the LVDS display. Asks for the user approval."
	echo "i2s_out          Playback on headphone. Asks for the user approval."
	echo "spdif            Playback on S/PDIF interface. Asks for the user approval."
	echo "i2s_in           Capture audio from I2S interface (microphone), play it back on the headphone. Asks for the user approval."
	echo "audio_all        Playback on headphone, capture it back on microphone and play it on S/PDIF."
	echo "csi              Capture images from the CSI interface and displays them on the screen. Asks for the user approval."
	echo "mipi             Capture images from the MIPI interface and displays them on the screen. Asks for the user approval."
	echo "can0             Tests the can0 interface."
	echo "can1             Tests the can1 interface."
	echo "i2c              Checks for known devices on the I2C interfaces."
	echo "wlan0            Checks if Wifi (WILC3000) is working."
	echo "wlp1s0           Checks if Wifi (Intel Wireless) is working."
	echo "bluetooth        Checks if Bluetooth (WILC3000) is working."
	echo "sleep            Checks if the board can sleep and wakeup properly."
	echo "kit-cpu          Runs all tests related to Turing's System on Module."
	echo "kit-mb           Runs all tests related to Turing's Motherboard."
	echo "kit-cn           Runs all tests related to Turing's Connectivity Expansion Board."
	echo "kit-dis          Runs all tests related to Turing's Display Expansion Board."
	echo "EXAMPLE:"
	echo "${0} all "
	return
}

function test_title
{
    echo ""
    echo -e "\e[93m\e[1m\e[4m$1\e[0m"
    echo ""
}

function test_success
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

function ask_user
{
	read -p "$1" -n 1 -r
	echo
	if [[ $REPLY =~ ^[Yy]$ ]]
	then
	    test_success "Done."
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
     test_title "Testing Full DDR3 ($MEMFREE MB / $MEMTOTAL MB)"
     memtester $(MEMFREE)M 1 || error_exit "Memory Stress and Integrity Test failed."
     test_success "Done."
}

function test_cpu
{
	CPUS=$(grep "processor" /proc/cpuinfo | wc -l)
	test_title "Testing $CPUS CPUs..."
	stress --cpu 1000 --timeout 15s || error_exit "CPU Stress Test failed."
	test_success "Done."
}

function test_ddr3
{
     MEMTOTAL=$(grep MemTotal /proc/meminfo | awk '{print $2}')
     MEMFREE=$(grep MemFree /proc/meminfo | awk '{print $2}')
     let MEMTOTAL=($MEMTOTAL / 1024)
     let MEMFREE=($MEMFREE / 1024)
     test_title "Testing DDR3 ($MEMFREE MB / $MEMTOTAL MB)"
     memtester 16M 1 || error_exit "Memory Stress and Integrity Test failed."
     test_success "Done."
}

function test_sata
{
	# if /sys/devices/soc0/soc.0/2200000.sata/ exists
	# then we should test it.. otherwise, we ignore this test
	# because we are running Solo or Dual Lite versions
	if [ -e "/sys/devices/soc0/soc.0/2200000.sata/" ]
	then
		test_title "Testing SATA"
	  	if [ -e "/dev/sda" ]
	  	then
	  		test_success "Done."
	  	else
	  		error_exit "SATA Test failed."
	  	fi
	fi
}

function test_spi
{
	test_title "Testing SPI"
	if [ -e "/dev/mtd0" ]
	then
		test_success "Done."
	else
	  	error_exit "SPI Test failed."
	fi
}

function test_usbh
{
	test_title "Testing USB Host"
	if [ $(lsusb | wc -l) -ge 3 ]
	then
		test_success "Done."
	else
		error_exit "USB Host Test failed."
	fi
}

function test_mmc
{
	test_title "Testing e-MMC"
	if [ -e "/dev/mmcblk3" ]
	then
	  	test_success "Done."
	else
	  	error_exit "e-MMC Test failed."
	fi
}

function test_pcie
{
	test_title "Testing PCI-e"
	if [ $(lspci | wc -l) -ge 1 ]
	then
		test_success "Done."
	else
		error_exit "PCI-e Test failed."
	fi
}

function test_ts
{
	let COUNT=0
    test_title "Testing Touchscreen"
    echo "Please, touch the display at any position..."
    while [ $(timeout 3s ts_print | wc -l) -lt 1 ] && [ $COUNT -lt 5 ]
    do
    	echo "..."
    	let COUNT=$COUNT+1
    done
    if [ $COUNT -lt 5 ]
    then
    	test_success "Done."
    else
    	error_exit "Touchscreen Test failed."
    fi
}

function test_lcd
{
	test_title "Testing RGB display"
	echo 16 > /sys/class/graphics/fb2/bits_per_pixel
	sleep 1
	echo 0 > /sys/class/graphics/fb2/blank
	sleep 2
	cat /unit_tests/pansy-1280x720-565.rgb > /dev/fb2
	ask_user "Could you see color changes on the RGB display correctly? (y/N): " "RGB"
	echo 16 > /sys/class/graphics/fb2/bits_per_pixel
}

function test_lvds
{
	test_title "Testing LVDS display"
	echo 16 > /sys/class/graphics/fb0/bits_per_pixel
	sleep 1
	echo 0 > /sys/class/graphics/fb0/blank
	sleep 2
	cat /unit_tests/rose-800x600-565.rgb > /dev/fb0
	ask_user "Could you see color changes on the LVDS display correctly? (y/N): " "LCD"
	echo 16 > /sys/class/graphics/fb0/bits_per_pixel
}

function test_i2s_out
{
	test_title "Testing I2S Out"
	aplay /unit_tests/audio8k16S.wav -D sysdefault:CARD=imxsgtl5000 --duration=10 || error_exit "I2S Out Test Failed."
	ask_user "Could you listen to audio on your headphone interface? (y/N): " "I2S Out"
}

function test_i2s_in
{
	test_title "Testing I2S In"
	arecord -D sysdefault:CARD=imxsgtl5000 -f dat -t raw --duration=10 | aplay -f dat -t raw -D sysdefault:CARD=imxsgtl5000 || error_exit "I2S In Test Failed."
	ask_user "Could you listen to microphone on your headphone interface? (y/N): " "I2S In"
}

function test_spdif
{
	test_title "Testing S/PDIF output interface"
	aplay /unit_tests/audio8k16S.wav -D sysdefault:CARD=imxspdif --duration=10 || error_exit "S/PDIF Out Test Failed."
	ask_user "Could you listen to audio at S/PDIF interface? (y/N): " "S/PDIF Out"
}

function test_audio_all
{
	test_title "Testing Audio"
	aplay /unit_tests/audio8k16S.wav -D sysdefault:CARD=imxsgtl5000 --duration=10 &
	arecord -D sysdefault:CARD=imxsgtl5000 -f dat -t raw --duration=10 | aplay -f dat -t raw -D sysdefault:CARD=imxspdif || error_exit "Audio Test Failed."
	ask_user "Could you listen to audio at S/PDIF interface? (y/N): " "Audio All"
}

function test_csi
{
	test_title "Testing CSI interface"
	test_success "Done."
}

function test_mipi
{
	test_title "Testing MIPI interface"
	test_success "Done."
}

function test_can
{
	CAN_INTERFACE=$1
	test_title "Testing $CAN_INTERFACE interfaces"
	ifconfig $CAN_INTERFACE down || error_exit "Failed to close $CAN_INTERFACE interface."
	
	ip link set $CAN_INTERFACE type can bitrate 250000 || error_exit "Failed to configure $CAN_INTERFACE interface."
	ifconfig $CAN_INTERFACE up || error_exit "Failed to open $CAN_INTERFACE interface."
	
	if [ $(timeout -s KILL 5s candump $CAN_INTERFACE | wc -l) -lt 1 ]
	then
		error_exit "$CAN_INTERFACE Test Failed."
	fi
	
	ifconfig $CAN_INTERFACE down || error_exit "Failed to close $CAN_INTERFACE interface."

	test_success "Done."
}

function test_can0
{
	test_can can0
}

function test_can1
{
	test_can can1
}

function test_i2c
{
	# Checks for existance of some i2c peripherals
	test_title "Testing I2C interfaces"
	if [ $(cat /sys/class/sound/card0/id) != "imxsgtl5000" ] && [ $(cat /sys/class/sound/card1/id) != "imxsgtl5000" ]
	then 
		error_exit "I2C Test failed: sgtl5000 not found."
	fi
	test_success "Done."
}

function test_sleep
{
	let SLEEP_TIME=5
	test_title "Testing Sleep and Wake Up"
	echo "The system will sleep for $SLEEP_TIME seconds. You can check for current drop to below 180mA..."
	rtcwake -m mem -s $SLEEP_TIME || error_exit "Sleep Test failed."
	test_success "Done."
}

function test_gps
{
	test_title "Testing GPS"
	if [ $(lsusb | grep -i "U-Blox AG" | wc -l) -eq 0 ]
	then
		error_exit "GPS not detected."
	fi
	test_success "Done."
}

function test_modem
{
	test_title "Testing 3G Modem"
	
	let PWR_ON="8"
    let RESET_IN="174"

    echo ${PWR_ON} > /sys/class/gpio/export
    echo ${RESET_IN} > /sys/class/gpio/export
    echo "out" > /sys/class/gpio/gpio${PWR_ON}/direction
    echo "out" > /sys/class/gpio/gpio${RESET_IN}/direction

    echo 1 > /sys/class/gpio/gpio${PWR_ON}/value
    echo 0 > /sys/class/gpio/gpio${RESET_IN}/value

    echo 0 > /sys/class/gpio/gpio${PWR_ON}/value
    echo 1 > /sys/class/gpio/gpio${RESET_IN}/value

    echo ${PWR_ON} > /sys/class/gpio/unexport
 	echo ${RESET_IN} > /sys/class/gpio/unexport

	# Wait for USB device to come up
    sleep 10
	
	if [ $(lsusb | grep -i "Comneon" | wc -l) -eq 0 ]
	then
		error_exit "3G Modem not detected."
	fi
	test_success "Done."
}

function test_wifi
{
	WLAN_INTERFACE=$1
	test_title "Testing Wifi $WLAN_INTERFACE"
	if [ -e "/sys/class/net/$WLAN_INTERFACE" ]
	then
		ip link set $WLAN_INTERFACE up || error_exit "Failed to start wlan interface."
		if [ $(iw dev $WLAN_INTERFACE scan | grep -i "SSID" | wc -l) -ge 1 ]
		then
			ifconfig $WLAN_INTERFACE down
			test_success "Done."
		else
			ifconfig $WLAN_INTERFACE down
			error_exit "Could not find any wireless network."
		fi
	else
		error_exit "$WLAN_INTERFACE interface not found."
	fi
}

function test_bluetooth
{
	BT_INTERFACE=$1
	WLAN_INTERFACE=wlan0
	test_title "Testing Bluetooth $BT_INTERFACE"
	if [ -e "/sys/class/net/$WLAN_INTERFACE" ]
	then
		ifconfig $WLAN_INTERFACE up || error_exit "Failed to start wlan interface."
		echo BT_POWER_UP > /dev/at_pwr_dev
		echo BT_DOWNLOAD_FW > /dev/at_pwr_dev
		if [ ! -e "/sys/class/bluetooth/$BT_INTERFACE" ]
		then
			hciattach -n -s 115200 /dev/ttymxc2 any 115200 noflow &
			sleep 5
		fi
		hciconfig $BT_INTERFACE up
		DEVICES=$(hcitool scan | wc -l)
		
		echo BT_POWER_DOWN > /dev/at_pwr_dev
		hciconfig $BT_INTERFACE down
		ifconfig $WLAN_INTERFACE down
		
		if [ $DEVICES -gt 1 ]
		then
			test_success "Done."
		else
			error_exit "Could not find any bluetooth device."
		fi
	else
		error_exit "$WLAN_INTERFACE interface not found."
	fi
}

function test_9axis
{
	test_title "Testing 9-Axis"
	if [ $(cat /sys/bus/i2c/devices/0-001e/name) == "lsm9ds1-mag" ] && [ $(cat /sys/bus/i2c/devices/0-006b/name) == "lsm9ds1-acc-gyr" ]
	then
		test_success "Done"
	else
		error_exit "9-Axis not detected" 
	fi
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
        modem)
        		test_modem
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
       	audio_all)
       			test_audio_all
       			;;
       	csi)
       			test_csi
       			;;
       	mipi)
       			test_mipi
       			;;
        can0)	
        		test_can0
        		;;
        can1)	
        		test_can1
        		;;
        i2c)
        		test_i2c
        		;;
        wlan0)
        		test_wifi wlan0
        		;;
        wlp1s0)
        		test_wifi wlp1s0
        		;;
       	bluetooth)
       			test_bluetooth hci0
       			;;
       	sleep)
       			test_sleep
       			;;
       	kit-mb)
       			test_sata
       			test_spi
       			test_usbh
       			test_pcie
       			test_i2s_out
       			test_lcd
       			;;
       	kit-cn)		
       			test_gps
       			#test_modem
       			test_wifi wlan0
       			test_bluetooth hci0
       			test_9axis
       			test_can0
       			test_can1
       			;;
       	kit-dis)
       			test_ts
        		test_lvds
       			;;
        kit-cpu)
        		test_cpu
        		test_ddr3
        		test_sata
        		test_spi
        		test_usbh
        		test_mmc
        		test_i2c
        		test_can0
        		test_can1
        		test_pcie
        		test_ts
        		test_lcd
        		test_lvds
        		test_i2s_out
        		#test_csi
        		#test_mipi
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
        		test_can0
        		test_can1
        		test_pcie
        		test_ts
        		test_lcd
        		test_lvds
        		test_audio_all
        		test_gps
       			test_modem
       			test_wifi wlan0
       			test_wifi wlp1s0
       			test_bluetooth hci0
       			test_9axis
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
