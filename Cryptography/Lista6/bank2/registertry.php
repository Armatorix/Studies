<?php
if(!(isset($_POST["user"])&&isset($_POST["pswrd"]))) {
	header("Location: ./login.php");
	exit();
}

$login = $_POST["user"];
$password= $_POST["pswrd"];
require_once("db.php");
session_start();
if (isId($login)) {
	$_SESSION["accept"] = "Rejstracja zakończona prawidłowo.";
	register($login,$password);
	header("Location: ./login.php");
	exit();
}
else {
	$_SESSION["error"] = "Nie można zarejstrować,login już istnieje.";
	header("Location: ./register.php");
}

?>
