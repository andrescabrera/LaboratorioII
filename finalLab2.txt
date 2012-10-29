Final Laboratorio 2
Andrés Cabrera - Legajo 53231
andrescabrera20@gmail.com

--pruebas
begin
dbms_output.put_line(final.tablaLibros(72230789).nombreCategoria);
end;
exec final.actualizarPrecios('1,15', '1,18', 1);
exec final.listado(1);
exec final.listado(2);

--especificacion
create or replace package final is
  type recLibro is record (isbn libros.isbn%type, titulo libros.titulo%type, precio libros.precio%type, total_paginas libros.total_paginas%type, nombreCategoria categorias.nombre%type, estado inventario.estado%type, clientesCompras number);
  type tipoTablaLibros is table of recLibro index by binary_integer;
  tablaLibros tipoTablaLibros;
  procedure ventas(isbnVenta libros.isbn%type, cliente clientes.id_cliente%type);
  procedure listado(idCategoria categorias.id%type);
  procedure actualizarPrecios(porcentaje number, idCategoria categorias.id%type);
end;

--bodycreate or replace
PACKAGE BODY FINAL AS

  --cursor y variables privadas para cargar la tabla en memoria
  CURSOR cursorLibros IS
    SELECT * FROM libros;
  nombreCategoria categorias.nombre%type;
  estadoLibro inventario.estado%type;
  cantidadClientes number;

  --valido si existe el cliente, devuelvo TRUE si existe, de lo contrario devuelvo FALSE
  function existeCliente(cliente clientes.id_cliente%type) return boolean is
  varCliente clientes.id_cliente%type;
  begin
    SELECT id_cliente INTO varCliente FROM clientes WHERE id_cliente = cliente;
    return TRUE;
    EXCEPTION 
      WHEN no_data_found THEN
        return FALSE;
  end;

  procedure ventas(isbnVenta libros.isbn%type, cliente clientes.id_cliente%type) AS
  noExisteCliente exception;
  noExisteLibro exception;
  libroNoDisponible exception;
  BEGIN
    IF NOT existeCliente(cliente) THEN
      raise noExisteCliente;
    END IF;
    IF NOT tablaLibros.exists(isbnVenta) THEN
      raise noExisteLibro;
    END IF;
    IF tablaLibros(isbnVenta).estado <> 1 THEN
      raise libroNoDisponible;
    END IF;
    
    INSERT INTO venta_libros VALUES (cliente, isbnVenta, sysdate, 'E');
    UPDATE inventario SET cantidad = cantidad-1 WHERE isbn = isbnVenta AND estado = 1;
    tablaLibros(isbnVenta).clientesCompras := tablaLibros(isbnVenta).clientesCompras+1;
    
    dbms_output.put_line('Venta cargada exitosamente');
    
    EXCEPTION
      WHEN noExisteCliente THEN
        dbms_output.put_line('No existe el cliente');
      WHEN noExisteLibro THEN
        dbms_output.put_line('No existe el libro');
      WHEN libroNoDisponible THEN
        dbms_output.put_line('Libro no disponible');
  END ventas;

  procedure listado(idCategoria categorias.id%type) AS
  j number;
  BEGIN
    --Consigo el nombre de la categoria
    SELECT c.nombre 
    INTO nombreCategoria
    FROM categorias c
    WHERE c.id = idCategoria;
    dbms_output.put_line('ID: ' || idCategoria || ' Nombre Categoria: ' || nombreCategoria);
    j := tablaLibros.first;
    dbms_output.put_line('Isbn  Titulo  Precio  Cant.Pag  Estado  Cant. De Clientes');
        dbms_output.put_line('---------------------------------------------------------------');
    FOR i IN 1..tablaLibros.count LOOP
      IF tablaLibros(j).nombreCategoria = nombreCategoria THEN
        dbms_output.put_line(tablaLibros(j).isbn || ' ' || tablaLibros(j).titulo || ' ' || tablaLibros(j).precio || ' ' || tablaLibros(j).total_paginas || '  ' || tablaLibros(j).estado || ' ' || tablaLibros(j).clientesCompras);
      END IF;
      j := tablaLibros.next(j);
    END LOOP;
  END listado;

  procedure actualizarPrecios(porcentaje1 number, porcentaje2 number, idCategoria categorias.id%type) AS
  j number;
  BEGIN
    j := tablaLibros.first;
    UPDATE libros SET precio = precio*porcentaje1 WHERE id_categoria = idCategoria;
    dbms_output.put_line('Se actualizaron ' || sql%rowcount || ' precios de libros de: ' || idCategoria);
    UPDATE libros SET precio = precio*porcentaje2 WHERE id_categoria <> idCategoria;
    dbms_output.put_line('Se actualizaron ' || sql%rowcount || ' precios de libros.');    
    FOR i IN 1..tablaLibros.count LOOP
      SELECT nombre INTO nombreCategoria FROM categorias WHERE id = idCategoria;
      IF tablaLibros(j).nombreCategoria = nombreCategoria THEN
        tablaLibros(j).precio := tablaLibros(j).precio*porcentaje1;
      ELSE
        tablaLibros(j).precio := tablaLibros(j).precio*porcentaje2;
      END IF;
      j := tablaLibros.next(j);
    END LOOP;
  END actualizarPrecios;
  
