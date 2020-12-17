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

# The employees table has a emp_no column that refrences the emp_no on the departments tables

SHOW CREATE TABLE dept_manager;