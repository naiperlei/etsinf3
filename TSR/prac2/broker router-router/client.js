const zmq = require('zeromq')
let req = zmq.socket('req');
const port = process.argv[2]
req.identity = process.argv[3] 
const m = process.argv[4]
req.connect(port)
req.on('message', (msg)=> {
	console.log('resp: '+msg)
	process.exit(0);
})
req.send(m)
