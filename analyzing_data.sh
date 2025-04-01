#!/bin/bash
#read the results script 
result_file="ping_results.txt"
sorted_file="sorted_results.txt"
#check exist file - if not stop running#!/bin/bash
#read the results files
result_file="ping_results.txt"
sorted_file="sorted_results.txt"
#check exist file - if not stop running
        if [ ! -f "$result_file" ]; then
echo "Error $result_file not found "
exit 1
        fi
#to create the list, I took only numbers lines: 
grep -v "unreachable" "$result_file" | sort -k2 -n > "$sorted_file"
#Added unreachable to the end of the list:
grep -v "unreachable" "$result_file" >> "$sorted_file"
#show the fastest service
fastest_service=$(cat "$result_file" | sort -n -k2 | head -1)
echo "fastest server :" "$fastest_service"
#show the slowest service
slowest_service=$(cat "$result_file" | sort -n -k2 | tail -1)
echo "slowest server :" "$slowest_service"
#sort a list by latency and saved it in a file (sorted_file.txt)
sorted_file=$(cat "$result_file" | sort -k2 -n)
echo "list by latency per response time :" "$sorted_file"
       echo "$sorted_file"


