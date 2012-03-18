#!/usr/bin/perl -w
# find dirak's fish
use strict;

my $levels = $ARGV[0];
$levels = 1 if(!defined($levels));
print "to find dirak's fish for levels=$levels\n";

my $good = 0;
L1: for(my $i = -10;$good < 10; $i++) {
	my $x = $i * 3 + 1;
	for(my $l = 1; $l < $levels; $l++) {
		next L1 if ($x % 2);
		$x = $x / 2 * 3 + 1;
	}
	print "$x\n";
	$good++;
}
