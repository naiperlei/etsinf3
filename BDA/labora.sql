--cine

--1. Obtener ordenados ascendentemente los c�digos de los pa�ses de donde son los actores.

SELECT DISTINCT cod_pais
FROM actor
ORDER BY cod_pais;

--2. Obtener el c�digo y el t�tulo de las pel�culas de a�o anterior a 1970 que no est�n basadas en ning�n libro
--ordenadas por t�tulo.

SELECT cod_peli, titulo
FROM pelicula
WHERE anyo < 1970 AND cod_lib IS NULL;

--3. Obtener el c�digo y el nombre de los actores cuyo nombre incluye �John�. 

SELECT cod_act, nombre
FROM actor
WHERE nombre LIKE '%John%';

--4. Obtener el c�digo y el t�tulo de las pel�culas de m�s de 120 minutos de la d�cada de los 80.

SELECT cod_peli, titulo
FROM pelicula
WHERE duracion > 120 AND anyo > 1980 AND anyo < 1990;

--5. Obtener el c�digo y el t�tulo de las pel�culas que est�n basadas en alg�n libro y cuyo director se apellide
--�Pakula�

SELECT cod_peli, titulo
FROM pelicula
WHERE cod_lib IS NOT NULL AND director LIKE '%Pakula';

--6. �Cu�ntas pel�culas hay de m�s de 120 minutos de la d�cada de los 80?

SELECT COUNT(*)
FROM pelicula
WHERE duracion > 120 AND anyo > 1980 AND anyo < 1990;

--7. �Cu�ntas pel�culas se han clasificado de los g�neros de c�digo 'BB5' o 'GG4' o'JH6'?

SELECT COUNT(DISTINCT cod_peli)
FROM clasificacion
WHERE cod_gen='BB5' OR cod_gen='GG4' OR cod_gen='JH6';

--8. . �De qu� a�o es el libro m�s antiguo?

SELECT MIN(anyo)
FROM libro_peli;

--9. �Cu�l es la duraci�n media de las pel�culas del a�o 1987?

SELECT AVG(duracion)
FROM pelicula
WHERE anyo=1987;

--10. �Cu�ntos minutos ocupan todas las pel�culas dirigidas por �Steven Spielberg�?

SELECT SUM(duracion)
FROM pelicula
WHERE director='Steven Spielberg';

--33. Obtener el c�digo y el nombre de los actores tales que todos los papeles que han tenido son de
--�Secundario�. S�lo interesan aquellos actores que hayan actuado en alguna pel�cula.

SELECT a.cod_act, a.nombre
FROM actor a
WHERE NOT EXISTS
        (SELECT *
        FROM actua ac
        WHERE ac.papel='Secundario' AND
        NOT EXISTS
            (SELECT *
            FROM actor a
            WHERE a.cod_act=ac.actor_act
            )
        );

--musica

SELECT cod, nombre, fecha
FROM disco
WHERE nombre='October';

--1. �Cu�ntos discos hay?

SELECT COUNT(*)
FROM disco;

--valor medio del n� de socios de los clubs de fans

SELECT AVG(num)
FROM club;

--2. Selecciona el nombre de los grupos que no sean de Eszpa�a.

SELECT nombre
FROM grupo
WHERE pais <> 'Espa�a'; -- pais != 'Espa�a' es otra opci�n

--3. Obtener el t�tulo de las canciones con m�s de 5 minutos de duraci�n.

SELECT titulo
FROM cancion
WHERE duracion > 5;

--4. Obtener la lista de las distintas funciones que se pueden realizar en un grupo.

SELECT DISTINCT funcion
FROM pertenece;

--5. Obtener la lista de clubs de fans junto con su tama�o (n�mero de personas). La lista debe estar ordenada
--de menor a mayor seg�n el tama�o del club.

SELECT nombre, num
FROM club
ORDER BY num ASC;

--6. Selecciona el nombre y la sede de los clubes de fans con m�s de 500 socios.

