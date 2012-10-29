--Ejemplos de definicion de datos en PLSQL
--INSERT
BEGIN
INSERT INTO department
VALUE(&id, '&nombre','&localidad');
EXCEPTION WHEN OTHERS THEN
END;
--UPDATE
DECLARE
v_p number(2):= &porcentaje;
v_d number(4):= &dep;
BEGIN
UPDATE employee
  SET salary = salary + (salary * v_p)/100
  WHERE department_id = v_d;
END;
--DELETE
BEGIN
  DELETE FROM employee
  WHERE employee_id = &id;
EXCEPTION 
WHEN OTHERS THEN
END;