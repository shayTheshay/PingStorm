#!/bin/bash
. ./init_logging.sh

file_name="sorted_results.txt"
declare -A sum_number
declare -A total_count 
function getValue { 
        sorted_file=$(cat "$file_name")
        if [[ $? -eq 0 ]]; then
                while IFS= read -r line; do
			num=$(echo $line | cut -d' ' -f2)
			if [[ $num =~ ^[0-9]+\.[0-9]+$ ]]; then
				name=$(echo $line | cut -d':' -f1)
				current_sum=${sum_number[$name]:-0}
				sum_number["$name"]=$(echo "$current_sum + $num" | bc)
				total_count["$name"]=$((total_count["$name"]+1))
			fi
                done < "$file_name"
	else
                echo "Fail"
        fi
}

getValue


#values for emoji
globe_with_meridians="\U1F310"
check_mark_button="\U2705"
sad_crying_emoji="\U1F622"
page_facing_up="\U1F4C3"

#general values
report_number=$(cat $file_name | sort -k1 | uniq | wc -l)
declare -A arr

for key in "${!total_count[@]}"; do
        arr["$key"]=$(echo "scale=3; ${sum_number[$key]} / ${total_count[$key]}" | bc)
done

average_latency=60.1
fastest_service=$(echo "${!arr[@]}" | awk '{print $1}')
slowest_service=$(echo "${!arr[@]}" | awk '{print $1}')
fastest_time=$(echo "${arr[@]}" | awk '{print $1}')
slowest_time=$(echo "${arr[@]}" | awk '{print $1}')
sum=0.0

for key in "${!arr[@]}"; do
	if (( $(echo "${arr[$key]} > $slowest_time" | bc -l) )); then
		slowest_time=${arr[$key]}
		slowest_service=$key
	fi
	if (( $(echo "${arr[$key]} < $slowest_time" | bc -l) )); then
		fastest_time=${arr[$key]}
		fastest_service=$key
	fi
	sum=$(echo "$sum + ${arr[$key]}" | bc -l)
done
average_latency=$(echo "scale=3; $sum / $report_number" | bc)

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
		printf "%5.1f|%5s | %5s %5.3f ms\n" "$val" "$key" "$bar" "$val" #MIssing ms at the end, please fix
	done | sort -n | cut -d'|' -f2-

	echo -e "\n${page_facing_up} Results saved to $file_name_saved"
}

output
