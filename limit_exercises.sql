use employees;
# Show salaries beteen the range
# Order by salary
# Show the first 100
SELECT *
FROM salaries 
WHERE salary between 67000 and 71000
ORDER BY salary ASC
LIMIT 100;

# Tqke the above query and show the last 100...
# Reverse our order by 
# Add the limit 
SELECT *
FROM salaries 
WHERE salary between 67000 and 71000
ORDER BY salary DESC
LIMIT 100;

#Let take a look at the first 10 employees (Ordered by emp_no)
#If we show 10 employees per page.. This is the first page of results
SELECT *
FROM employees 
LIMIT 10 OFFSET 0; #offset 0 is the default 

#. Lets get the same results, but the secounds page 
# Where the results are the next ten rows
#This shows emp_no 10011 through 10020
SELECT *
FROM employees
LIMIT 10 OFFSET 10; #Offset of 10, limit 10 shows age 2 of the results.

#Page 3 of the results of what we did above
SELECT *
FROM employees 
LIMIT 10 OFFSET 20; #Offset of 20 gives us page 3

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#Exercises

#1)Create a new SQL script named limit_exercises.sql.

#2)MySQL provides a way to return only unique results from our queries with the keyword DISTINCT. For example, to find all the unique titles within the company, we could run the following query:

#List the first 10 distinct last name sorted in descending order.
SELECT DISTINCT title
FROM titles
LIMIT 10;

#3)Find all previous or current employees hired in the 90s and born on Christmas. Find the first 5 employees hired in the 90's by sorting by hire date and limiting your results to the first 5 records. Write a comment in your code that lists the five names of the employees returned.
SELECT *
FROM employees
WHERE hire_date LIKE "199%"
AND birth_date LIKE "%12-25"
ORDER BY hire_date ASC
LIMIT 5;

#4)Try to think of your results as batches, sets, or pages. The first five results are your first page. The five after that would be your second page, etc. Update the query to find the tenth page of results.
SELECT *
FROM employees
WHERE hire_date LIKE "199%"
AND birth_date LIKE "%12-25"
ORDER BY hire_date ASC
LIMIT 5 OFFSET 45;

#LIMIT and OFFSET can be used to create multiple pages of data. What is the relationship between OFFSET (number of results to skip), LIMIT (number of results per page), and the page number?

#Offset = Limit * Page Number - Limit

#Or

#Offset = Page - 1 * Limit