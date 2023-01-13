<?php 
    require '../database.php';
    $mysqli = new mysqli("localhost", "root", "", "unsc_database");

    if(isset($_GET['student_id'])) {
        $student_id = $_GET['student_id']; 
        $result = $mysqli->query("SELECT * FROM students WHERE student_id = $student_id");

        if(mysqli_num_rows($result) == 1) {
            $row = mysqli_fetch_array($result);
            $first_name = $row['student_firstName'];
            $last_name = $row['student_lastName'];
            $note = $row['student_note'];
            $group = $row['student_group_id'];
            $genre = $row['student_genre'];
            $payment = $row['student_payment'];

        }

    }

    if(isset($_POST['update'])) {
        $query = "UPDATE students SET student_firstName = :first_name, student_lastName = :last_name, student_note = :note, student_group_id = :group, student_genre = :genre, student_state = :state,  student_payment = :payment WHERE student_id = :id";
        $stmt = $conn->prepare($query);
        $stmt->bindParam(':id', $_GET['student_id']);
        $stmt->bindParam(':first_name', $_POST['student_firstName']); //variable vinculada con un parametro
        $stmt->bindParam(':last_name', $_POST['student_lastName']);
        $stmt->bindParam(':note', $_POST['student_note']);
        $stmt->bindParam(':group', $_POST['student_group_id']);
        $stmt->bindParam(':genre', $_POST['student_genre']);
        $stmt->bindParam(':state', $_POST['student_state']);
        $stmt->bindParam(':payment', $_POST['student_payment']);

        if ($stmt->execute()) {
            header("Location: /UNSC_database/students/students.php");
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
    <title>Editar Estudiante</title>
</head>
<body>  
        <?php require '../partials/header.php'?>

        <h1>Editar Estudiante</h1>
        <form action= "edit.php?student_id=<?php echo $_GET['student_id']?>" method="POST" autocomplete="off">
            <input type="text" name = "student_firstName" placeholder="Nombre" value="<?php echo $first_name; ?>" required>
            <input type="text" name = "student_lastName" placeholder="Apellido" value="<?php echo $last_name; ?>" required>
            <input type="number" name = "student_note" placeholder="Calificación" value="<?php echo $note; ?>" min=-1 max=100 required>
            <input type="number" name = "student_group_id" placeholder="Grupo" value="<?php echo $group; ?>" min=1 max=10 required>

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
                <select name="student_payment" id="select_label" >
                    <option value="No pagado" id='No pagado'>No pagado</option>
                    <option value="Pagado" id='Pagado'>Pagado</option>
                </select>
            </div>
            <input type="submit" name="update" value="Actualizar">
        </form>
</body>
</html>