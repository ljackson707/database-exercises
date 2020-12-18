use employees;

# Using Order By (If not specified the order is by Primary Key)
SELECT * 
FROM employees
ORDER BY hire_date DESC;        #([ASC|DESC])(ASC Default)

SELECT * 
FROM employees
ORDER BY first_name ASC, last_name ASC, hire_date ASC;

SELECT * 
FROM employees
ORDER BY first_name DESC, birth_date ASC; #(Order by is used at the end to sort not to filter)

#ORDER AND WHERE 
SELECT * 
FROM employees
WHERE emp_no between 101010 and 202020
AND last_name LIKE "%q%"
ORDER BY last_name ASC;

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#Exercises

#1)Copy the order by exercise and save it as functions_exercises.sql.



#2)Write a query to to find all current employees whose last name starts and ends with 'E'. Use concat() to combine their first and last name together as a single column named full_name.

#3)Convert the names produced in your last query to all uppercase.

#4)Find all previous employees hired in the 90s and born on Christmas. Use datediff() function to find how many days they have been working at the company (Hint: You will also need to use NOW() or CURDATE()),

#5)Find the smallest and largest current salary from the salaries table.

#6)Use your knowledge of built in SQL functions to generate a username for all of the current and previous employees. A username should be all lowercase, and consist of the first character of the employees first name, the first 4 characters of the employees last name, an underscore, the month the employee was born, and the last two digits of the year that they were born. Below is an example of what the first 10 rows will look like:

