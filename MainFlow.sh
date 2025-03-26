#!/bin/bash
flow_option=5
while [[ $flow_option != 0 ]]
do
echo "WELCOME TO PingStorm MANAGER
============================

Please choose from following options:

     1.) Start PingStorm service
     2.) Stop PingStorm service
     3.) Review PingStorm service execution status
     4.) Show Pingstorm service latest log entries
     0.) Exit manager program

For quitting manager, please choose 0."

read flow_option
case $flow_option in
 1 )
    if [[ `ps -ef | grep PingStormService.sh | grep -v grep | wc -l` == 0 ]]; then
        `./PingStormService.sh &`
        echo "PingStorm batch service started."
    fi ; read ;;
 2 )
    while read -r process_id; do
        echo "Terminating PingStorm service with PID "$process_id
        kill $process_id
    done <<< `ps -ef | grep PingStormService.sh | grep -v grep | awk '{print $2}'` ; read ;;
 3 )
    echo "Following is list of PingStorm manager processes currently running" ;
    while read -r process_id; do
    if [[ -n $process_id ]]; then
        echo "A PingStorm service is running with PID "$process_id
    fi
    done <<< `ps -ef | grep PingStormService.sh | grep -v grep | awk '{print $2}'` ; 
    if [[ -n $process_id ]]; then
        :
        else echo "None is running."
    fi ; read ;;
 4 )
    echo "Latest PingStorm service operations from log:" ; \
    tail -10 ./LogDir/PingStorm.log ;;
 0 )
    exit 0 ;;
* )
    echo "Invalid option, please press any key." ; read ;;
esac
clear
done
