#!/bin/bash

IP=$(cat info/ip.txt)
MODE=$(cat info/modes.txt)

if [[ $MODE == fast ]]; then
        nmap -oG scans/scan.txt $IP
elif [[ $MODE == normal ]]; then
        nmap -p- -oG scans/scan.txt $IP
elif [[ $MODE == thorough ]]; then
        nmap -sV -p- -oG scans/scan.txt $IP
else
        echo "no modes provided, quitting!"
        quit 1
fi

wait

HTTP_PORTS=$(grep -oE "[0-9]+/open/[^,]*http" scans/scan.txt | cut -d/ -f1 )
SMB_PORTS=$(grep -oE "[0-9]+/open/[^,]*microsoft-ds" scans/scan.txt | cut -d/ -f1 )
FTP_PORTS=$(grep -oE "[0-9]+/open/[^,]*ftp" scans/scan.txt | cut -d/ -f1 )
SSH_PORTS=$(grep -oE "[0-9]+/open/[^,]*ssh" scans/scan.txt | cut -d/ -f1 )

echo $HTTP_PORTS > info/http_ports.txt
echo $SMB_PORTS > info/smb_ports.txt

cat info/http_ports.txt
cat info/smb_ports.txt
