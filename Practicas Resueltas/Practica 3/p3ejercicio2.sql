BEGIN
UPDATE employee
SET commission = comission*1.10
WHERE salary < 1300;
dbms_output.put_line('Actualizados en un 10% ' || sql%rowcount || ' empleados.');

UPDATE employee
SET commission = commission*1.15
WHERE salary BETWEEN 1300 AND 1500;
dbms_output.put_line('Actualizados en un 15% ' || sql%rowcount || ' empleados');

UPDATE employee
SET commission = commission*1.20
WHERE salary > 1500;
dbms_output.put_line('Actualizados en un 20% ' || sql%rowcount || ' empleados');
END;