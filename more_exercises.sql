Use world;

#1) How much do the current managers of each department get paid, relative to the average salary for the department? Is there any department where the department manager gets paid less than the average salary?
CREATE TABLE Manager_Salaries as(
	SELECT dept_name, salary as Manager_Salary 
	FROM employees.salaries
			JOIN employees.dept_manager USING(emp_no)
			JOIN employees.departments USING(dept_no)
	WHERE emp_no IN 
			(select emp_no from employees.dept_manager
				WHERE employees.dept_manager.to_date>curdate()
				AND employees.salaries.to_date>curdate())
	GROUP BY dept_name, salary);

SELECT *
FROM Manager_Salaries;

CREATE TABLE Avg_Dept_Salary
(SELECT dept_name, truncate(AVG(salary),0) as Average_Dept_Salary, Manager_Salary
FROM employees.salaries 
	JOIN employees.dept_manager USING(emp_no)
	JOIN employees.departments USING(dept_no)
	JOIN Manager_Salaries USING(dept_name)
GROUP BY dept_name, Manager_Salary);

SELECT *
FROM Avg_Dept_Salary;

# no current dept. managers are being paid belove the dept. average.

#2) What languages are spoken in Santa Monica?
use world;

select Language, Percentage 
from countrylanguage
join city using(CountryCode)
where Name = 'Santa Monica'
order by Percentage ASC;

#3) How many different countries are in each region?
select Region, count(Name)
from country
group by Region
order by count(Name);

#4) What is the population for each region?
select Region, SUM(Population)
from country
group by Region
order by Sum(Population) DESC;

#5) What is the population for each continent?
select Continent, SUM(Population)
from country
group by Continent
order by SUM(Population) DESC;
<<<<<<< HEAD

#6) What is the average life expectancy globally?
select avg(LifeExpectancy) as Avg_Global_Life_Expectancy
from country;


#7) What is the average life expectancy for each region, each continent? Sort the results from shortest to longest

select Continent, avg(LifeExpectancy) as Avg_Life_Expectancy_Con
from country
group by Continent
order by Avg_Life_Expectancy_Con;

select Region, avg(LifeExpectancy) as Avg_Life_Expectancy_Reg
from country
group by Region
order by Avg_Life_Expectancy_Reg;

#8) Find all the countries whose local name is different from the official name
Select Name, LocalName
from country
where LocalName not like Name;

#9) How many countries have a life expectancy less than x?
Select Name, count(Code)
from country
where LifeExpectancy < 50
group by Name;

#10) What state is city x located in?
Select Name, District
from city
where Name = "Blackpool";













=======
>>>>>>> 5bce4c5b033b8480c7f69633f564a16c995b3297
