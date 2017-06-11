<?php
if(!((isset($_POST["admin"])&&isset($_POST["pswrd"])))) {
	header("Location: ./admin.php");
	exit();
}

$adminLogin = $_POST["admin"];
$adminPassword= $_POST["pswrd"];
require_once("db.php");
session_start();

if(myadminlog($adminLogin,$adminPassword)) {
	$_SESSION["admin"] = $adminLogin;
	header("Location: ./accepter.php");
	exit();
}
else {
	$_SESSION["error"] = "Nie można zalogować, zły login lub hasło.";
	header("Location: ./admin.php");
}

?>
