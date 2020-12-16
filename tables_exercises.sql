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

# Deppartments is a parent to department managers and dept_manager is a sibling to employees.

SHOW CREATE TABLE dept_manager;