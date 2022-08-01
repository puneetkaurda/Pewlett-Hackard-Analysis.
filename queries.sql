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
DROP TABLE retirement_info;

-- Create new table for retiring employees
SELECT emp_no, first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '2052-01-01' AND '2055-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');
-- Check the table
SELECT * FROM retirement_info;

-- Joining departments and dept_manager tables
SELECT departments.dept_name,
     dept_manager.emp_no,
     dept_manager.from_date,
     dept_manager.to_date
FROM departments
INNER JOIN dept_manager
ON departments.dept_no = dept_manager.dept_no;

-- Joining retirement_info and dept_emp tables
SELECT retirement_info.emp_no,
    retirement_info.first_name,
retirement_info.last_name,
    dept_emp.to_date
FROM retirement_info
LEFT JOIN dept_emp
ON retirement_info.emp_no = dept_emp.emp_no;

-- Use aliases in the code above^ to make code cleaner
select ri.emp_no,
	ri.first_name,
	ri.last_name,
	de.to_date
from retirement_info as ri --this is where the alias 'ri' gets defined
left join dept_emp as de --this is where the alias 'de' gets defined
on ri.emp_no = de.emp_no;
-- NOTE: these aliases only exist within this query; they aren't committed to that database

-- Join the "departments" and "managers" tables
select dpt.dept_name,
	mgr.emp_no,
	mgr.from_date,
	mgr.to_date
from departments as dpt
inner join dept_manager as mgr
on dpt.dept_no = mgr.dept_no;

-- Join the "retirement_info" and "dept_emp" tables to make sure they're still employed
select ri.emp_no,
	ri.first_name,
	ri.last_name,
	de.to_date
into current_emp
from retirement_info as ri
left join dept_emp as de
on ri.emp_no = de.emp_no
where de.to_date = ('9999-01-01');
-- Check the table
select * from current_emp;

    -- Employee count by department number
SELECT COUNT(ce.emp_no), de.dept_no
FROM current_emp as ce
LEFT JOIN dept_emp as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no
ORDER BY de.dept_no;

-- Determine the employee count by department number
select count(ce.emp_no), de.dept_no
into emp_count_by_dept_no
from current_emp as ce
left join dept_emp as de
on ce.emp_no = de.emp_no
group by de.dept_no
order by de.dept_no;
SELECT * FROM emp_count_by_dept_no;
 
SELECT * FROM salaries
ORDER BY to_date DESC;

-- Create the 1st List: Employee Information
-- Here, we are using a modified version of the "retirement_info" table to include salaries 
-- and renaming the table to "emp_info"
select e.emp_no, 
	e.first_name, 
	e.last_name,
	e.gender,
	s.salary,
	de.to_date
into emp_info
from employees as e
	inner join salaries as s
		on (e.emp_no = s.emp_no)
	inner join dept_emp as de
		on (e.emp_no = de.emp_no)
where (e.birth_date between '2052-01-01' and '2055-12-31')
	and (e.hire_date between '1985-01-01' and '1988-12-31')
	and (de.to_date = '9999-01-01');
SELECT * FROM emp_info;

-- List of managers per department
SELECT  dm.dept_no,
        d.dept_name,
        dm.emp_no,
        ce.last_name,
        ce.first_name,
        dm.from_date,
        dm.to_date
INTO manager_info
FROM dept_manager AS dm
    INNER JOIN departments AS d
        ON (dm.dept_no = d.dept_no)
    INNER JOIN current_emp AS ce
        ON (dm.emp_no = ce.emp_no);

-- Create the 3rd List: Department Retirees
select ce.emp_no,
	ce.first_name,
	ce.last_name,
	dpt.dept_name
into dept_info
from current_emp as ce
	inner join dept_emp as de
		on (ce.emp_no = de.emp_no)
	inner join departments as dpt
		on (de.dept_no = dpt.dept_no);
		
-- 7.3.6 Create a Tailored List
-- Create a query that returns the info relevant to the Sales Team
-- Requested list includes: employee numbers, first name, last name, department name
select ce.emp_no,
	ce.first_name,
	ce.last_name,
	de.dept_no,
	dpt.dept_name
from current_emp as ce
	inner join dept_emp as de
		on (ce.emp_no = de.emp_no)
	inner join departments as dpt
		on (de.dept_no = dpt.dept_no)
where dept_name = 'Sales';

-- Create another query that will return the following information for the Sales and Development teams:
-- Requested list includes: employee numbers, first name, last, department name
select ce.emp_no,
	ce.first_name,
	ce.last_name,
	de.dept_no,
	dpt.dept_name
from current_emp as ce
	inner join dept_emp as de
		on (ce.emp_no = de.emp_no)
	inner join departments as dpt
		on (de.dept_no = dpt.dept_no)
where dept_name in ('Sales', 'Development');  


