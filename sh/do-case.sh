#!/bin/sh
servers="adb adb4 adb3 ad4 ad5 ad6 adp1 ad2 adstat"
file="nginx.conf"
dir="/usr/local/nginx/conf/"
for s in $servers; 
do
	case $s in 
		adp1 )
		scp oraz@$s.rambler.ru:/usr/local/nginx/nginx.conf $s.$file
		;;
		adstat )
		scp oraz@$s.rambler.ru:/usr/local/etc/nginx/nginx.conf $s.$file
		;;
		* )
		scp oraz@$s.rambler.ru:$dir$file $s.$file
		;;
	esac
done
