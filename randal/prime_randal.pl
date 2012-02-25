#!/usr/bin/perl -w
my $UPPER = 1_000_000;
my $sieve = "";
GUESS: for (my $guess = 2; $guess <= $UPPER; $guess++) {
	next GUESS if vec($sieve,$guess,1);
	print "$guess\n";
	for (my $mults = $guess * 2; $mults <= $UPPER; $mults += $guess) {
		vec($sieve,$mults,1) = 1;
	}
}
