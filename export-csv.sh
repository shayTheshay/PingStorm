#!/bin/bash

# write headers & results
function export_to_csv() {
domains=("${!1}") # first arg: array of domains
latencies=("${!2}") # second arf: array of latencies
# file to store the exported results
 csv_file="latency_results.csv"

# Create or overwite the CSV file with the headers
echo "Domain,Latency (ms)" > "$csv_file"

for ((i=0; i<${#domains[@]}; i++)); do
# Append the domain and latency to the CSV file
echo "${domains[i]},${latencies[i]}" >> "$csv_file"
done

# Notify the user
echo "Data has been exported to $csv_file"

# show the file
cat "$csv_file"
}


# Example domains 
 domains=("google.com" "Facebook.com" "TikTok.com")

# Example latency 
 latencies=("23.45" "26.33" "21.23")

export_to_csv domains[@] latencies[@]






