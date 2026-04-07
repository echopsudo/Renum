#!/bin/bash

IP=$(cat info/ip.txt)
MODE=$(cat info/modes.txt)

if [[ $MODE == fast ]]; then
        nmap -oG scans/fast_scan.txt $IP
elif [[ $MODE == normal ]]; then
        nmap -p- -oG scans/normal_scan.txt $IP
elif [[ $MODE == thorough ]]; then
        nmap -sV -p- -oG scans/thorough_scan.txt $IP
else
        echo "no modes provided, quitting!"
        quit 1
fi

wait

HTTP_PORTS=$(grep -oE "[0-9]+/open/[^,]*http" scans/fast_scan.txt | cut -d/ -f1 )
SMB_PORTS=$(grep -oE "[0-9]+/open/[^,]*microsoft-ds" scans/fast_scan.txt | cut -d/ -f1 )

echo HTTP_PORTS > info/http_ports.txt
echo SMB_PORTS > info/smb_ports.txt

cat http_ports
cat smb_ports
