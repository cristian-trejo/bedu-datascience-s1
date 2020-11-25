# ****** Sesion 01: Fundamentos de SQL ****** #
SHOW DATABASES;
USE tienda;
SHOW TABLES;
DESCRIBE venta;
SELECT * FROM empleado;

# ****** Reto 1: Estructura de una tabla ****** #
# Desarrollo: Usando la base de datos tienda, muestra la descripción de las tablas articulo, puesto y venta. Por cada tipo de dato que encuentras llena la siguiente tabla, a mano. Usa la Documentación de MySQL como referencia.
#---Tipo---#	#---Descripcion---#
# varchar(n)		Cadenas de caracteres variables
# int				Numeros enteros
# double			Numeros decimales
# timestamp			Horas, minutos y segundos
DESCRIBE articulo;
DESCRIBE puesto;
DESCRIBE venta;

# ****** Reto 2: Estructura básica de una consulta ****** #
# Desarrollo: Usando la base de datos tienda, escribe consultas que permitan responder las siguientes preguntas.
# ¿Cuál es el nombre de los empleados con el puesto 4?
SELECT nombre FROM empleado WHERE id_puesto = 4;
# ¿Qué puestos tienen un salario mayor a $10,000?
SELECT * FROM puesto WHERE salario > 10000;
# ¿Qué articulos tienen un precio mayor a $1,000 y un iva mayor a 100?
SELECT * FROM articulo WHERE precio > 1000 AND iva > 100;
# ¿Qué ventas incluyen los artículo 135 o 963 y fueron hechas por los empleados 835 o 369?
SELECT * FROM venta WHERE id_articulo IN (135, 963) AND id_empleado IN (835, 369);

# ****** Reto 3: Ordenamientos y Límites ****** #
# Usando la base de datos tienda, escribe una consulta que permita obtener el top 5 de puestos por salarios.
use tienda;
SELECT nombre, salario FROM puesto ORDER BY salario DESC LIMIT 5;