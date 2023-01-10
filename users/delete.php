<?php
    require '../database.php';
    $mysqli = new mysqli("localhost", "root", "", "unsc_database");

    if(isset($_GET['user_id'])) {
        $id = $_GET['user_id'];
        $result = $mysqli->query("DELETE FROM users WHERE user_id = $id");

        if (!$result){
            die("Algo salio mal");
        }

        
        header("Location: /UNSC_database/users/users.php");
        

    }
?>