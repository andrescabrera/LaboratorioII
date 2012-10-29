DECLARE

  i pls_integer;
  i := t_dep.first;
BEGIN

  
  FOR i IN 1..t_dep.count
  LOOP
    dbms_output.put_line(t_dep(i).name || ' ' || t_dep(i).cnt);
    i:= t_dep.next(i);
  END LOOP;
END;