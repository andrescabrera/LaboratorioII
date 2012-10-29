/*
Practica 2 - Ejercicio 2
1. Crear un bloque anónimo para desplegar un mensaje indicando la fecha de día:: 
‘Hola , hoy es dd – Mon – yyyy’.
*/
DECLARE
V_date DATE := SYSDATE;
BEGIN
dbms_output.put_line('Hola, hoy es ' || V_date);
END;