#!/bin/bash          

NOW=`date +%X`
# OUTPUTFILE="output_EKG_$1_$NOW.txt"
OUTPUTFILE2="output_PAD_$1_$NOW.txt"
# script -a -t 10 $OUTPUTFILE screen /dev/cu.usbmodem1411 115200
script -a -t 10 $OUTPUTFILE2 screen /dev/cu.usbmodem1421 115200


