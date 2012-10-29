DECLARE
  CURSOR c_emp IS
    SELECT last_name, salary
    FROM employee
    WHERE department_id = &id
    ORDER BY salary desc;
  A pls_integer := 0;
BEGIN
  FOR reg_e IN c_emp
  LOOP 
    dbms_output.put_line(reg_e.last_name || ' ' || reg_e.salary);
    A := c_emp%rowcount;
  EXIT WHEN c_emp%rowcount = 5;
  END LOOP;
  IF A = 0 THEN
    dbms_output.put_line('El departamento no tiene empleados');
  END IF;
END;