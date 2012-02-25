#!/usr/bin/perl -w
use strict;

my @array = qw(1 2 3 4 5 6 7 8 9 10);
my @childs = ();

my $num = 10;
for(1..$num) {
	my $pid = fork;
	if($pid) {
		#parent
		push @childs, $pid;
	} elsif ( $pid == 0 ) {
		#child
		print "@array\n";
		sleep 5;
		exit(0);
	} else {
		die "couldn't fork $!\n";
	}
	print "before for bracket\n";
}

print "after for bracket\n";

foreach my $child (@childs) {
	waitpid($child, 0);
}

