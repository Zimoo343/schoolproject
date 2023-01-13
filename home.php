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

    include 'header.php';
?>

    
    <?php if(!empty($user)): ?>
        <h1>Hola, Bienvenido a</h1>
        <?php endif; ?>
        
        <img src ="assets/imgs/unsc_logo.png" width = "250">
        <h1>UNSC Database</h1>

        <a href="students/students.php"><input type="button" value="Estudiantes"></input></a>
        <a href="employees/employees.php"><input type="button" value="Empleados"></input></a>
        <a href="courses/courses.php"><input type="button" value="Cursos"></input></a>
        <a href="users/users.php"><input type="button" value="Admins"></input></a>
        <a href="logout.php"><input type="button" value="Salir"></input></a></i>
</body>
</html>