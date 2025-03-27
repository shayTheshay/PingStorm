#!/bin/bash
. ./init_logging.sh

targets=(
"google.com"
"facebook.com"
"tiktok.com"
"youtube.com"
"netflix.com"
)

ping_count=4
output_file="ping_results.txt"
echo -n "" > "$output_file"

for target in "${targets[@]}";do
    output=$(ping -c $ping_count $target 2>&1)

    if [[ $? -eq 0 ]]; then
	avg_latency=$(echo "$output" | grep -oP '([0-9]+\.[0-9]+)/([0-9]+\.[0-9]+)/([0-9]+\.[0-9]+)' | cut -d'/' -f2)
	echo "$target: $avg_latency" >> "$output_file"
	PingStormLog 1 PING $target success
    else
        echo "$target: unreachable" >> "$output_file"
        PingStormLog 3 PING $target unreachable
    fi

done
