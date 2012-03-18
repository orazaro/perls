#!/usr/bin/perl -w

use strict;
use warnings;

use Time::Local;
while(<>){
	my ($year,$mon,$mday,$hours,$min,$sec) = split /-/;
	$sec = 0 unless defined $sec;
	$year -= 1900;
	$mon -= 1;
	my $time = timelocal($sec, $min, $hours, $mday, $mon, $year);
	print "time=$time\n";
}