SELECT nombre, sede
FROM club
WHERE num > 500;

--23. Obtener el n�mero de canciones que ha grabado cada compa��a(todas las compa�ias) discogr�fica y su direcci�n. 
SELECT c.nombre, c.dir, count(e.can)
FROM companyia c LEFT JOIN (disco d JOIN esta e ON e.cod=d.cod) ON c.cod=d.cod_comp
GROUP BY c.dir, c.nombre
ORDER BY c.nombre;

--biblioteca
--consultas adicionales
--1. Obtener los titulos de los libros que contienen la palabra cuento

SELECT titulo
FROM libro
WHERE titulo LIKE '%cuento%';

--2. Obtener los identificadores de los libros publicados entre los a�os 1996 y 1999. Resolver esta consulta con el predicado BETWEEN

SELECT id_lib
FROM libro
WHERE a�o BETWEEN 1996 AND 1999;

--3. Resolver la consulta anterior con el predicado IN

SELECT id_lib
FROM libro
WHERE a�o IN (1996,1997,1998,1999);

--4. Obtener la cantidad de libros que no tienen titulo

SELECT COUNT(id_lib)
FROM libro
WHERE titulo IS NULL;

--5. Obtener el titulo de los libros que no tienen a�o de publicaci�n

SELECT titulo
FROM libro
WHERE a�o IS NULL AND titulo IS NOT NULL;

--6. Obtener el a�o del libro sin titulo m�s antiguo

SELECT MIN(a�o)
FROM libro
WHERE titulo IS NULL;

--9. Obtener cuantos autores han escrito alguna obra con la palabra ciudad en su titulo

SELECT COUNT(DISTINCT e.autor_id)
FROM escribir e, obra o
WHERE e.cod_ob = o.cod_ob AND o.titulo LIKE '%ciudad%';

--10. Obtener el titulo de todas las obras escritas por el autor de nombre 'Camus, Albert'

SELECT o.titulo
FROM autor a, escribir e, obra o
WHERE a.autor_id = e.autor_id AND e.cod_ob = o.cod_ob AND a.nombre = 'Cam�s, Albert';

--11. �Qui�n es el autor de la obra de titulo 'La tata'?

SELECT a.nombre
FROM autor a, escribir e, obra o
WHERE a.autor_id = e.autor_id AND e.cod_ob = o.cod_ob AND o.titulo = 'La tata';

--12. Obtener el nombre de los amigos que han le�do alguna obra del autor de identificador �RUKI�

SELECT DISTINCT a.nombre
FROM amigo a, leer l, obra o, escribir e
WHERE l.cod_ob = o.cod_ob AND a.num = l.num AND o.cod_ob = e.cod_ob AND e.autor_id = 'RUKI';

--13. Obtener el t�tulo y el identificador de los libros que tengan t�tulo y m�s de una obra. Resolver este
--ejercicio sin utilizar el atributo num_obras.

SELECT l.titulo, l.id_lib
FROM libro l, esta_en e1, esta_en e2, obra o
WHERE l.id_lib = e1.id_lib AND l.id_lib = e2.id_lib AND e1.cod_ob <> e2.cod_ob AND l.titulo IS NOT NULL;

--14. . Obtener el t�tulo de las obras escritas s�lo por un autor si �ste es de nacionalidad �Francesa� indicando
--tambi�n el nombre del autor.

SELECT o.titulo, a.nombre
FROM obra o, escribir e, autor a
WHERE o.cod_ob = e.cod_ob AND e.autor_id = a.autor_id AND a.nacionalidad = 'Francesa' AND
    (SELECT  COUNT(*)
    FROM escribir e1
    WHERE e1.cod_ob = o.cod_ob) = 1;
    
--15. �Cu�ntos autores hay en la base de datos de los que no se tiene ninguna obra?

SELECT COUNT(*)
FROM autor a
WHERE NOT EXISTS
    (SELECT *
     FROM escribir e
     WHERE e.autor_id = a.autor_id);
     
