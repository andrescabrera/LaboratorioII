-- crear un bloque anonimo que permita modificar según el grado del
salario
DECLARE
 CURSOR c_emp IS
   SELECT salary, grade_id
   FROM employee, salary_grade
   WHERE salary BETWEEN lower_bound and upper_bound
   FOR UPDATE of salary;
   v_por pls_integer;
BEGIN
 FOR reg_e IN c_emp
 LOOP
 IF reg_e.grade_id = 1 then v_por := 25;
 ELSIF reg_e.grade_id = 2 then v_por := 20;
   ELSIF reg_e.grade_id = 3 THEN v_por := 15;
     ELSIF reg_e.grade_id = 4 THEN v_por := 10;
       ELSIF reg_e.grade_id = 5 THEN v_por := 5;
END IF;
 UPDATE employee
   SET salary = salary+(salary*v_por)/100
 WHERE CURRENT OF c_emp;
END LOOP;
END;