#!/bin/sh
servers="adb adb4 adb3 ad4 ad5 ad6 adp1 ad2 adstat"
file="nginx.conf"
dir="/usr/local/nginx/conf/"
for s in $servers; 
do
	if [ $s = adp1 ]; then
		scp oraz@$s.rambler.ru:/usr/local/nginx/nginx.conf $s.$file
	elif [ $s = adstat ]; then
		scp oraz@$s.rambler.ru:/usr/local/etc/nginx/nginx.conf $s.$file
	else
		scp oraz@$s.rambler.ru:$dir$file $s.$file
	fi
done
