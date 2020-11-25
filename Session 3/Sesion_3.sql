# ****** Sesion 03: Subconsultas, Joins y Vistas ****** #
USE tienda;

SELECT * FROM puesto;

# ********** Subconsultas ********** #

# ********** WHERE ********** #
SELECT SUM(salario)
FROM puesto
WHERE id_puesto > (SELECT MAX(id_puesto) - 5 FROM puesto);

# ********** WHERE in ********** #
# Junior Executive
SELECT id_puesto
FROM puesto
WHERE nombre = 'Junior Executive';

SELECT * 
FROM empleado
WHERE id_puesto IN 
(SELECT id_puesto
FROM puesto
WHERE nombre = 'Junior Executive');

# ********** FROM ********** #
# Menor y mayor cantidad de ventas de un Articulo
SELECT * FROM venta;

SELECT clave, id_articulo, count(*) as cantidad
FROM venta
GROUP BY clave, id_articulo
ORDER BY cantidad DESC;

SELECT id_articulo, min(cantidad) AS cantidad_min, max(cantidad) AS cantidad_max
FROM 
(SELECT clave, id_articulo, count(*) as cantidad
FROM venta
GROUP BY clave, id_articulo
ORDER BY cantidad DESC) AS subconsulta
GROUP BY id_articulo;

# ********** Reto 1: Subconsultas ********** #
/* Desarrollo:
	Usando la base de datos tienda, escribe consultas que permitan responder las siguientes preguntas.
*/
# 1- ¿Cuál es el nombre de los empleados cuyo sueldo es menor a $10,000?
SELECT nombre FROM empleado;
SELECT id_puesto FROM puesto WHERE salario < 11000;

SELECT nombre, apellido_paterno, apellido_materno
FROM empleado
WHERE id_puesto 
IN 
	(SELECT id_puesto 
	FROM puesto 
    WHERE salario < 11000);

# 2- ¿Cuál es la cantidad mínima y máxima de ventas de cada empleado?
SELECT id_empleado, min(n_ventas) minimo, max(n_ventas) maximo 
FROM (SELECT id_empleado, clave, count(*) n_ventas FROM venta GROUP BY clave, id_empleado) AS sub 
GROUP BY id_empleado ORDER BY maximo DESC, minimo DESC;

# 3- ¿Cuáles claves de venta incluyen artículos cuyos precios son mayores a $5,000?
SELECT * FROM articulo WHERE precio > 5000;

SELECT * 
FROM venta
WHERE id_articulo 
IN 
	(SELECT id_articulo FROM articulo WHERE precio > 5000)
ORDER BY id_articulo;


# ********** JOINS ********** #
SHOW KEYS FROM empleado;
SELECT * FROM puesto;
SELECT * FROM empleado;

SELECT *
FROM empleado AS emp
JOIN puesto AS pue
ON emp.id_puesto = pue.id_puesto;

# ********** LEFT JOIN ********** #
SELECT *
FROM puesto AS pue LEFT JOIN empleado AS emp
ON pue.id_puesto = emp.id_puesto;

# ********** RIGHT JOING ********** #
SELECT *
FROM empleado AS emp RIGHT JOIN puesto AS pue
ON pue.id_puesto = emp.id_puesto;

# ********** USING ********** #

# ********** Reto 2: Joins ********** #
/* Desarrollo:
	Usando la base de datos tienda, escribe consultas que permitan responder las siguientes preguntas.
*/
# 1- ¿Cuál es el nombre de los empleados que realizaron cada venta?
SELECT * FROM empleado;

SELECT nombre, id_venta, clave
FROM empleado AS emp
JOIN venta AS ven
ON emp.id_empleado = ven.id_empleado;

# 2- ¿Cuál es el nombre de los artículos que se han vendido?
SELECT articulo.nombre, venta.id_venta, venta.clave
FROM venta
JOIN articulo
USING (id_articulo);
# USING solo funciona si el campo tiene el mismo nombre en ambas tablas.

# 3- ¿Cuál es el total de cada venta?
SELECT * FROM venta;
SELECT * FROM articulo;

SELECT clave, round(sum(precio), 2) AS total_venta
FROM venta AS ven
JOIN articulo AS art
ON ven.id_articulo = art.id_articulo 
GROUP BY clave
ORDER BY total_venta;

# ********** VISTAS (VIEW) ********** #
SELECT v.clave, v.fecha, a.nombre AS producto, a.precio, concat(e.nombre, ' ', e.apellido_paterno) AS empleado 
FROM venta AS v
JOIN empleado AS e
ON v.id_empleado = e.id_empleado
JOIN articulo AS a
ON v.id_articulo = a.id_articulo;

CREATE VIEW tickets_070 AS
(SELECT v.clave, v.fecha, a.nombre AS producto, a.precio, concat(e.nombre, ' ', e.apellido_paterno) AS empleado 
FROM venta AS v
JOIN empleado AS e
ON v.id_empleado = e.id_empleado
JOIN articulo AS a
ON v.id_articulo = a.id_articulo);

SELECT * FROM tickets_070;

SELECT clave, round(sum(precio), 2) AS total
FROM tickets_070
GROUP BY clave;

# ********** Reto 3: Definición de vistas ********** #
/* Desarrollo:
	Usando la base de datos tienda, escribe consultas que permitan responder las siguientes preguntas.
*/
# 1- Obtener el puesto de un empleado.
SELECT * FROM empleado;

CREATE VIEW puesto_empleado_070 AS 
(SELECT concat(empleado.nombre, ' ', empleado.apellido_paterno, ' ', empleado.apellido_materno) AS empleado, puesto.nombre AS puesto
FROM empleado
JOIN puesto
ON empleado.id_puesto = puesto.id_puesto);

SELECT * FROM puesto_empleado_070;

# 2- Saber qué artículos ha vendido cada empleado.
SELECT * FROM venta;
CREATE VIEW venta_articulos_empleado_070 AS
(SELECT concat(empleado.nombre, ' ', empleado.apellido_paterno, ' ', empleado.apellido_materno) AS empleado, articulo.nombre AS articulo
FROM empleado
JOIN venta
ON empleado.id_empleado = venta.id_empleado
JOIN articulo
ON articulo.id_articulo = venta.id_articulo);

SELECT * FROM venta_articulos_empleado_070;

# 3- Saber qué puesto ha tenido más ventas.
SELECT * FROM venta;

SHOW KEYS FROM venta;
SHOW KEYS FROM empleado;

CREATE VIEW puesto__mayores_ventas_070 AS
(SELECT p.nombre, count(*) ventas 
FROM venta v 
JOIN empleado e 
	ON v.id_empleado = e.id_empleado 
JOIN puesto p 
	ON e.id_puesto = p.id_puesto 
GROUP BY p.nombre
ORDER BY ventas DESC);
SELECT * FROM puesto__mayores_ventas_070 LIMIT 1;

select * from puesto__mayores_ventas_070;

# DROP VIEW