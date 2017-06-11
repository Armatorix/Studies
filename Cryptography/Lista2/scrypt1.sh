#!/bin/bash
x=$1
prefix=""
sufix="9a139e389efaebead55ec4905b36c0800896876fe958144042e077a9"
xhex="$(echo "obase=16; $x" | bc)"

while [ ${#xhex} != 8 ]
do
	xhex="0$xhex"
done
key="$prefix$xhex$sufix"
hell=$(openssl aes-256-cbc -d -A -base64 -K $key -iv 1452fbfe77de32484c1e8773f868910f <<< "kD54SApD9tYoLgkljg02VNcrNfbfvKJFtO58jqKsetp1jZeDi1T5h+I2Np3WGgdlWCgdGAaC5dcyDzBMOP9pftnQgn7tPJbtQPIojqhaw/jNSrXaHqGBXtfkLVsqkTPNGEl/0LC+hDy1vfG1ecZsLKgV5gLtngLEXJrXaK3RZG0Fu0fAvh8EV/F/Cc4U58gW" 2>&1 | isutf8)
while [ ! -z "$hell" ]
do
	x=$((x+1));
	xhex="$(echo "obase=16; $x" | bc)"
	while [ ${#xhex} != 8 ]
	do
		xhex="0$xhex"
	done
	key="$prefix$xhex$sufix"
	hell=$(openssl aes-256-cbc -d -A -base64 -K $key -iv 1452fbfe77de32484c1e8773f868910f <<< "kD54SApD9tYoLgkljg02VNcrNfbfvKJFtO58jqKsetp1jZeDi1T5h+I2Np3WGgdlWCgdGAaC5dcyDzBMOP9pftnQgn7tPJbtQPIojqhaw/jNSrXaHqGBXtfkLVsqkTPNGEl/0LC+hDy1vfG1ecZsLKgV5gLtngLEXJrXaK3RZG0Fu0fAvh8EV/F/Cc4U58gW" 2>&1 | isutf8)
	echo -ne "\r$key\t$x";
done
	echo -ne "\r\033[K what ? $x";
	printf "\n"
	echo $key > key1
	
