create or replace
package emp_pack
is
procedure alta_emp (empId employee.employee_id%type, ape employee.last_name%type, nom employee.first_name%type, jobId employee.job_id%type, jefeId employee.manager_id%type);
end;

cuerpo:
create or replace
PACKAGE BODY EMP_PACK AS

  function valida_job (jId number) return number --para validar si job existe o no..!
  is 
  j number;
  begin
        select job_id
        into j
        from job
        where job_id = jId;
        return j;
  exception
        when no_data_found then
              dbms_output.put_line('No existe el jobId INGRESADO');
              return 0;
  end;
  
  function valida_jefe(id employee.employee_id%type) return number
  is
  idDep department.department_id%type;
  begin
        select distinct j.department_id
        into idDep
        from employee e, employee j
        where e.manager_id = j.employee_id and e.manager_id = id;
        return idDep;
  exception
        when no_data_found then
              dbms_output.put_line('No existe el id de empleado');
              return 0;
  end;
  
  
  procedure alta_emp(empId employee.employee_id%type, ape employee.last_name%type, nom employee.first_name%type, 
  jobId employee.job_id%type, jefeId employee.manager_id%type) AS
  fecha date := sysdate;
  minSal employee.salary%type;
  depId employee.department_id%type;
  j employee.job_id%type;
  BEGIN
        j := valida_job(jobId);
        
        depId := valida_jefe(jefeId);
        
        select min(salary)
        into minSal
        from employee
        where job_id = j and department_id = depId;
        
        insert into employee (employee_id, last_name, first_name, middle_initial, job_id, manager_id, hire_date, salary, commission, department_id) values (empId, ape, nom, NULL, j, jefeId, fecha, minSal, NULL, depId);  
        dbms_output.put_line('Se agrego correctamente a la base');
  END alta_emp;

END EMP_PACK;
