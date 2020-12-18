use employees;

#Functions Intro
SELECT COUNT(*)
FROM employees;

#Concat a list of strings (combines strings)
SELECT concat("Hi", "Hi", "Hi");

#Concat adds strings together
SELECT concat(first_name," ", last_name) AS full_name
FROM employees
LIMIT 10;

#using SUBSTR
SELECT SUBSTR('abcdef', 2, 4);

SELECT SUBSTR(upper('hello'), 2, 4);

#using REPLACE
SELECT REPLACE(title, "Senior", "Lead");

# using time fuctions 
SELECT CURDATE();
SELECT NOW();
SELECT NOW();

#Show all of the saleries
SELECT *
FROM salaries;

#Show all current salaries
SELECT *
FROM salaries 
WHERE to_date > CURDATE();

#Use avg to get average
SELECT avg(salary) as avg_current_salary
FROM salaries
WHERE to_date > CURDATE();

#Use Min to show current Min salaries 
SELECT min(salary) as min_current_salary
FROM salaries
WHERE to_date > CURDATE();

#Use Max to show current Max salaries
SELECT max(salary) as max_current_salary
FROM salaries
WHERE to_date > CURDATE();

#Exercises Order By


#1)Create a new file named order_by_exercises.sql and copy in the contents of your exercise from the previous lesson.

#2)Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by first name. In your comments, answer: What was the first and last name in the first row of the results? What was the first and last name of the last person in the table?
use employees;

SELECT *
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
ORDER BY first_name; #Irena Reutenauer
 
SELECT *
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
ORDER BY first_name DESC, emp_no DESC;#Vidya Simmen (Need Secodary Sort)

#3)Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by first name and then last name. In your comments, answer: What was the first and last name in the first row of the results? What was the first and last name of the last person in the table?
SELECT *
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
ORDER BY first_name , last_name; #Irena Acton

SELECT *
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
ORDER BY first_name DESC, last_name DESC; #Vidya Zweizig

#4)Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by last name and then first name. In your comments, answer: What was the first and last name in the first row of the results? What was the first and last name of the last person in the table?
SELECT *
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
ORDER BY last_name , first_name; #Irena Acton

SELECT *
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
ORDER BY last_name DESC , first_name DESC;#Maya Zyda

#5)Write a query to to find all employees whose last name starts and ends with 'E'. Sort the results by their employee number. Enter a comment with the number of employees returned, the first employee number and their first and last name, and the last employee number with their first and last name.
SELECT *
FROM employees
WHERE last_name LIKE 'e%e'
ORDER BY emp_no; #899 Records #10021 Ramzi Erde

SELECT *
FROM employees
WHERE last_name LIKE 'e%e'
ORDER BY emp_no DESC; # 199648 Tadahiro Erde

#6)Write a query to to find all employees whose last name starts and ends with 'E'. Sort the results by their hire date, so that the newest employees are listed first. Enter a comment with the number of employees returned, the name of the newest employee, and the name of the oldest emmployee.
SELECT *
FROM employees
WHERE last_name LIKE 'e%e'
ORDER BY hire_date DESC; #899 Records #Teiji Eldridge

SELECT *
FROM employees
WHERE last_name LIKE 'e%e'
ORDER BY hire_date ASC; #899 Records #Sergi Erde


#7)Find all employees hired in the 90s and born on Christmas. Sort the results so that the oldest employee who was hired last is the first result. Enter a comment with the number of employees returned, the name of the oldest employee who was hired last, and the name of the youngest emmployee who was hired first. 
use employees;

SELECT *
FROM employees
WHERE hire_date LIKE '199%'
AND birth_date LIKE '%12-25'
ORDER BY birth_date ASC, hire_date DESC;#362 Records #Khun Bernini

SELECT *
FROM employees
WHERE hire_date LIKE '199%'
AND birth_date LIKE '%12-25'
ORDER BY birth_date DESC, hire_date ASC;#362 Records #Douadi Pettis

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

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#Exercises Functions 

#1)Copy the order by exercise and save it as functions_exercises.sql.
use employees;

#2)Write a query to to find all current employees whose last name starts and ends with 'E'. Use concat() to combine their first and last name together as a single column named full_name.
SELECT concat(first_name," ", Last_name) as full_name
FROM employees
WHERE last_name LIKE 'e%e';

#3)Convert the names produced in your last query to all uppercase.
SELECT upper(concat(first_name," ", Last_name)) as full_name
FROM employees
WHERE last_name LIKE 'e%e';

#4)Find all previous employees hired in the 90s and born on Christmas. Use datediff() function to find how many days they have been working at the company (Hint: You will also need to use NOW() or CURDATE()),
SELECT datediff(NOW(), hire_date) AS how_many_days_at_company
FROM employees
WHERE hire_date LIKE '199%' 
AND birth_date LIKE '%12-25';

#5)Find the smallest and largest current salary from the salaries table.
SELECT min(salary) as min_current_salary
FROM salaries
WHERE to_date > CURDATE();#38623

#Use Max to show current Max salaries
SELECT max(salary) as max_current_salary
FROM salaries
WHERE to_date > CURDATE();#158220

#6)Use your knowledge of built in SQL functions to generate a username for all of the current and previous employees. A username should be all lowercase, and consist of the first character of the employees first name, the first 4 characters of the employees last name, an underscore, the month the employee was born, and the last two digits of the year that they were born. Below is an example of what the first 10 rows will look like:

SELECT LOWER(CONCAT(SUBSTR(first_name,1,1),substr(last_name,1,4),"_",substr(birth_date,6,2),substr(birth_date,3,2)))
FROM employees;

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~