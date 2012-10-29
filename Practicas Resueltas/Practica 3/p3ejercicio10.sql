DECLARE
  CURSOR departamentos
  IS
    SELECT
      department_id,
      name,
      regional_group
    FROM
      department
    JOIN location USING (location_id)
    ORDER BY
      department_id;
  CURSOR empleados (idDepartamento department.department_id%TYPE)
  IS
    SELECT
      last_name
      || ', '
      || first_name AS nombre,
      hire_date
    FROM
      employee
    WHERE
      department_id = idDepartamento
    ORDER BY
      nombre;
BEGIN
  FOR regDep IN departamentos
  LOOP
    dbms_output.put_line(regDep.department_id || ' - ' || regDep.name || ' - '
    || regDep.regional_group);
    dbms_output.put_line('-------------------------------');
    FOR regEmp IN empleados (regDep.department_id)
    LOOP
      dbms_output.put_line('  ' || regEmp.nombre || '   ' || regEmp.hire_date);
    END
    LOOP;
  END
  LOOP;
END
;