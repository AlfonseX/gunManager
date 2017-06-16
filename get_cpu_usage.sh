#!/bin/env bash

get_cpu_usage(){
    local sy=$(top -bn1 | grep "%Cpu(s)" | cut -d' ' -f6 | sed 's/,/./')
    local us=$(top -bn1 | grep "%Cpu(s)" | cut -d' ' -f3 | sed 's/,/./')
    local total=$(echo "($us+$sy)" | bc)
    printf "Load: %5.2f%%\n" "${total/./,}"
}

get_mem_usage(){
    local line_mem=$(top -bn1 | grep "KiB Mem")
    local mem_total=$(echo $line_mem | cut -d' ' -f4)
    local mem_free=$(echo $line_mem | cut -d' ' -f6)
    local mem_used=$(echo $line_mem | cut -d' ' -f8)
    local line_swap=$(top -bn1 | grep "KiB Swap")
    local swap_total=$(echo $line_swap | cut -d' ' -f3)
    local swap_free=$(echo $line_swap | cut -d' ' -f5)
    local swap_used=$(echo $line_swap | cut -d' ' -f7)

    printf "Mem: %d total %d free %d used\n" "$mem_total" "$mem_free" "$mem_used"
    printf "Swap: %d total %d free %d used\n" "$swap_total" "$swap_free" "$swap_used"
}

get_cpu_usage
get_mem_usage
