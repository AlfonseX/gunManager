#!/bin/env bash
# chercher les infos dans les fichiers .log
# quelles infos ?


GUNBOT_DIR=~/gunbot_v3.2
MANAGER_DIR=~/Scripts/gunManager

#source create_log_files.sh
declare -A tab
for file in ${MANAGER_DIR}/*.log; do
    pair=$(basename $file | cut -d'-' -f2)
    pair=${pair%.log}
    market=$(basename $file | cut -d'-' -f1)
    mark=${market:0:1}
    ind="${mark}${pair}"
    tab[$ind]=$(awk '/\[/ { print $10 }' $file)
    echo "pair: $pair - market: $market - mark: $mark"
    echo "$ind : ${tab[$ind]}"

done
#export $tab

#for ind in ${!tab[@]}; do
#    echo "$ind : ${tab[$ind]}"
#done
# date, n°cycle
# BalBTC, BalALT, LP
# open order
# boughtPrice
# price grows, falls
# Callback

# next delay
# last error

##LowBB, HighBB
##PriceToBuy, PriceToSell
##LP > prBuy, secMargin
##need faster, need slower
