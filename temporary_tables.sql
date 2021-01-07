USE easley_1272;

#1) Using the example from the lesson, re-create the employees_with_departments table
CREATE TEMPORARY TABLE employees_with_departments AS (
		SELECT emp_no, first_name, last_name, dept_no, dept_name
		FROM employees.employees
		JOIN employees.dept_emp USING(emp_no)
		JOIN employees.departments USING(dept_no)
		LIMIT 100);
		
Select *
from employees_with_departments;

#A) Add a column named full_name to this table. It should be a VARCHAR whose length is the sum 		of the lengths of the first name and last name columns
    
Alter Table employees_with_departments add full_name Varchar(30);

Select *
from employees_with_departments;

#B) Update the table so that full name column contains the correct data

Update employees_with_departments 
set full_name = concat(first_name," ", last_name);

Select *
from employees_with_departments;

#C) Remove the first_name and last_name columns from the table.
Alter table employees_with_departments
Drop column first_name;

Alter table employees_with_departments
Drop column last_name;

Select *
from employees_with_departments;

#D) What is another way you could have ended up with this same table?
use easley_1272;

CREATE TEMPORARY TABLE employees_with_departments1 AS (
		SELECT emp_no, concat(first_name," ", last_name) as "Full Name", dept_no, dept_name
		FROM employees.employees
		JOIN employees.dept_emp USING(emp_no)
		JOIN employees.departments USING(dept_no)
		LIMIT 100);

Select *
from employees_with_departments1;

#IDK

Alter Table employees_with_departments1 add full_name Varchar(30);

Update employees_with_departments1 
set full_name = concat(first_name," ", last_name)

Alter table employees_with_departments1
Drop column first_name;

Alter table employees_with_departments1
Drop column last_name;


#2) Create a temporary table based on the payment table from the sakila database.

USE easley_1272;

CREATE TEMPORARY TABLE payment4 AS
    (SELECT * 
    FROM sakila.payment);

#Write the SQL necessary to transform the amount column such that it is stored as an integer 	representing the number of cents of the payment. For example, 1.99 should become 199.
    
SELECT *
FROM payment4;

ALTER TABLE payment4 ADD new_amount INT;

SELECT * 
FROM payment4;

UPDATE payment4 
SET new_amount = amount * 100;

SELECT *
FROM payment4;

ALTER TABLE payment4 
DROP COLUMN amount;

SELECT * 
FROM payment4;

ALTER TABLE payment4 
CHANGE COLUMN new_amount amount int;

SELECT *
from payment4;

#3) Find out how the current average pay in each department compares to the overall, historical 	average pay. In order to make the comparison easier, you should use the Z-score for salaries. 	In terms of salary, what is the best department right now to work for? The worst?

Use employees;

#These are the independent columns 

select round(avg(salary), 2) as "average hist.salary"
from employees_with_departments
join salaries using(emp_no)
group by dept_name;

select round(avg(salary), 2) as "average curr.salary"
from employees_with_departments
join salaries using(emp_no)
where salaries.to_date > curdate()
group by dept_name;

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#New Temp Table w/each column and z score
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~							
Use easley_1272;

#Table 1
CREATE TEMPORARY TABLE avg_hist11 AS (
		SELECT round(avg(salaries.salary), 2) as "avg_hist_salary", departments.dept_name
		FROM employees.salaries
		JOIN employees.dept_emp USING(emp_no)
		join employees.departments using(dept_no)
		group by dept_name);

Select *
from avg_hist11;

#Table 2		
CREATE TEMPORARY TABLE avg_curr1 AS (
		SELECT round(avg(salaries.salary), 2) as "avg_curr_salary", departments.dept_name
		FROM employees.salaries
		JOIN employees.dept_emp USING(emp_no)
		join employees.departments using(dept_no)
		where employees.salaries.to_date > curdate()
		group by dept_name);
		
Select *
from avg_curr1;	

#Table 3
CREATE TEMPORARY TABLE overall_hist_avg1 AS (
		SELECT round(avg(salaries.salary), 2) as "overall_hist_avg"
		FROM employees.salaries);

select * 
from overall_hist_avg1;

# We use Inner join to join each temp table (avg_curr and avg_hist)
select avg_hist11.*, avg_curr1.*
from avg_hist11
inner join avg_curr1 on avg_hist11.dept_name = avg_curr1.dept_name;

#Table 4 create a table called combined averages.
CREATE TEMPORARY TABLE comb_avg AS (
	select avg_hist11.*, avg_curr1.avg_curr_salary
	from avg_hist11
	right join avg_curr1 on avg_hist11.dept_name = avg_curr1.dept_name);
	
select * 
from comb_avg;

# Use alter table
Alter table comb_avg add z_score decimal(9, 2);

select * 
from comb_avg;

#create final table (cross join due to no similar column names)
CREATE TEMPORARY TABLE final AS (
	select overall_hist_avg1.*, comb_avg.*
	from comb_avg
	cross join overall_hist_avg1);
	
select *
from final;
#~~~~~~~~~~~~~
select round(STDDEV(avg_curr_salary), 2)
from final; #(found the STD of avg_curr_salary)

#8034.52
#~~~~~~~~~~~~~~~~~~~~~
Alter table final add x_mean decimal(9, 2);

select *
from final; #(added x_mean column)
#~~~~~~~~~~~~~~~~~~~~~~~~~
update final
set x_mean = (avg_curr_salary - overall_hist_avg);

select *
from final; #(found the diff of avg_curr and avg_overall_hist)
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~
update final
set z_score = x_mean/8034.52;

select *
from final;

#final output

select *
from final
order by z_score DESC;

 #answer 
 	#63810.74	80667.61	Sales	88842.16	3.12	25031.42



