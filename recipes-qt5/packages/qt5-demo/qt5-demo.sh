#!/bin/sh
# We run the demo on fb0 (LVDS) display
# To run on HDMI monitor, change fb0 to fb2
FRAMEBUFFER=fb0
echo 32 > /sys/class/graphics/$FRAMEBUFFER/bits_per_pixel
echo 0 > /sys/class/graphics/$FRAMEBUFFER/blank 
sleep 1
export QT_QPA_EGLFS_FB=/dev/$FRAMEBUFFER
/usr/share/cinematicexperience-1.0/Qt5_CinematicExperience -platform eglfs