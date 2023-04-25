-- Database: employee_sql

-- DROP DATABASE IF EXISTS employee_sql;
-- create database


-- create tables
CREATE TABLE departments (
  dept_no VARCHAR(4) PRIMARY KEY,
  dept_name VARCHAR(40) NOT NULL
);

COPY departments FROM 'C:\Users\Mathew\Desktop\sql_challenge\departments.csv' DELIMITER ',' CSV HEADER;

CREATE TABLE titles (
  title_id VARCHAR(50) PRIMARY KEY,
  title VARCHAR(50) NOT NULL
);
COPY titles FROM 'C:\Users\Mathew\Desktop\sql_challenge\titles.csv' DELIMITER ',' CSV HEADER;



CREATE TABLE employees (
  emp_no INTEGER PRIMARY KEY,
  emp_title VARCHAR(50) NOT NULL,
  birth_date DATE NOT NULL,
  first_name VARCHAR(20) NOT NULL,
  last_name VARCHAR(20) NOT NULL,
  sex VARCHAR(1) NOT NULL,
  hire_date DATE NOT NULL,
  CONSTRAINT emp_title_fk FOREIGN KEY (emp_title) REFERENCES titles(title_id)
);
COPY employees FROM 'C:\Users\Mathew\Desktop\sql_challenge\employees.csv' DELIMITER ',' CSV HEADER;

CREATE TABLE salaries (
  emp_no INTEGER NOT NULL,
  salary INTEGER NOT NULL,
  FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);

COPY salaries FROM 'C:\Users\Mathew\Desktop\sql_challenge\salaries.csv' DELIMITER ',' CSV HEADER;




CREATE TABLE dept_emp (
  emp_no INTEGER NOT NULL,
  dept_no VARCHAR(4) NOT NULL,
  FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
  FOREIGN KEY (dept_no) REFERENCES departments(dept_no)
);

COPY dept_emp FROM 'C:\Users\Mathew\Desktop\sql_challenge\dept_emp.csv' DELIMITER ',' CSV HEADER;

CREATE TABLE dept_manager (
  dept_no VARCHAR(4) NOT NULL,
  emp_no INTEGER NOT NULL,
  FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
  FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);
COPY dept_manager FROM 'C:\Users\Mathew\Desktop\sql_challenge\dept_manager.csv' DELIMITER ',' CSV HEADER;

-- import data

SELECT e.emp_no, last_name, first_name, sex, salary
FROM employees e
INNER JOIN salaries s ON e.emp_no = s.emp_no;

SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date BETWEEN '1986-01-01' AND '1986-12-31';

SELECT dm.dept_no, d.dept_name, dm.emp_no, e.last_name, e.first_name
FROM dept_manager dm
INNER JOIN departments d ON dm.dept_no = d.dept_no
INNER JOIN employees e ON dm.emp_no = e.emp_no;

SELECT de.emp_no, e.last_name, e.first_name, d.dept_name
FROM dept_emp de
INNER JOIN employees e ON de.emp_no = e.emp_no
INNER JOIN departments d ON de.dept_no = d.dept_no;

SELECT first_name, last_name, sex
FROM employees
WHERE first_name = 'Hercules' AND last_name LIKE 'B%';

SELECT e.emp_no, e.last_name, e.first_name
FROM employees e
INNER JOIN dept_emp de ON e.emp_no = de.emp_no
INNER JOIN departments d ON de.dept_no = d.dept_no
WHERE d.dept_name = 'Sales';

SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees e
INNER JOIN dept_emp de ON e.emp_no = de.emp_no
INNER JOIN departments d ON de.dept_no = d.dept_no
WHERE d.dept_name IN ('Sales', 'Development');

SELECT last_name, COUNT(*) as frequency
FROM employees
GROUP BY last_name
ORDER BY frequency DESC;











