#!/bin/sh
#$Id: ocodesw.sh,v 1.1 2010/04/06 15:42:52 oraz Exp $

cvs -q up .ocodes.enc
TMPFILE=`mktemp .ocodest.XXXXXXXXXX` && {
  trap 'rm -f "$TMPFILE" >/dev/null 2>&1' 0
  trap "exit 2" 1 2 3 13 15
  openssl enc -d -aes-256-cbc -in .ocodes.enc -out $TMPFILE && {
	if [ $# -gt 0 -a "$1" = "w" ];
	then    	
		vim $TMPFILE
		openssl enc -e -aes-256-cbc -in $TMPFILE -out .ocodes.enc && cvs ci -m"ed ocodes" .ocodes.enc 
	else 
		vim -R $TMPFILE
	fi
  }
}

