#!/bin/bash
FILE=/tmp/testtest
SERVER="http://127.0.0.1:4444"
>$FILE

while true; do
	content=`cat $FILE`
	echo $content
	#curl -H "Content-Type: application/json" -d "{\"data\": \"$content\"}" "$SERVER/rooms/123" &> /dev/null
	curl -d "$content" "$SERVER/rooms/123" &> /dev/null
	sleep 1
done &

trap "kill 0" exit INT TERM

script -t 1 $FILE
