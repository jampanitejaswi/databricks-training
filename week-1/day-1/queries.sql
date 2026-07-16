--query-1
--Select all columns from employee table
SELECT emp_id,name, age, salary, dept_id, hire_date
   from Employee;

--query-2
--Select only name and salary from employee table
SELECT emp_id, name, salary
   from Employee;

--  query-3
--Select employee who are older than 30
SELECT emp_id,name, age, salary, dept_id, hire_date
   from Employee
WHERE age>30;

--query-4
--Select the names of all departments
SELECT name
   from Department;

--query-5
--Select employee who work in IT department
SELECT emp_id,name, age, salary, dept_id, hire_date
    from Employee
WHERE dept_id = 1;

--query-6
--Select employee name starts with 'J'
SELECT name
   from Employee
WHERE name LIKE 'J%';

--      query-7
--Select employee name ends with 'e'
SELECT name
   from Employee
WHERE name LIKE '%e';

--query-8
--Select employee name contains 'a'
SELECT name 
   from Employee
WHERE name LIKE '%a%';

--query-9
--Select employee names are exactly 9 chars long
SELECT name 
   from Employee
WHERE LEN(name) = 9;

--query-10
--Select employee names have 'o' as 2nd char
SELECT name
   from Employee
WHERE name LIKE '_o%';

--query-11
--Select employee hired in 2020
SELECT name, hire_date
   from Employee 
WHERE YEAR(hire_date) >= 2020;

--query-12
--Select employee jan of any year
SELECT name, hire_date
   from Employee 
WHERE MONTH(hire_date) >= 1;

--query-13
--Select employee hired before 2019
SELECT name, hire_date
   from Employee 
WHERE YEAR(hire_date) <= 2019;

--query-14
--Select employee hired on or after march 1, 2021
SELECT name, hire_date
   from Employee 
WHERE hire_date >= '2021-03-01';

--  query-15
--Select employee hired in last 2 years
SELECT name, hire_date
   from Employee 
WHERE hire_date >= DATEADD(year, -2, GETDATE());

--  query-16
--Select total salary of all employee 
SELECT SUM(salary)
   from Employee; 

--query-17
--Select avg salary of all employee 
SELECT AVG(salary)
   from Employee; 

--query-18
--Select min salary of all employee 
SELECT MIN(salary)
   from Employee; 

--query-19
--Select no. of employee in each dept 
SELECT dept_id, COUNT(*) 
    from Employee
GROUP BY dept_id;

--query-20
--Select avg salary of employee in each dept 
SELECT dept_id, AVG(salary) 
    from Employee
GROUP BY dept_id;

--query-21
--Select total salary of employee in each dept 
SELECT dept_id, SUM(salary) 
    from Employee
GROUP BY dept_id;

--query-22
--Select avg age of employee in each dept 
SELECT dept_id, AVG(age)
    from Employee
GROUP BY dept_id;

--query-23
--Select no. of employee hired in each yr 
SELECT YEAR(hire_date), COUNT(*)
    from Employee
GROUP BY YEAR(hire_date);

--query-24
--Select highest salary in each dept 
SELECT dept_id, MAX(salary)
    from Employee
GROUP BY dept_id;
 
--query-25
--Select dept with highest avg salary
SELECT dept_id, AVG(salary) AS avg_sal 
FROM Employee 
GROUP BY dept_id 
ORDER BY avg_sal DESC 
LIMIT 1;
--or
SELECT dept_id, avg_salary
FROM (
    SELECT dept_id, 
           AVG(salary) AS avg_salary,
           RANK() OVER(ORDER BY AVG(Salary) DESC) AS rank_
    FROM Employee
    GROUP BY dept_id
) AS RankedDepartments
WHERE rank_ = 1;

--query-26
--Select dept with more than 2 employee
SELECT dept_id, COUNT(*) 
FROM Employee 
GROUP BY dept_id 
HAVING COUNT(*) > 2;

