/*
7. Ingresar un número de departamento n. y mostrar el nombre del departamento y la cantidad de empleados que trabajan en él.
Si no tiene empleados sacar un mensaje “Sin empleados”
Si tiene entre 1 y 10 empleados desplegar “Normal”
Si tiene más de 10 empleados, desplegar “Muchos”.
*/
DECLARE
nombre department.name%TYPE;
cantEmp NUMBER := 0;
BEGIN
SELECT name, COUNT(employee_id)
INTO nombre, cantEmp
FROM employee JOIN department USING(department_id)
WHERE department_id = &departamento
GROUP BY name;
dbms_output.put_line('Department: ' || nombre);
IF CANTEMP = 0 THEN
dbms_output.put_line('Sin Empleados');
ELSIF CANTEMP BETWEEN 1 AND 10 THEN
dbms_output.put_line('Normal');
ELSE
dbms_output.put_line('Muchos');
END IF;
EXCEPTION WHEN no_data_found THEN
dbms_output.put_line('Non existant department');
END;