BEGIN
  --Bloque OneTimeOnly
  FOR unLibro IN cursorLibros LOOP
    --Consigo el nombre de la categoria
    SELECT c.nombre 
    INTO nombreCategoria
    FROM categorias c JOIN libros l ON (l.id_categoria = c.id)
    WHERE l.isbn = unLibro.isbn;
    --Consigo el estado del libro
    SELECT estado
    INTO estadoLibro
    FROM inventario i
    WHERE i.isbn = unLibro.isbn;
    --Consigo la cantidad de clientes que compraron el libro
    SELECT COUNT(*)
    INTO cantidadClientes
    FROM venta_libros
    WHERE isbn = unLibro.isbn;
    --Cargo la tabla en memoria
    --Indexo la tabla por isbn, para acceder directamente a c/libro y comprobar su existencia con .exists(idLibro).    
    tablaLibros(unLibro.isbn).isbn := unLibro.isbn;
    tablaLibros(unLibro.isbn).titulo := unLibro.titulo;
    tablaLibros(unLibro.isbn).precio := unLibro.precio;
    tablaLibros(unLibro.isbn).total_paginas := unLibro.total_paginas;
    tablaLibros(unLibro.isbn).nombreCategoria := nombreCategoria;
    tablaLibros(unLibro.isbn).estado := estadoLibro;
    tablaLibros(unLibro.isbn).clientesCompras := cantidadClientes;
  END LOOP;
END FINAL;

  procedure actualizarPrecios(porcentaje number, idCategoria categorias.id%type) AS
  j number;
  BEGIN
    j := tablaLibros.first;
    UPDATE libros SET precio = precio*porcentaje WHERE id_categoria = idCategoria;
    dbms_output.put_line('Se actualizaron ' || sql%rowcount || ' precios de libros.');
    FOR i IN 1..tablaLibros.count LOOP
      SELECT nombre INTO nombreCategoria FROM categorias WHERE id = idCategoria;
      IF tablaLibros(j).nombreCategoria = nombreCategoria THEN
        tablaLibros(j).precio := tablaLibros(j).precio*porcentaje;
      END IF;
      j := tablaLibros.next(j);
    END LOOP;
  END actualizarPrecios;
  
BEGIN
  --Bloque OneTimeOnly
  FOR unLibro IN cursorLibros LOOP
    --Consigo el nombre de la categoria
    SELECT c.nombre 
    INTO nombreCategoria
    FROM categorias c JOIN libros l ON (l.id_categoria = c.id)
    WHERE l.isbn = unLibro.isbn;
    --Consigo el estado del libro
    SELECT estado
    INTO estadoLibro
    FROM inventario i
    WHERE i.isbn = unLibro.isbn;
    --Consigo la cantidad de clientes que compraron el libro
    SELECT COUNT(*)
    INTO cantidadClientes
    FROM venta_libros
    WHERE isbn = unLibro.isbn;
    --Cargo la tabla en memoria
    --Indexo la tabla por isbn, para acceder directamente a c/libro y comprobar su existencia con .exists(idLibro).    
    tablaLibros(unLibro.isbn).isbn := unLibro.isbn;
    tablaLibros(unLibro.isbn).titulo := unLibro.titulo;
    tablaLibros(unLibro.isbn).precio := unLibro.precio;
    tablaLibros(unLibro.isbn).total_paginas := unLibro.total_paginas;
    tablaLibros(unLibro.isbn).nombreCategoria := nombreCategoria;
    tablaLibros(unLibro.isbn).estado := estadoLibro;
    tablaLibros(unLibro.isbn).clientesCompras := cantidadClientes;
  END LOOP;
END FINAL;


--trigger - PUNTO 5
CREATE OR REPLACE
TRIGGER INSERTARINVENTARIO
AFTER INSERT ON LIBROS
FOR EACH ROW
BEGIN
  INSERT INTO inventario (isbn, estado, cantidad) VALUES (:new.isbn, 1, 10);
END;