#!/usr/bin/perl -w
#
use strict;

my $x = $ARGV[0];
if(!defined($x)){
	print"input number= ";
	$x = <>;
} 
my $g = $x;
my $d = 0;
do
{
	$g = ($g + $x/$g)/2;
	$d = abs($x - $g*$g);
	print "g=$g g*g=", $g*$g, " diff=$d\n";
} while( $d > 1E-10)

