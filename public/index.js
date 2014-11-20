var io = require('socket.io-client');
var terminalId = window.location.pathname.split('/')[1];
var socket = io('//' + window.location.host);

socket.emit('join-room', {id: terminalId});

function format(text) {
	return text.replace(/\[\??\d+(;\d+)?\w?/g, '');
}

window.addEventListener('load', function () {
	var terminal = document.querySelector('.terminal');
	socket.on('terminal', function (data) {
		terminal.innerHTML = format(data.terminal);
		terminal.scrollTop = terminal.scrollHeight;
	});
});
