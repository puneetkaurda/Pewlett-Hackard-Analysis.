SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '2052-01-01' AND '2055-12-31';

SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '2055-01-01' AND '2055-12-31';

SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '2053-01-01' AND '2053-12-31';

SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '2054-01-01' AND '2054-12-31';

-- Retirement eligibility
SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '2052-01-01' AND '2055-12-31';

-- Retirement eligibility
SELECT first_name, last_name
FROM employees
WHERE (birth_date BETWEEN '2052-01-01' AND '2055-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- Number of employees retiring
SELECT COUNT(first_name)
FROM employees
WHERE (birth_date BETWEEN '2052-01-01' AND '2055-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- Number of employees retiring
SELECT first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '2052-01-01' AND '2055-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

SELECT * FROM retirement_info;
