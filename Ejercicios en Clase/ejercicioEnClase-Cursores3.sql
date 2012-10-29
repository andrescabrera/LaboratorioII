DECLARE
  TYPE r1 IS RECORD 
  (ape employee.last_name%TYPE, sal employee.salary%TYPE);
  TYPE t1 IS TABLE OF r1
    INDEX BY binary_integer;
  t_emp t1;
BEGIN
  SELECT last_name, salary
  BULK COLLECT INTO t_emp
  FROM employee
  WHERE department_id = &id
  ORDER BY salary desc;
  FOR i IN 1..t_emp.count 
  --o last
  LOOP
    dbms_output.put_line(t_emp(i).ape || ' ' || t_emp(i).sal);
    EXIT WHEN i = 5;
  END LOOP;
  IF t_emp.count = 0 THEN
    dbms_output.put_line('El departamento no tiene empleados');
  END IF;
END;