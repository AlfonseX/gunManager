#!/bin/bash
# quelles sont les paires qui tournent ou pas

GUNBOT_DIR=~/gunbot_v3.2

# bots are stop/run/pause
bots_status(){
    for file in ${GUNBOT_DIR}/*-config.js; do
        local pair=$(basename $file | cut -d'-' -f2)
        local market=$(basename $file | cut -d'-' -f1)
        local test=$(pgrep -a gunthy | grep -w $pair | grep -w $market)
        if [ -z "$test" ]; then
            status="stop"
        else
            limit=$(grep -w "BTC_TRADING_LIMIT" $file | awk -F'[:,]' '{print $2}')
            limit=$(echo $limit | bc -l)
            if [[ "$limit" = "0" ]]; then
                status="pause"
            else
                status="run"
            fi
        fi
        mark=$(echo $market | cut -c-4)
        echo -e "${mark}\t$pair  \t$status"
    done
}

bots_status

