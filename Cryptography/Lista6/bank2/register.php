<!DOCTYPE html>
<html>
<body>
<h1>Okno rejstracji</h1> <br>
<form action="registertry.php" id="form1" method='post'>
Login<br>
<input type="text" name="user">
<br>
Hasło:<br>
<input type="password" name="pswrd">
</form>
<br><button type="submit" form="form1" value="Submit">Submit</button><br>
<?php 
session_start();
if (isset($_SESSION["error"])) {
	echo($_SESSION["error"]);
	unset($_SESSION["error"]);

}
?>
<br><br><br> <a href="./login.php">Zaloguj się</a>


</body>
</html>

