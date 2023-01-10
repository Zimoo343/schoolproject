<?php
    require 'database.php';
    session_start();

    $mysqli = new mysqli("localhost", "root", "", "unsc_database");

    
    

    if (isset($_SESSION['user_id'])) {
        $records = $conn->prepare('SELECT user_id, user_name, user_password FROM users WHERE user_id = :id');
        $records->bindParam(':id', $_SESSION['user_id']);
        $records->execute(); 
        $results = $records->fetch(PDO::FETCH_ASSOC);

        $user = null;
        if(is_countable($results) > 0) {
            $user = $results;
        }
    }
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <script src="https://kit.fontawesome.com/2385ce6cbc.js" crossorigin="anonymous"></script>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="assets/styles/styles.css">
    <link rel="icon" href="assets/imgs/unsc_logo.ico">  
    <title>Home</title>
</head>
<body>
    <header>

    </header>
    
    <?php if(!empty($user)): ?>
        <h1>Hola, Bienvenido a</h1>
        <?php endif; ?>
        
        <img src ="assets/imgs/unsc_logo.png" width = "250">
        <h1>UNSC Database</h1>

        <a href="students/students.php"><input type="button" value="Estudiantes"></input></a>
        <a href="employees/employees.php"><input type="button" value="Empleados"></input></a>
        <a href="users/users.php"><input type="button" value="Admins"></input></a>
        <a href="logout.php"><input type="button" value="Salir"></input></a></i>
</body>
</html>