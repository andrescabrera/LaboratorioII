create or replace trigger deptId
before insert on department
for each row
when (new.department_id is null)
begin
  select max(department_id)+1
  into :new.department_id
  from department;
end;