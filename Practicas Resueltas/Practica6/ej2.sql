CREATE OR REPLACE TRIGGER modificarItems 
BEFORE INSERT OR DELETE OR UPDATE ON item
BEGIN
  controlFecha;
END;

CREATE OR REPLACE TRIGGER modificarOrdenes 
BEFORE INSERT OR UPDATE OR DELETE ON sales_order 
BEGIN
  controlFecha;
END;

delete sales_order where order_id = 123123;
delete item where order_id = 123123;