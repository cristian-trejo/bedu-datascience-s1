# ****** Sesion 02: Agrupaciones y subconsultas ****** #
USE tienda;
SHOW TABLES;

# ********** Busqueda de patrones con LIKE ********** #
SELECT * FROM empleado;
SELECT * FROM empleado WHERE nombre LIKE 'M%';
SELECT * FROM empleado WHERE nombre LIKE '%a';
SELECT * FROM empleado WHERE nombre LIKE 'M%a';
SELECT * FROM empleado WHERE nombre LIKE 'M_losa';

# ********** Reto 1: Búsqueda de patrones mediante LIKE ********** #
/* Desarrollo:
    Usando la base de datos tienda, escribe consultas que permitan responder las siguientes preguntas.
*/
# ¿Qué artículos incluyen la palabra Pasta en su nombre?
SELECT * FROM articulo WHERE nombre LIKE '%Pasta%';
# ¿Qué artículos incluyen la palabra Cannelloni en su nombre?
SELECT * FROM articulo WHERE nombre LIKE '%Cannelloni%';
# ¿Qué nombres están separados por un guión (-) por ejemplo Puree - Kiwi?
SELECT * FROM articulo WHERE nombre LIKE '%-%';
# ¿Qué puestos incluyen la palabra Designer?
SELECT * FROM puesto WHERE nombre LIKE '%Designer%';
# ¿Qué puestos incluyen la palabra Developer?
SELECT * FROM puesto WHERE nombre LIKE '%Developer%';

# ********** Funciones de agrupamiento ********** #
SELECT (1 + 7) * (10 / (6 - 4));
SELECT * FROM articulo;
# AS -> se utiliza para colocar un alias al resultado de la funcion
# ROUND() -> redondea el resultado de la funcion
SELECT ROUND(AVG(precio)) AS promedio_precio FROM articulo;
SELECT COUNT(*) AS conteo_articulos FROM articulo;
SELECT MAX(precio) AS precio_maximo FROM articulo;
SELECT MIN(precio) AS precio_minimo FROM articulo;
SELECT SUM(precio) AS suma_precios FROM articulo;

# ********** Reto 2: Funciones de agrupamiento ********** #
/* Descripcion:
    Usando la base de datos tienda, escribe consultas que permitan responder las siguientes preguntas.
*/
# ¿Cuál es el promedio de salario de los puestos?
DESCRIBE puesto;
SELECT ROUND(AVG(salario)) AS promedio_salario FROM puesto;
# ¿Cuántos artículos incluyen la palabra Pasta en su nombre?
SELECT COUNT(*) FROM articulo WHERE nombre LIKE '%Pasta%';
# ¿Cuál es el salario mínimo y máximo?
SELECT MIN(salario) AS 'Salario Minimo', MAX(salario) AS 'Salario Maximo' FROM puesto;
# ¿Cuál es la suma del salario de los últimos cinco puestos agregados?
# Se busca los ID del utimo puesto y se le resta 5 (995)
SELECT MAX(id_puesto) - 5 from puesto;
# Se suman los ultimos 5 salarios de los puestos por eso >, si fuera >= serian 6 registros (995, 996, 997, 998, 999 y 1000)
SELECT SUM(salario) AS 'Suma ultimos 5 salarios' FROM puesto WHERE id_puesto > (SELECT MAX(id_puesto) - 5 FROM puesto);

# ********** GROUP BY ********** #
SELECT * FROM articulo;
SELECT nombre, SUM(precio) FROM articulo GROUP BY nombre;
# Conteo de todas las filas que hay en cada grupo
SELECT nombre, count(*) AS numero_articulos_repetidos FROM articulo GROUP BY nombre ORDER BY numero_articulos_repetidos DESC;

SELECT * FROM puesto;
# GROUP BY agrupa valores repetidos.
SELECT nombre, MIN(salario) AS salario_minimo, MAX(salario) AS salario_maximo FROM puesto GROUP BY nombre;

# ********** Reto 3: Agrupamientos ********** #
/* Descripcion:
    Usando la base de datos tienda, escribe consultas que permitan responder las siguientes preguntas.
*/
# ¿Cuántos registros hay por cada uno de los puestos?
SELECT nombre, COUNT(*) AS numero_puestos FROM puesto GROUP BY nombre;
# ¿Cuánto dinero se paga en total por puesto?
SELECT nombre, SUM(salario) AS salario_por_puesto FROM puesto GROUP BY nombre;
# ¿Cuál es el número total de ventas por vendedor?
SELECT id_empleado, COUNT(*) AS numero_ventas FROM venta GROUP BY id_empleado  ORDER BY numero_ventas DESC;
# ¿Cuál es el número total de ventas por artículo?
SELECT id_articulo, COUNT(*) AS numero_ventas FROM venta GROUP BY id_articulo ORDER BY numero_ventas DESC;

