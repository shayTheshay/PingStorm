#!/bin/bash

#---------------------------------------------------------------#
#                                                               # 
# Function PingStormLog                                         #
#                                                               #
# Add the function to any PingStorm script requiring logging    #
# At the beginning of any script where logging is required add  #
#  the following after the shebang line:                        #
#                                                               # 
#  . ./.init_logging.sh                                         #
#                                                               # 
# Logging function call structure:                              #
#                                                               # 
# PingStormLog {1|2|3} {<OPERATION>} {<DESTINATION>} {RESPONSE} #
#                                                               # 
# Usage example:                                                # 
#                                                               # 
# PingStormLog 2 PING x.com timeout                             #
#                                                               # 
#---------------------------------------------------------------#

function PingStormLog () {
    case $1 in
    1 )
        logLevel="INFO" ;;
    2 )
        logLevel="WARNING" ;;
    3 )
        logLevel="ERROR" ;;
    * )
        logLevel="" ;;
    esac
    if [ -d LogDir ]; then
        :
        else
            mkdir LogDir
    fi
    echo "["$logLevel"] "$(date +"%m/%d/%Y %T")" Script "$(basename "$0")\
    "issued "$2" to target "$3" with result "$4"." >> LogDir/PingStorm.log
}
