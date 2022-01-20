const zmq = require('zeromq')
let req = zmq.socket('req')
const port = process.argv[2]
req.identity=process.argv[3]
const resp = process.argv[4] 
req.connect(port)
req.on('message', (c,sep,msg)=> {
	setTimeout(()=> {
		req.send([c,'',resp])
	}, 1000)
})
req.send(['','',''])
