#!/bin/bash
. ./init_logging.sh

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

max_value=0
for val in "${arr[@]}"; do
	val_int="${val%%.*}"
	(( val_int > max_value )) && max_value=$val_int
done

bar_width=10
scale=$(( max_value /bar_width ))
(( scale == 0 )) && scale=1

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
		val="${arr[$key]}"
		val_int="${val%%.*}"
		bar_length=$(( val_int / scale ))

		bar=$(eval "printf '█%.0s' {1..$bar_length}")
		printf "%5.1f|%5s | %5s %5.1f ms\n" "$val" "$key" "$bar" "$val" #MIssing ms at the end, please fix
	done | sort -n | cut -d'|' -f2-

	echo -e "\n${page_facing_up} Results saved to $file_name_saved"
}

output
