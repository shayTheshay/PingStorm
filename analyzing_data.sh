#!bin/bash
#read the results script 
input_file="ping_results.txt"
#show the fastest service
fastest_service=$(cat "$input_file" | sort -n -k2 | head -1)
echo "fastest server :" "$fastest_service"
#show the slowest service
slowest_service=$(cat "$input_file" | sort -n -k2 | tail -1)
        echo "slowest server :" "$fastest_service"

