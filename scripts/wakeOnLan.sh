#!/usr/bin/env sh
pcIP="192.168.1.2"
pingTimes=30

echo accendi >/storage/emulated/0/start
echo "Wait two seconds"
sleep 2
cat /storage/emulated/0/start-result
[ "$1" = "--noping" ] && exit
echo
echo "Start ping for $pingTimes times"

count=0
loop="false"
while [ "$count" -lt $pingTimes ] && [ "$loop" = "false" ]; do
    count=$((count + 1))
    result="$(ping -c 1 "$pcIP" | grep "ttl=[0-9]* time=.* ms")"
    if [ -z "$result" ]; then
        echo "Attempt number $count: No response..."
    else
        echo "Attempt number $count: PC it's on!" && exit
    fi
done
echo "Start failed after $count attempts"
exit 1
