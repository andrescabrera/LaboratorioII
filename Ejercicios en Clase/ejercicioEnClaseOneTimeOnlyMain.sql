DECLARE
precio number;
numeroDeProducto product.product_id%TYPE := 1001;
descripcion product.description%TYPE := 'ace teis net';
BEGIN
  --dbms_output.put_line(precio_producto.T_producto(100861).precio_p);
  precio_producto.consulta_p(numeroDeProducto, precio);
  dbms_output.put_line('El precio del producto: ' || numeroDeProducto || ' es: ' || precio);
  precio_producto.consulta_p(descripcion, precio);
  dbms_output.put_line('El precio del producto: ' || descripcion || ' es: ' || precio);
END;