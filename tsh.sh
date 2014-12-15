#!/bin/bash
FILE=~/.tsh/terminal-hardcopy
PID_FILE=~/.tsh/pid
ROOM_ID=`openssl rand -hex 123 | head -c 16`
SERVER="https://glacial-oasis-4823.herokuapp.com"
PANE=0

mkdir -p ~/.tsh
>$FILE

function start {
	if [ $TERM != 'screen' ]; then
		echo "Not in tmux session. Connect to tmux first"
		exit
	fi;
	prev=''
	while true; do
		tmux capture-pane -e -t $PANE \; save-buffer -b 0 $FILE
		width=`tmux display-message -pt $PANE -F '#{pane_width}'`
		height=`tmux display-message -pt $PANE -F '#{pane_height}'`
		content=`cat $FILE`
		if [[ $content != $prev ]]; then
			curl \
				-d terminal="$content" \
				-d width="$width" \
				-d height="$height" \
				-k "$SERVER/api/terminals/$ROOM_ID" \
				&> /dev/null

			prev=$content;
		fi;
		sleep 1
	done &

	echo $! >> $PID_FILE
	echo -e "\n\tStreaming started. Type \"exit\" to stop streaming:\n\t\033[37m\033[4m$SERVER/$ROOM_ID\033[0m\n"
}

function stop {
	cat $PID_FILE | xargs kill
	>$PID_FILE
}

COMMAND=$1
shift

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

case $COMMAND in
	start) start
		;;
	stop) stop
		;;
	*) echo "Invalid command $COMMAND"
		;;
esac

#trap "kill 0" exit INT TERM
