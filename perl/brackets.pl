#!/usr/bin/perl -w
# $Id: brackets.pl,v 1.2 2010/04/21 12:13:20 oraz Exp $
# brackets.pl: outputs filenames with unmatched brackets (with hint to linenumber)
# example: ./brackets *.c
while(<>)
{
	if(!defined($f) or $f ne $ARGV){$f=$ARGV;$l=0}
	$l++;
	push @ar,"$f: $l" if(/{/);
	pop @ar if(/}/)
}
print"$_\n" for(@ar);

