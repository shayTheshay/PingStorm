#!/bin/bash
. ./init_logging.sh

results_file="ping_results.txt"

csv_file="latency_results.csv"

if [ ! -f "$results_file" ]; then
	echo "Error: Input file '$results' does not exist."
	PingStormLog 3 Error file does not exist.
	exit 1
fi

# write headers & results
echo "Domain,Latency (ms)" > "$csv_file"

while IFS= read -r line; do
	echo "$line" >> "$csv_file"
done < "$results_file"

# Notify the user
echo "Results has been exported to $csv_file"

PingStormLog 1 CSV file exported success

# show the file
cat "$csv_file"



