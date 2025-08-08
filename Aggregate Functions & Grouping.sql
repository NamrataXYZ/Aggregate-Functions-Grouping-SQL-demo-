-- Create the database
CREATE DATABASE employee_db;
USE employee_db;

-- Create Departments table
CREATE TABLE departments (
    dept_no CHAR(4) PRIMARY KEY,
    dept_name VARCHAR(50) NOT NULL
);

-- Create Employees table
CREATE TABLE employees (
    emp_no INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    hire_date DATE NOT NULL
);

-- Create Department-Employee mapping table 
CREATE TABLE dept_emp (
    emp_no INT,
    dept_no CHAR(4),
    PRIMARY KEY (emp_no, dept_no),
    FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
    FOREIGN KEY (dept_no) REFERENCES departments(dept_no)
);

-- Create Salaries table
CREATE TABLE salaries (
    emp_no INT,
    salary DECIMAL(10,2) NOT NULL,
    from_date DATE NOT NULL,
    to_date DATE NOT NULL,
    FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);

-- Insert Departments
INSERT INTO departments VALUES
('d001', 'Finance'),
('d002', 'IT'),
('d003', 'HR'),
('d004', 'Marketing');

-- Insert Employees
INSERT INTO employees VALUES
(101, 'John', 'Smith', '2015-03-01'),
(102, 'Alice', 'Johnson', '2017-06-12'),
(103, 'Robert', 'Brown', '2018-09-15'),
(104, 'Emily', 'Davis', '2019-11-23'),
(105, 'Michael', 'Wilson', '2020-01-05'),
(106, 'Sophia', 'Taylor', '2016-04-10'),
(107, 'David', 'Clark', '2018-08-19');

-- Assign Employees to Departments (Mapping)
INSERT INTO dept_emp VALUES
(101, 'd001'),
(102, 'd002'),
(103, 'd002'),
(104, 'd003'),
(105, 'd004'),
(106, 'd002'),
(107, 'd001');

-- Insert Salaries
INSERT INTO salaries VALUES
(101, 75000, '2022-01-01', '2023-01-01'),
(102, 90000, '2022-01-01', '2023-01-01'),
(103, 85000, '2022-01-01', '2023-01-01'),
(104, 60000, '2022-01-01', '2023-01-01'),
(105, 72000, '2022-01-01', '2023-01-01'),
(106, 95000, '2022-01-01', '2023-01-01'),
(107, 68000, '2022-01-01', '2023-01-01');

-- Total salary & average salary per department with high-earner count
SELECT 
    dept_name AS Department,
    COUNT(emp_no) AS Total_Employees,
    SUM(salary) AS Total_Salary,
    ROUND(AVG(salary), 2) AS Avg_Salary,
    SUM(CASE WHEN salary > 80000 THEN 1 ELSE 0 END) AS High_Earners
FROM employees
JOIN dept_emp USING (emp_no)
JOIN departments USING (dept_no)
JOIN salaries USING (emp_no)
GROUP BY dept_name
HAVING COUNT(emp_no) > 5
ORDER BY Avg_Salary DESC;

