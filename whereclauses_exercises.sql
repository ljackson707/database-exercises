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



