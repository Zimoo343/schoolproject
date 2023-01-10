<?php 
    require '../database.php';
    $mysqli = new mysqli("localhost", "root", "", "unsc_database");

    if(isset($_GET['employee_id'])) {
        $employee_id = $_GET['employee_id']; 
        $result = $mysqli->query("SELECT * FROM employees WHERE employee_id = $employee_id");

        if(mysqli_num_rows($result) == 1) {
            $row = mysqli_fetch_array($result);
            $first_name = $row['employee_firstName'];
            $last_name = $row['employee_lastName'];
            $dept = $row['employee_dept'];
            $genre = $row['employee_genre'];
            $salary = $row['employee_salary'];

        }

    }

    if(isset($_POST['update'])) {
        $query = "UPDATE employees SET employee_firstName = :first_name, employee_lastName = :last_name, employee_dept = :dept, employee_genre = :genre, employee_salary = :salary WHERE employee_id = :id";
        $stmt = $conn->prepare($query);
        $stmt->bindParam(':id', $_GET['employee_id']);
        $stmt->bindParam(':first_name', $_POST['employee_firstName']); //variable vinculada con un parametro
        $stmt->bindParam(':last_name', $_POST['employee_lastName']);
        $stmt->bindParam(':dept', $_POST['employee_dept']);
        $stmt->bindParam(':genre', $_POST['employee_genre']);
        $stmt->bindParam(':salary', $_POST['employee_salary']);

        if ($stmt->execute()) {
            header("Location: /UNSC_database/employees/employees.php");
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
    <title>Editar Empleado</title>
</head>
<body>  
        <?php require '../partials/header.php'?>

        <h1>Editar Empleado</h1>
        <form action= "edit.php?employee_id=<?php echo $_GET['employee_id']?>" method="POST" autocomplete="off">
        <input type="text" name = "employee_firstName" placeholder="Nombre" value="<?php echo $first_name; ?>" required>
        <input type="text" name = "employee_lastName" placeholder="Apellido" value="<?php echo $last_name; ?>" required>
        
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

        <input type="number" name = "employee_salary" placeholder="Salario" value="<?php echo $salary; ?>" min=1 max=999999 required>
        <input type="submit" name= "update" value="Actualizar">
        </form>
</body>
</html>