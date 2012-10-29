DECLARE
maxId job.job_id%type;
funcion job.function%type := '&functionJob';
BEGIN
  IF funcion = 'becario' OR funcion = 'estudiante' THEN
    SELECT MAX(job_id)
    INTO maxId
    FROM job;
    INSERT INTO job 
    VALUES (maxId+1, UPPER(funcion));
    COMMIT;  
  ELSE
    dbms_output.put_line('Tiene que ingresar becario o estudiante como funcion.');
  END IF;
END;