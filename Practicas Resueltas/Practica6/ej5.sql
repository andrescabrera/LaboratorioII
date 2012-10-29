CREATE OR REPLACE TRIGGER calculoTotal
BEFORE INSERT OR DELETE OR UPDATE OF quantity, actual_price ON item
FOR EACH ROW
BEGIN
    IF DELETING THEN
      UPDATE sales_order set total = total - (:old.actual_price * :old.quantity) WHERE order_id = :old.order_id;
    ELSIF INSERTING THEN
      :new.total := :new.actual_price * :new.quantity;
      UPDATE sales_order set total = total + :new.total WHERE order_id = :new.order_id;
    ELSE
      :new.total := :new.actual_price * :new.quantity;
      UPDATE sales_order set total = total + :new.total - :old.total WHERE order_id = :new.order_id
    END IF;
END;