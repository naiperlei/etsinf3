--cine

--1. Obtener ordenados ascendentemente los códigos de los países de donde son los actores.

SELECT DISTINCT cod_pais
FROM actor
ORDER BY cod_pais;

--2. Obtener el código y el título de las películas de año anterior a 1970 que no estén basadas en ningún libro
--ordenadas por título.

SELECT cod_peli, titulo
FROM pelicula
WHERE anyo < 1970 AND cod_lib IS NULL;

--3. Obtener el código y el nombre de los actores cuyo nombre incluye “John”. 

SELECT cod_act, nombre
FROM actor
WHERE nombre LIKE '%John%';

--4. Obtener el código y el título de las películas de más de 120 minutos de la década de los 80.

SELECT cod_peli, titulo
FROM pelicula
WHERE duracion > 120 AND anyo > 1980 AND anyo < 1990;

--5. Obtener el código y el título de las películas que estén basadas en algún libro y cuyo director se apellide
--‘Pakula’

SELECT cod_peli, titulo
FROM pelicula
WHERE cod_lib IS NOT NULL AND director LIKE '%Pakula';

--6. ¿Cuántas películas hay de más de 120 minutos de la década de los 80?

SELECT COUNT(*)
FROM pelicula
WHERE duracion > 120 AND anyo > 1980 AND anyo < 1990;

--7. ¿Cuántas películas se han clasificado de los géneros de código 'BB5' o 'GG4' o'JH6'?

SELECT COUNT(DISTINCT cod_peli)
FROM clasificacion
WHERE cod_gen='BB5' OR cod_gen='GG4' OR cod_gen='JH6';

--8. . ¿De qué año es el libro más antiguo?

SELECT MIN(anyo)
FROM libro_peli;

--9. ¿Cuál es la duración media de las películas del año 1987?

SELECT AVG(duracion)
FROM pelicula
WHERE anyo=1987;

--10. ¿Cuántos minutos ocupan todas las películas dirigidas por ‘Steven Spielberg’?

SELECT SUM(duracion)
FROM pelicula
WHERE director='Steven Spielberg';

--33. Obtener el código y el nombre de los actores tales que todos los papeles que han tenido son de
--‘Secundario’. Sólo interesan aquellos actores que hayan actuado en alguna película.

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

--1. ¿Cuántos discos hay?

SELECT COUNT(*)
FROM disco;

--valor medio del nº de socios de los clubs de fans

SELECT AVG(num)
FROM club;

--2. Selecciona el nombre de los grupos que no sean de Eszpaña.

SELECT nombre
FROM grupo
WHERE pais <> 'España'; -- pais != 'España' es otra opción

--3. Obtener el título de las canciones con más de 5 minutos de duración.

SELECT titulo
FROM cancion
WHERE duracion > 5;

--4. Obtener la lista de las distintas funciones que se pueden realizar en un grupo.

SELECT DISTINCT funcion
FROM pertenece;

--5. Obtener la lista de clubs de fans junto con su tamaño (número de personas). La lista debe estar ordenada
--de menor a mayor según el tamaño del club.

SELECT nombre, num
FROM club
ORDER BY num ASC;

--6. Selecciona el nombre y la sede de los clubes de fans con más de 500 socios.

SELECT nombre, sede
FROM club
WHERE num > 500;

--23. Obtener el número de canciones que ha grabado cada compañía(todas las compañias) discográfica y su dirección. 
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

--2. Obtener los identificadores de los libros publicados entre los años 1996 y 1999. Resolver esta consulta con el predicado BETWEEN

SELECT id_lib
FROM libro
WHERE año BETWEEN 1996 AND 1999;

--3. Resolver la consulta anterior con el predicado IN

SELECT id_lib
FROM libro
WHERE año IN (1996,1997,1998,1999);

--4. Obtener la cantidad de libros que no tienen titulo

SELECT COUNT(id_lib)
FROM libro
WHERE titulo IS NULL;

--5. Obtener el titulo de los libros que no tienen año de publicación

SELECT titulo
FROM libro
WHERE año IS NULL AND titulo IS NOT NULL;

--6. Obtener el año del libro sin titulo más antiguo

SELECT MIN(año)
FROM libro
WHERE titulo IS NULL;

--9. Obtener cuantos autores han escrito alguna obra con la palabra ciudad en su titulo

SELECT COUNT(DISTINCT e.autor_id)
FROM escribir e, obra o
WHERE e.cod_ob = o.cod_ob AND o.titulo LIKE '%ciudad%';

