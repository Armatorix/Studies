<?php
session_start();
if(!(isset($_POST["user_name"]))) {
	header("Location: ./form.php");
	exit();
}
require_once("db.php");
makeTranss($_SESSION["login"],$_POST["user_name"],$_POST["user_account"],$_POST["user_address"],$_POST["form_title"],$_POST["cash"],$_POST["date"]);
header("Location: ./account.php");
?>
