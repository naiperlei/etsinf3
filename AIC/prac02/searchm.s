        .data
a:      .dword  9,8,0,1,0,5,3,1,2,0
tam:    .dword 10       ; Tamaño del vector
cont:   .dword 0        ; Número de componentes == 0

        .text
start:	dadd r1,$gp,a   ; Puntero
        ld r4,tam($gp)  ; Tamaño lista
        dadd r10,r0,r0  ; Contador de ceros
 
loop:
	ld r2,0(r1)
        dadd r4, r4, -1
        dadd r1, r1, #8 
        bnez r2, nocero
        dadd r10,r10,1
nocero: bnez r4, loop

        trap #0
