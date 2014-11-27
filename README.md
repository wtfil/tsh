# tsh

Tool for sharing terminal session over http

## limitations

`tsh` using the `script` commant for capture terminal. Because of this, there are limitations to environment.

OS:
- OSX - supported
- Linux - not tested
- Windows - not working

Also `tsh` has not support for special characters yet:
- arrrows
- backspace
- output that could change over the time (like VIM)

## install

	npm install -g tsh

## usage

	tsh

you can define your own (server)[https://github.com/wtfil/tsh-server] or room name

	tsh -s http://127.0.0.1:4444 -r my-room

and then you streem will be avaliable by ()[http://127.0.0.1:4444/my-room]
