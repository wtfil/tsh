#!/bin/bash
FILE=/tmp/testtest
SERVER="http://127.0.0.1:4444"
>$FILE

while true; do
	content=`cat $FILE`
	curl -d "$content" "$SERVER/rooms/123" &> /dev/null
	sleep 0.1
done &

trap "kill 0" exit INT TERM

script -t 0.1 $FILE
