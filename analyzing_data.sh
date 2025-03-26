#!bin/bash
#read the results script 
input_file="results.txt"
#show the fastest service
fastest_service=$(cat "$input_file" | sort -n -k2 | head -1)
echo "fastest server :" "$fastest_service"

