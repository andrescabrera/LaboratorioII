DECLARE
CURSOR ordenes IS
  SELECT o.order_id AS oid, o.order_date AS od, i.quantity AS qty, p.description AS dsc, p.product_id AS pid
  FROM product p JOIN item i ON(i.product_id = p.product_id) JOIN sales_order o ON(i.order_id = o.order_id)
  ORDER BY order_id;
r_ordenes ordenes%rowtype;
BEGIN
OPEN ordenes;
LOOP
FETCH ordenes INTO r_ordenes;
dbms_output.put_line(r_ordenes.oid || ' ' || r_ordenes.od || ' ' || r_ordenes.pid || ' ' || r_ordenes.dsc || ' ' || r_ordenes.qty);
EXIT WHEN ordenes%notfound;
END LOOP;
CLOSE ordenes;
END;
/*
tabla sales orders
nro de orden
fecha de la orden

tablas item y en product
codproducto
nombre_producto
cantidad
*/