--query-27
--Select dept with avg salary > 55000
SELECT dept_id, AVG(salary) 
FROM Employee 
GROUP BY dept_id 
HAVING AVG(salary) > 55000;

--query-28
--Select yrs with more than 1 employee hired
SELECT YEAR(hire_date), COUNT(*) 
FROM Employee 
GROUP BY YEAR(hire_date) 
HAVING COUNT(*) > 1;

--query-29
--Select dept with total salary expences less than 100000
SELECT dept_id, SUM(salary) 
FROM Employee 
GROUP BY dept_id 
HAVING SUM(salary) < 100000;

--query-30
--Select dept with max salary above 75000
SELECT dept_id, MAX(salary) 
FROM Employee 
GROUP BY dept_id 
HAVING MAX(salary) > 75000;

--query-31
--Select all employess ordered by salary in ascending order
SELECT * FROM Employee ORDER BY salary ASC;

--query-32
--Select all employess ordered by age in descending order
SELECT * FROM Employee ORDER BY age DESC;

--query-33
--Select all employess ordered by hire date in ascending order
SELECT * FROM Employee ORDER BY hire_date ASC;

--query-34
--Select all employess ordered by dept and then by salary
SELECT * FROM Employee ORDER BY dept_id, salary;

--query-35
--Select dept ordered byt total salary of employee
SELECT d.dept_id, d.name, SUM(e.salary) AS total_sal
FROM Depaertment d
LEFT JOIN Employee e ON d.dept_id = e.dept_id
GROUP BY d.dept_id
ORDER BY total_sal;

--query-36
--Select employee names along with their dept names
SELECT e.name, d.name 
FROM Employee e 
JOIN Department d ON e.dept_id = d.dept_id;

--query-37
--Select project names along with their dept names
SELECT p.name, d.name 
FROM Project p 
JOIN Department d ON p.dept_id = d.dept_id;

--query-38
--Select employee names corresponding project names
-- Without bridge table, can't answer exactly. But if we assume employee works on dept's projects:
SELECT e.name, p.name
FROM Employee e
JOIN Project p ON e.dept_id = p.dept_id;

--query-39
--Select employee and their dept including without a dept
SELECT e.*, d.*
FROM Employee e
LEFT JOIN Department d ON e.dept_id = d.dept_id;

--query-40
--Select all depts and their employee including dept without employee
SELECT d.*, e.*
FROM Department d
LEFT JOIN Employee e ON d.dept_id = e.dept_id;

--query-41
--Select employee not assigned to any project
SELECT e.*
FROM Employee e
LEFT JOIN Project p ON e.dept_id = p.dept_id
WHERE p.project_id IS NULL;

--query-42
--Select employees and the number of projects their department is working on
SELECT e.emp_id, e.name, COUNT(p.project_id) AS project_count
FROM Employee e
LEFT JOIN Project p ON e.dept_id = p.dept_id
GROUP BY e.emp_id;

--query-43
--Select the departments that have no employees
SELECT d.*
FROM Department d
LEFT JOIN Employee e ON d.dept_id = e.dept_id
WHERE e.emp_id IS NULL;

--query-44
--Select employee names who share the same department with 'John Doe'
SELECT e2.*
FROM Employee e1
JOIN Employee e2 ON e1.dept_id = e2.dept_id
WHERE e1.name = 'John Doe' AND e2.name != 'John Doe';

--query-45
--Select the department name with the highest average salary
SELECT d.name, AVG(e.salary) AS avg_sal
FROM Employee e
JOIN Department d ON e.dept_id = d.dept_id
GROUP BY d.dept_id
ORDER BY avg_sal DESC
LIMIT 1;

--query-46
--Select the employee with the highest salary
SELECT * FROM Employee 
WHERE salary = (SELECT MAX(salary) FROM Employee);

--query-47
--Select employees whose salary is above the average salary.
SELECT * FROM Employee 
WHERE salary > (SELECT AVG(salary) FROM Employee);

