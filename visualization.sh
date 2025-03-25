#!/bin/bash

#values for emoji
globe_with_meridians="\U1F310"
check_mark_button="\U2705"
sad_crying_emoji="\U1F622"
page_facing_up="\U1F4C3"
#general values
report_number=5
average_latency=60.1
fastest_service="google.com"
slowest_service="tiktok.com"
fastest_time=32.4
slowest_time=89.1

declare -A arr
arr["google.com"]=32.4
arr["facebook.com"]=58.7
arr["tiktok.com"]=89.1

file_name_saved="ping_results.csv"

function output {
	echo -e "${globe_with_meridians} PINGSTORM REPORT"
	echo "-------------------------"
	echo "Tested $report_number services"
	echo -e "Average Latency: $average_latency ms\n"
	echo -e "${check_mark_button} Fastest: $fastest_service($fastest_time ms)" #add emoji Vi
	echo -e "${sad_crying_emoji} Slowest: $slowest_service($slowest_time ms)\n" #add emoji SAD 

	echo "Visual:"
	# Template for looping over the list(might not be sorted list)
	# add bar for latency 
	for key in "${!arr[@]}"; do 
		echo "$key | ${arr[$key]} ms" #It went in reverse please make sure order is correct
	done | sort -n -k3
	echo -e "\n${page_facing_up} Results saved to $file_name_saved"
}

output
