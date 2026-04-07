#!/bin/bash

IP=$(cat info/ip.txt)
MODE=$(cat info/mode.txt)

if [[ $MODE == fast ]]; then
        nmap -oG scans/fast_scan.txt $IP
elif [[ $MODE == normal ]]; then
        nmap -p- -oG scans/normal_scan.txt $IP
elif [[ $MODE == thorough ]]; then
        nmap -sV -p- -oG scans/thorough.txt $IP
else
        echo "no modes provided, quitting!"
        quit 1
fi
