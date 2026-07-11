#!/usr/bin/env bash

USER_NAME=$USER
HOST_NAME=$(cat /etc/hostname 2>/dev/null || hostname)

if [ -f /etc/os-release ]; then
	source /etc/os-release
	OS_NAME=$PRETTY_NAME
else
    OS_NAME="Linux"
fi

read -r _ user nice system idle iowait irq softirq steal guest guest_nice _ < /proc/stat
prev_active=$((user + nice + system + irq + softirq + steal + guest + guest_nice))
prev_total=$((user + nice + system + idle + iowait + irq + softirq + steal + guest + guest_nice))

echo "{\"username\": \"$USER_NAME\", \"hostname:\": \"$HOST_NAME\", \"os\": \"$OS_NAME\", \"cpu\": 0, \"temp\": 0, \"ram_used\": 0, \"ram_total\": 0, \"disk_used\": 0, \"disk_total\": 0}"

while true; do
    sleep 2

    # cpu percentage
    read -r _ user nice system idle iowait irq softirq steal guest guest_nice _ < /proc/stat
    active=$((user + nice + system + irq + softirq + steal + guest + guest_nice))
    total=$((user + nice + system + idle + iowait + irq + softirq + steal + guest + guest_nice))

    diff_active=$((active - prev_active))
    diff_total=$((total - prev_total))

    if [ $diff_total -eq 0 ]; then
        cpu_pct=0
    else
        cpu_pct=$(( diff_active * 100 / diff_total ))
    fi

    prev_active=$active
    prev_total=$total

    # cpu temp (in celsius)
    cpu_temp=0
    for zone in /sys/class/thermal/thermal_zone*; do
        if [[ -f "$zone/type" && -f "$zone/temp" ]]; then
            type=$(cat "$zone/type")
            if [ "$type" == "x86_pkg_temp" ]; then
                cpu_temp=$(cat "$zone/temp")
                cpu_temp=$(( cpu_temp / 1000 ))
                break
            fi
        fi
    done

    if [[ "$cpu_temp" -eq 0 && -d /sys/class/thermal/thermal_zone0 ]]; then
        cpu_temp=$(cat /sys/class/thermal/thermal_zone0/temp)
        cpu_temp=$(( cpu_temp / 1000 ))
    fi

    # ram usage (in GB)
    total_mem=0
    read -r total_mem _ used_mem < <(awk '
        $1 == "MemTotal:" { total=$2 / 1024 / 1024 }
        $1 == "MemAvailable:" { avail=$2 / 1024 / 1024 }
        END {
            printf "%.2f %.2f %.2f", total, avail, total - avail
        }
    ' /proc/meminfo)

    # disk usage for root partition (in GB)
    read -r disk_total disk_used < <(df / | awk 'NR==2 {printf "%.1f %.1f", $2/1024/1024, $3/1024/1024}')
    disk_total=${disk_total%}
    disk_used=${disk_used%}

    echo "{\"username\": \"$USER_NAME\", \"hostname:\": \"$HOST_NAME\", \"os\": \"$OS_NAME\", \"cpu\": $cpu_pct, \"temp\": $cpu_temp, \"ram_used\": $used_mem, \"ram_total\": $total_mem, \"disk_used\": $disk_used, \"disk_total\": $disk_total}"
done
