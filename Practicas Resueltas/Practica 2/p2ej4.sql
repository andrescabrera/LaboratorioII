/*
4. Crear un bloque Pl/Sql para consultar el salario de un empleado dado:
Ingresar el id del empleado desde el Sql*plus
Desplegar por pantalla el siguiente texto:
First_name, Last_name  tiene un salario de Salary pesos.
Si el empleado no existe desplegar un mensaje de error. (Usar Excepciones)
*/

DECLARE
TYPE recEmp IS RECORD(nom employee.first_name%TYPE, ape employee.last_name%TYPE, salario employee.salary%TYPE);
unEmp recEmp;
BEGIN
SELECT first_name, last_name, salary
INTO unemp.nom, unemp.ape, unemp.salario
FROM employee
WHERE employee_id = &ingrese_un_numero;
dbms_output.put_line(unEmp.nom || ' ' || unEmp.ape || ' ' || unEmp.salario || ' ');
EXCEPTION WHEN no_data_found THEN
dbms_output.put_line('No existe el ID');
END;
