#!/bin/bash
FILE=/tmp/terminal-share-test
ROOM_ID=`Date | md5`
SERVER="https://glacial-oasis-4823.herokuapp.com/"
>$FILE

while true; do
	content=`cat $FILE`
	curl -d "$content" "$SERVER/rooms/$ROOM_ID" &> /dev/null
	sleep 0.1
done &

trap "kill 0" exit INT TERM

echo -e "\n\t\033[4m$SERVER/$ROOM_ID\033[0m\n"
script -q -t 0.1 $FILE
