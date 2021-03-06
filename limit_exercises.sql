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

Senior Engineer
Staff
Engineer
Senior Staff
Assistant Engineer
Technique Leader
Manager


#3)Find all previous or current employees hired in the 90s and born on Christmas. Find the first 5 employees hired in the 90s by sorting by hire date and limiting your results to the first 5 records. Write a comment in your code that lists the five names of the employees returned.
SELECT *
FROM employees
WHERE hire_date LIKE "199%"
AND birth_date LIKE "%12-25"
ORDER BY hire_date ASC
LIMIT 5;

243297	1962-12-25	Alselm	Cappello	F	1990-01-01
34335	1960-12-25	Utz	Mandell	M	1990-01-03
400710	1963-12-25	Bouchung	Schreiter	M	1990-01-04
465730	1959-12-25	Baocai	Kushner	F	1990-01-05
490744	1959-12-25	Petter	Stroustrup	M	1990-01-10

#4)Try to think of your results as batches, sets, or pages. The first five results are your first page. The five after that would be your second page, etc. Update the query to find the tenth page of results.
SELECT *
FROM employees
WHERE hire_date LIKE "199%"
AND birth_date LIKE "%12-25"
ORDER BY hire_date ASC
LIMIT 5 OFFSET 45;

463558	1963-12-25	Pranay	Narwekar	F	1990-07-18
444269	1963-12-25	Marjo	Farrow	F	1990-07-18
291662	1962-12-25	Ennio	Karcich	M	1990-08-05
413687	1954-12-25	Dines	Lubachevsky	F	1990-08-06
416525	1952-12-25	Ipke	Fontan	M	1990-08-06

#LIMIT and OFFSET can be used to create multiple pages of data. What is the relationship between OFFSET (number of results to skip), LIMIT (number of results per page), and the page number?

#Offset = Limit * Page Number - Limit

#Or

#Offset = Page - 1 * Limit