DECLARE 
  v_d pls_integer := &DEPARTAMENTO;
  i pls_integer;
  CURSOR c_dep IS
    SELECT d.department_id, d.name, count(*) cnt
    FROM department d, employee e
    WHERE d.department_id = e.department_id
    GROUP BY d.department_id, d.name;
    TYPE t_type IS TABLE OF c_dep%rowtype
      INDEX BY binary_integer;
    t_dep t_type;
    BEGIN
    FOR reg in c_dep
    LOOP
      t_dep(reg.department_id).department_id := reg.department_id;
      t_dep(reg.department_id).name := reg.name;
      t_dep(reg.department_id).cnt := reg.cnt;
    END LOOP;
    dbms_output.put_line(t_dep(v_d).name || ' ' || t_dep(v_d).cnt);
    EXCEPTION WHEN no_data_found 
    THEN dbms_output.put_line('El departamento no existe o no tiene empleados');
  --muestro toda la tabla
  i := t_dep.first;
  FOR i IN 1..t_dep.count
  LOOP
    dbms_output.put_line(t_dep(i).name || ' ' || t_dep(i).cnt);
    i:= t_dep.next(i);
  END LOOP;
END;