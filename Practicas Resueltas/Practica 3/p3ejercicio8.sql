DECLARE
  idDepartamento department.department_id%TYPE := &departamento;
  CURSOR cursorEmpleados IS
    SELECT last_name, first_name, salary
    FROM employee JOIN department USING (department_id) JOIN job USING (job_id)
    WHERE department_id = idDepartamento AND function = 'CLERK'
    ORDER BY last_name;
  regEmp cursorEmpleados%ROWTYPE;
BEGIN
  OPEN cursorEmpleados;
  LOOP
    FETCH cursorEmpleados INTO regEmp;
    EXIT WHEN cursorEmpleados%notfound;
    IF regEmp.salary < 1000 THEN dbms_output.put_line(regEmp.last_name || ' ' || regEmp.first_name || ' candidato a un aumento.');
      ELSE dbms_output.put_line(regEmp.last_name || ' ' || regEmp.first_name || ' no es candidato a un aumento.');
    END IF;
  END LOOP;
  IF cursorEmpleados%rowcount = 0 THEN
   dbms_output.put_line('El departamento ' || idDepartamento || ' no tiene candidatos a aumento de salario. ');
  END IF;
  CLOSE cursorEmpleados;
END;