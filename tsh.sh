#!/bin/bash
FILE=/tmp/terminal-share-test
ROOM_ID=`Date | md5`
SERVER="https://glacial-oasis-4823.herokuapp.com"
>$FILE

while getopts ":r:s:" opt; do
	case $opt in
		r) ROOM_ID="$OPTARG"
			;;
		s) SERVER="$OPTARG"
			;;
		\?) echo "Invalid option -$OPTARG" >&2
			;;
	esac
done

prev=''
while true; do
	content=`cat $FILE`
	if [[ $content != $prev ]]; then
		curl -d "$content" "$SERVER/api/terminals/$ROOM_ID" &> /dev/null
		prev=$content;
	fi;
	sleep 0.1
done &

trap "kill 0" exit INT TERM

echo -e "\n\tStreaming started. Type \"exit\" to stop streaming:\n\t\033[37m\033[4m$SERVER/$ROOM_ID\033[0m\n"

script -q -t 0.1 $FILE
