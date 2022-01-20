const zmq = require('zeromq')
let cli=[], req=[]
let nreq = 0
var nw = 0 
const portc = process.argv[2]
const portw = process.argv[3]
let sc = zmq.socket('router') // frontend
let sw = zmq.socket('router') // backend
sc.bind('tcp://*:' + portc, (err) =>{
	if(err) console.log(err)
	else console.log('listening')
} )
sw.bind('tcp://*:' + portw, (err) =>{
	if(err) console.log(err)
	else console.log('listening')
} )
sc.on('message',(c,sep,m)=> {
	if (nw > 0) { 
		sw.send([c, '', m]); 
		nw--;
	} else {
		cli.push(c);
		req.push(m);
	}
})
sw.on('message',(c,sep,r)=> {
	if (cli.length>0) { 
		sw.send([cli.shift(),'',req.shift()])
	} 
	nw++;
	if(c!=''){
		sc.send([c,'',r])
	} 
})

