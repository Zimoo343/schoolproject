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
    <title>Home</title>
</head>
<body>

    <?php require '../partials/header.php'?>
    
    <?php if(!empty($user)): ?>
        <div class="title">
            <h1>Users <i class="fa-solid fa-unlock"></i></h1>
        </div>
        <?php endif; ?>
        
    
    
    

    <form action="search.php" method="GET" class="search">
        <a class = "log" href="add.php"><input type="button" value="Agregar" href="add.php"></input> </a>
        <a class = "log" href="../logout.php"><input type="button" value="Salir" href="../logout.php"></input></a>
    </form>
    <div class="tableView">
        <table class="users_table">
            <thead>
                <tr>
                <th>ID</th>
                <th>Usuario</th>
                <th>Acciones</th>
                </tr>
            </thead>
            <tbody>
            <?php 
                $users_result = $mysqli->query("SELECT * FROM users");
                while($row = mysqli_fetch_array($users_result)) { ?>
                    <tr>
                        <td><?php echo $row['user_id'] ?></td>
                        <td><?php echo $row['user_name'] ?></td>
                        <td>
                            <a href="delete.php?user_id=<?php echo $row['user_id']?>"><i id="trash-can" class="fa-solid fa-trash-can"></i></a>
                        </td>
                    </tr>
                <?php } ?>
            </tbody>
        </table>
    </div>
    
</body>
</html>