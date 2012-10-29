--Ejecucion
pk2.pr1('9859'); --idEmpleado

--Especificacion
create or replace
PACKAGE pk2
IS
	V_A varchar(100);
	PROCEDURE PR1 (Pa number);
END;

--Body
create or replace
PACKAGE BODY pk2
IS
V_B varchar2(100);
PROCEDURE PR1 (Pa number)
IS
  BEGIN
    SELECT last_name into v_b
    FROM employee
    WHERE employee_id = Pa;
    dbms_output.put_line('alumno' || V_A || ' cursa la materia ' || Pa);
    dbms_output.put_line('v_b es: ' || V_B);
  END;
END;
