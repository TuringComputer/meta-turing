#!/bin/sh
FRAMEBUFFER=fb2
echo 32 > /sys/class/graphics/$FRAMEBUFFER/bits_per_pixel
echo 0 > /sys/class/graphics/$FRAMEBUFFER/blank 