
select * from employees;
select * from departments;

-- 1) Find the total salary expense for each department in the employees table.
-- Table: employees
-- Columns: employee_id, name, department, salary
select department_id, SUM(salary) from employees group by department_id;

-- 2) List all employees along with their department name. 
-- Assume there’s another table departments with columns department_id and department_name.
select e.name, d.department_name from employees e left join departments d on e.department_id=d.department_id;

-- 3) Retrieve the name of the employee(s) with the highest salary from the employees table.
-- Retrieve the name of the employee with the second highest salary from the employees table.
select max(salary) from employees;
select name from employees where salary < (select max(salary) from employees) order by salary desc limit 1;

-- 4) Write a query that returns a list of employees with a new column, salary_category, 
-- which classifies salary into "High" for salaries greater than 60000, 
-- "Medium" for salaries between 50000 and 60000, and "Low" for salaries less than 50000.

select name, salary, 
case 
	when salary >= 60000 then 'High'
    when salary >= 50000 && salary < 60000 then 'Medium'
    else 'Low'
end as salary_category
from employees;

-- Window Functions
-- 5) List all employees and their salary along with the average salary in their department
select name, salary, department_id, avg(salary) over (partition by department_id) as avg_dept_salary from employees;

-- Self-Join
-- 6) Find employees who have the same manager. 
-- The employees table has a manager_id column, 
-- which is a foreign key referring to the employee_id of the same table.
select e1.employee_id, e1.name, e2.employee_id, e2.name 
from employees e1 join employees e2 
on e1.manager_id = e2.employee_id
where e1.employee_id != e2.employee_id;

-- String Functions
-- 7) Retrieve all employees whose name starts with "A" and ends with "n". 
select name from employees where name like 'A%' and name like '%n';

-- 8) Find employees who have a null value for the manager_id (meaning they do not have a manager).
select * from employees where manager_id is NULL;

-- Update Operation
-- 9) Increase the salary by 10% for all employees in the "HR" department.
update employees set salary=(salary+(salary/10));

-- Delete Operation
-- 10) Delete all employees who have been hired before 2010 from the employees table.
delete from employees where year(hired_date) < 2010;

-- Union and Intersect
-- 11) Retrieve a list of all distinct employees who have either attended a training program or a workshop. 
-- Assume there are two tables: training_programs and workshops with employee_id.
select employee_id from training_programs
union
select employee_id from workshop;

-- Complex Join with Multiple Tables
-- 12) Find all customers who placed orders for a specific product (product_id = 123) and their order date.
-- orders: order_id, customer_id, order_date
-- order_items: order_id, product_id, quantity
-- customers: customer_id, name
select c.name, o.order_date, p.product_id 
from order_items ot 
inner join orders o on ot.order_id=o.order_id
inner join customers c on o.customer_id=c.customer_id
where ot.product_id=123;

-- Indexes and Performance Optimization
-- 13) Create an index on the salary column of the employees table.
create index idx_salary
on employees (salary);

-- Complex Filtering and Date Functions
-- 14) Find all employees who joined after January 1, 2020, and have a salary greater than $75,000.
select * from employees where DATE(joined_date) > '2020-01-01' and salary > 75000;








