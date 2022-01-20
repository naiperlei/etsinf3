const zmq = require('zeromq')
let pub = zmq.socket('pub')
var port = parseInt(process.argv[2])
var numMensajes = parseInt(process.argv[3])
let msg = process.argv.splice(4)
pub.bind('tcp://*:' + port)
let i = 1
function emite() {
	let m=msg[0]
	let msgSend = `${i}: ${m} ${Math.floor((i-1)/msg.length) + 1}`
	pub.send(msgSend)
	console.log(msgSend)
	msg.shift(); msg.push(m) // rotatorio
	if(i == numMensajes)
		process.exit();
	i++;
}
setInterval(emite,1000) // every second
