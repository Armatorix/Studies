<?php 
$servername = "localhost";
$dbusername = "root";
$dbpassword = "password";
$dbname = "krypto";
$conn = new mysqli($servername, $dbusername, $dbpassword, $dbname);
if ($conn->connect_error) {
	session_start();
    $_SESSION["error"]="Connection failed: ".$conn->connect_error;
	exit();
} 
function mylog($id, $pass) {
	global $conn;
	$query = "SELECT * FROM users WHERE login = '".code($id)."' AND password = '".code($pass)."'" ;
	$result = $conn->query($query);
	if (mysqli_num_rows($result) == 1) {
	return TRUE;
	} else {
	return FALSE;
	}
}

function myadminlog($id, $pass) {
	global $conn;
	$query = "SELECT * FROM admins WHERE login = '".$id."' AND password = '".$pass."'" ;
	$result = $conn->query($query);
	if (mysqli_num_rows($result) == 1) {
	return TRUE;
	} else {
	return FALSE;
	}
}

function isId($id) {
	$query = "SELECT * FROM users WHERE login= '".code($id)."'";
	global $conn;
	$result = $conn->query($query);
	if (mysqli_num_rows($result) == 1) {
	return FALSE;
	} else {
	return TRUE;
	}
}

function register ($id, $pass) {
	global $conn;
	$query = "INSERT INTO users (login,password) VALUES ('".code($id)."','".code($pass)."');" ;
	$conn->query($query);
}
function code ($pass){
	$salt = "5mb821ebeu8rnxy0ss3j";
	#return hash_pbkdf2("sha256",$pass,$salt,10000,34);
	return $pass;
}
function history ($id) {
	$query = "SELECT * FROM transactions WHERE executor='".code($id)."' AND accepted=1 ORDER BY date DESC";
	global $conn;
	$result = $conn->query($query);
	if (!mysqli_num_rows($result)) {
	return "Nie było żadnych przelewów.";
	exit();
	}
	else {
		$ret  = "";
		while($row = $result->fetch_assoc()) {
        $ret=$ret."Numer konta: " . $row["account_nr"]. 
		"</br>"."Nazwa: " . $row["user_name"]. "</br>".
		"Adres: " . $row["user_address"]. "</br>".
		"Tytuł przelewu: " . $row["title"]. "</br>".
		"Kwota: " . $row["cash"]. "</br>".
		"Data: " . $row["date"]. "</br></br></br>";
    }
	return $ret;
	}
}

function toAccept () {
	$query = "SELECT * FROM transactions WHERE accepted=0 ORDER BY date DESC";
	global $conn;
	$result = $conn->query($query);
	if (!mysqli_num_rows($result)) {
	return "Nie ma nic do zaakceptowania.</br></br><img src='https://pics.onsizzle.com/me-ive-done-nothing-productive-today-plus-i-have-two-7342895.png' width=30%>";
	exit();
	}
	else {
		$ret  = "";
		while($row = $result->fetch_assoc()) {
        $ret=$ret."Numer konta: " . $row["account_nr"]. 
		"</br>"."Nazwa: " . $row["user_name"]. "</br>".
		"Adres: " . $row["user_address"]. "</br>".
		"Tytuł przelewu: " . $row["title"]. "</br>".
		"Kwota: " . $row["cash"]. "</br>".
		"Data: " . $row["date"]. "</br>".acceptButton($row["id"])."</br></br></br>";
    }
	return $ret;
	}
}

function acceptButton($id) {
	return "<form action='accept.php' method='POST'>".
  "<button type='submit' name='toAccId'value='".$id."'>ACCEPT</button><br></form>";
}

function makeTranss($id,$name,$nr,$adrr,$tit,$cash,$date) {
	global $conn;
	$query = "INSERT INTO transactions (account_nr,cash,date,executor,title,user_address,user_name) VALUES ('".$nr."','".$cash."','".$date."','".code($id)."','".$tit."','".$adrr."','".$name."');" ;
	$conn->query($query);
}
function acceptTransaction($id) {
	global $conn;	
	$query ="UPDATE transactions SET accepted=1 WHERE id=".$id;
	$conn->query($query);
	
}
?>
