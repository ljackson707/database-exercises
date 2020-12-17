use employees;

##Using The % (Wildcard)

#lookup Gorg but dont know last part of the name spelling
SELECT *
FROM employees
WHERE first_name LIKE 'Geor%';

# Show us everybody who was hired todday. No matter the year.
SELECT *
FROM employees
WHERE hire_date like '%12-17';

##AND, OR, NOT logical operators.
# AND (Limit Results) 
# OR (Expand Results)

#Using And
SELECT *
FROM employees
WHERE hire_date LIKE '%12-17'
AND birth_date LIKE '%12-17';

#Using Or 
SELECT *
FROM employees
WHERE hire_date LIKE '%12-17'
or birth_date like '%12-17';

#Using NOT
SELECT *
FROM employees
WHERE hire_date NOT LIKE '%12-17';

#Adding AND,OR,NOT together
SELECT *
FROM employees
WHERE 
	(hire_date LIKE '%-12-17'
	OR 
	birth_date LIKE '%12-17')
AND NOT 
	(hire_date LIKE '%-12-17'
	AND
	birth_date LIKE '%12-17')
AND first_name LIKE '%B'
AND last_name LIKE '%T';

#This Shows the employees that have a hiredate like today or birthdate like today, but removes all people that have a birthdate and hiredate as today. 


##Using the in Operator 

#Show me the employees that have the emp_no of 101010 202020 or 303030
SELECT *
FROM employees
WHERE first_name IN ('Georgi', 'Mary', 'Jane', 'Bob');

#Show me the employees that have the name Gergi or Mary or Jane or Bob
SELECT * 
FROM employees
WHERE first_name IN ('Georgi', 'Mary', 'Jane', 'Bob');

#Show me the employees that have the name Gergi or Mary or Jane or Bob with a birthdate of 12-17
SELECT * 
FROM employees
WHERE first_name NOT IN ('Georgi', 'Mary', 'Jane', 'Bob')
AND birth_date LIKE '%12-17';

## Using zillow database to see NULLs
use zillow;
SELECT * 
FROM properties_2017
WHERE fireplacecnt IS NOT NULL
AND airconditioningtypeid IS NOT NULL;

#Using NULL to see if a house has no aircoditioning but has a fire place( could me norther homes that do not need AC) 
SELECT * 
FROM properties_2017
WHERE taxamount < 4000
AND fireplacecnt IS NOT NULL
AND airconditioningtypeid IS NULL
LIMIT 10;
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

##**Where_Exercises**

#Create a file named where_exercises.sql. Make sure to use the employees database.
use employees;

#Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya' using IN. Enter a comment with the number of records returned.
SELECT *
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya');#709 Records 

#Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya', as in Q2, but use OR instead of IN. Enter a comment with the number of records returned. Does it match number of rows from Q2?
SELECT *
FROM employees
WHERE first_name = 'Irena' 
or first_name = 'Vidya' 
or first_name = 'Maya'; #709 Records

#Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya', using OR, and who is male. Enter a comment with the number of records returned.
SELECT *
FROM employees
WHERE first_name = 'Irena' 
	AND gender = 'M' 
or first_name = 'Vidya' 
	AND gender = 'M'
or first_name = 'Maya' 
	AND gender = 'M'; #441 Records

#Find all current or previous employees whose last name starts with 'E'. Enter a comment with the number of employees whose last name starts with E.
SELECT *
FROM employees
WHERE last_name LIKE 'e%';#7330 Records


#Find all current or previous employees whose last name starts or ends with 'E'. Enter a comment with the number of employees whose last name starts or ends with E. How many employees have a last name that ends with E, but does not start with E?
SELECT *
FROM employees
WHERE last_name LIKE 'e%'
or last_name LIKE '%e';#30723


SELECT *
FROM employees
WHERE last_name LIKE '%e'
AND NOT last_name LIKE 'e%';#23393 Records

#Find all current or previous employees employees whose last name starts and ends with 'E'. Enter a comment with the number of employees whose last name starts and ends with E. How many employees' last names end with E, regardless of whether they start with E?
SELECT *
FROM employees
WHERE last_name LIKE '%e'
AND last_name LIKE 'e%';#899 Records (e_)

SELECT *
FROM employees
WHERE last_name LIKE '%e';#24292 Records (_e)

#Find all current or previous employees hired in the 90s. Enter a comment with the number of employees returned.
SELECT *
FROM employees
WHERE hire_date LIKE '199%'; #135214 Records

#Find all current or previous employees born on Christmas. Enter a comment with the number of employees returned.
SELECT *
FROM employees
WHERE birth_date LIKE '%12-25';#842

#Find all current or previous employees hired in the 90s and born on Christmas. Enter a comment with the number of employees returned.
SELECT *
FROM employees
WHERE 
(hire_date LIKE '199%' 
AND 
birth_date LIKE '%12-25');#362 Records

#Find all current or previous employees with a 'q' in their last name. Enter a comment with the number of records returned.
SELECT *
FROM employees
WHERE last_name LIKE '%q%';#1873 Records

#Find all current or previous employees with a 'q' in their last name but not 'qu'. How many employees are found?
SELECT *
FROM employees
WHERE 
last_name LIKE '%q%'
AND NOT 
last_name LIKE '%qu%';#547


