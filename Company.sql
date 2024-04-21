CREATE DATABASE EMPLOYEE;



CREATE TABLE employee(
	emp_id INT PRIMARY KEY,
	first_name VARCHAR(20),
	last_name VARCHAR(20),
	birth_date DATE,
	gender CHAR(1),
	salary INT,
	super_id INT,
	branch_id INT
);

CREATE TABLE branch(
	branch_id INT PRIMARY KEY,
	branch_name VARCHAR(20),
	mgr_id INT,
	mgr_start_date DATE,
	FOREIGN KEY (mgr_id) REFERENCES employee(emp_id) ON DELETE SET NULL
);

ALTER TABLE employee
ADD FOREIGN KEY (branch_id)
REFERENCES branch(branch_id)
ON DELETE SET NULL;

ALTER TABLE employee
ADD FOREIGN KEY (super_id)
REFERENCES employee(emp_id)
ON DELETE NO ACTION;

CREATE TABLE client(
	client_id INT PRIMARY KEY,
	client_name VARCHAR(25),
	branch_id INT,
	FOREIGN KEY (branch_id) REFERENCES branch(branch_id) ON DELETE CASCADE
);

CREATE TABLE works_with(
	emp_id INT,
	client_id INT,
	total_sales INT,
	PRIMARY KEY(emp_id, client_id),
	FOREIGN KEY (emp_id) REFERENCES employee(emp_id) ON DELETE CASCADE,
	FOREIGN KEY (client_id) REFERENCES client(client_id) ON DELETE CASCADE
);

CREATE TABLE branch_supplier(
	branch_id INT,
	supplier_name VARCHAR(25),
	supply_type VARCHAR(30),
	PRIMARY KEY(branch_id, supplier_name),
	FOREIGN KEY (branch_id) REFERENCES branch(branch_id) ON DELETE CASCADE
);


/*
DROP TABLE employee;
DROP TABLE branch;
DROP TABLE client;
DROP TABLE works_with;
DROP TABLE branch_supplier;
*/

--Inserting into EMPLOYEE and BRANCH

--branch1

INSERT INTO employee VALUES (100, 'David', 'Wallace', '1967-11-17', 'M', 250000, NULL, NULL);
INSERT INTO branch VALUES (1, 'Corporate', 100, '2006-02-09');

UPDATE employee
SET branch_id = 1
WHERE emp_id = 100;

INSERT INTO employee VALUES (101, 'Jan', 'Levinson', '1961-05-11', 'F', 110000, 100, 1);

--branch2

INSERT INTO employee VALUES (102, 'Michael', 'Scott', '1964-03-15', 'M', 75000, 100, NULL);
INSERT INTO branch VALUES (2, 'Scranton', 102, '1992-04-06');

UPDATE employee
SET branch_id = 2
WHERE emp_id = 102;

INSERT INTO employee VALUES
	(103, 'Angela', 'Martin', '1971-06-25', 'F', 63000, 102, 2),
	(104, 'Kelly', 'Kapoor', '1980-02-05', 'F', 55000, 102, 2),
	(105, 'Stanley', 'Hudson', '1958-02-19', 'M', 69000, 102, 2);

--branch3

INSERT INTO employee VALUES (106, 'Josh', 'Porter', '1969-09-05', 'M', 78000, 100, NULL);
INSERT INTO branch VALUES (3, 'Stamford', 106, '1998-02-13');

UPDATE employee
SET branch_id = 3
WHERE emp_id = 106;

INSERT INTO employee VALUES
	(107, 'Andy', 'Bernard', '1973-07-22', 'M', 65000, 106, 3),
	(108, 'Jim', 'Halpert', '1978-10-01', 'M', 71000, 106, 3);

--inserting into CLIENT

INSERT INTO client VALUES
	(400, 'Dunmore Highschool', 2),
	(401, 'Lackawana Country', 2),
	(402, 'FedEx', 3),
	(403, 'John Daly Law, LLC', 3),
	(404, 'Scranton Whitepages', 3),
	(405, 'Times Newspaper', 3),
	(406, 'FedEx', 2);

--inserting into WORKS_WITH

INSERT INTO works_with VALUES
	(105, 400, 55000),
	(102, 401, 267000),
	(108, 402, 22500),
	(107, 403, 5000),
	(108, 403, 12000),
	(105, 404, 33000),
	(107, 405, 26000),
	(102, 406, 15000),
	(105, 406, 130000);

--inserting into BRANCH SUPPLIER

INSERT INTO branch_supplier VALUES
	(2, 'Hammer Mill', 'Paper'),
	(2, 'Uni-ball', 'Writing Utensils'),
	(3, 'Patriot Paper', 'Paper'),
	(2, 'J.T. Forms & Labels', 'Custom Forms'),
	(3, 'Uni-ball', 'Writing Utensils'),
	(3, 'Hammer Mill', 'Paper'),
	(3, 'Stamford Lables', 'Custom Forms');



--FIND ALL EMPLOYEES

SELECT *
FROM employee;

--FIND ALL BRANCHES

SELECT *
FROM branch;

--FIND ALL CLIENTS

SELECT *
FROM client;

--FIND ALL WORKS WITH

SELECT *
FROM works_with;

--FIND ALL BRANCH SUPPLIERS

SELECT *
FROM branch_supplier;

--FIND ALL EMPLOYEES ORDERED BY SALARY

SELECT *
FROM employee
ORDER BY salary;

