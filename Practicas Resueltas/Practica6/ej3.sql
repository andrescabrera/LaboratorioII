CREATE OR REPLACE TRIGGER ORDERSHIPPED 
BEFORE UPDATE OF ship_date ON SALES_ORDER 
FOR EACH ROW 
WHEN (old.ship_date IS NOT NULL) 
BEGIN
  IF :old.ship_date <> :new.ship_date THEN
    raise_application_error(-20002, 'La fecha de envío no se puede modificar');
  END IF;
END;             

update sales_order SET ship_date = sysdate WHERE order_id BETWEEN 600 AND 601;