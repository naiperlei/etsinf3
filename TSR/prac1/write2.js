fiSys.writeFile('texto.txt','contenido del nuevo fichero',cbError,cbEscritura);

function cbEscritura(fichero){
	console.log("escritura realizada en: "+fichero);
}

function cbError(fichero){
	console.log("ERROR DE ESCRITURA en "+fichero);
}