DECLARE
      cursor c_dep is select department_id, name, location_id
                      from department;
                      
      type t_table is table of c_dep%rowtype index by binary_integer;
      t_dep t_table;
      j binary_integer;
BEGIN
    for r_dep in c_dep loop
          t_dep(r_dep.department_id).department_id := r_dep.department_id;
          t_dep(r_dep.department_id).name := r_dep.name;
          t_dep(r_dep.department_id).location_id := r_dep.location_id;
    end loop;
    
    J:= t_dep.first;
    dbms_output.put_line('Hay ' || t_dep.first || ' departamentos.');
    FOR I in 1..t_dep.count
    LOOP
      dbms_output.put_line(t_dep(J).department_id || ' ' || t_dep(J).name || ' ' || t_dep(J).location_id);
    J:= t_dep.next(J);
END LOOP;
END;