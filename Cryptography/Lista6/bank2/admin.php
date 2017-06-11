<!DOCTYPE html>
<html>
<body>
<h1>Okno logowania admina</h1> <br>
<form action="./admintry.php" id="form1" method='post'>
Login:<br>
<input type="text" name="admin">
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

</body>
</html>

