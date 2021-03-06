USE employees;
#1) Find all the current employees with the same hire date as employee 101010 using a sub-query.


# Need to add current date function
Select first_name, last_name, hire_date, emp_no
from employees 
Where hire_date = (
		select hire_date
		from employees 
		where emp_no = "101010");
#We got 69 employees due to no current function 

#Use this insted to get current
		
SELECT first_name, last_name, hire_date
FROM employees
JOIN dept_emp ON employees.emp_no = dept_emp.emp_no
Where dept_emp.to_date > CURDATE()
and hire_date = (SELECT
                       hire_date
                   FROM employees
                   WHERE emp_no = 101010
                 );

#Answer = 55 Employees

#2) Find all the titles ever held by all current employees with the first name Aamod.

Select first_name, title
from employees 
join dept_emp using(emp_no)
join titles using(emp_no)
Where first_name = "Aamod"
AND dept_emp.to_date > curdate()
group by title;

#OR 

Select first_name, title
from employees
join dept_emp using(emp_no)
join titles using(emp_no)
where first_name in ( 
		select first_name 
		from employees
		where first_name = "Aamod"
		AND dept_emp.to_date > curdate())
group by title;

#3) How many people in the employees table are no longer working for the company? Give the answer in a comment in your code.

Select count(emp_no)
from dept_emp 
where to_date in (
		select to_date 
		from dept_emp
		where to_date < curdate())
OR to_date in (
		select to_date
		from dept_manager
		where to_date < curdate());

#OR 
	
Select count(emp_no)
from dept_emp 
where to_date not in (
		select to_date 
		from dept_emp
		where to_date > curdate())
AND to_date not in (
		select to_date
		from dept_manager
		where to_date > curdate()); 
		
		# We got 91479 employees not currently working.
		
		
#This one is right
Select emp_no,
first_name,
last_name
from employees
where emp_no not in (
		select 
		emp_no
		from salaries
		where to_date > curdate());
		
# We got 59900 employees not currently working.

#4) Find all the current department managers that are female. List their names in a comment in your code.

Select concat(first_name," ", last_name) As "Female Department Manager"
from employees
where emp_no in (
		select emp_no
		from dept_manager
		where to_date > curdate())
AND gender = "f";

#Results

#Isamu Legleitner
#Karsten Sigstam
#Leon DasSarma
#Hilary Kambil

 #5) Find all the employees who currently have a higher salary than the companies overall, historical average salary.
 select avg(salary) 
 		from salaries;
 		
 #Historical Average Salary is 63810.7448 
 
 Select concat(first_name," ", last_name) as "Employee", salary
 From salaries
 Join employees using(emp_no)
 where salary > (
 		select avg(salary) 
 		from salaries)
 and salaries.to_date > curdate()
 Order by salary ASC;
 
 #min = 63811 max= 159220 total = 154543 current salary 

 #6) How many current salaries are within 1 standard deviation of the current highest salary? (Hint: you can use a built in function to calculate the standard deviation.) What percentage of all salaries is this?
 
 
 Select count(salary)
 from salaries
 where salary > (
 		Select 
 		max(salary) - STDDEV(salary)
 		from salaries
 	    Where to_date > curdate())
 AND salaries.to_date > curdate();
 
 #This givs how many salaries that are one standard deviation avary from the max 
 # = 83 current salaries
 
#~~~~~~~~~~

select
 (Select count(salary)
 from salaries 
 where salary > (
 		Select 
 		max(salary) - STDDEV(salary)
 		from salaries
 	    Where to_date > curdate())
 AND to_date > curdate())
 /
 (select
 count(salary)
 from salaries
 Where to_date > curdate())
 *100;
 
#0.0346 
#Percentage of all current salaries that are within one standard deviation of the current max salary" 
 
 
 #Bonus
 
 #1) Find all the department names that currently have female managers.


#Right
select dept_name
from departments
where dept_no in (
		select dept_no
		from dept_manager
		where dept_manager.to_date > curdate()
		and emp_no in (
				select emp_no
				from employees
				where gender = "f"));
# Answer #
#Development
#Finance
#Human Resources
#Research

 #2) Find the first and last name of the employee with the highest salary.

select concat(first_name, " ", last_name) as "Employee", salary
from employees 
join salaries using(emp_no)
where emp_no in (
		select emp_no
		from salaries
		where salary in (
				select Max(salary)
				from salaries
				where salaries.to_date > curdate()));

#First and last name of employee with highest salary 
# = Tokuyasu Pesch

 #3) Find the department name that the employee with the highest salary works in.

select dept_name
from departments
where dept_no in (
	select dept_no
	from dept_emp
	where emp_no in (
			select emp_no
			from salaries
			where salary in (
					select Max(salary)
					from salaries
					where salaries.to_date > curdate())));

# This works but does not check 
# Answer = Sales 

select dept_name, first_name, last_name, salary
from departments
join dept_emp using(dept_no)
join employees using(emp_no)
join salaries using (emp_no)
where dept_no in (
	select dept_no
	from dept_emp
	where dept_emp.to_date > curdate() 
	and emp_no in (
			select emp_no
			from salaries
			where salary in (
					select Max(salary)
					from salaries
					where salaries.to_date > curdate())))
Order by salary DESC;

#This one works and checks but not current dat

