#!/bin/env bash
# récupérer les dernières lignes de ${market}-${pair}-log.txt

GUNBOT_DIR=~/gunbot_v3.2
MANAGER_DIR=~/Scripts/gunManager

create_log_files(){
    local file="$1"
    local base_file=$(basename $file)
    local pair=$(echo $base_file | cut -d'-' -f2)
    local market=$(echo $base_file | cut -d'-' -f1)
    local pattern="[[:blank:]]\+\[[[:blank:]]\+.\+"  # " [ …"
    local beginning=$(grep -n -e $pattern $file | tail -1 | cut -d':' -f1)
    local len_file=$(wc -l $file | cut -d' ' -f1)
    local context=$((len_file - beginning + 2))
    tail -n${context} $file > ${MANAGER_DIR}/${market}-${pair}.log
    #TODO: inverser la condition
    if grep "next delay" $file > /dev/null; then
        :
        #TODO: sed est-il nécessaire ?
        #sed -i '/^$/d' ${MANAGER_DIR}/${market}-${pair}.log
    else
        create_log_files $file
    fi
}

for file in ${GUNBOT_DIR}/*-log.txt; do
create_log_files "$file"
done