--con NOT IN en lugar de NOT EXISTS

SELECT COUNT(*)
FROM autor a
WHERE a.autor_id NOT IN
    (SELECT autor_id
     FROM escribir);
     
--otro

SELECT COUNT (*)
FROM autor a
WHERE 0 = (SELECT COUNT(*)
           FROM escribir e
           WHERE e.autor_id = a.autor_id);
           
--16. Obtener el nombre de esos autores

SELECT a.nombre
FROM autor a
WHERE NOT EXISTS
    (SELECT *
     FROM escribir e
     WHERE e.autor_id = a.autor_id);
     
--17. Obtener el nombre de los autores de nacionalidad �Espa�ola� que han escrito dos o m�s obras.

SELECT a.nombre
FROM autor a
WHERE a.nacionalidad = 'Espa�ola' AND 
    2 <= (SELECT COUNT(*)
         FROM escribir e
         WHERE e.autor_id = a.autor_id);
         
--18. Obtener el nombre de los autores de nacionalidad �Espa�ola� que han escrito alguna obra que est� en
--dos o m�s libros.

SELECT DISTINCT a.nombre
FROM autor a, escribir e
WHERE a.autor_id=e.autor_id AND a.nacionalidad = 'Espa�ola' AND 
    (SELECT COUNT(*)
     FROM esta_en es
     WHERE e.cod_ob=es.cod_ob) >=2;
     
--19. Obtener el t�tulo y el c�digo de las obras que tengan m�s de un autor.

--20. Obtener el nombre de los amigos que han le�do todas las obras del autor de identificador �RUKI�.

SELECT a.nombre
FROM amigo a
WHERE NOT EXISTS
    (SELECT *
    FROM escribir e
    WHERE e.autor_id = 'RUKI' AND 
    NOT EXISTS
        (SELECT *
        FROM leer l
        WHERE l.cod_ob = e.cod_ob AND l.num = a.num))
AND EXISTS
    (SELECT *
    FROM escribir e1
    WHERE e1.autor_id = 'RUKI');
                                        
--21. Resolver de nuevo la consulta anterior pero para el autor de identificador �GUAP�

SELECT a.nombre
FROM amigo a
WHERE NOT EXISTS
    (SELECT *
    FROM escribir e
    WHERE e.autor_id = 'GUAP' AND 
    NOT EXISTS
        (SELECT *
        FROM leer l
        WHERE l.cod_ob = e.cod_ob AND l.num = a.num))
AND EXISTS
    (SELECT *
    FROM escribir e1
    WHERE e1.autor_id = 'GUAP');

--24. Obtener el nombre de los amigos que s�lo han le�do obras del autor de identificador �CAMA�.

SELECT a.nombre
FROM amigo a
WHERE NOT EXISTS
    (SELECT *
    FROM leer l
    WHERE l.num = a.num AND
        NOT EXISTS (SELECT *
                    FROM escribir e
                    WHERE e.autor_id = 'CAMA' AND e.cod_ob=l.cod_ob))
AND EXISTS
    (SELECT *
    FROM leer l1
    WHERE l1.num = a.num);
    
--26. Obtener el nombre de los amigos tales que todas las obras que han le�do son del mismo autor.

SELECT a.nombre
FROM amigo a
WHERE EXISTS
    (SELECT *
    FROM autor au
    WHERE NOT EXISTS
    (SELECT *
    FROM leer l
    WHERE a.num=l.num AND
    NOT EXISTS(SELECT *
                FROM escribir e
                WHERE e.autor_id = au.autor_id AND e.cod_ob=l.cod_ob)))
AND EXISTS
    (SELECT *
    FROM leer l1
    WHERE l1.num = a.num);
    
--27. Resolver la consulta anterior indicando tambi�n el nombre del autor

