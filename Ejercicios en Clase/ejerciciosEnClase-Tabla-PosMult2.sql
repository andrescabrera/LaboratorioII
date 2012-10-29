/*
HACER UN BLOQUE Q GUARDE LAS POSICIONES UNA TABLA DE NUMEROS ENTEROS MULTIPLOS DE 2, n potencias de 2.

T(1) := 1;
T(2) := 4;
T(3) := 8;
T(4) := 16;
T(n) := T(n-1)*2;
*/
DECLARE
TYPE T_Type IS TABLE OF pls_integer INDEX BY binary_integer;
T T_Type;
V_n pls_integer := &n;
BEGIN
T(1) := 2;
FOR I IN 2..V_n
LOOP
  T(I) := T(I-1)*2;
END LOOP;
FOR I in 1..T.last
LOOP
dbms_output.put_line(T(I));
END LOOP;
END;