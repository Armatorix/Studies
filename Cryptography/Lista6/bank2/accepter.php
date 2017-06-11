<?php
session_start();
if(!(isset($_SESSION["admin"]))) {
	header("Location: ./admin.php");
	exit();
}
?>
<html>
<body>
<h1>Do zaakceptowania</h1> <br>
<?php
require_once("db.php");
echo toAccept();
?>
<br><br><br> <a href="./logoutadmin.php">Wyloguj</a>
</body>
</html>
