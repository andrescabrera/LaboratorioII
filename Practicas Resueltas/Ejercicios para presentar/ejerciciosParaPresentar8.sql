DECLARE
  CURSOR empleados
  IS
    SELECT
      last_name,
      salary
    FROM
      employee;
BEGIN
  FOR R_Emp IN empleados
  LOOP
    DBMS_Output.Put_line (R_emp.last_name || ' ' || R_emp.Salary);
  END
  LOOP;
END
;