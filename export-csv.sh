#!/bin/bash
. ./init_logging.sh

# write headers & results

results_file="ping_results.txt"

csv_file="latency_results.csv"

if [ ! -f "$results_file" ]; then
	echo "Error"
	PingStormLog 3 Error
	exit 1
fi

echo "Domain,Latency (ms)" > "$csv_file"

while IFS= read -r line; do
	echo "$line" >> "$csv_file"
done < "$results_file"

# Notify the user
echo "Results has been exported to $csv_file"

PingStormLog 1 CSV exported success

# show the file
cat "$csv_file"



