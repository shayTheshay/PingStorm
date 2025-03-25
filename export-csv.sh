#!/bin/bash

# file to store the exported results
csv_file="latency_results.csv"

echo "Domain,Latency (ms)" > "$csv_file"
 
# Add rows of data
echo "google.com,23.45" >> "$csv_file"
echo "Facebook.com,26.33" >> "$csv_file"
echo "TikTok.com,21.13" >> "$csv_file"

# Notify the user
echo "Data has been exported to $csv_file"

# show the file
cat "$csv_file"
