#!/usr/bin/perl -w
use strict;

my @childs = ();
my @readers = ();

my $num = 10;
my $sum = 0;
for(1..$num) {
	my($r,$w);
	pipe($r,$w);
	my $pid = fork;
	if($pid) {
		#parent
		push @childs, $pid;
		close $w;
		push @readers, $r;
	} elsif ( $pid == 0 ) {
		#child
		$sum = rand(5)%5;
		print "pid=$pid sum=$sum\n";
		close $r;
		print $w "$sum\n";
		exit(0);
	} else {
		die "couldn't fork $!\n";
	}
	print "before for bracket\n";
}
foreach my $r (@readers) {
	$sum += <$r>;
}
print "parent: sum=$sum\n";

foreach my $child (@childs) {
	waitpid($child, 0);
}

