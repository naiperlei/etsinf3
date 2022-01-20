(defglobal ?*nod-gen* = 0)
(defglobal ?*prof* = 60)

(deffacts grid
	(tamaño 8 5)
	(contenedor 1 3)	
	(contenedor 1 5)
	(contenedor 2 1)
	(contenedor 4 3)
	(contenedor 6 1)
	(contenedor 8 1)
	(contenedor 8 3)
	(contenedor 4 5)
	(contenedor 7 5)
	(problema robot 2 3 lata e 3 1 e 3 3 e 6 4  nivel 0))
 

;MOVER ROBOT

(defrule mueveDerecha
  (problema robot ?x ?y lata $?w nivel ?n)
  (tamaño ?lx ?ly)
  (test (not (member$ (create$ e (+ ?x 1) ?y) $?w)))	
  (not (contenedor =(+ ?x 1) ?y ))
  (test (< ?x ?lx)) 
  (test (< ?n ?*prof*))
=>
  (bind ?*nod-gen* (+ ?*nod-gen* 1))
  (assert (problema robot (+ ?x 1) ?y lata $?w nivel (+ ?n 1)))
)


(defrule mueveIzquierda
  (problema robot ?x ?y lata $?w nivel ?n)
  (tamaño ?lx ?ly)
  (test (not (member$ (create$ e (- ?x 1) ?y) $?w)))
  (not (contenedor =(- ?x 1) ?y ))
  (test (> ?x 0)) 
  (test (< ?n ?*prof*))
=>
  (bind ?*nod-gen* (+ ?*nod-gen* 1))
  (assert (problema robot (- ?x 1) ?y lata $?w nivel (+ ?n 1)))
)


(defrule mueveArriba
  (problema robot ?x ?y lata $?w nivel ?n)
  (tamaño ?lx ?ly)
  (test (not (member$ (create$ e ?x (+ ?y 1)) $?w)))
  (not (contenedor ?x =(+ ?y 1)))
  (test (< ?y ?ly)) 
  (test (< ?n ?*prof*))
=>
  (bind ?*nod-gen* (+ ?*nod-gen* 1))
  (assert (problema robot ?x (+ ?y 1) lata $?w nivel (+ ?n 1)))
)


(defrule mueveAbajo
  (problema robot ?x ?y lata $?w nivel ?n)
  (tamaño ?lx ?ly)
  (test (not (member$ (create$ e ?x (- ?y 1)) $?w)))
  (not (contenedor ?x =(- ?y 1)))
  (test (> ?y 0)) 
  (test (< ?n ?*prof*))
=>
  (bind ?*nod-gen* (+ ?*nod-gen* 1))
  (assert (problema robot ?x (- ?y 1) lata $?w nivel (+ ?n 1)))
)



;EMPUJAR LATAS

(defrule empujarLataDerecha
  (problema robot ?x ?y lata $?w nivel ?n)
  (tamaño ?lx ?ly)
  (test (member$ (create$ e (+ ?x 1) ?y) $?w))
  (test (not (member$ (create$ e (+ ?x 2) ?y) $?w)))
  (not (contenedor = (+ ?x 2) ?y))
  (test (< ?x ?lx)) 
  (test (< ?n ?*prof*))
=>
  (bind ?*nod-gen* (+ ?*nod-gen* 1))
  (assert (problema robot (+ ?x 1) ?y lata (replace-member$ $?w (create$ e (+ ?x 2) ?y) (create$ e (+ ?x 1) ?y)) nivel (+ ?n 1)))
)


(defrule empujarLataIzquierda
  (problema robot ?x ?y lata $?w nivel ?n)
  (tamaño ?lx ?ly)
  (test (member$ (create$ e (- ?x 1) ?y) $?w))
  (test (not (member$ (create$ e (- ?x 2) ?y) $?w)))
  (not (contenedor = (- ?x 2) ?y))
  (test (> ?x 0)) 
  (test (< ?n ?*prof*))
=>
  (bind ?*nod-gen* (+ ?*nod-gen* 1))
  (assert (problema robot (- ?x 1) ?y lata (replace-member$ $?w (create$ e (- ?x 2) ?y) (create$ e (- ?x 1) ?y)) nivel (+ ?n 1)))
)


