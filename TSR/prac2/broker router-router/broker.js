const zmq = require('zeromq')
let cli=[], req=[], workers=[]
let nreq = 0
let nworkers = {} 
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
	if (workers.length==0) { 
		cli.push(c); req.push(m)
	} else {
		sw.send([workers.shift(),'',c,'',m])
	}
})
sw.on('message',(w,sep,c,sep2,r)=> {
    if (c=='') {workers.push(w); return}
	if (cli.length>0) { 
		sw.send([w,'',
			cli.shift(),'',req.shift()])
	} else {
		workers.push(w)
	}
	if(nworkers[w]){
		nworkers[w]++ 
	} else{
		nworkers[w] = 1 
	} 
	++nreq
	sc.send([c,'',r])
})
setInterval(()=>{
	console.log('Numero de peticiones totales: ' + nreq)
	for (const w in nworkers){
		console.log('El ' + w + ' ha realizado ' + nworkers[w] + ' peticiones')
	} 
	console.log()
},5000)
