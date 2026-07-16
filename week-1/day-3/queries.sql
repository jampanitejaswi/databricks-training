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