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
        ./PingStormService.sh &
        echo "PingStorm batch service started."
    fi ; read ;;
 2 )
    keep_process_id="" ; while read -r process_id; do
    if [[ -n $process_id ]]; then
        keep_process_id=$process_id
        echo "Terminating PingStorm service with PID "$process_id
        kill $process_id
    fi 
    done <<< `ps -ef | grep PingStormService.sh | grep -v grep | awk '{print $2}'` ;
    if [[ !( -n $keep_process_id ) ]]; then
        echo "None is running. "
    fi ; read ;;
 3 )
    echo "Following is list of PingStorm manager processes currently running:" ;
    keep_process_id="" ; while read -r process_id; do
    if [[ -n $process_id ]]; then
        keep_process_id=$process_id
        echo "A PingStorm service is running with PID "$process_id
    fi
    done <<< `ps -ef | grep PingStormService.sh | grep -v grep | awk '{print $2}'` ;
    if [[ !( -n $keep_process_id ) ]]; then
        echo "None is running. "
    fi ; read ;;
 4 )
    echo "Latest PingStorm service operations from log:" ; \
    if [[ -e /LogDir/PingStorm.log ]]; then
    tail -10 ./LogDir/PingStorm.log
    else echo "So far no PingStorm log entries created."
    fi ; read ;;
 0 )
    exit 0 ;;
* )
    echo "Invalid option, please press any key." ; read ;;
esac
clear
done
