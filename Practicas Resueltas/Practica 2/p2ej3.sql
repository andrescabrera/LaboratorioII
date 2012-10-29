/*
1. Crear un bloque anónimo para desplegar los primeros n números múltiplos de 3. 
El valor de n debe ingresarse por pantalla usando una variable de sustitución del Sql*plus. 
Si n >10  desplegar un mensaje de advertencia y terminar el bloque. 
--Encuentro el siguiente multiplo de 3, cuando encuentro muestro y vuelvo al for
*/
DECLARE
Vn binary_integer := &n;
n binary_integer := 1;
BEGIN
IF Vn < 11 THEN
FOR i IN 1..Vn LOOP
  dbms_output.put_line(n*3);
  n := n+1;
END LOOP;
ELSE
dbms_output.put_line('Ingreso un numero mayor al permitido.');
END IF;
END;