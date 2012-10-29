-- PARCIALITO RESUELTO
-- Ejercicio 6 COMPLETAR
DECLARE
cusor c1 is
	select d.department_id, d.name, regional_group, count(*) cnt
	from department d, location l, employee e
	where e.department_id = d.dep.... and d.location_id = l.location_id
	group by *M
	
cursor c2 (p nombre) is
	select * from employee
	where department_id = p;
BEGIN
	for r1 in c1
	loop
		dbms_output.put_line(r1.name || ' ' || r1..... || ' ' ||r1.cut);
		for r2 in c2 (r1.department_id)
		loop
			dbms_output.put_line(.........);
		end loop;
	end loop;
END;
-- Ejercicio 7 COMPLETAR
DECLARE
	CURSOR C1 IS
		SELECT p.product.id, p.description, i.actual_price, count(i.order_id) CO, sum (i.total) ST
		FROM product p, item i
		WHERE p.product_id = i.product_id
		GROUP BY *;
	TYPE T_T IS TABLE OF C1%ROWTYPE INDEX BY binary_integer;
	T_P T_T;
BEGIN
	FOR R IN C1
	LOOP
		T_P(R.product_id).desctiption := R.description;
		T_P(R.product_id).actual_price := R.actual_price;
		T_P(R.product_id).CO := R.CO;
		T_P(R.product_id).ST := R.ST;
	END LOOP;
	J:= T_P.first;
	FOR I 1..T_P.count
	LOOP
		dbms_output.put_line(T_P(J).description || ' ' || T_P(J).actual_price || ' ' || T_P(J).CO || ' ' || T_P(J).ST);
		J := T_P.next(J);
	END LOOP;
END;
