USE employees;

# Using the example in the Associative Table Joins section as a guide, write a query
# that shows each department along with the name of the current manager for that department.

SELECT departments.dept_name AS "Department Name",
    CONCAT(employees.first_name, " ", employees.last_name) AS "Department Manager"
FROM employees
JOIN dept_manager
    ON dept_manager.emp_no = employees.emp_no
JOIN departments
    ON departments.dept_no = dept_manager.dept_no
WHERE dept_manager.to_date like "9999%"
ORDER BY departments.dept_name ASC;

# Find the name of all departments currently managed by women.

SELECT departments.dept_name AS "Department Name",
    CONCAT(employees.first_name, " ", employees.last_name) AS "Department Manager"
FROM employees
JOIN dept_manager
    ON dept_manager.emp_no = employees.emp_no
JOIN departments
    ON departments.dept_no = dept_manager.dept_no
WHERE dept_manager.to_date like "9999%" and employees.gender = 'F'
ORDER BY departments.dept_name ASC;

# Find the current titles of employees currently working in the Customer Service
# department.
--
-- Title              | Count
-- -------------------+------
-- Assistant Engineer |    68
-- Engineer           |   627
-- Manager            |     1
-- Senior Engineer    |  1790
-- Senior Staff       | 11268
-- Staff              |  3574
-- Technique Leader   |   241

# tables:
#   titles
#   dept_emp
#   departments
SELECT titles.title, count(*)
FROM titles
JOIN dept_emp
  ON titles.emp_no = dept_emp.emp_no
JOIN departments
  ON departments.dept_no = dept_emp.dept_no
WHERE dept_emp.to_date > now()
  AND titles.to_date > now()
  AND departments.dept_name = "Customer Service"
GROUP BY titles.title;

# Find the current salary of all current managers.
# tables:
#   salaries -> employees to salaries
#   dept_manager -> relate managers to departments
#   departments -> for department name
#   employees -> to get the names

SELECT departments.dept_name AS "Department Name",
  concat(managers.first_name, " ", managers.last_name) AS "Name",
  salaries.salary AS "Salary"
FROM employees AS managers
JOIN dept_manager
  ON dept_manager.emp_no = managers.emp_no
JOIN salaries
  ON salaries.emp_no = managers.emp_no
JOIN departments
  ON departments.dept_no = dept_manager.dept_no
WHERE salaries.to_date > now()
  AND dept_manager.to_date > now()
LIMIT 8;

# Bonus Find the names of all current employees, their department name, and
# their current manager name.
# tables
#   employees -> first/last name
#   dept_emp -> dep of each employee
#   departments -> get dept name
#   dept_manager -> emp_no of the manager
#   managers -> get the emp_no of the manager

SELECT concat(emp.first_name, ' ', emp.last_name) AS 'Employee Name',
  departments.dept_name AS 'Department Name',
  concat(managers.first_name, ' ', managers.last_name) AS 'Manager Name'
FROM employees AS emp
JOIN dept_emp
  ON dept_emp.emp_no = emp.emp_no
JOIN departments
  ON departments.dept_no = dept_emp.dept_no
JOIN dept_manager
  ON dept_manager.dept_no = departments.dept_no
JOIN employees AS managers
  ON managers.emp_no = dept_manager.emp_no
WHERE dept_emp.to_date > now() AND dept_manager.to_date > now();
