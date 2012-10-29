/*//SALARIO COMPLETO (MULT. X 12m)
//construir una tabla en memoria que tenga 3 campos:
//salario, nombre, numero de empleado*/
DECLARE
TYPE rec is record (numero number, nombre varchar(25), salario EMPLOYEE.salary%type);
TYPE T_emp_type IS TABLE OF rec
INDEX BY binary_integer;
T_emp T_emp_type;
BEGIN
SELECT employee_id, first_name, salary*12
BULK COLLECT INTO T_emp
FROM employee;
/*MUESTRO LA TABLA*/
FOR i in 1..T_emp.count
LOOP
dbms_output.put_line(T_emp(i).numero || ' ' || T_emp(i).nombre || ' ' || T_emp(i).salario);
END LOOP;
END;