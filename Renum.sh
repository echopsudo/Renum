#!/bin/bash

echo "Renum" #change to ascii art that is created by me

HEAD=$(echo "Running script")

#make a checker to check if user downloaded all dependencies

if [[ $1 == "--help" || $1 == "-h" || $1 == "help" ]]; then
	echo "Help Options"
	echo "use -m to change modes ex. -m1 or -m 1"
	echo "		Modes		"
	echo "1 (Default) - reads from input" #currently 1 mode for now
	echo "alternatively, you can just do ./Renum.sh IP to do recon on an IP/web ex. ./Renum.sh 127.0.0.1"
	echo "--help or -h or help to print help"
	exit 1
elif [[ $1 == "" ]]; then
	echo $HEAD
elif [[ $1 == "-m1" || $1 == "-m 1" ]]; then
	echo $HEAD
elif [[ $1 =~ ^([0-9]{1,3}\.){3}[0-9]{1,3}$ || $1 =~ ^[A-Za-z]+\.[A-Za-z]+$ ]]; then
	echo $HEAD
	echo $1 > ip.txt
	echo "Running scan script.."
	chmod +x scan.sh
	./scan.sh
	exit 1
else
	echo "use --help"
	exit 1
fi


echo "Enter the target IP:"
read IP
if [[ $IP =~ ^([0-9]{1,3}\.){3}[0-9]{1,3}$ ]]; then
	echo $IP > ip.txt
	echo "Running scan script.."
	chmod +x scan.sh
	./scan.sh
	exit 1
else
	echo "invalid IP!"
	exit 1
fi

