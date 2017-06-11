<?php
session_start();
if(!(isset($_SESSION["login"]))) {
	header("Location: ./login.php");
	exit();
}
if(!(isset($_POST["cash"]))) {
	header("Location: ./form.php");
	exit();
}
?>
<html>
<head>
<script src="./js/changer.js"></script>
</head>
<body>
<h1>Przelew- potwierdzenie</h1> <br>
<?php
echo "<form action='./make_transs.php' id='form1' method='post'>
Nazwa odbiorcy:<br>
<input type='text' name='user_name' value='".$_POST["user_name"]."' readonly>
<br>
Na rachunek:<br>
<input type='number' name='user_account' value='".$_POST["user_account"]."' id='acc_id' readonly>
<br>
Adres odbiorcy:<br>
<input type='text' name='user_address' value='".$_POST["user_address"]."' readonly>
<br>
Tytuł przelewu:<br>
<input type='text' name='form_title' value='".$_POST["form_title"]."' readonly>
<br>
Kwota w PLN:<br>
<input type='number' name='cash' value='".$_POST["cash"]."' readonly>
<br>
Data przelewu:<br>
<input type='date' name='date' value='".$_POST["date"]."' readonly>
<br>
</form>
<br><button type='submit' form='form1' id='submit' value='Submit'>Przelej hasjy</button><br>
<br><br><br> <a href='./account.php'>Wróć</a>
</body>
</html>";
?>
