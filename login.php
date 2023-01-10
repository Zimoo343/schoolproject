<?php
  session_start();

  if(isset($_SESSION['user_id'])) {
    header('Location: /UNSC_database/home.php');
  }
  require 'database.php';

  if (!empty($_POST['user_name']) && !empty($_POST['user_password'])) {
    $records = $conn->prepare('SELECT user_id, user_name, user_password FROM users WHERE user_name = :user_name');
    $records->bindParam(':user_name', $_POST['user_name']);
    $records->execute();
    $results = $records->fetch(PDO::FETCH_ASSOC);

    $message = '';
    
      if (is_countable($results) > 0 && ($_POST['user_password'] == $results['user_password'])) {
        $_SESSION['user_id'] = $results['user_id'];
        header("Location: /UNSC_database/home.php");
      } 
      else {
        $message = 'La credenciales no coinciden';
      } 
  }
?>

<?php
    include 'header.php';
?>
      <header>
      <a href="/UNSC_database/">Inicio</a>
      </header>

        <img src ="assets/imgs/unsc_logo.png" width = "200">
        <h3>Iniciar</h3>

        <?php if(!empty($message)): ?>
          <p><?= $message ?></p>
        <?php endif;?>

        <form action= "login.php" method="POST" autocomplete="off">
          <input type="text" name = "user_name" placeholder="Usuario" required>
          <input type="password" name = "user_password" placeholder="Contraseña" required>
          <input type="submit" value="Enviar">
        </form>

  </body>
</html>