
#!/bin/bash

IP=$(cat info/ip.txt)

nmap -oG scans/normal_scan.txt $IP

HTTP_PORTS=$(grep -oE "[0-9]+/open/[^,]*http" scans/normal_scan.txt | cut -d/ -f1)
SMB_PORTS=$(grep -oE "[0-9]+/open/[^,]*microsoft-ds" scans/normal_scan.txt | cut -d/ -f1)


if [[ $HTTP_PORTS == "" ]]; then
	echo " "
else
	echo "Found HTTP(s) ports: $HTTP_PORTS"
	./modules/http_normal.sh
	quit 1
fi

if [[ $SMB_PORTS == "" ]]; then
	echo " "
else
	echo "Found SMB ports: $SMB_PORTS"
	./modules/smb_normal.sh
	quit 1
fi
