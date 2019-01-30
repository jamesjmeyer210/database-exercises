USE employees;

SELECT DISTINCT title FROM titles;

SELECT last_name
FROM employees
WHERE last_name like 'E%' and last_name like '%e'
GROUP BY last_name;

SELECT last_name
FROM employees
WHERE last_name like '%q%' AND last_name NOT like '%qu%'
GROUP BY last_name;

SELECT last_name, COUNT(last_name)
FROM employees
WHERE last_name like '%q%' AND last_name NOT like '%qu%'
GROUP BY last_name;

SELECT gender, COUNT(gender)
FROM employees
WHERE (first_name = 'Irena' OR first_name = 'Vidya' OR first_name = 'Maya')
GROUP BY gender;
