DECLARE --producto: 100890
  productId product.product_id%type := &producto;
  cantidad number(10, 2);
  porcentaje number;
BEGIN
  SELECT COUNT(*)
  INTO cantidad
  FROM ITEM
  WHERE product_id = productId;
  IF cantidad = 0 THEN porcentaje := 0.50;
    ELSIF cantidad <= 2 THEN porcentaje := 0.90;
      ELSE porcentaje := 0.80;
  END IF;
  
  UPDATE price SET list_price = list_price*porcentaje, min_price = min_price*porcentaje
  WHERE product_id = productId AND END_DATE IS NULL;
  dbms_output.put_line('Se modificaron: ' || sql%rowcount);
  IF sql%notfound THEN
    dbms_output.put_line('Error: El producto '  || productId || ' no existe o no tiene pedidos'  );
  END IF;
  COMMIT;
END;