DECLARE 
ex_non_existant EXCEPTION;
BEGIN
DELETE 
FROM job
WHERE job_id = '&job_id';
IF sql%notfound
THEN RAISE ex_non_existant;
END IF;
EXCEPTION 
WHEN ex_non_existant
THEN  dbms_output.put_line('Cargo no existente.');
WHEN OTHERS
THEN dbms_output.put_line('No se pudo eliminar. Hay empleados con este cargo.');
END;