#!/bin/bash

#THIS IS SPAGHETTI CODE, ILL HAVE TO RESTRUCTURE AND MAKE IT MORE REUSABLE
#REMIND THAT TO FIX ./Renum.sh N 127.0.0.1 DOESNT WORK

echo "Renum" #change to ascii art that is created by me

HEAD=$(echo "Running script")
IP_PROMPT() {
	read -p "Enter the IP you want to scan: " IP
	if [[ $IP =~ ^([0-9]{1,3}\.){3}[0-9]{1,3}$ ]]; then
		echo $IP > ip.txt
	else
		echo "Invalid IP!"
 	fi
}
FAST() {
	echo $HEAD
	echo "running fast scan!"
	./fast_scan.sh
}

NORMAL() {
	echo $HEAD
	echo "running normal scan!"
	./scan.sh
}

THOROUGH() {
	echo $HEAD
	echo "running thorough scan!"
	./thorough_scan
}

#make a checker to check if user downloaded all dependencies

if [[ $1 == "--help" || $1 == "-h" || $1 == "help" ]]; then
	echo "Help Options"
	echo " "
	echo "		Modes		"
	echo "F (default) - fast scan"
	echo "N - normal scan"
	echo "T - thorough scan"
	echo "usage example - ./Renum.sh N"
	echo "alternatively, you can just do ./Renum.sh IP to do recon on an IP/web ex. ./Renum.sh 127.0.0.1"
	echo "--help or -h or help to print help"
	exit 1
elif [[ $1 == "" ]]; then
	FAST
	exit 1
elif [[ $1 == "F" || $1 == "f" ]]; then
	IP_PROMPT
	FAST
	exit 1
elif [[ $1 == "N" || $1 == "n" ]]; then
	IP_PROMPT
	NORMAL
	exit 1
elif [[ $1 == "T" || $1 == "t" ]]; then
	IP_PROMPT
	THOROUGH
	exit 1
elif [[ $1 =~ ^([0-9]{1,3}\.){3}[0-9]{1,3}$ || $1 =~ ^[A-Za-z]+\.[A-Za-z]+$ ]]; then
	echo $1 > ip.txt
	FAST
	exit 1
else
	echo "use --help"
	exit 1
fi


echo "Enter the target IP:"
read IP
if [[ $IP =~ ^([0-9]{1,3}\.){3}[0-9]{1,3}$ ]]; then
	echo $IP > ip.txt
	echo "Which type of scan do you want to run?"
	echo "F - fast scan"
	echo "N - normal scan"
	echo "T - thorough scan"
	read SCAN_CHOICE
	if [[ $SCAN_CHOICE == F || $1 == F ]]; then
		FAST
		exit 1
	elif [[ $SCAN_CHOICE == N || $1 == N ]]; then
		NORMAL
		exit 1
	elif [[ $SCAN_CHOICE == T || $1 == T ]]; then
		THOROUGH
		exit 1
	fi
else
	echo "invalid IP!"
	exit 1
fi
