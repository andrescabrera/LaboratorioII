EXECUTE controlFecha;

create or replace
PROCEDURE controlFecha IS
  BEGIN
    IF to_char(sysdate,'hh24:mi') NOT BETWEEN '09:00' AND '18:00' THEN
      raise_application_error(-20001, 'Fuera del horario permitido');
    END IF;
  END;