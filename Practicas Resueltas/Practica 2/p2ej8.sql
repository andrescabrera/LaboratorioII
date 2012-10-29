/*
8. Hacer un bloque que guarde en las posiciones pares de una tabla en memoria 
(tabla Pl/Sql) de números enteros el múltiplo de 2 de la posición. 
Ej: T(4) := 8. 
Ingresar la cantidad de elementos que debe tener la tabla.
Por último desplegar la cantidad de elementos que tiene la tabla y 
todo su contenido.
*/
DECLARE
TYPE tablitaT IS TABLE OF NUMBER INDEX BY binary_integer;
miTablita tablitaT;
tamTablita NUMBER := &tamanio;
BEGIN
FOR contador IN 1..tamTablita LOOP
miTablita(contador) := contador * 2;
dbms_output.put_line(miTablita(contador));
END LOOP;
END;