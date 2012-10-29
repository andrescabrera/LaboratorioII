DECLARE
j number;
n pls_integer := 0; --indice para cargar la tabla
hasta number := &nn;
TYPE tipoTabla IS TABLE OF NUMBER INDEX BY pls_integer;
unaTabla tipoTabla;
BEGIN
FOR i IN 1..hasta LOOP
  j := 2;
  WHILE j<i LOOP
    EXIT WHEN MOD(i, j) = 0;
    j := j+1;
  END LOOP;
  IF j = i THEN
    unaTabla(n) := i;
    n := n+1;
  END IF;
END LOOP;
--muestro la tabla
FOR i IN unaTabla.first..unaTabla.count LOOP
  dbms_output.put_line(unaTabla(i) ||' es primo');
END LOOP;
END;