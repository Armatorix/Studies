#!/bin/bash

if [ "$#" -ne 7 ]; then
    echo "$0   [e/d]   [AES]   [CBC/CTR/GCM]   [śnieżka_do_keystora]   [id_klucza]   [plik_do_(za/od)kodowania]   [plik_wyjściowy]
    
    
[e/d] - szyfrowanie/deszyfrowanie
[AES] - rodzaj szyfrowania
[CBC/CTR/GCM] - tryb szyfrowania/deszyfrowania"
    exit -1
fi
echo "Podaj haslo do keystora:"
read -s keystore_password

iv=4FC92C2873672E20FB123A0BCB22B4AC

if [ $1 = "e" ]
then
keytool -genkeypair -alias $5 -keyalg RSA -keystore $4 -storepass $keystore_password -dname "CN=wojciech, OU=ppt, O=pwr, L=wroc, S=lwrsls,C=PL" -keypass $keystore_password 2>> error 1>> error
fi
key=$(keytool -export -alias $5 -keystore $4 -storepass $keystore_password 2>> error | xxd -c 32 -ps | head -n 1)
cat error
PATTERN="password"
FILE=error
if grep -q $PATTERN $FILE;
then
	echo "Błędne hasło do keystora"
	rm error
	exit -1
	
fi
rm error
openssl $2-256-$3 -$1 -base64 -K $key -iv $iv <$6 >$7 2>> error
if [ -s error  ] 
then	
	echo "Błędne hasło do pliku, bądź złe id klucza"
	rm error $7
	exit -1
	
fi
rm error