--10. Obtener el titulo de todas las obras escritas por el autor de nombre 'Camus, Albert'

SELECT o.titulo
FROM autor a, escribir e, obra o
WHERE a.autor_id = e.autor_id AND e.cod_ob = o.cod_ob AND a.nombre = 'Camús, Albert';

--11. ¿Quién es el autor de la obra de titulo 'La tata'?

SELECT a.nombre
FROM autor a, escribir e, obra o
WHERE a.autor_id = e.autor_id AND e.cod_ob = o.cod_ob AND o.titulo = 'La tata';

--12. Obtener el nombre de los amigos que han leído alguna obra del autor de identificador ‘RUKI’

SELECT DISTINCT a.nombre
FROM amigo a, leer l, obra o, escribir e
WHERE l.cod_ob = o.cod_ob AND a.num = l.num AND o.cod_ob = e.cod_ob AND e.autor_id = 'RUKI';

--13. Obtener el título y el identificador de los libros que tengan título y más de una obra. Resolver este
--ejercicio sin utilizar el atributo num_obras.

SELECT l.titulo, l.id_lib
FROM libro l, esta_en e1, esta_en e2, obra o
WHERE l.id_lib = e1.id_lib AND l.id_lib = e2.id_lib AND e1.cod_ob <> e2.cod_ob AND l.titulo IS NOT NULL;

--14. . Obtener el título de las obras escritas sólo por un autor si éste es de nacionalidad “Francesa” indicando
--también el nombre del autor.

SELECT o.titulo, a.nombre
FROM obra o, escribir e, autor a
WHERE o.cod_ob = e.cod_ob AND e.autor_id = a.autor_id AND a.nacionalidad = 'Francesa' AND
    (SELECT  COUNT(*)
    FROM escribir e1
    WHERE e1.cod_ob = o.cod_ob) = 1;
    
--15. ¿Cuántos autores hay en la base de datos de los que no se tiene ninguna obra?

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
     
--17. Obtener el nombre de los autores de nacionalidad “Española” que han escrito dos o más obras.

SELECT a.nombre
FROM autor a
WHERE a.nacionalidad = 'Española' AND 
    2 <= (SELECT COUNT(*)
         FROM escribir e
         WHERE e.autor_id = a.autor_id);
         
--18. Obtener el nombre de los autores de nacionalidad “Española” que han escrito alguna obra que está en
--dos o más libros.

SELECT DISTINCT a.nombre
FROM autor a, escribir e
WHERE a.autor_id=e.autor_id AND a.nacionalidad = 'Española' AND 
    (SELECT COUNT(*)
     FROM esta_en es
     WHERE e.cod_ob=es.cod_ob) >=2;
     
--19. Obtener el título y el código de las obras que tengan más de un autor.

--20. Obtener el nombre de los amigos que han leído todas las obras del autor de identificador ‘RUKI’.

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
                                        
--21. Resolver de nuevo la consulta anterior pero para el autor de identificador ‘GUAP’

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

--24. Obtener el nombre de los amigos que sólo han leído obras del autor de identificador ‘CAMA’.

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
    
--26. Obtener el nombre de los amigos tales que todas las obras que han leído son del mismo autor.

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
    
--27. Resolver la consulta anterior indicando también el nombre del autor

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
    
--28. Obtener el nombre de los amigos que han leído todas las obras de algún autor y no han leído nada de
--ningún otro indicando también el nombre del autor.

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
        
--30. Obtener el nombre de los amigos que han leído más de 3 obras indicando también la cantidad de obras
--leídas.

SELECT a.nombre, count(*)
FROM amigo a, leer l
WHERE a.num=l.num
GROUP BY a.nombre
HAVING count(*) > 3;

--29. Resolver el ejercicio 13 usando la cláusula GROUP BY.

SELECT l.titulo, l.id_lib
FROM libro l, esta_en e
WHERE l.id_lib = e.id_lib AND l.titulo IS NOT NULL
GROUP BY l.id_lib, l.titulo
HAVING COUNT(*) > 1;

--31. Obtener, de los temas con alguna obra, la temática y la cantidad de obras con ese tema.

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

--32. . Obtener, de todos los temas de la base de datos, la temática y la cantidad de obras con ese tema.

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

--33. Obtener el nombre del autor (o autores) que más obras han escrito

SELECT a.nombre
FROM autor a, escribir e
WHERE a.autor_id=e.autor_id
GROUP BY a.autor_id, a.nombre
HAVING count(*) =
    (SELECT MAX(count(*))
    FROM escribir e
    GROUP BY e.autor_id);
    
--34.