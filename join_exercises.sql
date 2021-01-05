#1A) Use join_example_db;

Use join_example_db;

#2B) 

Select *
From users
join roles on users.role_id = roles.id; #This gives us no nulls but all the users. 4 results for roles and users.

Select *
From users
Left join roles on users.role_id = roles.id; #This gave use all the users. 6 results for user ids


Select *
From users
Right join roles on roles.id = users.role_id; #This gives us the roles accepting njulls from users 5 results for roles.

#3C)

Select roles.name, count(users.name) as number_of_users
From users
right join roles on roles.id = users.role_id
Group By name; #There are no active comentors that we know of with the null infromation for user.

#1 Use the employees database.

Use employees;

#2 Using the example in the Associative Table Joins section as a guide, write a query that shows each department along with the name of the current manager for that department.

SELECT dept_name as "Department Name", concat(first_name," ", last_name) as "Department Manager"
From departments
join dept_manager on dept_manager.dept_no = departments.dept_no
join employees on employees.emp_no = dept_manager.emp_no
Where dept_manager.to_date > curdate()
Order by dept_name;

#3 Find the name of all departments currently managed by women.

Select gender, dept_name as "Department Name", concat(first_name," ", last_name) as "Manager Name"
From departments 
join dept_manager on dept_manager.dept_no = departments.dept_no
join employees on employees.emp_no = dept_manager.emp_no
Where gender like "f"
AND dept_manager.to_date > curdate()
Order by dept_name;

#4 Find the current titles of employees currently working in the Customer Service department.

Select title, count(title) as Count
From titles
join employees using(emp_no)
join dept_emp on employees.emp_no = dept_emp.emp_no
join departments on departments.dept_no = dept_emp.dept_no
Where dept_emp.to_date > curdate()
AND titles.to_date > curdate()
AND dept_name Like "customer service"
group by title; #Correct

#5 Find the current salary of all current managers.

Select dept_name as "Department Name", concat(first_name," ", last_name), salary as Salary
from salaries
Join employees using(emp_no)
Join dept_manager using(emp_no)
Join departments using(dept_no)
Where salaries.to_date > curdate()
And dept_manager.to_date > curdate()
Order By dept_name;

#6 Find the number of current employees in each department.

Select dept_no, dept_name, count(emp_no)
from dept_emp
join departments using(dept_no)
Where dept_emp.to_date > curdate()
Group By dept_no;


#7 Which department has the highest average salary? Hint: Use current not historic information.

Select dept_name, avg(salary) as "average salary"
from salaries
join dept_emp using(emp_no)
join departments using(dept_no)
Where salaries.to_date > curdate()
And dept_emp.to_date > curdate()
group by dept_name
Order by avg(salary) DESC
Limit 1;

#8 Who is the highest paid employee in the Marketing department?

Select first_name, last_name, salary
from employees 
join salaries using(emp_no)
join dept_emp using(emp_no)
join departments using(dept_no)
Where dept_name = "marketing"
and salaries.to_date > curdate()
Order by salary DESC
Limit 1;


#9 Which current department manager has the highest salary?

Select first_name, last_name, salary, dept_name
from salaries
join employees using(emp_no)
join dept_manager using(emp_no)
join departments using(dept_no)
Where dept_manager.to_date > curdate()
and salaries.to_date > curdate()
Order by salary desc
limit 1;


#10 Bonus Find the names of all current employees, their department name, and their current managers name.

Select concat(employees.first_name," ", employees.last_name) as "Employee Name", 
dept_name, dept_manager.emp_no,
concat(managers.first_name," ", managers.last_name)
from employees 
join dept_emp using(emp_no)
join departments using(dept_no)
join dept_manager using(dept_no)
join employees as managers on managers.emp_no = dept_manager.emp_no
Where dept_manager.to_date > curdate()
and dept_emp.to_date > curdate()
Order by dept_name;

#11 Bonus Who is the highest paid employee within each department.

