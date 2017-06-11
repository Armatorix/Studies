#!/bin/bash

iv=CFCA2C3873273E20FA123A02CB22B2AC
key=df3ffcd325a329e4908a8a64132ca5b2173e4c8102468b5bf78833af54c77882

if [ "$#" -ne 2 ]; then
    echo "$0 [e/d] [nazwa_piosenki]
[e/d]-kodowanie/dekodowanie
"
    exit -1
fi
echo "Podaj PIN:"
read -s pin

if [ ! -s player.config ]
then
	echo $pin | cat >> player.config.temp
	
	echo "Ścieżka do keysora:"
	read keystore_src
	echo $keystore_src | cat >> player.config.temp
	
	echo "Id klucza:"
	read key_id
	echo $key_id | cat >> player.config.temp
	
	echo "Hasło:"
	read -s password
	echo $password | cat >> player.config.temp
	
	openssl AES-256-CBC -e -base64 -K $key -iv $iv <player.config.temp >player.config
	rm player.config.temp
else
	openssl AES-256-CBC -d -base64 -K $key -iv $iv <player.config >player.config.temp
	lpin=$(sed '1q;d' player.config.temp)
	keystore_src=$(sed '2q;d' player.config.temp)
	key_id=$(sed '3q;d' player.config.temp)
	password=$(sed '4q;d' player.config.temp)
	echo "$password $key_id $keystore_src"
	rm player.config.temp
	if [ ! $lpin = $pin  ]
	then
		(>&2 echo "Błędny PIN")
		exit -1
	fi
fi

./krypter.sh $1 AES CTR $keystore_src $key_id $2 $2.2 $password
ls -al
if [ $1 = "e" ]
then
	rm $2
else
	mpg123 $2.2&
	rm $2.2
fi
rm error

