DECLARE
      type recEmp is record (nombre employee.first_name%TYPE, funcion job.function%TYPE, salario employee.salary%TYPE);
      type t_tabla is table of recEmp index by binary_integer;
      t_emp t_tabla;
      j binary_integer := 0;
BEGIN
      select first_name || ', ' || last_name as nombre, function, salary
      bulk collect into t_emp
      from employee join job using (job_id)
      where department_id = &id
      order by salary asc;
      If T_Emp.count = 0 then
        RAISE_APPLICATION_ERROR (-20000, 'El depto no existe o no tiene empleados');
      End If;
      for i in 1..t_emp.count loop
        dbms_output.put_line(t_emp(i).nombre || ' ' ||t_emp(i).funcion || ' ' ||t_emp(i).salario);
      end loop;
      j:=t_emp.count;
      for i in 1..t_emp.count loop
        dbms_output.put_line(t_emp(j).nombre || ' ' ||t_emp(j).funcion || ' ' ||t_emp(j).salario);
        j := t_emp.count - i;
      end loop;
END;