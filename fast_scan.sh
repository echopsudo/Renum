#!/bin/bash

IP=$(cat info/ip.txt)

nmap -F -oG scans/fast_scan.txt $IP

HTTP_PORTS=$(grep -oE "[0-9]+/open/[^,]*http" scans/fast_scan.txt | cut -d/ -f1)
SMB_PORTS=$(grep -oE "[0-9]+/open/[^,]*microsoft-ds" scans/fast_scan.txt | cut -d/ -f1)


if [[ $HTTP_PORTS == "" ]]; then
	echo " "
else
	echo "Found HTTP(s) ports: $HTTP_PORTS"
	./modules/http_fast.sh
	quit 1
fi

if [[ $SMB_PORTS == "" ]]; then
	echo " "
else
	echo "Found SMB ports: $SMB_PORTS"
	./modules/smb_fast.sh
	quit 1
fi
