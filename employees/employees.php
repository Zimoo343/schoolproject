<?php
    require '../database.php';
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
    <link rel="stylesheet" href="../assets/styles/styles.css">
    <link rel="icon" href="../assets/imgs/unsc_logo.ico">
    <img class="home_logo" src ="../assets/imgs/unsc_logo.png">  
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.3.4/jspdf.debug.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.3.4/jspdf.min.js"></script>
    <title>Home</title>
</head>
<body id="body">

    <?php require '../partials/header.php'?>
    
    <?php if(!empty($user)): ?>
        <div class="title">
            <h1>Empleados <i class="fa-solid fa-user-tie"></i></h1>
        </div>
        <?php endif; ?>
        
    
    
    

    <form action="employees.php" method="GET" class="search" autocomplete="off">
        <input type="search" name="search" placeholder="Buscar"></input>
        <input type="submit" value="Buscar"></input>
        <a class = "log" href="add.php"><input type="button" value="Agregar" href="add.php"></input> </a>
        <a class="pdf" id="pdf" href="javascript:generatePDF()"><input type="button" value="Reporte"></input></a>
        <a class = "log" href="../logout.php"><input type="button" value="Salir" href="../logout.php"></input></a>
    </form>
    <div class="tableView">
        <table class="employee_table">
            <thead>
                <tr>
                <th>ID</th>
                <th>Nombre</th>
                <th>Apellido</th>
                <th>Departamento</th>
                <th>G??nero</th>
                <th>Salario</th>
                <th>Acciones</th>
                </tr>
            </thead>
            <tbody>
                <?php 
                $search = isset($_REQUEST['search']) ? strtolower($_REQUEST['search']) : "";

                $q = $search
                    ? "SELECT * FROM employees WHERE employee_id LIKE '%$search%' OR employee_firstName LIKE '%$search%' OR employee_lastName LIKE '%$search%'"
                    : "SELECT * FROM employees";
                $employee_result = $mysqli->query($q);
                while($row = mysqli_fetch_array($employee_result)) { ?>
                    <tr>
                        <td><?php echo $row['employee_id'] ?></td>
                        <td><?php echo $row['employee_firstName'] ?></td>
                        <td><?php echo $row['employee_lastName'] ?></td>
                        <td><?php echo $row['employee_dept'] ?></td>
                        <td><?php echo $row['employee_genre'] ?></td>
                        <td> $ <?php echo $row['employee_salary'] ?></td>
                        <td>
                            <a href="edit.php?employee_id=<?php echo $row['employee_id']?>"><i id="editIcon" class="fa-solid fa-pen-to-square"></i></a>
                            <a href="delete.php?employee_id=<?php echo $row['employee_id']?>"><i id="trashIcon" class="fa-solid fa-trash-can"></i></a>
                        </td>
                    </tr>
                <?php } ?>
            </tbody>
        </table>
    </div>
    
    <script>
        async function generatePDF() {
            document.getElementById("pdf").innerHTML;

            //Downloading
            var downloading = document.getElementById("body");
            var doc = new jsPDF('l', 'pt');

            await html2canvas(downloading, {
                //allowTaint: true,
                //useCORS: true,
                width: 530
            }).then((canvas) => {
                //Canvas (convert to PNG)
                doc.addImage(canvas.toDataURL("image/png"), 'PNG', 50, 50, 800, 400);
            })

            doc.save("ReporteEmployees.pdf");

        }

    </script>

</body>
</html>