(defrule empujarLataArriba
  (problema robot ?x ?y lata $?w nivel ?n)
  (tamaño ?lx ?ly)
  (test (member$ (create$ e ?x (+ 1 ?y)) $?w))
  (test (not (member$ (create$ e ?x (+ ?y 2)) $?w)))
  (not (contenedor ?x = (+ ?y 2)))
  (test (< ?y ?ly)) 
  (test (< ?n ?*prof*))
=>
  (bind ?*nod-gen* (+ ?*nod-gen* 1))
  (assert (problema robot ?x (+ ?y 1) lata (replace-member$ $?w (create$ e ?x (+ ?y 2)) (create$ e ?x (+ ?y 1))) nivel (+ ?n 1)))
)


(defrule empujarLataAbajo
  (problema robot ?x ?y lata $?w nivel ?n)
  (tamaño ?lx ?ly)
  (test (member$ (create$ e ?x (- 1 ?y)) $?w))
  (test (not (member$ (create$ e ?x (- ?y 2)) $?w)))
  (not (contenedor ?x = (- ?y 2)))
  (test (> ?y 0)) 
  (test (< ?n ?*prof*))
=>
  (bind ?*nod-gen* (+ ?*nod-gen* 1))
  (assert (problema robot ?x (- ?y 1) lata (replace-member$ $?w (create$ e ?x (- ?y 2)) (create$ e ?x (- ?y 1))) nivel (+ ?n 1)))
)


;EMPUJAR LATA A UN CONTENEDOR

(defrule contenedorDerecha
  (problema robot ?x ?y lata $?w nivel ?n)
  (test (member$ (create$ e (+ ?x 1) ?y) $?w))	
  (contenedor = (+ ?x 2) ?y)
  (test (< ?n ?*prof*))
=>
  (bind ?*nod-gen* (+ ?*nod-gen* 1))
  (assert (problema robot (+ ?x 1) ?y lata (delete-member$ $?w (create$ e (+ ?x 1) ?y)) nivel (+ ?n 1)))
)


(defrule contenedorIzquierda
  (problema robot ?x ?y lata $?w nivel ?n)
  (test (member$ (create$ e (- ?x 1) ?y) $?w))	
  (contenedor = (- ?x 2) ?y)
  (test (< ?n ?*prof*))
=>
  (bind ?*nod-gen* (+ ?*nod-gen* 1))
  (assert (problema robot (- ?x 1) ?y lata (delete-member$ $?w (create$ e (- ?x 1) ?y)) nivel (+ ?n 1)))
)


(defrule contenedorArriba
  (problema robot ?x ?y lata $?w nivel ?n)
  (test (member$ (create$ e ?x (+ ?y 1)) $?w))	
  (contenedor ?x =(+ ?y 2))
  (test (< ?n ?*prof*))
=>
  (bind ?*nod-gen* (+ ?*nod-gen* 1))
  (assert (problema robot ?x (+ ?y 1) lata (delete-member$ $?w (create$ e ?x (+ ?y 1))) nivel (+ ?n 1)))
)


(defrule contenedorAbajo
  (problema robot ?x ?y lata $?w nivel ?n)
  (test (member$ (create$ e ?x (- ?y 1)) $?w))	
  (contenedor ?x =(- ?y 2))
  (test (< ?n ?*prof*))
=>
  (bind ?*nod-gen* (+ ?*nod-gen* 1))
  (assert (problema robot ?x (- ?y 1) lata (delete-member$ $?w (create$ e ?x (- ?y 1))) nivel (+ ?n 1)))
)



;; ==== ESTRATEGIA DE CONTROL DE BÚSQUEDA =====

(defrule no_solucion
	(declare (salience -99))
	(problema robot $? lata $? nivel ?n )
	=>
	(printout t "SOLUCION NO ENCONTRADA" crlf)
	(printout t "NODOS GENERADOS: " ?*nod-gen* crlf)
	(halt)
)
(defrule objetivo
	(declare (salience 100))
	?f<-(problema robot ?x ?y lata nivel ?n )
	=>
	(printout t "SOLUCION ENCONTRADA EN EL NIVEL " ?n crlf)
	(printout t "NUM DE NODOS EXPANDIDOS O REGLAS DISPARADAS " ?n crlf)
	(printout t "HECHO OBJETIVO " ?f crlf)
	(halt)
)

(deffunction inicio ()
	(reset)
	(printout t "Profundidad Maxima:= " )
	(bind ?prof (read))	
	(printout t "Tipo de Búsqueda " crlf "1.- Anchura" crlf
		"2.- Profundidad" crlf )
	(bind ?a (read))
	(if (= ?a 1)
		then (set-strategy breadth)
		else (set-strategy depth))
	(assert (profundidad-maxima ?prof))
	)
