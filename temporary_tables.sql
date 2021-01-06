Use employees;

#Create a Temporary table (n is column name) (Unsigned Not Null are the modifiers)
CREATE TEMPORARY TABLE my_numbers(
    n INT UNSIGNED NOT NULL 
);

#Create a Permanent table
CREATE TABLE my_numbers(
    n INT UNSIGNED NOT NULL 
);

#Must use this database to make temp tabes
Use easley_1272;

#This is the quarey that we want to put itno the temp table
select 1, 2, 3, 4, 5 * 12;

#Quary and table mixed together
Use easley_1272;

CREATE TEMPORARY TABLE numbers as (
    select 1, 2, 3, 4, 5 * 12
);
select * from numbers;

#Modifying temp tables (Updating temp table)
DATE my_numbers SET n = n + 1;

#Examples
CREATE TEMPORARY TABLE my_numbers1(
	n INT UNSIGNED NOT NULL 
);

INSERT INTO my_numbers1(n) VALUES (1), (2), (3), (4), (5);

select * 
from my_numbers1;

update my_numbers1
set n = 503
where n = 5; # using the where clause to isolate specific 

select * 
from my_numbers1;

#(deleteing values from temp table)
DELETE FROM my_numbers1 WHERE n % 2 = 0; # where n = even numbers are deleted

select * 
from my_numbers1;

#When doing temp tables 
#Satrt by using your own database (so you ca write/edit/delete/whatever)

#Step 1
#start 
#use easley database
Use easley_1272;

#Step 2
#lets make a temp table of current employees w/ their salary
select *
from employees.employees # database_name.table_name
join employees.salaries using(emp_no) # database_name.table_name
where to_date > curdate();

#Step 3
#Wrap up quarey in temp table
create temporary table emp_salary as (
	select *
	from employees.employees # database_name.table_name
	join employees.salaries using(emp_no) # database_name.table_name
	where to_date > curdate()
);

#Step 4 
#show temp table to edit (will not touch source data)
select *
from emp_salary;
#AFTER WE HAVE A TEMP TABLE WHERE WE CAN QUERY FROM IT OR ALTER DATA WHEN NEEDED 

#Stakeholders say:
#What would our total slary be if everybody got a 5% rasie?
#example of when to use a temp table.
update emp_salary
set salary = salary + salary * .05;


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

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

Use easley_1272;

CREATE TEMPORARY TABLE ewd3 AS (
		SELECT emp_no, concat(first_name," ", last_name) as "Full Name", departments.dept_no, departments.dept_name, salaries.salary
		FROM employees.employees_with_departments 
		JOIN employees.salaries using(emp_no)
		JOIN employees.dept_emp USING(emp_no)
		JOIN employees.departments on employees.departments.dept_no = employees.employees_with_departments.dept_no);
				
Select *
from ewd3;				
		
Alter table ewd3 add average_hist_salary decimal(9, 2);
				
Alter table ewd3 add average_curr_salary decimal(9, 2); 

Alter table ewd3 add z_score int; 

Select *
from ewd3;		
				
update ewd3
set average_hist_salary	= (
				select round(avg(employees.salaries.salary), 2) 
				from employees.employees_with_departments
				join employees.salaries using(emp_no));
update ewd3
set average_curr_salary	= (	
				select round(avg(employees.salaries.salary), 2)
				from employees.employees
				join employees.salaries using(emp_no)
				join employees.employees_with_departments using(emp_no)
				join employees.departments using(dept_no)
				where employees.salaries.to_date > curdate()
				group by employees.departments.dept_name
				limit 1);
		
				
Select *
from ewd3;
	
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~				
				Use employees;
				
				select round(avg(salary), 2) as "average curr.salary", dept_name
				from employees_with_departments
				join salaries using(emp_no)
				where salaries.to_date > curdate()
				group by dept_name;
						
						
				select round(avg(employees.salaries.salary), 2) 
				from employees.employees_with_departments
				join employees.salaries using(emp_no);
		