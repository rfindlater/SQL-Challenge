

CREATE TABLE "Departments" (
    "dept_no" VARCHAR   NOT NULL,
    "dept_name" VARCHAR   NOT NULL,
    CONSTRAINT "pk_Departments" PRIMARY KEY (
        "dept_no"
     )
);

CREATE TABLE "Titles" (
    "title_id" VARCHAR   NOT NULL,
    "title" VARCHAR   NOT NULL,
    CONSTRAINT "pk_Titles" PRIMARY KEY (
        "title_id"
     )
);

CREATE TABLE "Salaries" (
    "emp_no" int   NOT NULL,
    "salary" int   NOT NULL
);

CREATE TABLE "Employees" (
    "emp_no" int   NOT NULL,
    "emp_title_id" VARCHAR   NOT NULL,
    "birth_date" VARCHAR   NOT NULL,
    "first_name" VARCHAR   NOT NULL,
    "last_name" VARCHAR   NOT NULL,
    "sex" VARCHAR   NOT NULL,
    "hire_date" VARCHAR   NOT NULL,
    CONSTRAINT "pk_Employees" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "Department_Managers" (
    "dept_no" VARCHAR   NOT NULL,
    "emp_no" int   NOT NULL
);

CREATE TABLE "Department_Employees" (
    "emp_no" int   NOT NULL,
    "dept_no" VARCHAR   NOT NULL
);

ALTER TABLE "Salaries" ADD CONSTRAINT "fk_Salaries_emp_no" FOREIGN KEY("emp_no")
REFERENCES "Employees" ("emp_no");

ALTER TABLE "Employees" ADD CONSTRAINT "fk_Employees_emp_title_id" FOREIGN KEY("emp_title_id")
REFERENCES "Titles" ("title_id");

ALTER TABLE "Department_Managers" ADD CONSTRAINT "fk_Department_Managers_dept_no" FOREIGN KEY("dept_no")
REFERENCES "Departments" ("dept_no");

ALTER TABLE "Department_Managers" ADD CONSTRAINT "fk_Department_Managers_emp_no" FOREIGN KEY("emp_no")
REFERENCES "Employees" ("emp_no");

ALTER TABLE "Department_Employees" ADD CONSTRAINT "fk_Department_Employees_emp_no" FOREIGN KEY("emp_no")
REFERENCES "Employees" ("emp_no");

ALTER TABLE "Department_Employees" ADD CONSTRAINT "fk_Department_Employees_dept_no" FOREIGN KEY("dept_no")
REFERENCES "Departments" ("dept_no");
---
--Check data imports
SELECT * 
FROM "Salaries";

--List the following details of each employee: employee number, last name, first name, sex, and salary.
SELECT E.emp_no, E.last_name, E.first_name, E.sex, S.salary
FROM "Employees" AS E
LEFT JOIN "Salaries" AS S
ON S.emp_no = E.emp_no; 

--List first name, last name, and hire date for employees who were hired in 1986.
SELECT first_name, last_name, hire_date
FROM "Employees"
WHERE hire_date 
LIKE '%86';

--List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name.
SELECT DM.dept_no, D.dept_name, E.emp_no, E.last_name, E.first_name
FROM "Department_Managers" AS DM
LEFT JOIN "Employees" AS E
ON E.emp_no = DM.emp_no
RIGHT JOIN "Departments" AS D
ON D.dept_no = DM.dept_no;

--List the department of each employee with the following information: employee number, last name, first name, and department name.
SELECT DM.emp_no, E.last_name, E.first_name, D.dept_name
FROM "Department_Managers" AS DM
LEFT JOIN "Employees" AS E
ON E.emp_no = DM.emp_no
RIGHT JOIN "Departments" AS D
ON D.dept_no = DM.dept_no;

--List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."
SELECT first_name, last_name, sex
FROM "Employees"
WHERE first_name 
LIKE 'Hercules' 
AND last_name 
LIKE 'B%';

--List all employees in the Sales department, including their employee number, last name, first name, and department name.
SELECT DM.emp_no, E.last_name, E.first_name, D.dept_name
FROM "Department_Managers" AS DM
LEFT JOIN "Employees" AS E
ON E.emp_no = DM.emp_no
RIGHT JOIN "Departments" AS D
ON D.dept_no = DM.dept_no
WHERE D.dept_name = 'Sales';

--List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT DM.emp_no, E.last_name, E.first_name, D.dept_name
FROM "Department_Managers" AS DM
LEFT JOIN "Employees" AS E
ON E.emp_no = DM.emp_no
RIGHT JOIN "Departments" AS D
ON D.dept_no = DM.dept_no
WHERE D.dept_name = 'Sales' 
OR D.dept_name = 'Development';

--In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.

SELECT last_name,
COUNT (last_name) AS "Frequency"
FROM "Employees"
GROUP BY last_name 
ORDER BY 
COUNT (last_name) DESC;



