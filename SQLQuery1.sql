CREATE DATABASE employee_participation;
USE employee_participation;

-- Create Department table
CREATE TABLE department (
    num_s INT PRIMARY KEY,
    label VARCHAR(225) NOT NULL,
    manager_name VARCHAR(225) NOT NULL
);
INSERT INTO department (num_s, label, manager_name) VALUES
(1, 'IT', 'Alice Johnson'),
(2, 'HR', 'Bob Smith'),
(3, 'Marketing', 'Clara Bennett'
);

-- Create Employee table
CREATE TABLE employee (
    num_E INT PRIMARY KEY,
    name VARCHAR(225) NOT NULL,
    position VARCHAR(225) NOT NULL,
    salary DECIMAL(10,2) NOT NULL CHECK (salary >= 0),
    department_num_s INT,
    FOREIGN KEY (department_num_s) REFERENCES department(num_s)
        ON DELETE SET NULL 
        ON UPDATE CASCADE
);

INSERT INTO employee (num_e, name, position, salary, department_num_s) VALUES
(101, 'John Doe', 'Developer', 60000.00, 1),
(102, 'Jane Smith', 'Analyst', 55000.00, 2),
(103, 'Mike Brown', 'Designer', 50000.00, 3),
(104, 'Sarah Johnson', 'Data Scientist', 70000.00, 1),
(105, 'Emma Wilson', 'HR Specialist', 52000.00, 2);


-- Create Project table
CREATE TABLE project (
    num_p INT PRIMARY KEY,
    title VARCHAR(225) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    department_num_s INT,
    FOREIGN KEY (department_num_s) REFERENCES department(num_s)
        ON DELETE SET NULL
        ON UPDATE CASCADE,
    CHECK (end_date >= start_date)
);

INSERT INTO project (num_p, title, start_date, end_date, department_num_s) VALUES
(201, 'Website Redesign', '2024-01-15', '2024-06-30', 1),
(202, 'Employee Onboarding', '2024-03-01', '2024-09-01', 2),
(203, 'Market Research', '2024-02-01', '2024-07-31', 3),
(204, 'IT Infrastructure Setup', '2024-04-01', '2024-12-31', 1);


-- Create Employee_Project table
CREATE TABLE employee_project (
    employee_num_e INT NOT NULL,
    project_num_p INT NOT NULL,
    role VARCHAR(225) NOT NULL,
    PRIMARY KEY (employee_num_e, project_num_p),	
    FOREIGN KEY (employee_num_e) REFERENCES employee(num_e)
        ON DELETE CASCADE 
        ON UPDATE CASCADE,
    FOREIGN KEY (project_num_p) REFERENCES project(num_p)
        ON DELETE NO ACTION 
        ON UPDATE NO ACTION
);
INSERT INTO employee_project (employee_num_e, project_num_p, role) VALUES
(101, 201, 'Frontend Developer'),
(104, 201, 'Backend Developer'),
(102, 202, 'Trainer'),
(105, 202, 'Coordinator'),
(103, 203, 'Research Lead'),
(101, 204, 'Network Specialist');


/*modifying table employee_project with employee_num_e and project_num_p where it is = 101 and 201 
respectfully and changing the role from frontend developer to full stack developer'''*/

UPDATE employee_project
SET role = 'Full Stack Developer'
WHERE employee_num_e = 101 AND project_num_p = 201;


DELETE FROM employee
WHERE num_e = 103;


---Data query language checkpoint
---Question 1
/*Write a query to retrieve the names of employees who are assigned to more than one project,
including the total number of projects for each employee.*/

SELECT e.name, COUNT(ep.project_num_p) AS total_projects
FROM employee e
JOIN employee_project ep ON e.num_e = ep.employee_num_e
GROUP BY e.name
HAVING COUNT(ep.project_num_p) > 1;




---question 2
/*Write a query to retrieve the list of projects managed by each department, including the department label and manager’s name.*/
SELECT d.label AS department_label, d.manager_name, p.title AS project_title
FROM department d
JOIN project p ON d.num_s = p.department_num_s;







/* Question 3
Write a query to retrieve the names of employees working on the project "Website Redesign," including their roles in the project.
*/
SELECT e.name, ep.role
FROM employee e
JOIN employee_project ep ON e.num_e = ep.employee_num_e
JOIN project p ON p.num_p = ep.project_num_p
WHERE p.title = 'Website Redesign';



/*Question 4
Write a query to retrieve the department with the highest number of employees,
including the department label, manager name, and the total number of employees.
*/
SELECT TOP 1 d.label AS department_label, d.manager_name, COUNT(e.num_e) AS total_employees
FROM department d
JOIN employee e ON d.num_s = e.department_num_s
GROUP BY d.label, d.manager_name
ORDER BY total_employees DESC;






/* Question 5
Write a query to retrieve the names and positions of employees earning a salary greater than 60,000, including their department names.
*/
SELECT e.name, e.position, d.label AS department_label
FROM employee e
JOIN department d ON e.department_num_s = d.num_s
WHERE e.salary > 60000;




/*Question 6 
Write a query to retrieve the number of employees assigned to each project, including the project title.
*/
SELECT p.title AS project_title, COUNT(ep.employee_num_e) AS employee_count
FROM project p
JOIN employee_project ep ON p.num_p = ep.project_num_p
GROUP BY p.title;





/*Question 7
Write a query to retrieve a summary of roles employees have across different projects, including the employee name, project title, and role.
*/
SELECT e.name AS employee_name, p.title AS project_title, ep.role
FROM employee e
JOIN employee_project ep ON e.num_e = ep.employee_num_e
JOIN project p ON p.num_p = ep.project_num_p;






/*Question 8
Write a query to retrieve the total salary expenditure for each department, including the department label and manager name.
*/
SELECT d.label AS department_label, d.manager_name, SUM(e.salary) AS total_salary
FROM department d
JOIN employee e ON d.num_s = e.department_num_s
GROUP BY d.label, d.manager_name;


---it is good to Note that the type of join in sql that was used in some of the questions where inner join