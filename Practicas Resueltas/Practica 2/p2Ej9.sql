//Ejercicio 9
DECLARE
  empNom EMPLOYEE.first_name%TYPE;
  empApe EMPLOYEE.last_name%TYPE;
  empSal EMPLOYEE.salary%TYPE;
  astk varchar2(200);
BEGIN
  SELECT first_name, last_name, salary
  INTO empNom, empApe, empSal
  FROM Employee
  WHERE employee_id = &id;
  FOR i IN 1..round(empSal/100)
  LOOP
    astk:= astk || '*';
  END LOOP;
  dbms_output.put_line(empSal);
  dbms_output.put_line(astk);
EXCEPTION
  if no_data_found then
  dbms_output.put_line('El empleado no existe');
  if too_many_rows then
  dmbs_output.put_line('Demasiadas filas');
END;
