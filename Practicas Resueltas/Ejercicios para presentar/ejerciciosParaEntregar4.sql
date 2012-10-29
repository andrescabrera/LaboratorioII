--INCOMPLETO !!!!!!!!!!!!!!!!!!!!!!!!!!!!
DECLARE
  excepcionSinEmpleados EXCEPTION;
  idEmpleado employee.employee_id%TYPE := &empleado;
  -- Cursor con los otros empleados del mismo departamento
  CURSOR cursorEmpleados IS
    SELECT employee_id
    FROM employee
    WHERE employee_id != idEmpleado
    AND department_id = 
    (
        SELECT department_id
        FROM employee
        WHERE employee_id = idEmpleado
    );
  TYPE empleado IS RECORD (employee_id employee.employee_id%TYPE);
  otroEmpleado empleado;
BEGIN
  OPEN cursorEmpleados;
  IF cursorEmpleados%rowcount = 0 THEN
      RAISE excepcionSinEmpleados;
  END IF;
  CLOSE cursorEmpleados;
    -- Tengo que ver si existen otros empleados en el departamento y sino hacer raise....  
  FOR otroEmpleado IN cursorEmpleados LOOP
  EXIT WHEN cursorEmpleados%NOTFOUND;
  dbms_output.put_line('otroEmpleado: ' || otroEmpleado.employee_id);
  -- Cambia los clientes que tengan como vendedor al empleado que quiero borrar
  END LOOP;
  EXCEPTION WHEN excepcionSinEmpleados 
  THEN dbms_output.put_line('No se pudo borrar el empleado. No hay otros empleados en el departamento.');
  
  UPDATE customer
  SET salesperson_id = otroEmpleado.employee_id
  WHERE salesperson_id = idEmpleado;
  
  DELETE FROM employee
  WHERE employee_id = idEmpleado;
END;