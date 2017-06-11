<?php
$url = 'http://localhost/bank2/accept.php';
$ch = curl_init();

curl_setopt($ch, CURLOPT_URL,$url);
curl_setopt($ch, CURLOPT_POST, 1);

 curl_setopt($ch, CURLOPT_POSTFIELDS, ['toAccId'=>'3']);

curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);

$server_output = curl_exec ($ch);

curl_close ($ch);

?>