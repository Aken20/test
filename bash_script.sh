#!/bin/bash

echo "
          #Architecture : $(uname -a)"
echo "          #CPU Physical : $(lscpu | grep 'Socket(s):' | awk '{print $2}')"
echo "          #vCPU : $(lscpu | grep 'node(s):' | awk '{print $3}')"
total_ram=$(free -m | grep 'Mem' | awk '{print $2}')
used_ram=$(free -m | grep 'Mem' | awk '{print $3}')
ram_utilization=$(free | grep 'Mem' | awk '{printf("%.2f%%", $3/$2*100)}')
echo "          #Memory Usage : $used_ram/${total_ram}MB ($ram_utilization)"
total_memory=$(df -h | awk '$NF=="/" {print $2}')
used_memory=$(df -h | awk '$NF=="/" {print $3}')
memory_utilization=$(df -h | awk '$NF=="/" {print $5}')
echo "          #Disk Usage : $used_memory/$total_memory ($memory_utilization)"
echo "          #CPU load: $(mpstat | grep 'all' | awk '{printf("%.2f%%", 100-$13)}')"
echo "          #Last boot: $(who -b | awk '{print $3, $4}')"
echo "          #LVM use: $(if [ $(lsblk | grep "lvm" | wc -l) -gt 0 ]; then echo yes; else echo no; fi)"
echo "          #Connections TCP : $(netstat -an | grep ESTABLISHED | wc -l) ESTABLISHED"
echo "          #User log : $(who | wc -l)"
echo "          #Network : IP $(hostname -I) ($(ip link | awk '/ether/ {print $2}'))"
echo "          #Sudo : $(journalctl _COMM=sudo -q | grep COMMAND | wc -l) cmd"
