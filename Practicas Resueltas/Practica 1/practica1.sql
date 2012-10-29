SELECT * FROM customer, department, employee, ITEM, JOB, LOCATION, PRICE, PRODUCT, SALARY_GRADE, SALES_ORDER, SALES;
SELECT FUNCTION FROM JOB;
SELECT last_name, first_name FROM employee ORDER BY last_name;
SELECT first_name, last_name last_name FROM employee WHERE salary BETWEEN 1500 AND 2850;
SELECT first_name, last_name, hire_date FROM employee WHERE hire_date BETWEEN '01/01/1987' AND '31/12/1987';
SELECT first_name, last_name, hire_date FROM employee WHERE hire_date LIKE '%1987';
SELECT department_id, name FROM department WHERE location_id = 122;
SELECT department_id, name FROM department WHERE location_id = &localidad;
SELECT first_name, NVL(TO_CHAR(commission), 'sin comision') FROM employee;
SELECT first_name, last_name, salary FROM employee WHERE manager_id IS NULL;
SELECT first_name, last_name, department_id, name FROM employee JOIN department USING (department_id);
SELECT first_name, last_name, function, name, salary  FROM employee JOIN job USING (JOB_ID) JOIN department USING (department_id) ORDER BY last_name;
SELECT first_name, name, regional_group FROM employee JOIN department USING(department_id) JOIN location USING(location_id) WHERE commission IS NOT NULL;
SELECT employee_id, first_name, salary, grade_id FROM employee, salary_grade WHERE salary BETWEEN lower_bound AND upper_bound;
SELECT e.employee_id AS idEmp, e.first_name AS nombreEmp, j.employee_id AS jefeId, j.first_name AS nombreJefe FROM employee e JOIN employee j ON j.employee_id = e.manager_id;
SELECT e.employee_id AS idEmp, e.first_name AS nombreEmp, j.employee_id AS jefeId, j.first_name AS nombreJefe FROM employee e LEFT JOIN employee j ON j.employee_id = e.manager_id;
SELECT order_id AS id, order_date AS fechaPedido, ship_date AS fechaEnvio, orden.total, cliente.name AS cliente, producto.description AS descProd
FROM customer cliente JOIN sales_order orden USING(customer_id)
                      JOIN ITEM item USING (order_id)
                      JOIN PRODUCT producto USING (product_id) ORDER BY order_id;
SELECT COUNT(*) FROM customer;
SELECT COUNT(*) FROM customer WHERE city = 'NEW YORK';
SELECT COUNT(*) AS jefe
FROM employee 
WHERE employee_id IN (SELECT DISTINCT j.employee_id 
                      FROM employee e JOIN employee j 
                      ON j.employee_id = e.manager_id);
SELECT * FROM employee WHERE hire_date = (SELECT MIN(hire_date) FROM employee);

SELECT first_name, last_name, salary, name 
FROM employee JOIN department USING(department_id) JOIN job USING(job_id) 
WHERE job_id = (SELECT job_id 
                FROM employee 
                WHERE first_name = 'JOHN' 
                AND last_name = 'SMITH');
                
SELECT first_name, last_name, salary, name 
FROM employee JOIN department USING(department_id) 
WHERE salary > (SELECT AVG(salary) FROM employee);

-- Seleccionar los nombres completos, el nombre del departamento y el salario de aquellos empleados que ganan más que el promedio de salarios de su departamento.
SELECT e.first_name, e.last_name, e.salary, d.name
FROM employee e JOIN department d ON e.department_id = d.department_id
WHERE salary > (SELECT AVG(salary) FROM employee sub WHERE e.department_id = sub.department_id);

SELECT e.first_name, e.last_name, e.salary, d.name
FROM employee e, department d 
WHERE e.department_id = d.department_id
AND salary > (SELECT AVG(salary) FROM employee sub WHERE e.department_id = sub.department_id);

SELECT * 
FROM SALES_ORDER 
WHERE total = (SELECT MAX(total) 
              FROM sales_order) 
OR total = (SELECT MIN(total) 
            FROM sales_order);
            
SELECT COUNT(*) FROM sales_order GROUP BY customer_id;
SELECT name, phone_number, COUNT(*) FROM sales_order JOIN customer USING(customer_id)GROUP BY name, phone_number;
SELECT j.employee_id, j.last_name 
FROM employee e JOIN employee j 
ON(e.manager_id = j.employee_id) 
GROUP BY j.employee_id, j.last_name 
HAVING COUNT(*) > 1;
-- o de otra manera
select e.manager_id, f.last_name
from employee e , employee f
where e.MANAGER_ID = f.employee_id
group by e.manager_id, f.last_name
having count (e.manager_id) >=2;

SELECT first_name, last_name 
FROM employee 
WHERE hire_date = (SELECT MIN(hire_date) FROM employee)
OR hire_date = (SELECT MAX(hire_date) FROM employee);

SELECT COUNT(*) FROM employee WHERE department_id = 20 OR department_id = 30;

SELECT ROUND(AVG(salary), 2) FROM employee WHERE department_id IN (SELECT department_id FROM department WHERE name = 'RESEARCH');

-- Por cada departamento desplegar su id, su nombre y el promedio de salarios (sin decimales) de sus empleados. El resultado ordenarlo por promedio.
SELECT department_id, name, TRUNC(AVG(salary), 0)  AS prom 
FROM department JOIN employee USING(department_id) 
GROUP BY department_id, name 
ORDER BY prom;
-- Modificar el ejercicio anterior para mostrar solamente los departamentos que tienen más de 3 empleados.
SELECT department_id, name, TRUNC(AVG(salary), 0)  AS prom 
FROM department JOIN employee USING(department_id) 
GROUP BY department_id, name 
HAVING COUNT(employee_id) > 3
ORDER BY prom;
-- Por cada producto (incluir todos los productos)  mostrar la cantidad de unidades que se han pedido y el precio máximo que se ha facturado. 
SELECT description,  SUM(QUANTITY) AS cantPedida, MAX(total) AS precioMaximo FROM item JOIN product USING(product_id) GROUP BY description;
--  Para cada cliente mostrar nombre, teléfono, la cantidad de órdenes emitidas y la fecha de su última orden. Ordenar el resultado por nombre de cliente.
SELECT name, phone_number, COUNT(order_id), MAX(order_date) AS ultimoPedido 
FROM customer JOIN sales_order USING(customer_id) 
GROUP BY name, phone_number 
ORDER BY name;
-- 35. Para todas las localidades mostrar sus datos, la cantidad de empleados que tiene y el total de salarios de sus empleados. Ordenar por cantidad de empleados.
SELECT location_id, regional_group, COUNT(employee_id) AS cantEmpleados, SUM(salary) 
FROM location JOIN department USING(location_id) JOIN employee USING(department_id) 
GROUP BY location_id, regional_group
ORDER BY cantEmpleados;
-- 36. Mostrar los empleados que ganan más que su jefe. 
-- El reporte debe mostrar el nombre completo del empleado, su salario, el nombre del departamento al que pertenece y la función que ejerce.
SELECT e.last_name||', '||e.first_name AS "Apellido, Nombre", e.salary, d.name, t.function FROM employee e JOIN employee j 
ON e.manager_id = j.employee_id 
JOIN job t ON t.job_id = e.job_id
JOIN department d ON d.department_id = e.department_id
WHERE e.salary > j.salary;
-- 37. Por cada producto mostrar el promedio de su historial de precios. Ordenar por producto y fecha.
SELECT product_id, AVG(list_price) AS prom, start_date FROM price GROUP BY product_id, start_date ORDER BY product_id;
SELECT * FROM PRICE;