/*
10. Crear un bloque que pida código de producto y guarde en una tabla en memoria 
(Tabla Pl/Sql indexada) el precio mínimo y precio de lista del producto.
Los precios deben guardarse en la posición de la tabla correspondiente 
al código de producto.
Ej: Producto 100 guardar en la posición T(100).
*/
DECLARE
TYPE precProd IS RECORD (pMinimo price.min_price%type, pLista PRICE.list_price%TYPE);
TYPE tTabla IS TABLE OF precProd INDEX BY binary_integer;
miTabla tTabla;
idProd PRODUCT.product_id%TYPE := &Id_Producto;
BEGIN
SELECT min_price, list_price
INTO miTabla(idProd).pMinimo, miTabla(idProd).pLista
FROM price
WHERE product_id = idProd AND start_date = (SELECT MAX(START_DATE)
                                            FROM price
                                            WHERE product_id = idProd);
dbms_output.put_line(miTabla(idProd).pMinimo || ' ' || miTabla(idProd).pLista);
EXCEPTION WHEN no_data_found THEN
dbms_output.put_line('Producto no existente');
END;