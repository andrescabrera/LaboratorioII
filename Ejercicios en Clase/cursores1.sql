DECLARE
CURSOR precios IS
  SELECT description, start_date, list_price, min_price
  FROM product p, price pr
  WHERE p.product_id = pr.product_id AND p.product_id = &id
  ORDER BY start_date;
r_precios precios%rowtype;
BEGIN
OPEN precios;
LOOP
  FETCH precios INTO r_precios;
  dbms_output.put_line(r_precios.description || ' '  || r_precios.start_date || ' ' || r_precios.list_price || ' ' || r_precios.min_price);
  EXIT WHEN precios%notfound;
END LOOP;
CLOSE precios;
END;
/*
Propiedades o metodos del cursor
%rowcount
%isopen
%found
%notfound
*/