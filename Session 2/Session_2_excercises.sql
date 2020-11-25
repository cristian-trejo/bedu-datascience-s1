# ****** Ejercicios Sesion 02 ****** #
/* Desarrolllo:
    Aplicar los conceptos adquiridos durante la sesión.
*/ 

# 1. Dentro de la tabla employees, obten el número de empleado, apellido y nombre de todos los empleados cuyo nombre empiece con a.
SELECT employeeNumber, lastName, firstName FROM employees WHERE firstName LIKE 'a%';

# 2. Dentro de la tabla employees, obten el número de empleado, apellido y nombre de todos los empleados cuyo nombre termina con on.
SELECT employeeNumber, lastName, firstName FROM employees WHERE firstName LIKE '%on';

# 3. Dentro de la tabla employees, obten el número de empleado, apellido y nombre de todos los empleados cuyo nombre incluye la cadena on.
SELECT employeeNumber, lastName, firstName FROM employees WHERE firstName LIKE '%on%';

# 4. Dentro de la tabla employees, obten el número de empleado, apellido y nombre de todos los empleados cuyos nombres tienen tres letras e inician con T y finalizan con m.
SELECT employeeNumber, lastName, firstName FROM employees WHERE firstName LIKE 'T_m';

# 5. Dentro de la tabla employees, obten el número de empleado, apellido y nombre de todos los empleados cuyo nombre no inicia con B.
SELECT employeeNumber, lastName, firstName FROM employees WHERE firstName NOT LIKE 'B%';   

# 6. Dentro de la tabla products, obten el código de producto y nombre de los productos cuyo código incluye la cadena _20.
DESCRIBE products;
SELECT productCode,productName FROM products WHERE productCode LIKE '%_20%';

# 7. Dentro de la tabla orderdetails, obten el total de cada orden.
DESCRIBE orderdetails;
SELECT orderNumber, sum(quantityOrdered * priceEach) AS totalPrice FROM orderdetails GROUP BY orderNumber;

# 8. Dentro de la tabla orders obten el número de órdenes por año.
DESCRIBE orders;
SELECT year(orderDate) AS year, count(*) Orders FROM orders GROUP BY year(orderDate);

# 9. Obten el apellido y nombre de los empleados cuya oficina está ubicada en USA.
DESCRIBE employees;
DESCRIBE offices;
SELECT lastName, firstName FROM employees WHERE officeCode IN (SELECT officeCode FROM offices WHERE country = 'USA') ORDER BY lastName, firstName;

# 10. Obten el número de cliente, número de cheque y cantidad del cliente que ha realizado el pago más alto.
DESCRIBE payments;
SELECT customerNumber, checkNumber, amount FROM payments WHERE amount = (SELECT max(amount) FROM payments);

# 11. Obten el número de cliente, número de cheque y cantidad de aquellos clientes cuyo pago es más alto que el promedio.
SELECT customerNumber, checkNumber, amount FROM payments WHERE amount > (SELECT (sum(amount)/count(*)) FROM payments) ORDER BY amount DESC;

# 12. Obten el nombre de aquellos clientes que no han hecho ninguna orden.
DESCRIBE customers;
DESCRIBE orders;
SELECT customerNumber,customerName FROM customers WHERE customerNumber NOT IN (SELECT customerNumber FROM orders);

# 13. Obten el máximo, mínimo y promedio del número de productos en las órdenes de venta.
DESCRIBE orderdetails;
SELECT max(quantity) AS maxProducts , min(quantity) AS minProducts, avg(quantity) AS average FROM (SELECT orderNumber, sum(quantityOrdered) quantity FROM orderdetails GROUP BY orderNumber) AS orders;
DESCRIBE orderdetails;

# 14. Dentro de la tabla orders, obten el número de órdenes que hay por cada estado.
DESCRIBE orders;
SELECT status, count(*) AS ordersState FROM orders GROUP BY status ORDER BY ordersState DESC;
