use employees;

show tables;

SHOW CREATE TABLE employees;

#Which table(s) do you think contain a numeric type column?
#-emp_no

#Which table(s) do you think contain a string type column?
#-first_name
#-last_name
#-gender

#Which table(s) do you think contain a date type column?
#-hire_date
#-birth_date

# The departments table does not have a direct (do not share keys) relationship with employees table. There is insigt found through exploration when looking at dept.emp table which had two forigne keys, one to point to a dept_no and another to point to an emp_no 
	#-This is called a many to many relationship. 
	#(Sign1 = 2 unrealted tables and a third that relates the two tables) 
	#(Sign2 = Can more than one employee or departments hav more than one employee or department associated with it?)

SHOW CREATE TABLE dept_manager;