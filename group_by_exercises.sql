use employees;
#Group By 
SELECT count(*)
FROM salaries; 

#Select distinct to keep out repeats
SELECT count(distinct salary)
FROM salaries;

# INtroducing Group By
#85814 unique salaries
# NOTICE: the count is the exact same as distinct salary
# NOTICE: in salary ascending/increasing order
SELECT salary
FROM salaries
GROUP BY salary DESC;

use employees;

#Using Select Distinct
SELECT DISTINCT concat(first_name, " ", last_name) as full_name
FROM employees;

#Compare with group by (can group by with alias)
SELECT concat(first_name," ", Last_name) as full_name
FROM employees
GROUP BY full_name DESC;

# Once we have a group by query ... we have the option of using aggregate functions(count, min, max, avg, etc0
SELECT concat(first_name," ", Last_name) as full_name, count(*)
FROM employees
GROUP BY full_name DESC
ORDER BY count(*) DESC;

# When we group by in sql or python we are changing the level of our observation.
# the employees table, each row is a single indiviudal person
# but when we group by full_name we loose that layer of deatil and re-defining the obervation to be concat(first_name," ", last_name.

# What is the new deffintion of an observation/row 
SELECT dept_no, count(*)
FROM dept_emp
GROUP BY dept_no;

#Build up from select distinct 
SELECT distinct dept_no
FROM dept_emp;

#Group By adding agg functions as new columns
SELECT dept_no, count(*)
FROM dept_emp
WHERE to_date > curdate()
GROUP BY dept_no;

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#Group By Exercises

#1)Create a new file named group_by_exercises.sql


#2)In your script, use DISTINCT to find the unique titles in the titles table. How many unique titles have there ever been? Answer that in a comment in your SQL file.
SELECT DISTINCT title
FROM titles; #7 Title

#3)Write a query to to find a list of all unique last names of all employees that start and end with 'E' using GROUP BY.
SELECT first_name as emp_with_e, count(*)
FROM employees 
WHERE first_name LIKE "e%e"
GROUP BY emp_with_e;

#Ebbe 190
#Eldridge 269
#Elrique 245

#4)Write a query to to find all unique combinations of first and last names of all employees whose last names start and end with 'E'.
SELECT concat(first_name," ", last_name) as emp_with_e, count(*)
FROM employees 
WHERE first_name LIKE "e%e"
GROUP BY emp_with_e;

#5)Write a query to find the unique last names with a 'q' but not 'qu'. Include those names in a comment in your sql code.
SELECT last_name as emp_with_q_not_qu
FROM employees 
WHERE last_name LIKE "%q%"
AND NOT last_name LIKE "%qu%"
GROUP BY emp_with_q_not_qu;

#6)Add a COUNT() to your results (the query above) and use ORDER BY to make it easier to find employees whose unusual name is shared with others.
SELECT concat(first_name," ", last_name) as full_name, count(*)
FROM employees
WHERE last_name LIKE "%q%"
AND NOT last_name LIKE "%qu%"
GROUP BY full_name DESC
ORDER BY count(*) DESC;

#7)Find all all employees with first names 'Irena', 'Vidya', or 'Maya'. Use COUNT(*) and GROUP BY to find the number of employees for each gender with those names.
SELECT concat(first_name," ", gender) as emp_gender, count(*)
FROM employees
WHERE first_name IN('Irena', 'Vidya', 'Maya')
GROUP BY emp_gender DESC;

#8)Using your query that generates a username for all of the employees, generate a count employees for each unique username. Are there any duplicate usernames? BONUS: How many duplicate usernames are there?

SELECT lower(concat(substr(first_name,1, 1),
		substr(last_name, 1,4),
		"_",
		substr(birth_date,6,2),
		substr(birth_date,3,2)))
		AS employee_username,
		count(*) as count
FROM employees
GROUP BY employee_username
HAVING  count(*) > 1
ORDER BY count(*) DESC;

#Bonus = #12251 Duplicate Usernames

#Alternate way of solving
SELECT lower(concat(substr(first_name,1, 1),
		substr(last_name, 1,4),
		"_",
		substr(birth_date,6,2),
		substr(birth_date,3,2)))
		AS employee_username,
		count(*) 
FROM employees
GROUP BY employee_username
HAVING  count(employee_username) > 1
ORDER BY count(*) DESC;
