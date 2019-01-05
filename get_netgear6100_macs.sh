#!/bin/bash
if [ $# != 2 ]; then 
    echo "[command] [user] [password]"
    exit 1;
fi
while [ "$mac_info" = "" ]
do
    sleep 1
    mac_info=$(curl 10.0.0.1/DEV_show_device.htm -u $1:$2 -s | grep access_control_device.[0-9]*=)
done
mac_list=$(echo $mac_info | grep -E -o "[0-9A-Z]{2}(:[0-9A-Z]{2}){5}")
for mac in $mac_list
do
  echo $mac | sed 's/://g'
done