--FIND ALL EMPLOYEES ORDERED BY SALARY WITH HIGHEST ON TOP

SELECT *
FROM employee
ORDER BY salary DESC;

--FIND ALL EMPLOYEES ORDERED BY GENDER THEN NAME

SELECT *
FROM employee
ORDER BY gender, first_name, last_name;

--FIND THE FIRST 5 EMPLOYEES IN THE TABLE

SELECT TOP 5 *
FROM employee;

--FIND THE FIRST AND LAST NAMES OF ALL THE EMPLOYEES

SELECT first_name, last_name
FROM employee;

--FIND THE FORENAME AND SURNAME OF ALL THE EMPLOYEES

SELECT first_name AS Forename, last_name AS Surname
FROM employee;

--FIND OUT ALL THE DIFFERENT GENDERS

SELECT DISTINCT gender
FROM employee;

--FUNCTIONS

--FIND THE NUMBER OF EMPLOYEES

SELECT COUNT(emp_id)
FROM employee;

--FIND THE NUMBER OF SUPERVISORS

SELECT COUNT(super_id)
FROM employee;

--FIND THE NUMBER OF FEMALE EMPLOYEES BORN AFTER 1970

SELECT COUNT(emp_id)
FROM employee
WHERE gender = 'F' AND birth_date > '1970-01-01';

--FIND THE AVERAGE OF ALL EMPLOYEES SALARIES

SELECT AVG(salary)
FROM employee;

--FIND THE AVERAGE OF ALL MALE EMPLOYEES SALARIES

SELECT AVG(salary)
FROM employee
WHERE gender = 'M';

--FIND THE SUM OF ALL EMPLOYEES SALARY

SELECT SUM(salary)
FROM employee;

--FIND OUT HOW MANY MALES AND FEMALES ARE THERE

SELECT COUNT(gender), gender
FROM employee
GROUP BY gender;

--Group by columns

SELECT gender, branch_id
FROM employee
GROUP BY branch_id, gender;

--FIND THE TOTAL SALES OF EACH SALESMAN

SELECT SUM(total_sales), emp_id
FROM WORKS_WITH
GROUP BY emp_id;

--FIND THE TOTAL SALES OF EACH CLIENT

SELECT SUM(total_sales), client_id
FROM WORKS_WITH
GROUP BY client_id;

--MIN()

SELECT MIN(salary) AS MinSalary
FROM employee;

SELECT MAX(salary) AS MaxSalary
FROM employee;


--WILDCARDS--

--Find any Client's who are an LLC

SELECT *
FROM client
WHERE client_name LIKE '%LLC';

--Find any branch suppliers who are in the label business

SELECT *
FROM branch_supplier
WHERE supplier_name LIKE '%Label%';

--Find any Employee born in October

SELECT *
FROM employee
WHERE MONTH(birth_date) = 10;

--OR

SELECT *
FROM employee
WHERE birth_date LIKE '____-10%';

--Find any Client who are Schools

SELECT *
FROM client
WHERE client_name LIKE '%school%';

--UNION

--Find a list of Employee and branch name

SELECT first_name AS Employee_and_Branch
FROM employee
UNION
SELECT branch_name
FROM branch;

--Find a list of all clients & branch suppliers names

SELECT client_name
FROM client
UNION
SELECT supplier_name
FROM branch_supplier;

--ALSO

SELECT client_name, branch_id
FROM client
UNION
SELECT supplier_name, branch_id
FROM branch_supplier;

--Find the list of all money spent or earned by the company

SELECT salary
FROM employee
UNION
SELECT total_sales
FROM works_with;

--UNION ALL   -- will contain duplicates

SELECT first_name AS Employee_and_Branch
FROM employee
UNION ALL
SELECT branch_name
FROM branch;

--JOINS

INSERT INTO branch VALUES (4, 'Buffalo', NULL, NULL);

SELECT * FROM branch;

--Find all the branches and names of their managers

SELECT employee.emp_id, employee.first_name, branch.mgr_id
FROM employee
JOIN branch
ON employee.emp_id = branch.mgr_id;

--LEFT JOIN

SELECT employee.emp_id, employee.first_name, branch.mgr_id
FROM employee
LEFT JOIN branch
ON employee.emp_id = branch.mgr_id;

--RIGHT JOIN

SELECT employee.emp_id, employee.first_name, branch.branch_name
FROM employee
RIGHT JOIN branch
ON employee.emp_id = branch.mgr_id;

--FULL OUTER JOIN

SELECT employee.emp_id, employee.first_name, branch.branch_name
FROM employee
FULL OUTER JOIN branch
ON employee.emp_id = branch.mgr_id;

--NESTED QUERIES

--Find names of all employees who have sold over 30000 to a single client

SELECT employee.first_name, employee.last_name
FROM employee
WHERE employee.emp_id IN (
	SELECT works_with.emp_id
	FROM works_with
	WHERE works_with.total_sales > 30000
);

--Find all clients who are handled by the branch that Michael Scott manages - Assumen you know Michaels ID

SELECT client.client_name
FROM client
WHERE client.branch_id = (
	SELECT branch.branch_id
	FROM branch
	WHERE branch.mgr_id = 102
);

--ON DELETE SET NULL

DELETE FROM employee
WHERE emp_id = 102;

SELECT * FROM branch;
SELECT * FROM employee;

--ON DELETE CASCADE

DELETE FROM branch
WHERE branch_id = 2;

SELECT * FROM branch;
SELECT * FROM branch_supplier;


