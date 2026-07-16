--query-21
--Select total salary of employees in each department
select department_id,sum(salary) from Employee group by department_id;

--query-22
--Select average age of employees in each department
select department_id,avg(age) from Employee group by department_id;

--query-23
--Select number of employees hired in each year
select year(hire_date),count(*) from Employee group by year(hire_date);

--query-24
--Select highest salary in each department
select department_id,max(salary) AS highest_salary from Employee group by department_id;

--query-25
--Select department with highest average salary
select department_id,avg(salary) AS average_salary from Employee group by department_id order by avg(salary) DESC limit 1;

--query-26
--Select departments with more than 2 employees
select department_id,count(*) AS count_employee from Employee
group by department_id
having count(*)>2;

--query-27
--Select departments with average salary greater than 55000
select department_id,avg(salary) AS average_salary from Employee
group by department_id
having avg(salary)>55000;

--query-28
--Select years having more than one employee hired
select year(hire_date) AS hire_year,count(*) AS employee_count from Employee
group by YEAR(hire_date)
having count(*) > 1;

--query-29
--Select departments with total salary less than 100000
select department_id,sum(salary) as total_salary from Employee
group by department_id
having sum(salary) <100000;

--query-30
--Select departments with maximum salary greater than 75000
select department_id,max(salary) as maximum_salary from Employee
group by department_id
having max(salary) >75000;

--query-31
--Select all employees ordered by salary in ascending order
select * from Employee
order by salary ASC;

--query-32
--Select all employees ordered by age in descending order
select * from Employee
order by age DESC;

--query-33
--Select all employees ordered by hire date in ascending order
select * from Employee
order by hire_date ASC;

--query-34
--Select all employees ordered by department and salary
select * from Employee
order by department_id,salary;

--query-35
--Select departments ordered by total salary
select department_id,sum(salary) AS total_salary from Employee
group by department_id
order by total_salary;

--query-36
--Select employee names along with department names
select Employee.name,Department.name from Employee
join Department
on Employee.department_id = Department.department_id;

--query-37
--Select project names along with department names
select Project.name, Department.name from Project
join Department
on Project.department_id = Department.department_id;

--query-38
--Select employee names along with project names
select Employee.name,Project.name from Employee
join Project
on Employee.department_id = Project.department_id;

--query-39
--Select employees and their departments including employees without departments
select Employee.name,Department.name from Employee
left join Department
on Employee.department_id = Department.department_id;

--query-40
--Select all departments and their employees including departments without employees
select Department.name,Employee.name from Department
left join Employee
on Department.department_id = Employee.department_id;

--query-41
--Select employees not assigned to any project
select Employee.name from Employee
left join Project
on Employee.department_id = Project.department_id
where Project.project_id is NULL;

--query-42
--Select employees and the number of projects
select Employee.name,count(Project.project_id) as project_count from Employee
left join Project
on Employee.department_id = Project.department_id
group by Employee.name;

--query-43
--Select departments with no employees
select Department.name from Department
left join Employee
on Department.department_id = Employee.department_id
where Employee.emp_id is NULL;

--query-44
--Select employees working in the same department as John Doe
select name from Employee
where department_id = (
    select department_id from Employee
    where name = 'John Doe'
);

--query-45
--Select department with the highest average salary
select Department.name,avg(Employee.salary) AS average_salary from Employee
join Department
on Employee.department_id = Department.department_id
group by Department.name
order by avg(Employee.salary) DESC
limit 1;