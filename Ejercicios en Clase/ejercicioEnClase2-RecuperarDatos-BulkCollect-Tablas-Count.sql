/*
T_dep(1).department_id
T_dep(1).name
T_dep(1).XXXXXXXX
*/

//Recuperar datos
DECLARE
TYPE T_dep_type IS TABLE OF department%ROWTYPE
INDEX BY binary_integer;
T_dep T_dep_type;
BEGIN
SELECT *
BULK COLLECT
INTO T_dep
FROM department;
FOR i IN 1..T_dep.count
LOOP
dbms_output.put_line(T_dep(i).department_id || ' ' || T_dep(i).name || ' ' || T_dep(i).location_id);
END LOOP;
END;

