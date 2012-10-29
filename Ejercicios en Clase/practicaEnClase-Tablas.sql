//Declarar una TABLA
Declare type t_type is table of pls_integer index by binary_integer;
T T_type;
V_n pls_integer:= &n;
J pls_integer;
BEGIN
  FOR I in 1..V_n;
  LOOP
    T(I*2):= (I*2);
  END LOOP;

//Mostrar una tabla
FOR I in 1..T.last
LOOP
  if t.exists(I) then
    dbms_output.put_line(T(I));
  end if;
END LOOP;

//Otra manera mejor para MOSTRAR una tabla
J:= T.first;
FOR I in 1..T.count
LOOP
  dbms_output.put_line(T(J));
  J:= T.next(J);
END LOOP;
END;
