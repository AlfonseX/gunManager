#!/bin/env bash
# main window
# afficher l'écran d'accueil.
# TODO: afficher la liste des fichiers/paires (stop/start/pause/erreur)
# TODO: demander de choisir entre (M)anage_pair (V)iew_console (A)ALLPAIRS (C)reate_config

# ## VARS ############################
# GUNBOT_DIR gunbot directory
GUNBOT_DIR=~/gunbot_v3.2
cd $GUNBOT_DIR

# environment
RIGHT_THERE=$(pwd)
SAVE_PATH=$PATH
PATH=$PATH:$RIGHT_THERE:$GUNBOT_DIR

# CONFIG_FILE_EXT in case gunthar modify this!
CONFIG_FILE_EXT="-config.js"

# NB_GUNBOT_RUN how many gunthy's instances are running
count=0
for pid in $(pgrep gunthy);do
    PID[$count]="$pid"
    ((count++))
done
NB_GUNBOT_RUN=${#PID[@]}

# CONFIG_FILE_LIST list of all *-config.js
declare -a CONFIG_FILE_LIST
count=0
for file in $(ls ${GUNBOT_DIR}/*${CONFIG_FILE_EXT})
do CONFIG_FILE_LIST[$count]=$file
    ((count++))
done

# NB_CONFIG_FILE number of config file
NB_CONFIG_FILE=${#CONFIG_FILE_LIST[@]}
# ## end VARS ############################

# ## FUNCTIONS ################
# pretty_exit
bye(){
    read -n1 -p "Press any key to quit …"
    # restore previous environment
    PATH=$SAVE_PATH
    cd $RIGHT_THERE
    tput rmcup
    exit
}

running_gunbot_list(){
    pgrep -a gunthy | while read line; do
        pid=$(echo $line | cut -d' ' -f1)
        market=$(echo $line | cut -d' ' -f4)
        pair=$(echo $line | cut -d' ' -f3)
        printf "Pid: %s - Market: %s - Pair: %s\n" $pid $market $pair
    done
}
# ## end FUNCTIONS ###########

# ## BODY ####################
# save the screen and clear it
tput smcup
clear
#TODO: parcourir CONFIG_FILE_LIST et afficher
# market / pair
# running / not running
# strategy

for file in ${CONFIG_FILE_LIST[@]}; do
    market=$(basename $file | cut -d'-' -f1)
    market_alias=${market:0:4}
    pair=$(basename $file | cut -d'-' -f2)
    printf "Market: %s - Pair: %s\n" $market_alias $pair
done

running_gunbot_list

## récupérer les dernières lignes de ${market}-${pair}-log.txt
#file="poloniex-BTC_AMP-log.txt"
#pattern="[[:blank:]]\+\[[[:blank:]]\+.\+"  # " [ …"
#beginning=$(grep -n -e $pattern $file | tail -1 | cut -d':' -f1)
#len_file=$(wc -l $file | cut -d' ' -f1)
#context=$((len_file - beginning + 2))
#tail -n${context} $file


# ## end BODY ################

# ## EXIT ####################
bye
