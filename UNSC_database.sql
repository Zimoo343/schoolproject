-- =================== CREANDO TABLAS ===================

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

-- Tabla `users`

DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `user_id` int(8) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `user_password` varchar(16) COLLATE utf8_unicode_ci DEFAULT NULL,
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

-- =================== CREANDO PROCEDIMIENTOS ALMACENADOS ===================

-- Funcion `insert_employee`

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
END;

-- Funcion `insert_student`

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
END;

-- Funcion `insert_user`

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
END;

-- Trigger `after_insert_employee_create_user`
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
END;


-- =================== INSERTANDO DATOS ===================

-- Roles

INSERT INTO `roles` (`role_name`) VALUES ('superuser');
INSERT INTO `roles` (`role_name`) VALUES ('admin');
INSERT INTO `roles` (`role_name`) VALUES ('basic');

-- Grupos

INSERT INTO .`groups` (`group_name`, `group_code`) VALUES ('Grupo 1', 'G01');
INSERT INTO .`groups` (`group_name`, `group_code`) VALUES ('Grupo 2', 'G02');
INSERT INTO .`groups` (`group_name`, `group_code`) VALUES ('Grupo 3', 'G03');
INSERT INTO .`groups` (`group_name`, `group_code`) VALUES ('Grupo 4', 'G04');
INSERT INTO .`groups` (`group_name`, `group_code`) VALUES ('Grupo 5', 'G05');
INSERT INTO .`groups` (`group_name`, `group_code`) VALUES ('Grupo 6', 'G06');
INSERT INTO .`groups` (`group_name`, `group_code`) VALUES ('Grupo 7', 'G07');
INSERT INTO .`groups` (`group_name`, `group_code`) VALUES ('Grupo 8', 'G08');
INSERT INTO .`groups` (`group_name`, `group_code`) VALUES ('Grupo 9', 'G09');
INSERT INTO .`groups` (`group_name`, `group_code`) VALUES ('Grupo 10', 'G10');

-- Empleados

CALL insert_employee('Chris', 'Evans', 'Docente', 'H', 9600);
CALL insert_employee('Robert', 'Downey', 'Sistemas', 'H', 10700);
CALL insert_employee('Charlie', 'Murphy', 'Docente', 'M', 10700);
CALL insert_employee('Ryan', 'Reynolds', 'Directivo', 'H', 14800);
CALL insert_employee('Ben', 'Afleck', 'Administrativo', 'H', 8600);
CALL insert_employee('Matthew', 'Mcconaughey', 'Administrativo', 'H', 10200);
CALL insert_employee('Tom', 'Hiddleston', 'Docente', 'H', 9400);
CALL insert_employee('Emma', 'Stone', 'Directivo', 'M', 14800);
CALL insert_employee('Chris', 'Pratt', 'Administrativo', 'H', 10600);
CALL insert_employee('Pablo', 'Schreiber', 'Directivo', 'H', 14800);

-- Estudiantes

CALL insert_student('Luis Gerardo','Tinoco Coronel',100,'H','Cursando','Pagado',1);
CALL insert_student('David','Ruiz Lara',80,'H','Cursando','Pagado',1);
CALL insert_student('Miguel Angel','Ramirez Cruz',90,'H','Cursando','No pagado',1);
CALL insert_student('Alexis Guillermo','Gómez Puerto',75,'H','Cursando','Pagado',1);
CALL insert_student('Luis Alberto','De la Cruz Guerrero',85,'H','Cursando','No pagado',1);
CALL insert_student('Diego Alejandro','Macías Espejel',70,'H','Egresado','Pagado',1);
CALL insert_student('Estefania','Valencia',90,'M','Egresado','Pagado',1);
CALL insert_student('Maria','Mendoza Sanchez',-1,'M','Egresado','Pagado',1);
CALL insert_student('Cesar Eduardo','Gonzales Noriega',80,'H','Egresado','Pagado',2);
CALL insert_student('Helio','Barriga Obregón',-1,'H','Cursando','No Pagado',2);