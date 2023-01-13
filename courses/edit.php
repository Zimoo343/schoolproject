<?php 
    require '../database.php';
    $mysqli = new mysqli("localhost", "root", "", "unsc_database");

    if(isset($_GET['course_id'])) {
        $course_id = $_GET['course_id']; 
        $result = $mysqli->query("SELECT * FROM courses WHERE course_id = $course_id");

        if(mysqli_num_rows($result) == 1) {
            $row = mysqli_fetch_array($result);
            $code = $row['course_code'];
            $name = $row['course_title'];
            $desc = $row['course_description'];
            $employee_id = $row['course_employee_id'];
            $group_id = $row['course_group_id'];
            $start = $row['start_date'];
            $end = $row['end_date'];

        }

    }

    if(isset($_POST['update'])) {
        $query = "UPDATE courses SET course_code = :code, course_title = :name, course_description = :desc, course_employee_id = :employee_id, course_group_id = :group_id, start_date = :start, end_date = :end WHERE coursee_id = :id";
        $stmt = $conn->prepare($query);
        $stmt->bindParam(':id', $_GET['course_id']);
        $stmt->bindParam(':code', $_POST['course_code']); //variable vinculada con un parametro
        $stmt->bindParam(':name', $_POST['course_title']);
        $stmt->bindParam(':desc', $_POST['course_description']);
        $stmt->bindParam(':employee_id', $_POST['course_employee_id']);
        $stmt->bindParam(':group_id', $_POST['course_group_id']);
        $stmt->bindParam(':start', $_POST['start_date']);
        $stmt->bindParam(':end', $_POST['end_date']);

        if ($stmt->execute()) {
            header("Location: /UNSC_database/courses/courses.php");
        } else {
            $message = 'Ha ocurrido un error'; 
        }


    }
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <script src="https://kit.fontawesome.com/2385ce6cbc.js" crossorigin="anonymous"></script>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="../assets/styles/styles.css">
    <link rel="icon" href="../assets/imgs/unsc_logo.ico">
    <title>Editar Curso</title>
</head>
<body>  
        <?php require '../partials/header.php'?>

        <h1>Editar Curso</h1>
        <form action= "edit.php?course_id=<?php echo $_GET['course_id']?>" method="POST" autocomplete="off">
        <input type="text" name = "course_code" placeholder="Código" value="<?php echo $code; ?>" required>
        <input type="text" name = "course_title" placeholder="Nombre"  value="<?php echo $name; ?>" required>
        <input type="text" name = "course_description" placeholder="Descripción" value="<?php echo $desc; ?>" required>
        <input type="number" name = "course_employee_id" placeholder="Docente" value="<?php echo $employee_id; ?>" min=1 max=9999 required>
        <input type="number" name = "course_group_id" placeholder="Grupo" value="<?php echo $group_id; ?>" min=1 max=9999 required>
        <label for="start">Fecha Inicio</label>
        <input type="date" id="start" name="start_date"
        value="<?php echo $start; ?>"
        min="2023-01-01" max="9999-12-31"  required>
        <label for="start">Fecha Término</label>
        <input type="date" id="start" name="end_date"
        value="<?php echo $end; ?>"
            min="2023-01-01" max="9999-12-31"  required>

        <input type="submit" name= "" value="Actualizar">
        </form>
</body>
</html>