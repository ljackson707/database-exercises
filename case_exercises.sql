#Basic Case Statment

SELECT CASE column_a #specific column 
        WHEN condition_a THEN value_1 #if true runs 
        WHEN condition_b THEN value_2 #if true runs
        ELSE value_3 #catch all 
        END AS new_column_name #create new column name
		FROM table_a; #table location
		
# Use case staments when checking for more than. two optional values
# or when you need more flexability in your conditional tests

#1) value cannot be null 
#2) can ontly test for equality
#3) can only come from a single column
		
#output looks like 
# not case sensitive

#+-------------------+--------------------+
#| dept_name         | dept_group         |
#+-------------------+--------------------+
#| Customer Service  | Customer Service   |
#| Development       | Development        |
#| Finance           | Finance            |
#| Human Resources   | Human Resources    |
#| Marketing         | Sales              |
#| Production        | Production         |
#| Quality Management| Quality Management |
#| Research          | Development        |
#| Sales             | Sales              |
#+-------------------+--------------------+

#ability to test to for (>,<,=,LIKE,IN)
SELECT CASE
        WHEN column_a > condition_1 THEN value_1
        WHEN column_b <= condition_2 THEN value_2
        ELSE value_3
        END AS new_column_name
FROM table_a;

#Example

SELECT dept_name,
        CASE 
            WHEN dept_name IN ('research', 'development') THEN 'R&D'
            WHEN dept_name IN ('sales', 'marketing') THEN 'Sales & Marketing' 
            WHEN dept_name in ('Production', 'Quality Management') THEN 'Prod & QM'
            ELSE dept_name
            END AS dept_group
FROM employees.departments;

use numbers;

#if n is 3 then add 100
#if n is 5 multiply by 100
#otherwise return n

select n 
from numbers
	case 
	when 3 then n + 100
	when 5 then n * 100
	else n
	end as output
from numbers;

#selecting if 
SELECT IF(column_a = condition_1, value_1 #true, value_2 #false) AS new_column
FROM table_a;

#examples
SELECT dept_name,
        IF(dept_name = 'Research', true, false) AS is_research
FROM employees.departments;


 
use easley_1272;

create temporary table example1 as (
SELECT dept_name,
        IF(dept_name = 'Research', true, false) AS is_research
FROM employees.departments
);

select *
from example;

#programaticly add uo the Truesm ince you make a true column using if

#If task is to find the cas eof something ie (True or False)

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#1) Write a query that returns all employees (emp_no), their department number, their start date, their end date, and a new column 'is_current_employee' that is a 1 if the employee is still with the company and 0 if not.
use employees; 

select emp_no, dept_emp.dept_no, employees.hire_date as start_date, salaries.to_date as end_date,
	If (salaries.to_date >= curdate(), True, False) as is_current_employee
from employees
join dept_emp using(emp_no)
join salaries using(emp_no);

#2)Write a query that returns all employee names (previous and current), and a new column 'alpha_group' that returns 'A-H', 'I-Q', or 'R-Z' depending on the first letter of their last name.

select concat(first_name," ",last_name) as employee_name,	
	case substr(last_name, 1, 1)
		when 'A' Then 'A-H'
		when 'B' Then 'A-H'
		when 'C' Then 'A-H'
		when 'D' Then 'A-H'
		when 'E' Then 'A-H'
		when 'F' Then 'A-H'
		when 'G' Then 'A-H'
		when 'H' Then 'A-H'
		when 'I' Then 'I-Q'
		when 'J' Then 'I-Q'
		when 'K' Then 'I-Q'
		when 'L' Then 'I-Q'
		when 'M' Then 'I-Q'
		when 'N' Then 'I-Q'
		when 'O' Then 'I-Q'
		when 'P' Then 'I-Q'
		when 'Q' Then 'I-Q'
		when 'R' Then 'R-Z'
		when 'S' Then 'R-Z'
		when 'T' Then 'R-Z'
		when 'U' Then 'R-Z'
		when 'V' Then 'R-Z'
		when 'W' Then 'R-Z'
		when 'X' Then 'R-Z'
		when 'Y' Then 'R-Z'
		when 'Z' Then 'R-Z'
	else '???'
	end as alpha_group
from employees
order by alpha_group;

#3) How many employees (current or previous) were born in each decade?

select birth_date,	
	case substr(birth_date, 2, 2)
		when '91' Then '1910'
		when '92' Then '1920'
		when '93' Then '1930'
		when '94' Then '1940'
		when '95' Then '1950'
		when '96' Then '1960'
		when '97' Then '1970'
		when '98' Then '1980'
		when '99' Then '1990'
	else "???"
	end as Decade
from employees;



#Bonus

#1) What is the current average salary for each of the following department groups: R&D, Sales & Marketing, Prod & QM, Finance & HR, Customer Service? 




