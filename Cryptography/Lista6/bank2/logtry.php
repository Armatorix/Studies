<?php
if(!(isset($_POST["user"])&&isset($_POST["pswrd"]))) {
	header("Location: ./login.php");
	exit();
}

	
$userLogin = $_POST["user"];
$userPassword= $_POST["pswrd"];
require_once("db.php");
session_start();
if(mylog($userLogin,$userPassword)) {
	$_SESSION["login"] = $userLogin;
	header("Location: ./account.php");
	exit();
}
else {
	$_SESSION["error"] = "Nie można zalogować, zły login lub hasło.";
	header("Location: ./login.php");
}

?>
