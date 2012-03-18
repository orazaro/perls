#!/usr/bin/perl -w
use strict;

my $line;
while(1)
{
	print "=> ";
	$line = <>;
	last if not defined($line);
	chomp $line;
	last if($line eq 'q' or $line eq 'quit' or $line eq 'bye');
	print qx($line);
}
