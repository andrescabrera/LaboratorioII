DECLARE
   v_id employee.employee_id%TYPE := &employee_id;
   v_salary employee.salary%TYPE;
   v_pct NUMBER;
BEGIN
   SELECT salary   
   INTO v_salary
   FROM Employee
   WHERE employee_id = v_id;

   IF v_salary < 1300
   THEN v_pct := 1.10;
   ELSIF v_salary BETWEEN 1300 AND 1500 
   THEN v_pct := 1.15;
   ELSE v_pct := 1.20;
   END IF;

   UPDATE Employee
      SET commission = commission * v_pct
      WHERE employee_id = v_id;

EXCEPTION
   WHEN no_data_found THEN
      dbms_output.put_line ('Error: el empleado: ' || v_id || ' no existe');
END;