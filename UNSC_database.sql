-- =================== CREANDO TABLAS ===================

-- Creando Base de datos 

CREATE DATABASE UNSC_Database;

-- Tabla `employees`

DROP TABLE IF EXISTS `employees`;
CREATE TABLE `employees` (
  `employee_id` int(8) NOT NULL AUTO_INCREMENT,
  `employee_firstName` varchar(40) COLLATE utf8_unicode_ci DEFAULT NULL,
  `employee_lastName` varchar(40) COLLATE utf8_unicode_ci DEFAULT NULL,
  `employee_dept` varchar(40) COLLATE utf8_unicode_ci DEFAULT NULL,
  `employee_genre` varchar(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  `employee_salary` int(8) DEFAULT NULL,
  PRIMARY KEY (`employee_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


-- Tabla `groups`

DROP TABLE IF EXISTS `groups`;
CREATE TABLE `groups` (
  `group_id` int(11) NOT NULL AUTO_INCREMENT,
  `group_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `group_code` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`group_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Tabla `roles`

DROP TABLE IF EXISTS `roles`;
CREATE TABLE `roles` (
  `role_id` int(11) NOT NULL AUTO_INCREMENT,
  `role_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Tabla `students`

DROP TABLE IF EXISTS `students`;
CREATE TABLE `students` (
  `student_id` int(8) NOT NULL AUTO_INCREMENT,
  `student_firstName` varchar(40) COLLATE utf8_unicode_ci DEFAULT NULL,
  `student_lastName` varchar(40) COLLATE utf8_unicode_ci DEFAULT NULL,
  `student_note` int(3) DEFAULT '0',
  `student_genre` varchar(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  `student_state` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `student_payment` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `student_group_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`student_id`),
  KEY `student_group_id` (`student_group_id`),
  CONSTRAINT `students_ibfk_1` FOREIGN KEY (`student_group_id`) REFERENCES `groups` (`group_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Tabla `courses`

DROP TABLE IF EXISTS `courses`;
CREATE TABLE `courses` (
  `course_id` int(8) NOT NULL AUTO_INCREMENT,
  `course_code` int(8) COLLATE utf8_unicode_ci DEFAULT NULL,
  `course_title` varchar(80) COLLATE utf8_unicode_ci DEFAULT NULL,
  `course_description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `course_employee_id` int(8) DEFAULT NULL,
  `course_group_id` int(11) DEFAULT NULL,
  `start_date` DATE COLLATE utf8_unicode_ci DEFAULT NULL,
  `end_date` DATE COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`course_id`),
  KEY `course_group_id` (`course_group_id`),
  KEY `course_employee_id` (`course_employee_id`),
  CONSTRAINT `courses_ibfk_1` FOREIGN KEY (`course_group_id`) REFERENCES `groups` (`group_id`),
  CONSTRAINT `courses_ibfk_2` FOREIGN KEY (`course_employee_id`) REFERENCES `employees` (`employee_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Tabla `grades`

DROP TABLE IF EXISTS `grades`;
CREATE TABLE `grades` (
  `grade_id` int(8) NOT NULL AUTO_INCREMENT,
  `grade` int(3) DEFAULT NULL,
  `evaluation_date` date DEFAULT NULL,
  `evaluation_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `course_id` int(8) NOT NULL,
  `student_id` int(8) NOT NULL,
  PRIMARY KEY (`grade_id`),
  FOREIGN KEY (`course_id`) REFERENCES `courses` (`course_id`),
  FOREIGN KEY (`student_id`) REFERENCES `students` (`student_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


-- Tabla `users`

DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `user_id` int(8) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `user_password` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `user_employee_id` int(8) DEFAULT NULL,
  `user_role_id` int(8) DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  KEY `user_employee_id` (`user_employee_id`),
  KEY `user_role_id` (`user_role_id`),
  CONSTRAINT `users_ibfk_1` FOREIGN KEY (`user_employee_id`) REFERENCES `employees` (`employee_id`),
  CONSTRAINT `users_ibfk_2` FOREIGN KEY (`user_role_id`) REFERENCES `roles` (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- =================== CREANDO VISTAS ===================

-- Tabla `users_data`

DROP VIEW IF EXISTS `users_data`;
CREATE VIEW `users_data` AS 
SELECT 
  `u`.`user_id`,
  `u`.`user_name`,
  `e`.`employee_firstName`,
  `e`.`employee_lastName`,
  `e`.`employee_genre`,
  `e`.`employee_dept`,
  `r`.`role_name`
FROM 
    `roles` `r` 
LEFT JOIN `users` `u` 
    ON `u`.`user_role_id` = `r`.`role_id`
LEFT JOIN `employees` `e`
    ON `u`.`user_employee_id` = `e`.`employee_id`;

-- Tabla `students_data`

DROP VIEW IF EXISTS `students_data`;
CREATE VIEW `students_data` AS 
SELECT 
  `s`.`student_id`, 
  `s`.`student_firstName`, 
  `s`.`student_lastName`, 
  `s`.`student_note`, 
  `s`.`student_genre`, 
  `s`.`student_state`, 
  `s`.`student_payment`, 
  `g`.`group_name`, 
  `g`.`group_code`
FROM 
  `students` `s` 
LEFT JOIN `groups` `g`
    ON `s`.`student_group_id` = `g`.`group_id`;

-- Tabla Courses Data

DROP VIEW IF EXISTS `courses_data`;
CREATE VIEW `courses_data` AS
SELECT * 
FROM `courses` `c` 
LEFT JOIN `employees` `e` 
    ON `c`.`course_employee_id` = `e`.`employee_id`
LEFT JOIN groups g 
    ON `c`.`course_group_id` = `g`.`group_id`;

-- Tabla `students_per_group`

DROP VIEW IF EXISTS `students_per_group`;
CREATE VIEW `students_per_group` AS 
SELECT 
  `sd`.`group_code`, 
  COUNT(`sd`.`group_code`) AS `amount` 
FROM 
  `students_data` `sd` 
GROUP BY 
  `sd`.`group_code`;

-- `teachers_data`

DROP VIEW IF EXISTS `teachers_data`;
CREATE VIEW `teachers_data` AS
SELECT 
	*
FROM 
  `employees`
WHERE 
	`employee_dept` LIKE `Docente`

-- =================== CREANDO PROCEDIMIENTOS ALMACENADOS ===================

-- Funcion `insert_employee`

DELIMITER $$
CREATE PROCEDURE `insert_employee`(
  firstName VARCHAR(255),
  lastName VARCHAR(255),
  dept VARCHAR(255),
  genre VARCHAR(255),
  salary INT
)
BEGIN
  INSERT INTO employees (
    employee_firstName,
    employee_lastName,
    employee_dept,
    employee_genre,
    employee_salary
  )
  VALUES (
    firstName,
    lastName,
    dept,
    genre,
    salary
  );
END $$
DELIMITER;

-- Funcion `insert_student`

DELIMITER $$
CREATE PROCEDURE `insert_student`(
  firstName VARCHAR(255),
  lastName VARCHAR(255),
  note VARCHAR(255),
  genre VARCHAR(255),
  state VARCHAR(255),
  payment VARCHAR(255),
  group_id INT
)
BEGIN
  INSERT INTO students (
    student_firstName, 
    student_lastName, 
    student_note, 
    student_genre, 
    student_state, 
    student_payment, 
    student_group_id
  )
  VALUES (
    firstName,
    lastName,
    note,
    genre,
    state,
    payment,
    group_id
  );
END $$
DELIMITER;

-- Funcion `insert_course`

DELIMITER $$
CREATE PROCEDURE `insert_course`(
  code INT(8),
  title VARCHAR(80),
  description VARCHAR(80),
  employee_id INT(11),
  group_id INT(11),
  start_date DATE,
  end_date DATE
)
BEGIN
  INSERT INTO courses (
    course_code,
    course_title,
    course_description,
    course_employee_id,
    course_group_id,
    start_date,
    end_date
  )
  VALUES (
    code,
    title,
    description,
    employee_id,
    group_id,
    start_date,
    end_date 
  );
END $$
DELIMITER;

-- Funcion `insert_user`

DELIMITER $$
CREATE PROCEDURE `insert_user`( 
  name VARCHAR(255),
  password VARCHAR(255),
  employee_id INT,
  role_id INT
)
BEGIN
  INSERT INTO users (
    user_name,
    user_password,
    user_employee_id,
    user_role_id
  )
  VALUES (
    LOWER(name),
    password,
    employee_id,
    role_id
  );
END $$
DELIMITER;

-- Funcion `get_course_employee_by_code`

DELIMITER $$
CREATE PROCEDURE get_course_employee_by_code(code VARCHAR(8))
BEGIN
  SELECT
    e.employee_id, e.employee_firstName, e.employee_lastName, c.course_code ,c.course_title
FROM 
  employees e
JOIN 
  courses c ON e.employee_id = c.course_employee_id
WHERE
  course_code LIKE code;
END $$
DELIMITER;

-- Ejemplo de uso
-- CALL get_course_employee_by_code('2732');

-- Funcion `update_student_note`

DELIMITER $$
CREATE PROCEDURE `update_student_note`(IN studentId INT)
BEGIN
    UPDATE students SET student_note = 
    (SELECT AVG(grade) FROM grades WHERE student_id = studentId)
    WHERE student_id = studentId;
END $$
DELIMITER ;


-- Triggers  `update_student_note_after_grade_change`

-- Trigger for INSERT on grades
DELIMITER $$
CREATE TRIGGER update_student_note_after_grade_insert
AFTER INSERT ON grades
FOR EACH ROW
BEGIN
CALL update_student_note(NEW.student_id);
END $$
DELIMITER ;

-- Trigger for UPDATE on grades
DELIMITER $$
CREATE TRIGGER update_student_note_after_grade_update
AFTER UPDATE ON grades
FOR EACH ROW
BEGIN
CALL update_student_note(NEW.student_id);
END $$
DELIMITER ;

-- Trigger for DELETE on grades
DELIMITER $$
CREATE TRIGGER update_student_note_after_grade_delete
AFTER DELETE ON grades
FOR EACH ROW
BEGIN
CALL update_student_note(OLD.student_id);
END $$
DELIMITER;

-- Trigger `after_insert_employee_create_user`

DELIMITER $$
CREATE TRIGGER 
  after_insert_employee_create_user
AFTER INSERT 
ON employees FOR EACH ROW  
BEGIN  
  CALL insert_user(
    NEW.employee_firstName,
    CONCAT(NEW.employee_firstName, NEW.employee_lastName, '123'), -- password FirstLast123
    NEW.employee_id,
    3 -- role id / default 3 = basic
  );
END $$
DELIMITER;


-- =================== INSERTANDO DATOS ===================

-- Roles

INSERT INTO `roles` (`role_name`) VALUES ('admin');
INSERT INTO `roles` (`role_name`) VALUES ('superuser');
INSERT INTO `roles` (`role_name`) VALUES ('basic');

-- Grupos

INSERT INTO .`groups` (`group_name`, `group_code`) VALUES ('Grupo 1', 'G01');
INSERT INTO .`groups` (`group_name`, `group_code`) VALUES ('Grupo 2', 'B02');
INSERT INTO .`groups` (`group_name`, `group_code`) VALUES ('Grupo 3', 'G03');
INSERT INTO .`groups` (`group_name`, `group_code`) VALUES ('Grupo 4', 'G04');
INSERT INTO .`groups` (`group_name`, `group_code`) VALUES ('Grupo 5', 'G05');
INSERT INTO .`groups` (`group_name`, `group_code`) VALUES ('Grupo 6', 'G06');
INSERT INTO .`groups` (`group_name`, `group_code`) VALUES ('Grupo 7', 'G07');
INSERT INTO .`groups` (`group_name`, `group_code`) VALUES ('Grupo 8', 'G08');
INSERT INTO .`groups` (`group_name`, `group_code`) VALUES ('Grupo 9', 'G09');
INSERT INTO .`groups` (`group_name`, `group_code`) VALUES ('Grupo 32', 'G32');

-- Empleados

CALL insert_employee('Chris', 'Evans', 'Docente', 'H', 9600);
CALL insert_employee('Charlie', 'Murphy', 'Docente', 'M', 10700);
CALL insert_employee('Tom', 'Hiddleston', 'Docente', 'H', 9400);
CALL insert_employee('Pablo', 'Schreiber', 'Docente', 'H', 14800);
CALL insert_employee('Robert', 'Downey', 'Docente', 'H', 10700);
CALL insert_employee('Ryan', 'Reynolds', 'Directivo', 'H', 14800);
CALL insert_employee('Ben', 'Afleck', 'Administrativo', 'H', 8600);
CALL insert_employee('Matthew', 'Mcconaughey', 'Administrativo', 'H', 10200);
CALL insert_employee('Emma', 'Stone', 'Directivo', 'M', 14800);
CALL insert_employee('Chris', 'Pratt', 'Administrativo', 'H', 10600);

-- Estudiantes

CALL insert_student('Luis Gerardo','Tinoco Coronel',-1,'H','Cursando','Pagado',1);
CALL insert_student('David','Ruiz Lara',-1,'H','Cursando','Pagado',2);
CALL insert_student('Miguel Angel','Ramirez Cruz',-1,'H','Cursando','No pagado',3);
CALL insert_student('Alexis Guillermo','Gómez Puerto',-1,'H','Cursando','Pagado',4);
CALL insert_student('Luis Alberto','De la Cruz Guerrero',-1,'H','Cursando','No pagado',5);
CALL insert_student('Diego Alejandro','Macías Espejel',-1,'H','Egresado','Pagado',1);
CALL insert_student('Estefania','Valencia',-1,'M','Egresado','Pagado',2);
CALL insert_student('Maria','Mendoza Sanchez',-1,'M','Egresado','Pagado',3);
CALL insert_student('Cesar Eduardo','Gonzales Noriega',-1,'H','Egresado','Pagado',4);
CALL insert_student('Helio','Barriga Obregón',-1,'H','Cursando','No Pagado',5);

-- Cursos

CALL insert_course('2732', 'Redes 1', 'Materia redes 1', '1', '1', '2023-01-12', '2023-08-12');
CALL insert_course('1278', 'Redes 2', 'Materia redes 2', '2', '2', '2023-01-12', '2023-08-12');
CALL insert_course('4578', 'Matemáticas Computacionales', 'Materia Matemáticas Computacionales', '3', '3', '2023-01-12', '2023-08-12');
CALL insert_course('1223', 'Teoría de la computación', 'Materia Teoría de la computación', '4', '4', '2023-01-12', '2023-08-12');
CALL insert_course('2334', 'Desarrollo Humano', 'Materia Desarrollo Humano', '5', '5', '2023-01-12', '2023-08-12');
CALL insert_course('3221', 'Diseño de Software', 'Materia Diseño de Software', '5', '6', '2023-01-12', '2023-08-12');
CALL insert_course('4556', 'Node.js', 'Curso NodeJs', '4', '7', '2023-01-12', '2023-08-12');
CALL insert_course('7889', 'React Native', 'Curso React Native', '3', '8', '2023-01-12', '2023-08-12');
CALL insert_course('9663', 'Bases de Datos', 'Materia Bases de datos', '2', '9', '2023-01-12', '2023-08-12');
CALL insert_course('1256', 'Inteligencia Artificial', 'Materia Inteligencia Artificial', '1', '10', '2023-01-12', '2023-08-12');

-- Calificaciones

INSERT INTO grades (grade, evaluation_date, evaluation_type, course_id, student_id) VALUES (90, '2023-02-01', 'Examen parcial', 1, 1);
INSERT INTO grades (grade, evaluation_date, evaluation_type, course_id, student_id) VALUES (85, '2023-03-01', 'Examen final', 1, 1);
INSERT INTO grades (grade, evaluation_date, evaluation_type, course_id, student_id) VALUES (80, '2023-02-01', 'Examen parcial', 2, 1);
INSERT INTO grades (grade, evaluation_date, evaluation_type, course_id, student_id) VALUES (75, '2023-03-01', 'Examen final', 2, 1);
INSERT INTO grades (grade, evaluation_date, evaluation_type, course_id, student_id) VALUES (70, '2023-02-01', 'Examen parcial', 3, 1);
INSERT INTO grades (grade, evaluation_date, evaluation_type, course_id, student_id) VALUES (65, '2023-03-01', 'Examen final', 3, 1);

-- Otros inserts para estudiantes
INSERT INTO grades (grade, evaluation_date, evaluation_type, course_id, student_id) VALUES (95, '2023-02-01', 'Examen parcial', 1, 2);
INSERT INTO grades (grade, evaluation_date, evaluation_type, course_id, student_id) VALUES (92, '2023-03-01', 'Examen final', 1, 2);
INSERT INTO grades (grade, evaluation_date, evaluation_type, course_id, student_id) VALUES (85, '2023-02-01', 'Examen parcial', 2, 2);
INSERT INTO grades (grade, evaluation_date, evaluation_type, course_id, student_id) VALUES (80, '2023-03-01', 'Examen final', 2, 2);
INSERT INTO grades (grade, evaluation_date, evaluation_type, course_id, student_id) VALUES (90, '2023-02-01', 'Examen parcial', 3, 2);
INSERT INTO grades (grade, evaluation_date, evaluation_type, course_id, student_id) VALUES (85, '2023-03-01', 'Examen final', 3, 2);

-- Otros inserts para estudiantes
INSERT INTO grades (grade, evaluation_date, evaluation_type, course_id, student_id) VALUES (50, '2023-02-01', 'Examen parcial', 1, 1);
INSERT INTO grades (grade, evaluation_date, evaluation_type, course_id, student_id) VALUES (92, '2023-03-01', 'Examen final', 1, 2);
INSERT INTO grades (grade, evaluation_date, evaluation_type, course_id, student_id) VALUES (85, '2023-02-01', 'Examen parcial', 2, 3);
INSERT INTO grades (grade, evaluation_date, evaluation_type, course_id, student_id) VALUES (80, '2023-03-01', 'Examen final', 2, 4);
INSERT INTO grades (grade, evaluation_date, evaluation_type, course_id, student_id) VALUES (90, '2023-02-01', 'Examen parcial', 3, 5);
INSERT INTO grades (grade, evaluation_date, evaluation_type, course_id, student_id) VALUES (85, '2023-03-01', 'Examen final', 3, 6);


-- Otros inserts para estudiantes
INSERT INTO grades (grade, evaluation_date, evaluation_type, course_id, student_id) VALUES (100, '2023-02-01', 'Examen parcial', 1, 7);
INSERT INTO grades (grade, evaluation_date, evaluation_type, course_id, student_id) VALUES (92, '2023-03-01', 'Examen final', 1, 8);
INSERT INTO grades (grade, evaluation_date, evaluation_type, course_id, student_id) VALUES (85, '2023-02-01', 'Examen parcial', 2, 9);
INSERT INTO grades (grade, evaluation_date, evaluation_type, course_id, student_id) VALUES (80, '2023-03-01', 'Examen final', 2, 10);
INSERT INTO grades (grade, evaluation_date, evaluation_type, course_id, student_id) VALUES (90, '2023-02-01', 'Examen parcial', 3, 1);
INSERT INTO grades (grade, evaluation_date, evaluation_type, course_id, student_id) VALUES (85, '2023-03-01', 'Examen final', 3, 2);






-- Testeo apartir de aqui abajo

select
    c.course_title,
    c.course_code,
    g.grade
from
	students s
left join grades g on s.student_id = g.student_id 
left join courses c on g.course_id = c.course_id;