SELECT a.nombre AMIGO, au1.nombre AUTOR
FROM amigo a, autor au1
WHERE EXISTS
    (SELECT *
    FROM autor au
    WHERE au1.autor_id=au.autor_id AND NOT EXISTS(SELECT *
                    FROM leer l
                    WHERE a.num=l.num AND
                    NOT EXISTS(SELECT *
                                FROM escribir e
                                WHERE e.autor_id = au.autor_id AND e.cod_ob=l.cod_ob)))
AND EXISTS
    (SELECT *
    FROM leer l1
    WHERE l1.num = a.num);
    
--28. Obtener el nombre de los amigos que han le�do todas las obras de alg�n autor y no han le�do nada de
--ning�n otro indicando tambi�n el nombre del autor.

SELECT a.nombre AMIGO, au.nombre AUTOR
FROM amigo a, autor au
WHERE NOT EXISTS
    (SELECT *
    FROM escribir e
    WHERE e.autor_id=au.autor_id ADN NOT EXISTS
        (SELECT *
        FROM leer l
        WHERE l.cod_ob=e.cod_ob AND l.num=a.num))
    AND EXISTS
        (SELECT * FROM escribir e WHERE e1.autor_id=au.autor_id)
AND NOT EXISTS
    (SELECT *
    FROM leer l2, escribir e2
    WHERE l2.cod_ob=e2.cod_ob AND l2.num=a.num
        AND e2.autor_id<>au.autor_id);
        
--30. Obtener el nombre de los amigos que han le�do m�s de 3 obras indicando tambi�n la cantidad de obras
--le�das.

SELECT a.nombre, count(*)
FROM amigo a, leer l
WHERE a.num=l.num
GROUP BY a.nombre
HAVING count(*) > 3;

--29. Resolver el ejercicio 13 usando la cl�usula GROUP BY.

SELECT l.titulo, l.id_lib
FROM libro l, esta_en e
WHERE l.id_lib = e.id_lib AND l.titulo IS NOT NULL
GROUP BY l.id_lib, l.titulo
HAVING COUNT(*) > 1;

--31. Obtener, de los temas con alguna obra, la tem�tica y la cantidad de obras con ese tema.

SELECT t.tematica, count(*)
FROM obra o, tema t
WHERE o.tematica = t.tematica
GROUP BY t.tematica
ORDER BY t.tematica;

--31. otras manera

SELECT t.tematica, count(*) NUM_OBRAS
FROM tema t JOIN obra o ON t.tematica=o.tematica
GROUP BY t.tematica
ORDER BY t.tematica;

SELECT tematica, count(*) NUM_OBRAS
FROM tema t NATURAL JOIN obra o
GROUP BY tematica
ORDER BY tematica;

SELECT tematica, count(*) NUM_OBRAS
FROM tema t JOIN obra o USING(tematica)
GROUP BY tematica
ORDER BY tematica;

--32. . Obtener, de todos los temas de la base de datos, la tem�tica y la cantidad de obras con ese tema.

SELECT t.tematica, count(*) NUM_OBRAS
FROM tema t LEFT JOIN obra o ON t.tematica=o.tematica
GROUP BY t.tematica
ORDER BY t.tematica;

--obtener para todos los amigos de la base de datos, el nombre y la cantidad de libros que han leido

SELECT am.nombre, count(l.cod_ob) NUM_OBRAS_LEIDAS
FROM amigo am LEFT JOIN leer l ON am.num=l.num
GROUP BY am.nombre
ORDER BY am.nombre;

--si no queremos que aparezcan los que no han leido nada

SELECT am.nombre, count(*) NUM_OBRAS_LEIDAS
FROM amigo am JOIN leer l ON am.num=l.num
GROUP BY am.nombre
ORDER BY am.nombre;

--33. Obtener el nombre del autor (o autores) que m�s obras han escrito

SELECT a.nombre
FROM autor a, escribir e
WHERE a.autor_id=e.autor_id
GROUP BY a.autor_id, a.nombre
HAVING count(*) =
    (SELECT MAX(count(*))
    FROM escribir e
    GROUP BY e.autor_id);
    
--34.