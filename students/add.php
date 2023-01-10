
<?php

require '../database.php';

$message = '';

if (!empty($_POST['student_firstName']) && !empty($_POST['student_lastName']) && !empty($_POST['student_note']) && !empty($_POST['student_group']) && !empty($_POST['student_genre']) && !empty($_POST['student_state']) && !empty($_POST['student_payment'])) { //En el post va el atributo del form
    $sql = "INSERT INTO students (student_firstName, student_lastName,  student_note, student_group, student_genre, student_state,  student_payment) VALUES (:first_name, :last_name, :note, :group, :genre, :state, :payment)"; //Nombres de variables para pasarle los datos
    $stmt = $conn->prepare($sql);
    $stmt->bindParam(':first_name', $_POST['student_firstName']); //variable vinculada con un parametro
    $stmt->bindParam(':last_name', $_POST['student_lastName']);
    $stmt->bindParam(':note', $_POST['student_note']);
    $stmt->bindParam(':group', $_POST['student_group']);
    $stmt->bindParam(':genre', $_POST['student_genre']);
    $stmt->bindParam(':state', $_POST['student_state']);
    $stmt->bindParam(':payment', $_POST['student_payment']);

    if ($stmt->execute()) {
        $message = 'Se ha añadido un estudiante';
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
    
    <h1>Agregar Estudiante</h1>

    <form action="add.php" method="POST" autocomplete="off">
    <input type="text" name="student_firstName" placeholder="Nombre" required>
    <input type="text" name="student_lastName" placeholder="Apellido" required>
    <input type="number" name="student_note" placeholder="Calificación" min=1 max=100 required>
    <input type="text" name="student_group" placeholder="Grupo" required>
    
    <div class="custom_select">
        <select name="student_genre" id="select_label" >
            <option value="H" id='Hombre'>Hombre</option>
            <option value="M" id='Mujer'>Mujer</option>
        </select>
    </div>

    <div class="custom_select">
        <select name="student_state" id="select_label" >
            <option value="Cursando" id='Cursando'>Cursando</option>
            <option value="Egresado" id='Egresado'>Egresado</option>
        </select>
    </div>
    
    <div class="custom_select">
        <select name="student_payment" id="select_label">
            <option value="No pagado" id='No pagado'>No pagado</option>
            <option value="Pagado" id='Pagado'>Pagado</option>
            
        </select>
    </div>
    <input type="submit" name="submit" value="Enviar">
</body>
</html>