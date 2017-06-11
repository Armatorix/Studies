<?php
session_start();
if(!(isset($_SESSION["login"]))) {
	header("Location: ./login.php");
	exit();
}
?>
<html>
<body>
<h1>Historia</h1> <br>
<?php
require_once("db.php");
echo history($_SESSION["login"]);
?>
<br><br><br> <a href="./account.php">Wróć</a>
</body>
</html>