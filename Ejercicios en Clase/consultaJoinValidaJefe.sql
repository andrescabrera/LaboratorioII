SELECT DISTINCT j.department_id
FROM employee e LEFT JOIN employee j ON (e.manager_id = j.employee_id)
WHERE e.manager_id = managerId;
