#!/bin/sh
LAST_PACKETS=-1
LAST_BYTES=-1
while true
do
RET=`iptables -vx -L | grep 1234`
PACKET_NUM=`echo $RET | awk -F' ' '{print $1}'`
BYTES_NUM=`echo $RET | awk -F' ' '{print $2}'`
if [ $LAST_PACKETS == -1 ]
then 
  LAST_PACKETS=$PACKET_NUM
fi
if [ $LAST_BYTES == -1 ]
then
  LAST_BYTES=$BYTES_NUM
fi
echo $BYTES_NUM
CUR_PACKETS=`expr $PACKET_NUM - $LAST_PACKETS`
CUR_BYTES=`expr $BYTES_NUM - $LAST_BYTES`
LAST_PACKETS=$PACKET_NUM
LAST_BYTES=$BYTES_NUM
echo Packets:$CUR_PACKETS Bytes:$CUR_BYTES
curl -X POST -H "Content-Type: application/json" -d '{"value1":"'$CUR_BYTES'","value2":"'$CUR_PACKETS'"}' https://maker.ifttt.com/trigger/nettraffic/with/key/b-sDBt2fForadIBe5mW_S-
sleep 60
done
