-- Crear Base de Datos

CREATE DATABASE UNSC_Database;

-- Crear Tabla users

CREATE TABLE UNSC_Database.users (
    user_id INT(8) PRIMARY KEY AUTO_INCREMENT,
    user_name VARCHAR(30),
    user_password VARCHAR(16)
);

-- Insertar Datos en tabla users

INSERT INTO UNSC_Database.users (user_name, user_password) VALUES
('admin', '123'),
('striker', '123'),
('jeringasLoko', '123'),
('katu', '123'),
('exul', '123'),
('zimoo', '123');

-- Crear tabla students

CREATE TABLE UNSC_Database.students (
    student_id INT(8) PRIMARY KEY AUTO_INCREMENT,
    student_firstName VARCHAR(40),
    student_lastName VARCHAR(40),
    student_note INT(3) DEFAULT 0,
    student_group VARCHAR(3),
    student_genre VARCHAR(1),
    student_state VARCHAR(10),
    student_payment VARCHAR(10)
);

-- Insertar Datos en tabla students

INSERT INTO UNSC_Database.students (student_firstName, student_lastName, student_note, student_group, student_genre, student_state, student_payment) VALUES
('Luis Gerardo', 'Tinoco Coronel', 100, 'G32', 'H', 'Cursando', 'Pagado'),
('David', 'Ruiz Lara', 80, 'G32', 'H', 'Cursando','Pagado'),
('Miguel Angel', 'Ramirez Cruz', 90, 'G32', 'H', 'Cursando','No pagado'),
('Alexis Guillermo', 'Gómez Puerto', 75, 'G32', 'H', 'Cursando', 'Pagado'),
('Luis Alberto', 'De la Cruz Guerrero', 85, 'G32', 'H', 'Cursando', 'No pagado'),
('Diego Alejandro', 'Macías Espejel', 70, 'G32', 'H', 'Egresado', 'Pagado'),
('Estefania', 'Valencia', 90, 'G30', 'M', 'Egresado', 'Pagado'),
('Maria', 'Mendoza Sanchez', default, 'A12', 'M', 'Egresado','Pagado'),
('Cesar Eduardo', 'Gonzales Noriega', 80, 'G32', 'H', 'Egresado', 'Pagado'),
('Helio', 'Barriga Obregón', default, 'G32', 'H', 'Cursando', 'No Pagado');

-- Crear tabla employees

CREATE TABLE UNSC_Database.employees (
    employee_id INT(8) PRIMARY KEY AUTO_INCREMENT,
    employee_firstName VARCHAR(40),
    employee_lastName VARCHAR(40),
    employee_dept VARCHAR(40),
    employee_genre VARCHAR(1),
    employee_salary INT(8)
);

-- Insertar Datos en tabla employees

INSERT INTO UNSC_Database.employees (employee_firstName, employee_lastName, employee_dept, employee_genre, employee_salary) VALUES
('Chris', 'Evans', 'Docente', 'H', 9600),
('Robert', 'Downey', 'Sistemas', 'H', 10700),
('Charlie', 'Murphy', 'Docente', 'M', 10700),
('Ryan', 'Reynolds', 'Directivo', 'H', 14800),
('Ben', 'Afleck', 'Administrativo', 'H', 8600),
('Matthew', 'Mcconaughey', 'Administrativo', 'H', 10200),
('Tom', 'Hiddleston', 'Docente', 'H', 9400),
('Emma', 'Stone', 'Directivo', 'M', 14800),
('Chris', 'Pratt', 'Administrativo', 'H', 10600),
('Pablo', 'Schreiber', 'Directivo', 'H', 14800);



