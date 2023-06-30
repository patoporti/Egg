select * from producto;
select * from fabricante; 

-- Lista el nombre de todos los productos que hay en la tabla producto.
select nombre from producto;
-- Lista los nombres y los precios de todos los productos de la tabla producto.
select nombre, precio from producto;
-- Lista todas las columnas de la tabla producto.
select * from producto; 
/* Lista los nombres y los precios de todos los productos de la tabla producto, redondeando
el valor del precio.*/
select nombre, round(precio) as precio1 from producto;
-- Lista el código de los fabricantes que tienen productos en la tabla producto.
select codigo_fabricante from producto;
-- Lista el código de los fabricantes que tienen productos en la tabla producto, sin mostrar los repetidos.
select codigo_fabricante from producto group by codigo_fabricante;
-- Lista los nombres de los fabricantes ordenados de forma ascendente.
select nombre from producto order by nombre ASC;
/*Lista los nombres de los productos ordenados en primer lugar por el nombre de forma
ascendente y en segundo lugar por el precio de forma descendente.*/
select nombre, precio from producto order by nombre ASC;
select nombre, precio from producto order by precio DESC;
-- Devuelve una lista con las 5 primeras filas de la tabla fabricante. 
select * from fabricante limit 5;
/*Lista el nombre y el precio del producto más barato. (Utilice solamente las cláusulas
ORDER BY y LIMIT)*/
select nombre, precio from producto order by precio ASC limit 1;
-- Lista el nombre y el precio del producto más caro. (Utilice solamente las cláusulas ORDER BY y LIMIT)
select nombre, precio from producto order by precio DESC limit 1;
-- Lista el nombre de los productos que tienen un precio menor o igual a $120.
select nombre, precio from producto WHERE precio <= 120;
-- Lista todos los productos que tengan un precio entre $60 y $200. Utilizando el operador BETWEEN.
select precio from producto where precio between 60 and 200;
-- Lista todos los productos donde el código de fabricante sea 1, 3 o 5. Utilizando el operador IN.
select codigo_fabricante from producto where codigo_fabricante IN (1,3,5);
-- Devuelve una lista con el nombre de todos los productos que contienen la cadena Portátil en el nombre.
select nombre from producto where nombre like '%Portatil%';
/* Devuelve una lista con el código del producto, nombre del producto, código del fabricante 
y nombre del fabricante, de todos los productos de la base de datos.*/
select producto.codigo, producto.nombre, fabricante.codigo, fabricante.nombre 
from producto inner join fabricante on producto.codigo_fabricante = fabricante.codigo;
/*Devuelve una lista con el nombre del producto, precio y nombre de fabricante de todos
los productos de la base de datos. Ordene el resultado por el nombre del fabricante, por
orden alfabético.*/
select producto.nombre, producto.precio, fabricante.nombre
 from producto inner join fabricante on producto.codigo_fabricante = fabricante.codigo order by fabricante.nombre;
-- Devuelve el nombre del producto, su precio y el nombre de su fabricante, del producto más barato.
select producto.nombre, producto.precio, fabricante.nombre 
from producto inner join fabricante on producto.codigo_fabricante = fabricante.codigo order by producto.precio limit 1;
-- Devuelve una lista de todos los productos del fabricante Lenovo.
select producto.nombre, fabricante.nombre from producto INNER JOIN fabricante 
ON producto.codigo_fabricante=fabricante.codigo WHERE fabricante.nombre = "LENOVO";
-- Devuelve una lista de todos los productos del fabricante Crucial que tengan un precio mayor que $200.
select producto.nombre, producto.precio from producto inner join fabricante on producto.codigo_fabricante = fabricante.codigo where fabricante.nombre = 'Crucial' and precio > 200;
-- Devuelve un listado con todos los productos de los fabricantes Asus, Hewlett-Packard. Utilizando el operador IN.
select producto.nombre from producto inner join fabricante on producto.codigo_fabricante = fabricante.codigo where producto.nombre = 'Crucial' IN ('Asus', 'Hewlett-Packard');

/*Devuelve un listado con el nombre de producto, precio y nombre de fabricante, de todos
los productos que tengan un precio mayor o igual a $180. Ordene el resultado en primer
lugar por el precio (en orden descendente) y en segundo lugar por el nombre (en orden
ascendente)*/
select producto.nombre, producto.precio, fabricante.nombre
 from producto inner join fabricante on producto.codigo_fabricante = fabricante.codigo where producto.precio <=180 order by producto.precio DESC;
select producto.nombre, producto.precio, fabricante.nombre
 from producto inner join fabricante on producto.codigo_fabricante = fabricante.codigo where producto.precio <=180 order by producto.nombre ASC;
 
/*Devuelve un listado de todos los fabricantes que existen en la base de datos, junto con los
productos que tiene cada uno de ellos. El listado deberá mostrar también aquellos
fabricantes que no tienen productos asociados.*/
select fabricante.nombre, producto.nombre from fabricante left join producto on fabricante.codigo = producto.codigo_fabricante;

-- Devuelve un listado donde sólo aparezcan aquellos fabricantes que no tienen ningún producto asociado.
select nombre from fabricante
where NOT EXISTS
(select producto.nombre from producto where fabricante.codigo = producto.codigo_fabricante);

-- Devuelve todos los productos del fabricante Lenovo. (Sin utilizar INNER JOIN).
select * from producto
where producto.precio = (select producto.precio from producto where not exists
(select fabricante.codigo from fabricante
where fabricante.codigo = producto.codigo_fabricante 
and fabricante.nombre = "LENOVO") order by producto.precio DESC LIMIT 1);

-- 3. Lista el nombre del producto más caro del fabricante Lenovo.
SELECT * FROM producto WHERE EXISTS
(SELECT fabricante.codigo FROM fabricante 
WHERE fabricante.codigo = producto.codigo_fabricante AND fabricante.nombre = "LENOVO")
ORDER BY producto.precio DESC LIMIT 1; 

-- 4. Lista todos los productos del fabricante Asus que tienen un precio superior al precio
-- medio de todos sus productos.

SELECT * FROM producto,fabricante WHERE producto.codigo_fabricante = fabricante.codigo
AND fabricante.nombre = "ASUS"AND producto.precio > (SELECT AVG(producto.precio)FROM producto,fabricante
WHERE producto.codigo_fabricante = fabricante.codigo
AND fabricante.nombre = "ASUS");

-- Subconsultas con IN y NOT IN
-- 1. Devuelve los nombres de los fabricantes que tienen productos asociados. (Utilizando IN o
-- NOT IN).
SELECT fabricante.nombre FROM fabricante,producto
WHERE fabricante.codigo IN (producto.codigo_fabricante) GROUP BY fabricante.nombre;

-- 2. Devuelve los nombres de los fabricantes que no tienen productos asociados. (Utilizando
-- IN o NOT IN).
select nombre
from fabricante
where codigo 
not in (select codigo_fabricante from producto);


-- Subconsultas (En la cláusula HAVING)
-- 1. Devuelve un listado con todos los nombres de los fabricantes que tienen el mismo número
-- de productos que el fabricante Lenovo.

SELECT fabricante.nombre FROM fabricante,producto
WHERE fabricante.codigo = producto.codigo_fabricante
GROUP BY fabricante.nombre
HAVING COUNT(producto.nombre) =(SELECT COUNT(producto.nombre) FROM producto,fabricante
WHERE fabricante.codigo = producto.codigo_fabricante
AND fabricante.nombre = "LENOVO");


