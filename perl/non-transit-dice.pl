#!/usr/bin/perl -w
# $Id: non-transit-dice.pl,v 1.1 2010/12/15 08:13:02 oraz Exp $
# http://users.livejournal.com/_winnie/276895.html

use strict;

my $a = '333336';
my $b = '222555';
my $c = '144444';

mcmp($a,$b);
mcmp($b,$c);
mcmp($c,$a);
print"---\n";
exit;

sub mcmp
{
	my ($x,$y) = @_;
	my ($xs,$ys,$i,$j);
	for $i (split //, $x){
		for $j (split //, $y){
			if($i > $j) {
				$xs++;
			} else {
				$ys++;
			}
		}
	}
	print"$x ";
	print">" if $xs > $ys;
	print"<" if $xs < $ys;
	print"=" if $xs == $ys;
	print" $y\n";
}

