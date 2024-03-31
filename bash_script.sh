#!/bin/bash

total_ram=$(free -m | grep 'Mem' | awk '{print $2}')
used_ram=$(free -m | grep 'Mem' | awk '{print $3}')
ram_utilization=$(free | grep 'Mem' | awk '{printf("%.2f%%", $3/$2*100)}')
total_memory=$(df -m | grep "/dev/" | awk '{disk_t += $2} END {print disk_t}')
used_memory=$(df -m | grep "/dev/" | awk '{disk_u += $3} END {print disk_u}')
memory_utilization=$(printf "%d%%" "$((used_memory * 100 / total_memory))")
wall "
          #Architecture : $(uname -a)
          #CPU Physical : $(lscpu | grep 'Socket(s):' | awk '{print $2}')
          #vCPU : $(lscpu | grep 'node(s):' | awk '{print $3}')
          #Memory Usage : $used_ram/${total_ram}MB ($ram_utilization)
          #Disk Usage : $used_memory/$(printf "%d" "$((total_memory / 1024))")Gb ($memory_utilization)
          #CPU load: $(mpstat | grep 'all' | awk '{printf("%.2f%%", 100-$13)}')
          #Last boot: $(who -b | awk '{print $3, $4}')
          #LVM use: $(if [ $(lsblk | grep "lvm" | wc -l) -gt 0 ]; then echo yes; else echo no; fi)
          #Connections TCP : $(netstat -an | grep ESTABLISHED | wc -l) ESTABLISHED
          #User log : $(who | wc -l)
          #Network : IP $(hostname -I) ($(ip link | awk '/ether/ {print $2}'))
          #Sudo : $(journalctl _COMM=sudo -q | grep COMMAND | wc -l) cmd
"
