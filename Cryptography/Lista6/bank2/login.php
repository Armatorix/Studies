<!DOCTYPE html>
<html>
<body>
<h1>Okno logowania</h1> <br>
<form action="./logtry.php" id="form1" method='post'>
Login:<br>
<input type="text" name="user">
<br>
Hasło:<br>
<input type="password" name="pswrd">
</form>
<br><button type="submit" form="form1" value="Submit">Zaloguj</button><br>
<?php 
session_start();
if (isset($_SESSION["error"])) {
	echo($_SESSION["error"]);
	unset($_SESSION["error"]);
}
if (isset($_SESSION["accept"])) {
	echo($_SESSION["accept"]);
	unset($_SESSION["accept"]);
}
?>
<br><br><br> <a href="./register.php">Zarejstruj się</a>

</body>
</html>

