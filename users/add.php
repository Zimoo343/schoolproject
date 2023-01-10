
<?php

require '../database.php';

$message = '';

if (!empty($_POST['user_name']) && !empty($_POST['user_password'])) { //En el post va el atributo del form
    $sql = "INSERT INTO users ( user_name, user_password) VALUES (:name, :password)"; //Nombres de variables para pasarle los datos
    $stmt = $conn->prepare($sql);
    $stmt->bindParam(':name', $_POST['user_name']); //variable vinculada con un parametro
    $stmt->bindParam(':password', $_POST['user_password']);

    if ($stmt->execute()) {
        $message = 'Se ha añadido un administrador';
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
    
    <h1>Agregar Administrador</h1>

    <form action= "add.php" method="POST" autocomplete="off">
    <input type="text" name = "user_name" placeholder="Usuario" required>
    <input type="password" name = "user_password" placeholder="Contraseña" required>
    <input type="submit" name= "" value="Enviar">

</body>
</html>