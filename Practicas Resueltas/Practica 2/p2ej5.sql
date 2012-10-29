/*
5. Escribir un bloque para desplegar todos los datos de un cliente dado. 
Ingresar el id del cliente desde el Sql*plus
En una variable de tipo record recuperar toda la información y desplegarla usando Dbms_output.
Contemplar la posibilidad que el id ingresado no corresponde a un cliente.
*/

DECLARE
recEmp EMPLOYEE%ROWTYPE;
BEGIN
SELECT *
INTO recEmp
FROM employee
WHERE employee_id = &ingrese_un_numero;
dbms_output.put_line(recEmp.first_name || ' ' || recEmp.middle_initial || recEmp.last_name || ' Id: '|| recEmp.employee_id || ' Salary: ' || recEmp.salary);
dbms_output.put_line('JobId: '|| recEmp.job_id || ' ManagerId: '|| recEmp.manager_id || ' HireDate: ' || recEmp.hire_date || ' Comission: ' || recEmp.commission || ' DeptID: ' || recEmp.department_id);
EXCEPTION WHEN no_data_found THEN
dbms_output.put_line('No existe el ID');
END;