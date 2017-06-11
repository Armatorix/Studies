<?php
session_start();
if(!(isset($_SESSION["login"]))) {
	header("Location: ./login.php");
	exit();
}
?>
<html>
<body>
<h1>Konto</h1> <br>
<br> <a href="./form.php">Formularz do przelewu</a>
<br> <a href="./history.php">Historia</a>

<br><br><br> <a href="./logout.php">Wyloguj</a>

</body>
</html>