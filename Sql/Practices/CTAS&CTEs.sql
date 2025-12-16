CTAS — full copy (data + columns) -->


CREATE TABLE employees_backup AS
SELECT * FROM employees;  --creates employees_backup and inserts every row from employees.


CTAS with filter (subset)-->

CREATE TABLE high_paid_employees AS
SELECT * FROM employees
WHERE salary > 100000;  --creates table with only employees having salary > 10000


CREATE TABLE emp_minimal AS
SELECT id, name, job_role AS role, salary FROM employees;  --creates a smaller table with chosen column and i made job_role renamed to role.

CTAS with aggregation -->

CREATE TABLE role_salary_summary AS
SELECT job_role,
       COUNT(*) AS emp_count,
       AVG(salary)::numeric(12,2) AS avg_salary,
       MIN(salary) AS min_salary,
       MAX(salary) AS max_salary
FROM employees
GROUP BY job_role;  --creates a summary table with each role they say who is with min max and avg salary and the count of emp's


CTAS with DISTINCT (de-duplication from data)-->

CREATE TABLE distinct_emails AS
SELECT DISTINCT email FROM employees; --using this we can see unique list of emails

CTAS with WITH NO DATA (structure only)-->

CREATE TABLE employees_structure_only AS
SELECT * FROM employees
WITH NO DATA;


Create a temporary table-->

CREATE TEMP TABLE temp_emps AS
SELECT id, name, salary FROM employees WHERE created_at > now() - interval '30 days';

CTEs (Common Table Expressions)-->

WITH recent AS (
  SELECT id, name, salary
  FROM employees
  WHERE created_at > now() - interval '30 days'
)
SELECT * FROM recent;

--------------------

WITH recent AS (
    SELECT 
        salary,
        salary * 1.5 AS increased_amount
    FROM employees
)
SELECT * FROM recent;



