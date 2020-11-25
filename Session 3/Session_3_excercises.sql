# ****** Ejercicios Sesion 03 ****** #
/* Desarrolllo:
    Aplicar los conceptos adquiridos durante la sesión.
*/ 
USE classicmodels;

# Usar RIGHT JOIN
# 1. Obten el código de producto, nombre de producto y descripción de todos los productos.
SHOW KEYS FROM products;
SELECT * FROM products;

SELECT productCode, productName, productDescription FROM products;

# 2. Obten el número de orden, estado y costo total de cada orden.
SHOW KEYS FROM orders;
SHOW KEYS FROM orderdetails;
SELECT * FROM orders;
SELECT * FROM orderdetails;

SELECT orderDet.orderNumber, ord.status, sum(orderDet.quantityOrdered * orderDet.priceEach) AS total
FROM orderdetails orderDet 
	RIGHT JOIN orders ord ON ord.orderNumber = orderDet.orderNumber
GROUP BY ord.orderNumber 
ORDER BY total DESC;

# 3. Obten el número de orden, fecha de orden, línea de orden, nombre del producto, cantidad ordenada y precio de cada pieza que muestre los detalles de cada orden.
SHOW KEYS FROM products;
SELECT * FROM products;

SELECT ord.orderNumber, ord.orderDate, ordDet.orderLineNumber, ordDet.quantityOrdered, p.productName, ordDet.priceEach
FROM orders ord 
	RIGHT JOIN orderdetails ordDet ON ord.orderNumber = ordDet.orderNumber
	RIGHT JOIN products p ON p.productCode = ordDet.productCode
WHERE ord.comments IS NOT NULL;

# 4. Obtén el número de orden, nombre del producto, el precio sugerido de fábrica (msrp) y precio de cada pieza.
SHOW KEYS FROM products;

SELECT ord.orderNumber, p.productName, p.MSRP, ordDet.priceEach
FROM orders ord 
	RIGHT JOIN orderdetails ordDet ON ord.orderNumber=ordDet.orderNumber
	RIGHT JOIN products p ON ordDet.productCode=p.productCode; 

# Usar LEFT JOIN
# 5. Obtén el número de cliente, nombre de cliente, número de orden y estado de cada cliente.
SHOW KEYS FROM orders;

SELECT ord.orderNumber, cus.customerName, ord.orderNumber, cus.state
FROM orders ord 
LEFT JOIN customers cus ON ord.customerNumber = cus.customerNumber;

# 6. Obtén los clientes que no tienen una orden asociada.
SHOW KEYS FROM customers;

SELECT * 
FROM customers cus
LEFT JOIN orders ord ON ord.customerNumber = cus.customerNumber;

# 7. Obtén el apellido de empleado, nombre de empleado, nombre de cliente, número de cheque y total, es decir, los clientes asociados a cada empleado.
SHOW KEYS FROM customers;
SHOW KEYS FROM payments;

SELECT emp.lastName, emp.firstName, cus.customerName, pay.checkNumber, pay.amount
FROM customers cus 
	LEFT JOIN employees emp ON cus.salesRepEmployeeNumber = emp.employeeNumber
	LEFT JOIN payments pay ON pay.customerNumber = cus.customerNumber;

# Usar RIGHT JOIN
# 8. Repite los ejercicios 5 a 7 usando RIGHT JOIN.
# 5-RJ. Obtén el número de cliente, nombre de cliente, número de orden y estado de cada cliente.
SELECT ord.orderNumber, cus.customerName, ord.orderNumber, cus.state
FROM orders ord 
RIGHT JOIN customers cus ON ord.customerNumber = cus.customerNumber;
# 6-RJ. Obtén los clientes que no tienen una orden asociada.
SELECT * 
FROM customers cus
RIGHT JOIN orders ord ON ord.customerNumber = cus.customerNumber;
# 7-RJ. Obtén el apellido de empleado, nombre de empleado, nombre de cliente, número de cheque y total, es decir, los clientes asociados a cada empleado.
SELECT emp.lastName, emp.firstName, cus.customerName, pay.checkNumber, pay.amount
FROM customers cus 
	RIGHT JOIN employees emp ON cus.salesRepEmployeeNumber = emp.employeeNumber
	RIGHT JOIN payments pay ON pay.customerNumber = cus.customerNumber;

