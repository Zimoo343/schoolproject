<?php
    require '../database.php';
    $mysqli = new mysqli("localhost", "root", "", "unsc_database");

    if(isset($_GET['employee_id'])) {
        $id = $_GET['employee_id'];
        $result = $mysqli->query("DELETE FROM employees WHERE employee_id = $id");

        if (!$result){
            die("Algo salio mal");
        }

        
        header("Location: /UNSC_database/employees/employees.php");
        

    }
?>