--query-48
--Select the second highest salary from the Employee table
SELECT MAX(salary) 
FROM Employee 
WHERE salary < (SELECT MAX(salary) FROM Employee);

--      query-49
-- Select the department with the most employees
SELECT dept_id, COUNT(*) AS emp_count
FROM Employee
GROUP BY dept_id
ORDER BY emp_count DESC
LIMIT 1;

--query-50
--Select employees who earn more than the average salary of their department
SELECT e1.*
FROM Employee e1
WHERE e1.salary > (SELECT AVG(e2.salary) FROM Employee e2 WHERE e2.dept_id = e1.dept_id);

--query-51
--Select the nth highest salary
SELECT DISTINCT salary 
FROM Employee 
ORDER BY salary DESC 
LIMIT 1 OFFSET 2;

--query-52
--Select employees who are older than all employees in the HR department
SELECT * FROM Employee 
WHERE age > ALL (SELECT age FROM Employee e JOIN Department d ON e.dept_id = d.dept_id WHERE d.name = 'HR');

--query-53
--Select departments where the average salary is greater than 55000
SELECT dept_id, AVG(salary) 
FROM Employee 
GROUP BY dept_id 
HAVING AVG(salary) > 55000;

--query-54
--Select employees who work in a department with at least 2 projects
SELECT * 
FROM Employee 
WHERE dept_id IN (
    SELECT dept_id 
    FROM Projects 
    GROUP BY dept_id 
    HAVING COUNT(project_id) >= 2
);

--  query-55
--Select employees who were hired on the same date as 'Jane Smith'
SELECT * 
FROM Employee 
WHERE hire_date = (
    SELECT hire_date 
    FROM Employee 
    WHERE name = 'Jane Smith'
) AND name <> 'Jane Smith';

--query-56
--Total salary of employees hired in 2020
SELECT SUM(salary) 
FROM employees 
WHERE YEAR(hire_date) = 2020;

--  query-57
--Average salary by department
SELECT dept_id, AVG(salary) AS avg_salary 
FROM employees 
GROUP BY dept_id 
ORDER BY avg_salary DESC;

--query-58
--Departments with >1 employee and average salary >55000
SELECT dept_id 
FROM employees 
GROUP BY dept_id 
HAVING COUNT(*) > 1 AND AVG(salary) > 55000;

--query-59
--Employees hired in the last 2 years
SELECT * 
FROM employees 
WHERE hire_date >= DATE_SUB(CURDATE(), INTERVAL 2 YEAR) 
ORDER BY hire_date;

--query-60
--Employee count and average salary for departments with >2 employees
SELECT dept_id, COUNT(*), AVG(salary)
FROM Employee
GROUP BY dept_id
HAVING COUNT(*) > 2;

--query-61
--Employees with salary above dept average
SELECT e1.name, e1.salary
FROM Employee e1
WHERE e1.salary > (SELECT AVG(e2.salary) FROM Employee e2
WHERE e2.dept_id = e1.dept_id);

--query-62
--Employees hired on same date as oldest employee
SELECT e2.*
FROM Employee e1
JOIN Employee e2 ON e1.hire_date = e2.hire_date
WHERE e1.age = (SELECT MAX(age) FROM Employee);

--query-63
--Department names with total projects, ordered by project count
SELECT d.name, COUNT(p.project_id) AS project_count
FROM Department d
LEFT JOIN Project p ON d.dept_id = p.dept_id
GROUP BY d.dept_id
ORDER BY project_count;

--query-64
--Employee with the highest salary in each department
SELECT e1.*
FROM Employee e1
WHERE e1.salary = (SELECT MAX(e2.salary) 
FROM Employee e2 
WHERE e2.dept_id = e1.dept_id);

--query-65
--Employees older than average age of their department
SELECT e1.name, e1.age
FROM Employee e1
WHERE e1.age > (SELECT AVG(e2.age) 
FROM Employee e2 
WHERE e2.dept_id = e1.dept_id);