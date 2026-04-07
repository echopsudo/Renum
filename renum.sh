#!/bin/bash

#REMIND THAT ./renum.sh N 127.0.0.1 DOESNT WORK

echo "                                          "
echo "                                          "
echo "||==|| ||=== ||\     || ||  || ||\    /|| "
echo "||  || ||    || \    || ||  || || \  / || "
echo "||==|| ||=== ||  \   || ||  || ||  \/  || "
echo "||\    ||    ||   \  || ||  || ||      || "
echo "|| \   ||    ||    \ || ||  || ||      || "
echo "||  \  ||=== ||     \||  \==/  ||      || "
echo "                                          "
echo "                                          "
echo ">  By echopsudo, written in Bash shell.  <"
echo "                                          "
echo "                                          "


#Variables

HEAD=$(echo "Running script")




#Defining commands

SCAN_TYPES() {
	echo "-F (default) - fast scan"
	echo "-N - normal scan"
	echo "-T - thorough scan"
}

HELP() {
	echo "Help Options"
	echo " "
	echo "		Modes		"
	SCAN_TYPES
	echo "usage example - ./renum.sh N"
	echo "alternatively, you can just do ./renum.sh IP to do recon on an IP/web ex. ./renum.sh 127.0.0.1"
	echo "--help or -h or help to print help"
}

IP_PROMPT() {
	read -p "Enter the IP you want to scan: " IP
	if [[ $IP =~ ^([0-9]{1,3}\.){3}[0-9]{1,3}$ ]]; then
		echo $IP > info/ip.txt
	else
		echo "Invalid IP!"
		exit 1
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

SCAN_OPTIONS() {

	echo "Which type of scan do you want to run?"
	SCAN_TYPES
	read SCAN_CHOICE
	if [[ $SCAN_CHOICE == F || $SCAN_CHOICE == -F ]]; then
		FAST
		exit 1
	elif [[ $SCAN_CHOICE == N || $SCAN_CHOICE == -N ]]; then
		NORMAL
		exit 1
	elif [[ $SCAN_CHOICE == T || $SCAN_CHOICE == -T ]]; then
		THOROUGH
		exit 1
	fi
}






#Main script; flag set

if [[ $1 == "--help" || $1 == "-h" || $1 == "help" ]]; then
	HELP
	exit 1
elif [[ $1 == "" ]]; then
	echo " "
elif [[ $1 == "-F" ]]; then
	IP_PROMPT
	FAST
	exit 1
elif [[ $1 == "-N" ]]; then
	IP_PROMPT
	NORMAL
	exit 1
elif [[ $1 == "-T" ]]; then
	IP_PROMPT
	THOROUGH
	exit 1
elif [[ $1 =~ ^([0-9]{1,3}\.){3}[0-9]{1,3}$ || $1 =~ ^[A-Za-z]+\.[A-Za-z]+$ ]]; then
	echo $1 > info/ip.txt
	SCAN_OPTIONS
	exit 1
else
	echo "Invalid options, please use --help"
	exit 1
fi





#if no flags are set

IP_PROMPT
SCAN_OPTIONS
