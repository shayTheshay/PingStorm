#!/bin/bash

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
	echo "PINGSTORM REPORT" #add emoji internet
	echo "-------------------------"
	echo "Tested $report_number services"
	echo "Average Latency: $average_latency ms"
	echo "Fastest: $fastest_service($fastest_time ms)" #add emoji Vi
	echo "Slowest: $slowest_service($slowest_time ms)" #add emoji SAD 

	echo "Visual:"
	# Template for looping over the list(might not be sorted list)
	# add bar for latency 
	for key in "${!arr[@]}"; do 
		echo "$key | ${arr[$key]}"
	done

	echo "Results saved to $file_name_saved"
}

output
