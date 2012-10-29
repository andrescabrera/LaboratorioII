//PL/SQL
/*
Bloques PL/SQL:
Funciones
Procedimientos
Triggers
*/
--Paquetes--

DECLARE
	//def. identificadores {Variables, Constantes, Cursores, Excepciones}
/* 
Esto es un comentario 
de varias lineas
*/
// Esto es un comentario de una linea
BEGIN //Mandatorio, inicio del bloque
	//Comandos Ejecutables
	//P. Ej.:
	NULL;
END;
EXCEPTION //Manejo de excepciones


//EJ1 - Hola Mundo
BEGIN
	DBMS_OUTPUT.put_line('Hola alumnos');
END;

//Bloques Anidados
//Problema:
BEGIN
	A/B;
	---
	---
EXCEPTION
	-----
	-----
END;

//Solución:
BEGIN
	BEGIN
		A/B
	EXCEPTION
	----
	----	
	END;
---
---
END;
