/*
6. Escribir un bloque para mostrar la cantidad de órdenes que emitió un cliente dado siguiendo las siguientes consignas:
Ingresar el id del cliente desde el Sql*plus 
Si el cliente emitió menos de 3 órdenes desplegar:
	“El cliente nombre  ES REGULAR”.
Si emitió entre 4 y 6
	“El cliente  nombre ES BUENO”.
Si emitió más:
	“El cliente nombre ES MUY BUENO”.
*/
DECLARE
nombreCliente CUSTOMER.name%TYPE;
cantOrdenes NUMBER;
BEGIN
SELECT name, COUNT(order_id)
INTO nombreCliente, cantOrdenes
FROM customer JOIN sales_order USING (customer_id) 
WHERE customer_id = &cid
GROUP BY name;
IF cantOrdenes < 3 THEN
dbms_output.put_line('El cliente ' || nombreCliente || ' ES REGULAR');
ELSIF cantOrdenes BETWEEN 4 AND 6 THEN
dbms_output.put_line('El cliente ' || nombreCliente || ' ES BUENO');
ELSE
dbms_output.put_line('El cliente ' || nombreCliente || ' ES EXCELENTE');
END IF;
EXCEPTION WHEN no_data_found THEN
dbms_output.put_line('Cliente No existente');
END;