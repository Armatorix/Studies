<?php
session_start();
if(!(isset($_SESSION["login"]))) {
	header("Location: ./login.php");
	exit();
}
?>
<html>
<head>
<script src="./js/changer.js"></script>
	
</head>
<body>
<h1>Przelew</h1> <br>
<form action="./form_next.php" id="form1" method='post'>
Nazwa odbiorcy:<br>
<input type="text" name="user_name">
<br>
Na rachunek:<br>
<input type="number" name="user_account" id="acc_id">
<br>
Adres odbiorcy:<br>
<input type="text" name="user_address">
<br>
Tytuł przelewu:<br>
<input type="text" name="form_title">
<br>
Kwota w PLN:<br>
<input type="number" name="cash">
<br>
Data przelewu:<br>
<input type="date" name="date">
<br>
</form>
<br><button type="submit" form="form1" id="submit" name="sbmtBtn" value="Submit">Dalej</button><br>
<br><br><br> <a href="./account.php">Wróć</a>
</body>
</html>