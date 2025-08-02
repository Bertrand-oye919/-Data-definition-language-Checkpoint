CREATE DATABASE employee_participation;
USE employee_participation;

-- Create Department table
CREATE TABLE department (
    num_s INT PRIMARY KEY,
    label VARCHAR(225) NOT NULL,
    manager_name VARCHAR(225) NOT NULL
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


