#!/bin/bash

IP=$(cat info/ip.txt)
MODE=$(cat info/modes.txt)

if [[ $MODE == fast ]]; then
        nmap -oG info/scan.txt $IP
elif [[ $MODE == normal ]]; then
        nmap -p- -oG info/scan.txt $IP
elif [[ $MODE == thorough ]]; then
        nmap -sV -p- -oG info/scan.txt $IP
else
        echo "no modes provided, quitting!"
        echo "to fix this, re-run the renum script"
        quit 1
fi

wait

HTTP_PORTS=$(grep -oE "[0-9]+/open/[^,]*http" info/scan.txt | cut -d/ -f1 )
SMB_PORTS=$(grep -oE "[0-9]+/open/[^,]*microsoft-ds" info/scan.txt | cut -d/ -f1 )
FTP_PORTS=$(grep -oE "[0-9]+/open/[^,]*ftp" info/scan.txt | cut -d/ -f1 )
SSH_PORTS=$(grep -oE "[0-9]+/open/[^,]*ssh" info/scan.txt | cut -d/ -f1 )

echo $HTTP_PORTS > info/http_ports.txt
echo $SMB_PORTS > info/smb_ports.txt
echo $FTP_PORTS > info/ftp_ports.txt
echo $SSH_PORTS > info/ssh_ports.txt

