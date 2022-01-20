const zmq = require('zeromq')
let workers=[]
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
	sw.send([workers.shift(),'',c,'',m])
})
sw.on('message',(w,sep1,c,sep2,r)=> {
	sc.send([c,'',r]);
	workers.push(w);
})
