--query-1
--Display employees with row number based on salary in descending order.
select employee_name,salary,
row_number() over(order by salary desc) as row_num
from employees;

--query-2
--Display employees with rank based on salary in descending order.
select employee_name,salary,
rank() over(order by salary desc) as rank_num
from employees;

--query-3
--Display employees with dense rank based on salary in descending order.
select employee_name,salary,
dense_rank() over(order by salary desc) as dense_rank_num
from employees;

--query-4
--Display top 3 highest-paid employees.
select employee_name,salary
from(
    select employee_name,salary,
    row_number() over(order by salary desc) as rn
    from employees
) a
where rn<=3;

--query-5
--Display employees ranked by salary within each department.
select employee_name,department,salary,
rank() over(partition by department order by salary desc) as dept_rank
from employees;

--query-6
--Display highest salary in each department for every employee.
select employee_name,department,salary,
max(salary) over(partition by department) as highest_salary
from employees;

--query-7
--Display running total of order amounts by order date.
select order_id,order_date,total_amount,
sum(total_amount) over(order by order_date) as running_total
from orders;

--query-8
--Display cumulative sales for each employee.
select employee_id,order_date,total_amount,
sum(total_amount) over(
partition by employee_id
order by order_date
) as cumulative_sales
from orders;

--query-9
--Display previous order amount for each customer.
select customer_id,order_date,total_amount,
lag(total_amount) over(
partition by customer_id
order by order_date
) as previous_order
from orders;

--query-10
--Display next order amount for each customer.
select customer_id,order_date,total_amount,
lead(total_amount) over(
partition by customer_id
order by order_date
) as next_order
from orders;

--query-11
--Display difference between current and previous order amount for each customer.
select customer_id,order_date,total_amount,
total_amount -
lag(total_amount) over(
partition by customer_id
order by order_date
) as difference
from orders;

--query-12
--Display 3-order moving average of order amounts.
select order_id,order_date,total_amount,
avg(total_amount) over(
order by order_date
rows between 2 preceding and current row
) as moving_avg
from orders;

--query-13
--Divide employees into four salary quartiles.
select employee_name,salary,
ntile(4) over(order by salary desc) as quartile
from employees;

--query-14
--Display the first order placed by each customer.
select *
from(
    select *,
    row_number() over(
    partition by customer_id
    order by order_date
    ) as rn
    from orders
) a
where rn=1;

--query-15
--Display the most recent order placed by each customer.
select *
from(
    select *,
    row_number() over(
    partition by customer_id
    order by order_date desc
    ) as rn
    from orders
) a
where rn=1;

--query-16
--Display average salary of each employee's department.
select employee_name,department,salary,
avg(salary) over(partition by department) as avg_salary
from employees;

--query-17
--Display employees earning more than the average salary of their department.
select *
from(
    select employee_name,department,salary,
    avg(salary) over(partition by department) as avg_salary
    from employees
) a
where salary>avg_salary;

--query-18
--Display total payroll of each employee's department.
select employee_name,department,salary,
sum(salary) over(partition by department) as department_payroll
from employees;

--query-19
--Display each employee's percentage share of the department payroll.
select employee_name,department,salary,
round(
salary*100.0/
sum(salary) over(partition by department),2
) as percentage_share
from employees;

--query-20
--Display total number of employees with each employee record.
select employee_name,department,
count(*) over() as total_employees
from employees;

--query-21
--Display total sales made by each employee.
with employee_sales as(
    select employee_id,
    sum(total_amount) as total_sales
    from orders
    group by employee_id
)
select *
from employee_sales;

--query-22
--Display employees whose total sales are above the average total sales.
with employee_sales as(
    select employee_id,
    sum(total_amount) as total_sales
    from orders
    group by employee_id
)
select *
from employee_sales
where total_sales>(
    select avg(total_sales)
    from employee_sales
);

--query-23
--Display customer spending ranked by total amount spent.
with customer_spending as(
    select customer_id,
    sum(total_amount) as total_spent
    from orders
    group by customer_id
)
select customer_id,total_spent,
rank() over(order by total_spent desc) as customer_rank
from customer_spending;

--query-24
--Generate numbers from 1 to 10 using a recursive CTE.
with recursive numbers as(
    select 1 as n
    union all
    select n+1
    from numbers
    where n<10
)
select *
from numbers;

--query-25
--Display employee hierarchy using a recursive CTE.
with recursive emp_tree as(
    select employee_id,
           employee_name,
           manager_id,
           1 as level
    from employees
    where manager_id is null
    union all
    select e.employee_id,
           e.employee_name,
           e.manager_id,
           t.level + 1
    from employees e
    join emp_tree t
    on e.manager_id = t.employee_id
)
select *
from emp_tree;

--query-26
--Display orders with amount greater than the average order amount.
with avg_orders as(
    select avg(total_amount) as avg_amount
    from orders
)
select *
from orders
where total_amount>(
    select avg_amount
    from avg_orders
);

--query-27
--Display customer totals ranked by total spending.
with customer_totals as(
    select customer_id,
    sum(total_amount) as total_spent
    from orders
    group by customer_id
)
select customer_id,total_spent,
rank() over(order by total_spent desc) as rank_num
from customer_totals;

--query-28
--Display employees with the second highest salary in each department.
select *
from(
    select employee_name,
           department,
           salary,
           dense_rank() over(
           partition by department
           order by salary desc
           ) as rn
    from employees
) a
where rn=2;

--query-29
--Display salary difference between each employee and the highest salary in the department.
select employee_name,
       department,
       salary,
       max(salary) over(partition by department)-salary
       as salary_difference
from employees;

--query-30
--Display top-performing employee in each department based on total sales.
with employee_sales as(
    select e.employee_id,
           e.employee_name,
           e.department,
           sum(o.total_amount) as total_sales
    from employees e
    join orders o
    on e.employee_id=o.employee_id
    group by e.employee_id,
             e.employee_name,
             e.department
),
ranked_employees as(
    select *,
    rank() over(
    partition by department
    order by total_sales desc
    ) as rn
    from employee_sales
)
select *
from ranked_employees
where rn=1;

--query-31
--Display monthly sales report with running total, previous month sales, and growth percentage.
with monthly_sales as(
    select to_char(order_date,'YYYY-MM') as month,
           sum(total_amount) as total_sales
    from orders
    group by to_char(order_date,'YYYY-MM')
),
sales_report as(
    select month,
           total_sales,
           sum(total_sales) over(
           order by month
           ) as running_total,
           lag(total_sales) over(
           order by month
           ) as previous_sales
    from monthly_sales
)
select month,
       total_sales,
       running_total,
       previous_sales,
       round(
       ((total_sales-previous_sales)
/previous_sales)*100,2
       ) as growth_percentage
from sales_report;