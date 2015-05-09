#!/bin/bash          

# PID=`ps | grep cu | awk 'NR==2{print $1}'`

PIDS=`ps | grep [S]C | awk '{print $1}'`

while read -r line; do
	kill $line
done <<< "$PIDS"

# for i in $(PIDS); do
# 	kill $i
# done