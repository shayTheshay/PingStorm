#!/bin/bash
. ./init_logging.sh 
#read the results script
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
grep "unreachable" "$result_file" >> "$sorted_file"
#show the fastest service
fastest_service=$(grep -v "unreachable" "$result_file" | sort -k2 -n | head -1)
echo "fastest server :" "$fastest_service"
#show the slowest service
slowest_service=$(grep -v "unreachable" "$result_file" | sort -k2 -n | tail -1)
echo "slowest server :" "$slowest_service"
#sort a list by latency and saved it in a file (sorted_file)
echo "list by latency per response time :" "$sorted_file"
       cat "$sorted_file"
#see what we got in our log file
checked_domain=$(echo $fastest_service | awk '{FS=":"}{print $1}')
checked_speed=$(echo $fastest_service | awk '{FS=":"}{print $2}')
PingStormLog 1 $checked_domain $checked_speed
checked_domain=$(echo $slowest_service | awk '{FS=":"}{print $1}')
checked_speed=$(echo $slowest_service | awk '{FS=":"}{print $2}')
PingStormLog 1 $checked_domain $checked_speed

