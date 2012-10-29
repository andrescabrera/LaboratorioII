DECLARE
  cliente customer.customer_id%TYPE := &nroCliente;
  CURSOR ordenes IS
    SELECT order_id, order_date
    FROM sales_order
    WHERE customer_id = cliente;
  CURSOR items (nroOrden sales_order.order_id%TYPE) IS
    SELECT description
    FROM product JOIN item USING (product_id)
    WHERE order_id = nroOrden;
  o ordenes%ROWTYPE; --registro para el fetch
BEGIN
  OPEN ordenes;
  LOOP
    FETCH ordenes INTO o;
    EXIT WHEN ordenes%notfound;
    dbms_output.put_line('nroOrden: ' || o.order_id || ' fechaOrden: ' || o.order_date);
    FOR i IN items (o.order_id) LOOP
      dbms_output.put_line('  Descripcion: ' || i.description);  
    END LOOP;  
  END LOOP;
  IF ordenes%rowcount = 0 THEN
     dbms_output.put_line('El cliente '|| cliente || ' no tiene ordenes o no existe.');
  END IF;
  CLOSE ordenes;
END;