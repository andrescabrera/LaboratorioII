DECLARE
  CURSOR cursorOrden IS
    SELECT order_id, order_date
    FROM sales_order;
  CURSOR cursorProductos (idOrden sales_order.order_id%TYPE) IS
    SELECT product_id
    FROM item
    WHERE order_id = idOrden;
BEGIN
  FOR r IN cursorOrden
  LOOP
    dbms_output.put_line('idOrden: ' || r.order_id || ' orderDate: ' || r.order_date);
    FOR p IN cursorProductos (r.order_id)
    LOOP
      dbms_output.put_line('     idProducto: ' || p.product_id);
    END LOOP;
  END LOOP;
END;