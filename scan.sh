IP=$(cat ip.txt)

THIS LINE IS INTENDED TO BREAK CODE, AND TO CLARIFY THAT THIS IS A PLACEHOLDER

echo "Please clarify options for Nmap scan"
echo "example: -F does a fast scan"
echo "-sV does a service version detection scan"
echo "if you are unsure, please type man"
echo "keep in mind, -oG nmap_scan.txt has already been set."

read INPUT

if [[ $INPUT == "man" ]]; then
  man nmap
elif [[ $INPUT =~ -[a-zA-Z0-9]+ ]]; then
  nmap $INPUT -oG nmap_scan.txt $IP
elif [[ $INPUT == --help ]]; then
  nmap --help
else
  echo "your options are probably incorrect. please type man to see nmap's manual"
fi
