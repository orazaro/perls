#!/usr/bin/perl -w

use strict;

sub mysin
{
	my $x = shift;
	my $delta = 1E-40;
	my $y = $x;
	my $sum = $y;
	for(my $i = 1; $y > $delta ; $i++)
	{
		$y *= ($x/(2*$i))*($x/(2*$i+1));
		if($i % 2) {
			$sum -= $y;
		} else {
			$sum += $y;
		}
	}
	return $sum;
}

while(<>) {
	my $num = $_ + 0;
	print "sin(" , $num , ")=" , sin($num),
		" mysin=" , mysin($num), "\n";
}
