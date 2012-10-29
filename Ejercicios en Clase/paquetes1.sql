
--Ejecucion desde un bloque anonimo
BEGIN
  pk1.v_b := 'Hola';
  pk1.V_A := 'Monti';
  pk1.pr1('lab2');
END;

--Especificacion
create or replace
PACKAGE pk1
IS
	V_A varchar(100);
	PROCEDURE PR1 (Pa varchar2);
END;

--BODY
create or replace
PACKAGE BODY pk1
IS
V_B varchar2(100);
PROCEDURE PR1 (Pa varchar2)
IS
  BEGIN
    dbms_output.put_line('alumno' || V_A || ' cursa la materia ' || Pa);
  END;
END;


