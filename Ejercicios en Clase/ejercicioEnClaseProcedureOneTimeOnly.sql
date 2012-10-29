CREATE OR REPLACE PACKAGE precio_producto IS
  TYPE r_type IS RECORD 
    (nombre_p product.description%TYPE, 
    precio_p price.list_price%TYPE);
  TYPE t_type IS TABLE OF r_type 
    INDEX BY binary_integer;
  t_producto t_type;
  PROCEDURE consulta_p (id number, Pr OUT number);
  PROCEDURE consulta_p(nombre VARCHAR2, Pr OUT number);
END;