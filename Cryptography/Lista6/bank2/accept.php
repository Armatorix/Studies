<?php
session_start();
if(!(isset($_SESSION["admin"]))) {
	header("Location: ./admin.php");
	exit();
}
if(!((isset($_POST["toAccId"])))) {
	header("Location: ./admin.php");
	exit();
}
$toAcc = $_POST["toAccId"];
require_once 'db.php';
acceptTransaction($toAcc);
header("Location: ./accepter.php");
?>