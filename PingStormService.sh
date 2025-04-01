#!/bin/bash
while [[ 0 == 0 ]]; do
    ./pingExe.sh
    ./analyzing_data.sh
    ./export-csv.sh
    sleep 45
done
