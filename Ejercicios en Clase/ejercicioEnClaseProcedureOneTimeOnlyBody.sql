create or replace
PACKAGE BODY PRECIO_PRODUCTO AS
  CURSOR P_c IS
    SELECT p.product_id, p.description, pr.list_price
    FROM product p, price pr
    WHERE p.product_id = pr.product_id AND pr.end_date IS NULL;
  PROCEDURE consulta_p (id number, Pr OUT number) AS
  BEGIN
    /* TAREA Se necesita implementación */
    Pr := T_producto(id).precio_p;
    EXCEPTION
      WHEN no_data_found THEN
        dbms_output.put_line('El producto no existe');
  END consulta_p;

  PROCEDURE consulta_p(nombre VARCHAR2, Pr OUT number) AS
  j pls_integer;
    /* TAREA Se necesita implementación */
    BEGIN
      j := t_producto.first;
      FOR i IN 1..t_producto.count
      LOOP
        IF t_producto(j).nombre_p = upper(nombre) THEN
          pr := t_producto(j).precio_p;
          EXIT;
        END IF;
        j := t_producto.next(j);
      END LOOP;
      IF pr IS NULL THEN
        dbms_output.put_line('No existe el producto');
      END IF;
  END consulta_p;
-- Bloque One Time Only
BEGIN
  FOR r_p in P_c
  LOOP
    T_producto(r_p.product_id).nombre_p := r_p.description;
    T_producto(r_p.product_id).precio_p := r_p.list_price;
  END LOOP;
END PRECIO_PRODUCTO; --Es el END del package