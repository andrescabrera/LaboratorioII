DECLARE
  CURSOR c_emp IS
    SELECT last_name, salary
    FROM employee
    WHERE department_id = &id
    ORDER BY salary desc;
BEGIN
  FOR reg_e IN c_emp
  LOOP 
    dbms_output.put_line(reg_e.last_name || ' ' || reg_e.salary);
  EXIT WHEN c_emp%rowcount = 5;
  END LOOP;
END;