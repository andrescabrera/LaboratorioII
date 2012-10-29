/*
1. Crear un paquete EMP_PACK que contenga subprogramas públicos y privados:
Una función privada Valida_Job (job_id)  para validar si un cargo existe o no.
Una función privada Valida_Jefe (id) para validar si el id corresponde a un jefe existente. (Verificar que existe en la columna manager_id de la tabla Employee).
Un procedimiento público: Alta_Emp  que recibe como parámetros el código de empleado, nombre y apellido, cargo (job_id), y código de su jefe (manager_id).
a. Este procedimiento debe usar las funciones Valida_Job y Valida_Jefe.
b. Las columnas Middle_initial  y Commission por ahora dejarlas en nulls
c. En la columna Hire_date poner la fecha del día si no viene la fecha de ingreso por parámetro (Usar la opción Default en el parámetro)
d. El departamento en el que inicialmente se incorpora un empleado es el mismo en el que está su jefe
e. El salario del empleado inicialmente debe ser igual al salario mínimo de ese cargo y departamento.
*/
CREATE OR REPLACE PACKAGE emp_pak
IS
  PROCEDURE alta_emp (idEmpleado employee.employee_id%type, nombre employee.first_name%type, apellido employee.last_name%type, jobId job.job_id%type, managerId employee.manager_id%type);
END;