
<?php

require '../database.php';

$message = '';

if (!empty($_POST['course_code']) && !empty($_POST['course_title']) && !empty($_POST['course_description']) && !empty($_POST['course_employee_id']) && !empty($_POST['course_group_id' ]) && !empty($_POST['start_date' ]) && !empty($_POST['end_date' ])) { //En el post va el atributo del form
    $sql = "INSERT INTO courses (course_code, course_title, course_description, course_employee_id, course_group_id, start_date, end_date) VALUES (:code, :name, :desc, :employee_id, :group_id, :start, :end)"; //Nombres de variables para pasarle los datos
    $stmt = $conn->prepare($sql);
    $stmt->bindParam(':code', $_POST['course_code']); //variable vinculada con un parametro
    $stmt->bindParam(':name', $_POST['course_title']);
    $stmt->bindParam(':desc', $_POST['course_description']);
    $stmt->bindParam(':employee_id', $_POST['course_employee_id']);
    $stmt->bindParam(':group_id', $_POST['course_group_id']);
    $stmt->bindParam(':start', $_POST['start_date']);
    $stmt->bindParam(':end', $_POST['end_date']);

    if ($stmt->execute()) {
        $message = 'Se ha añadido un curso';
    } else {
        $message = 'Ha ocurrido un error'; 
    }
} 


?>

<!DOCTYPE html>
<html>
<head>
<script src="https://kit.fontawesome.com/2385ce6cbc.js" crossorigin="anonymous"></script>
<meta charset="utf-8">
<title>UNSC Base de datos</title>
<link rel="stylesheet" href="../assets/styles/styles.css">
<link rel="icon" href="../assets/imgs/unsc_logo.ico">
</head>
<body>
    <?php require '../partials/header.php'?>

    <?php if(!empty($message)): ?>
    <p> <?= $message ?></p>
    <?php endif; ?>
    
    <h1>Agregar Curso</h1>

    <form action= "add.php" method="POST" autocomplete="off">
    <input type="text" name = "course_code" placeholder="Código" required>
    <input type="text" name = "course_title" placeholder="Nombre" required>
    <input type="text" name = "course_description" placeholder="Descripción" required>
    <input type="number" name = "course_employee_id" placeholder="Docente" min=1 max=9999 required>
    <input type="number" name = "course_group_id" placeholder="Grupo" min=1 max=9999 required>
    <label for="start">Fecha Inicio</label>
    <input type="date" id="start" name="start_date"
        value="2023-07-22"
        min="2023-01-01" max="9999-12-31" required>
    <label for="start">Fecha Término</label>
    <input type="date" id="start" name="end_date"
        value="2023-07-22"
        min="2023-01-01" max="9999-12-31" required>

    <input type="submit" name= "" value="Enviar">
    </form>

</body>
</html>