select first_name, last_name, salary, dept_name
from employees
join salaries on salaries.emp_no = employees.emp_no
join dept_emp on dept_emp.emp_no = employees.emp_no
join departments on departments.dept_no = dept_emp.dept_no
where salary in (
	Select max(salary)
	from employees
	join salaries on salaries.emp_no = employees.emp_no
	join dept_emp on dept_emp.emp_no = employees.emp_no
	join departments on departments.dept_no = dept_emp.dept_no
	group by dept_name
)
And salaries.to_date > curdate()
And dept_emp.to_date > curdate();

#OR 

(SELECT first_name, last_name, salary, dept_name
	FROM employees
		JOIN salaries USING(emp_no)
		JOIN dept_emp USING(emp_no)
		JOIN departments USING(dept_no)
	WHERE dept_name = 'Sales'
		AND salaries.to_date > curdate()
		AND dept_emp.to_date > curdate()
	ORDER BY salary DESC
	LIMIT 1)
UNION
(SELECT first_name, last_name, salary, dept_name
	FROM employees
		JOIN salaries USING(emp_no)
		JOIN dept_emp USING(emp_no)
		JOIN departments USING(dept_no)
	WHERE dept_name = 'Marketing'
		AND salaries.to_date > curdate()
		AND dept_emp.to_date > curdate()
	ORDER BY salary DESC
	LIMIT 1)
UNION 
(SELECT first_name, last_name, salary, dept_name
	FROM employees
		JOIN salaries USING(emp_no)
		JOIN dept_emp USING(emp_no)
		JOIN departments USING(dept_no)
	WHERE dept_name = 'Finance'
		AND salaries.to_date > curdate()
		AND dept_emp.to_date > curdate()
	ORDER BY salary DESC
	LIMIT 1)
UNION 
(SELECT first_name, last_name, salary, dept_name
	FROM employees
		JOIN salaries USING(emp_no)
		JOIN dept_emp USING(emp_no)
		JOIN departments USING(dept_no)
	WHERE dept_name = 'Human Resources'
		AND salaries.to_date > curdate()
		AND dept_emp.to_date > curdate()
	ORDER BY salary DESC
	LIMIT 1)
UNION 
(SELECT first_name, last_name, salary, dept_name
	FROM employees
		JOIN salaries USING(emp_no)
		JOIN dept_emp USING(emp_no)
		JOIN departments USING(dept_no)
	WHERE dept_name = 'Production'
		AND salaries.to_date > curdate()
		AND dept_emp.to_date > curdate()
	ORDER BY salary DESC
	LIMIT 1)
UNION 
(SELECT first_name, last_name, salary, dept_name
	FROM employees
		JOIN salaries USING(emp_no)
		JOIN dept_emp USING(emp_no)
		JOIN departments USING(dept_no)
	WHERE dept_name = 'Development'
		AND salaries.to_date > curdate()
		AND dept_emp.to_date > curdate()
	ORDER BY salary DESC
	LIMIT 1)
UNION
(SELECT first_name, last_name, salary, dept_name
	FROM employees
		JOIN salaries USING(emp_no)
		JOIN dept_emp USING(emp_no)
		JOIN departments USING(dept_no)
	WHERE dept_name = 'Quality Management'
		AND salaries.to_date > curdate()
		AND dept_emp.to_date > curdate()
	ORDER BY salary DESC
	LIMIT 1)
UNION
(SELECT first_name, last_name, salary, dept_name
	FROM employees
		JOIN salaries USING(emp_no)
		JOIN dept_emp USING(emp_no)
		JOIN departments USING(dept_no)
	WHERE dept_name = 'Research'
		AND salaries.to_date > curdate()
		AND dept_emp.to_date > curdate()
	ORDER BY salary DESC
	LIMIT 1)
UNION
(SELECT first_name, last_name, salary, dept_name
	FROM employees
		JOIN salaries USING(emp_no)
		JOIN dept_emp USING(emp_no)
		JOIN departments USING(dept_no)
	WHERE dept_name = 'Customer Service'
		AND salaries.to_date > curdate()
		AND dept_emp.to_date > curdate()
	ORDER BY salary DESC
	LIMIT 1);


