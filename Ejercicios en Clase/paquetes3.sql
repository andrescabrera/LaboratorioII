--Especificacion
CREATE OR REPLACE PACKAGE PK2
IS
  PROCEDURE lista_dep;
END;
--Package Body
CREATE OR REPLACE PACKAGE BODY pk2
IS
  FUNCTION f_sal (p1 NUMBER) RETURN NUMBER
  IS
    v_ss employee.salary%type;
  BEGIN
    SELECT SUM(salary)
    INTO v_ss
    FROM employee
    WHERE department_id = p1;
    RETURN v_ss;    
  END;
  
  PROCEDURE lista_dep
  IS
    CURSOR c_d IS
      SELECT *
      FROM department;
    BEGIN
      FOR r_d IN c_d
    LOOP
      dbms_output.put_line(r_d.department_id || ' ' || r_d.name || ' ' || f_sal(r_d.department_id));
    END LOOP;
  END;
END pk2;


--EXECUTE pk2.lista_dep
