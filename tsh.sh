#!/bin/bash
FILE=~/tmux.ha  
ROOM_ID=`date | sha256sum | head -c 16`
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
    echo rere
    tmux capture-pane -t 0 \; save-buffer -b 0 $FILE
	content=`cat $FILE`
	if [[ $content != $prev ]]; then
		curl -d "$content" "$SERVER/rooms/$ROOM_ID" &> /dev/null
		prev=$content;
	fi;
	sleep 1
done
echo $!

trap "kill 0" exit INT TERM

echo -e "\n\tStreaming started. Type \"exit\" to stop streaming:\n\t\033[37m\033[4m$SERVER/$ROOM_ID\033[0m\n"
