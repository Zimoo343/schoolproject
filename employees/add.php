
<?php

require '../database.php';

$message = '';

if (!empty($_POST['employee_firstName']) && !empty($_POST['employee_lastName']) && !empty($_POST['employee_dept']) && !empty($_POST['employee_genre']) && !empty($_POST['employee_salary'])) { //En el post va el atributo del form
    $sql = "INSERT INTO employees (employee_firstName, employee_lastName, employee_dept, employee_genre, employee_salary) VALUES (:first_name, :last_name, :dept, :genre, :salary)"; //Nombres de variables para pasarle los datos
    $stmt = $conn->prepare($sql);
    $stmt->bindParam(':first_name', $_POST['employee_firstName']); //variable vinculada con un parametro
    $stmt->bindParam(':last_name', $_POST['employee_lastName']);
    $stmt->bindParam( ':dept', $_POST['employee_dept']);
    $stmt->bindParam( ':genre', $_POST['employee_genre']);
    $stmt->bindParam( ':salary', $_POST['employee_salary']);

    if ($stmt->execute()) {
        $message = 'Se ha añadido un empleado';
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
    
    <h1>Agregar Empleado</h1>

    <form action= "add.php" method="POST" autocomplete="off">
    <input type="text" name = "employee_firstName" placeholder="Nombre" required>
    <input type="text" name = "employee_lastName" placeholder="Apellido" required>
    
    <div class="custom_select">
        <select name="employee_dept" id="select_label" >
            <option value="Docente" id='Docente'>Docente</option>
            <option value="Administrativo" id='Administrativo'>Administrativo</option>
            <option value="Directivo" id='Directivo'>Directivo</option>
            <option value="Sistemas" id='Sistemas'>Sistemas</option>
            <option value="Intendencia" id='Intendencia'>Intendencia</option>
        </select>
    </div>

    <div class="custom_select">
        <select name="employee_genre" id="select_label" >
            <option value="H" id='Hombre'>Hombre</option>
            <option value="M" id='Mujer'>Mujer</option>
        </select>
    </div>
    <input type="number" name = "employee_salary" placeholder="Salario" min=1 max=999999 required>
    <input type="submit" name= "" value="Enviar">
    </form>

</body>
</html>