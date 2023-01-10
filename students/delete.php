<?php
    require '../database.php';
    $mysqli = new mysqli("localhost", "root", "", "unsc_database");

    if(isset($_GET['student_id'])) {
        $id = $_GET['student_id'];
        $result = $mysqli->query("DELETE FROM students WHERE student_id = $id");

        if (!$result){
            die("Algo salio mal");
        }

        
        header("Location: /UNSC_database/students/students.php");
        

    }
?>